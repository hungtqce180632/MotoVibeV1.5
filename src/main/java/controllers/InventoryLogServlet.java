/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.InventoryLogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.InventoryLog;

/**
 *
 * @author tiend
 */
@WebServlet(name = "InventoryLogServlet", urlPatterns = {"/inventoryLog"})
public class InventoryLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryLogDAO logDAO = new InventoryLogDAO();
        List<InventoryLog> logs = logDAO.getAllLogs();

        request.setAttribute("logs", logs);
        request.getRequestDispatcher("inventory_log.jsp").forward(request, response);
    }

}
