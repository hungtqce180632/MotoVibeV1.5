/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.InventoryLogDAO;
import dao.MotorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.InventoryLog;
import models.Motor;
import models.UserAccount;
import utils.DBContext;

/**
 *
 * @author tiend
 */
@WebServlet(name = "ChangeQuantityServlet", urlPatterns = {"/changeQuantity"})
public class ChangeQuantityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int motorId = Integer.parseInt(request.getParameter("id"));
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);
        if (motor == null) {
            response.sendRedirect("motorManagement");
            return;
        }
        request.setAttribute("motor", motor);
        request.getRequestDispatcher("change_quantity.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int motorId = Integer.parseInt(request.getParameter("motorId"));
        int changeAmount = Integer.parseInt(request.getParameter("changeAmount"));
        String action = request.getParameter("action");
        String note = request.getParameter("note");

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        MotorDAO motorDAO = new MotorDAO();
        InventoryLogDAO logDAO = new InventoryLogDAO();

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            int previousQuantity = motor.getQuantity();
            int newQuantity = ("increase".equals(action)) ? previousQuantity + changeAmount : previousQuantity - changeAmount;

            if (newQuantity < 0) {
                request.setAttribute("error", "Not enough stock available.");
                request.getRequestDispatcher("change_quantity.jsp").forward(request, response);
                return;
            }

            motor.setQuantity(newQuantity);
            motorDAO.updateMotor(motor);

            InventoryLog log = new InventoryLog(0, motorId, previousQuantity, ("increase".equals(action) ? changeAmount : -changeAmount), action, user.getUserId(), LocalDateTime.now(), note);
            logDAO.addLog(log);

            conn.commit();
            response.sendRedirect("motorManagement");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("change_quantity.jsp").forward(request, response);
        }
    }

}
