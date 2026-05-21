package com.bikerental.servlet;

import com.bikerental.dao.ReviewDAO;
import com.bikerental.interfaces.Moderatable;
import com.bikerental.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/moderateReview")
public class ModerationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reviewId = request.getParameter("reviewId");
        String action = request.getParameter("action");

        ReviewDAO dao = new ReviewDAO();

        if ("delete".equals(action)) {
            // *** OOP Polymorphism Magic Eka ***
            Moderatable content = new Review();
            ((Review)content).setContentId(reviewId);
            content.remove();

            // Text file eken line eka makala danawa
            dao.deleteReview(reviewId);

            response.sendRedirect(request.getContextPath() + "/views/review/admin-reviews.jsp?success=deleted");

        } else if ("reply".equals(action)) {
            // මෙන්න වෙනස් කරපු කෑල්ල! "replyText" කියලා හරියටම නම දැම්මා.
            String replyMessage = request.getParameter("replyText");

            dao.updateReviewReply(reviewId, replyMessage);

            response.sendRedirect(request.getContextPath() + "/views/review/admin-reviews.jsp?success=replied");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/review/admin-reviews.jsp");
        }
    }
}