package com.bikerental.servlet;

import com.bikerental.dao.UserDAO;
import com.bikerental.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        // Admin nemei nam hari login wela nattam hari elawamu
        if (loggedInUser == null || !loggedInUser.getRole().equals("Admin")) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        String userId = request.getParameter("id");

        // Thamanwa makaganna ba kiyala condition ekak danawa
        if (userId != null && !userId.equals(loggedInUser.getId())) {
            UserDAO dao = new UserDAO();
            dao.deleteUser(userId);
        }

        response.sendRedirect(request.getContextPath() + "/views/user/admin-users.jsp?deleted=true");
    }
}