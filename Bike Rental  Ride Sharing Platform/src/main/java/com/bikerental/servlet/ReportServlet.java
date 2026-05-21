package com.bikerental.servlet;

import com.bikerental.dao.ReportDAO;
import com.bikerental.dao.MaintenanceDAO; // ✅ අලුතින් එකතු කළා
import com.bikerental.model.Maintenance; // ✅ අලුතින් එකතු කළා
import com.bikerental.model.Person;
import com.bikerental.model.RevenueReport;
import com.bikerental.util.FilePathUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List; // ✅ අලුතින් එකතු කළා
import java.util.UUID;

@WebServlet("/generateReport")
public class ReportServlet extends HttpServlet {

    // Hardcode කරපු path එක අයින් කරලා FilePathUtil එක පාවිච්චි කරලා තියෙන්නේ
    private static final String REPORT_FILE = FilePathUtil.getPath("reports.txt");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Person admin = (Person) request.getSession().getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        String format = request.getParameter("format"); // "TXT" or "CSV"

        ReportDAO dao = new ReportDAO();

        // ✅ 1. MaintenanceDAO හරහා නඩත්තු වියදම් හොයාගන්නවා
        MaintenanceDAO mDao = new MaintenanceDAO();
        List<Maintenance> mList = mDao.getAllRecords();
        double totalMaintenanceCost = 0;
        if (mList != null) {
            for (Maintenance m : mList) {
                totalMaintenanceCost += m.getCost();
            }
        }

        // ✅ 2. ආදායම (Revenue) අරගෙන, ඒකෙන් වියදම අඩු කරලා ලාභය (Profit) හොයනවා
        double totalRevenue = dao.getTotalRevenue();
        double netProfit = totalRevenue - totalMaintenanceCost;

        String currentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String reportId = "RPT-" + UUID.randomUUID().toString().substring(0, 4).toUpperCase();

        // *** OOP Magic ***
        // RevenueReport object eka hadala data set karanawa
        RevenueReport report = new RevenueReport();
        report.setReportId(reportId);
        report.setType("Financial Overview"); // Type එක පොඩ්ඩක් වෙනස් කළා ගැලපෙන්න
        report.setGeneratedDate(currentDate);

        // ✅ 3. ගණන් 3 ම Report Object එකට Set කරනවා
        report.setTotalRevenue(totalRevenue);
        report.setTotalMaintenanceCost(totalMaintenanceCost);
        report.setNetProfit(netProfit);

        report.setTotalTransactions(dao.countLines("payments.txt"));

        report.compile(); // Console ekata print wenawa abstract method eka haraha

        // Polymorphism (Exportable interface) haraha file string eka gannawa
        String output = report.export(format);

        // File ekata liyanawa
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(REPORT_FILE, true))) {
            bw.write(output);
            bw.newLine();
        }

        // Dashboard ekata aith yawanawa success message ekak ekka
        response.sendRedirect(request.getContextPath() + "/adminDashboard?success=report_generated");
    }
}