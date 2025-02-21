package controllers;

import dao.MotorDAO;
import models.Motor;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ToggleMotorStatusServlet", urlPatterns = {"/toggleMotorStatus"})
public class ToggleMotorStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int motorId = Integer.parseInt(request.getParameter("id"));
            MotorDAO motorDAO = new MotorDAO();

            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("motorManagement");
                return;
            }

            // Toggle present status
            boolean newStatus = !motor.isPresent();
            motor.setPresent(newStatus);
            motorDAO.updateMotor(motor);

            response.sendRedirect("motorManagement");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("motorManagement");
        }
    }
}
