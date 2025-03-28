/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Event;

/**
 *
 * @author Jackt
 */
@WebServlet(name = "ListEventsServlet", urlPatterns = {"/listevents"})
public class ListEventsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Removed redundant processRequest method
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if event_id parameter is present for direct detail view
        String eventIdParam = request.getParameter("event_id");
        
        if (eventIdParam != null && !eventIdParam.isEmpty()) {
            // If event_id is provided, show event detail
            try {
                int eventId = Integer.parseInt(eventIdParam);
                EventDAO eventDAO = new EventDAO();
                Event event = eventDAO.getEventById(eventId);
                
                if (event == null) {
                    request.setAttribute("error", "Event not found!");
                } else {
                    request.setAttribute("event", event);
                }
                request.getRequestDispatcher("event_detail.jsp").forward(request, response);
                return;
            } catch (SQLException e) {
                throw new ServletException("Database access error", e);
            }
        }
        
        // Otherwise show list of events
        try {
            EventDAO eventDAO = new EventDAO();
            List<Event> events = eventDAO.getAllEventsAvailable();

            request.setAttribute("events", events);
            request.getRequestDispatcher("list_event.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }
}
