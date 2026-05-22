package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteBike")
public class DeleteBikeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Login wela nattan elawamu
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        // URL eken ena Bike ID eka allagannawa
        String bikeId = request.getParameter("id");

        if (bikeId != null) {
            BikeDAO dao = new BikeDAO();
            dao.deleteBike(bikeId); // DAO ekata kiyala makala danawa
        }

        // Makala iwara wela ayeth Dashboard ekatama yawanawa
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp?deleted=true");
    }
}