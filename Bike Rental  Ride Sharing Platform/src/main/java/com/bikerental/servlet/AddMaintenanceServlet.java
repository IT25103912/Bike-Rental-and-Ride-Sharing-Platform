package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.dao.MaintenanceDAO;
import com.bikerental.model.Maintenance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addMaintenance")
public class AddMaintenanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. JSP Form එකෙන් දත්ත ලබා ගැනීම
        String bikeId = request.getParameter("bikeId");
        String description = request.getParameter("description");
        double cost = Double.parseDouble(request.getParameter("cost"));
        String date = request.getParameter("date");
        String mId = "M" + System.currentTimeMillis(); // Unique ID එකක් හදාගමු

        // 2. Maintenance Object එකක් හැදීම
        Maintenance record = new Maintenance(mId, bikeId, description, cost, date);

        // 3. MaintenanceDAO හරහා record එක save කිරීම
        MaintenanceDAO mDao = new MaintenanceDAO();
        mDao.addMaintenanceRecord(record);

        // 4. වැදගත්ම දේ: Bike එකේ status එක 'Under Maintenance' කිරීම
        BikeDAO bDao = new BikeDAO();
        bDao.updateBikeStatus(bikeId, "Maintenance"); // දැන් හරි!

        // 5. ආපසු නඩත්තු පිටුවටම යැවීම
        response.sendRedirect("views/admin/admin-maintenance.jsp?success=true");
    }
}