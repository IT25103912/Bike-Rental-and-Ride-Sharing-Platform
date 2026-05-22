package com.bikerental.servlet;

import com.bikerental.dao.ReviewDAO;
import com.bikerental.model.Person;
import com.bikerental.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        String bikeId = request.getParameter("bikeId");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        // Random Review ID ekak hadanawa (e.g. REV-A1B2)
        review.setContentId("REV-" + UUID.randomUUID().toString().substring(0, 4).toUpperCase());
        review.setBookingId(bookingId);
        review.setBikeId(bikeId);
        review.setAuthorId(loggedInUser.getId());
        review.setComment(comment);
        review.setOwnerReply("None"); // Thama owner reply karala naha
        review.setTimestamp(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));

        try {
            // *** OOP Encapsulation *** // Meken check karanawa rating eka 1-5 atharada kiyala
            review.setRating(rating);

            // Text file ekata liyanawa
            ReviewDAO dao = new ReviewDAO();
            dao.addReview(review);

            response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp?review=success");

        } catch (IllegalArgumentException e) {
            // Rating eka waradi nam (Udaharanayak widiyata 6k dunnoth) error eka enawa
            response.sendRedirect(request.getContextPath() + "/views/review/submit-review.jsp?error=invalid_rating");
        }
    }
}