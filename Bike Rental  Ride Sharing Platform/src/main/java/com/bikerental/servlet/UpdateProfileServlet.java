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

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        // Form eken ena aluth details gannawa
        String newName = request.getParameter("name");
        String newPassword = request.getParameter("password");

        // User object eka update karanawa
        loggedInUser.setName(newName);
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            loggedInUser.setPassword(newPassword); // Password eka dila nam witarak update karanawa
        }

        // DAO eken text file eka update karanawa
        UserDAO dao = new UserDAO();
        dao.updateUser(loggedInUser);

        // Session eke thiyena user wath aluth karanawa (UI eke update wenna)
        session.setAttribute("user", loggedInUser);

        // Ayeth profile ekata yawanawa success message ekak ekka
        response.sendRedirect(request.getContextPath() + "/views/user/profile.jsp?updated=true");
    }
}