package com.bikerental.servlet;

import com.bikerental.dao.LogDAO;
import com.bikerental.dao.UserDAO;
import com.bikerental.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        Person loggedInUser = dao.loginUser(email, password);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);

            // 🔥 මෙතනදී තමයි ලොග් එක record කරන්නේ
            LogDAO logDao = new LogDAO(); // [cite: 91, 152]
            logDao.recordLog(loggedInUser.getEmail(), "User logged in successfully as " + loggedInUser.getRole()); // [cite: 91]

            response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
        } else {
            // 🆕 පරාජිත ලොගින් උත්සාහයක් ගැනත් ලොග් එකක් දැම්මොත් ඇඩ්මින්ට හොඳයි
            LogDAO logDao = new LogDAO();
            logDao.recordLog(email, "FAILED login attempt detected"); // [cite: 91]

            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp?error=1");
        }
    }
}