/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
/**
 *
 * @author ACER
 */
@WebServlet(name = "DeleteEventServlet", urlPatterns = {"/deleteEvent"})
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("id"));
            EventDAO eventDAO = new EventDAO();
            boolean deleted = eventDAO.deleteEvent(eventId);

            if (deleted) {
                response.sendRedirect("ManageEventServlet");  // Redirect to event management page after deletion
            } else {
                response.sendRedirect("error.jsp");  // Redirect to error page if event deletion fails
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}