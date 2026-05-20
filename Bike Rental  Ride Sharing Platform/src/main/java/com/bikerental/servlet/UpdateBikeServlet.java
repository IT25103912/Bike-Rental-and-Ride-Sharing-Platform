package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.model.Bike;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateBike")
public class UpdateBikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String bikeId = request.getParameter("bikeId");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String priceStr = request.getParameter("price");
            String status = request.getParameter("status");

            if (bikeId != null && !bikeId.isEmpty()) {
                BikeDAO dao = new BikeDAO();

                // BikeDAO එක ඇතුළේ තියෙන මෙතඩ් එක දැන් හරියට වැඩ කරයි
                Bike existingBike = dao.getBikeById(bikeId);

                if (existingBike != null) {
                    existingBike.setBrand(brand);
                    existingBike.setModel(model);

                    if (priceStr != null) {
                        existingBike.setPricePerDay(Double.parseDouble(priceStr));
                    }

                    if (status != null) {
                        existingBike.setStatus(status);
                    }

                    // DAO එක හරහා ෆයිල් එක අප්ඩේට් කරනවා
                    dao.updateBike(existingBike);
                }
            }

            // සාර්ථකව අවසන් වූ පසු manage bikes පේජ් එකට යවනවා
            response.sendRedirect(request.getContextPath() + "/views/bike/manage-bikes.jsp?msg=updated");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/bike/manage-bikes.jsp?msg=error");
        }
    }
}