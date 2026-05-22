package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String bikeId = request.getParameter("bikeId");
        String newStatus = request.getParameter("newStatus");

        if (bikeId != null && newStatus != null) {
            BikeDAO bikeDao = new BikeDAO();
            bikeDao.updateBikeStatus(bikeId, newStatus);

            response.sendRedirect(request.getContextPath() + "/views/admin/admin-dashboard.jsp?statusUpdated=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/admin/admin-dashboard.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/admin/admin-dashboard.jsp");
    }
}
