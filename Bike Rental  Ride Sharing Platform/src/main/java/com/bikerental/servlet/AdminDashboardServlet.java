package com.bikerental.servlet;

import com.bikerental.dao.ReportDAO;
import com.bikerental.dao.LogDAO; // 🆕 LogDAO එක import කළා
import com.bikerental.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        // 1. Security Check - ඇඩ්මින් කෙනෙක් නෙවෙයි නම් ලොගින් එකට යවනවා
        if (loggedInUser == null || !"Admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        // 🔥 2. ඇඩ්මින් ඩෑෂ්බෝඩ් එකට ආපු බව logs.txt එකේ සටහන් කරනවා
        LogDAO logDao = new LogDAO();
        logDao.recordLog(loggedInUser.getEmail(), "Accessed Admin Dashboard");

        // 3. රිපෝට් වලට අවශ්‍ය දත්ත ලබා ගැනීම [cite: 86, 91]
        ReportDAO reportDAO = new ReportDAO();

        // 4. JSP එකේ KPI cards වලට අවශ්‍ය දත්ත ටික සෙට් කරනවා [cite: 93, 98]
        request.setAttribute("totalUsers", reportDAO.getTotalUsers());
        request.setAttribute("totalBikes", reportDAO.getTotalBikes());
        request.setAttribute("activeRides", reportDAO.getActiveRides());
        request.setAttribute("totalRevenue", reportDAO.getTotalRevenue());

        // 5. ඇඩ්මින් ඩෑෂ්බෝඩ් JSP එකට දත්ත යවනවා [cite: 92, 150]
        request.getRequestDispatcher("/views/admin/admin-dashboard.jsp").forward(request, response);
    }
}