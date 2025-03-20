package controllers;

import java.io.IOException;
import java.sql.SQLException;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ChangeEventStatusServlet", urlPatterns = {"/changeEventStatus"})
public class ChangeEventStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // Get the event ID from the request and log it
            String eventIdParam = request.getParameter("event_id");
            System.out.println("Received event_id parameter: " + eventIdParam);
            
            // Get the action parameter (activate or deactivate)
            String action = request.getParameter("action");
            System.out.println("Received action parameter: " + action);

            if (eventIdParam == null || eventIdParam.isEmpty()) {
                throw new IllegalArgumentException("event_id parameter is missing");
            }

            int eventId = Integer.parseInt(eventIdParam);
            System.out.println("Parsed event_id: " + eventId);

            // Call the appropriate DAO method based on the action
            EventDAO eventDAO = new EventDAO();
            boolean statusChanged;
            
            if ("activate".equals(action)) {
                statusChanged = eventDAO.actEvent(eventId);
                if (statusChanged) {
                    request.getSession().setAttribute("statusMessage", "Event activated successfully");
                }
            } else if ("deactivate".equals(action)) {
                statusChanged = eventDAO.disEvent(eventId);
                if (statusChanged) {
                    request.getSession().setAttribute("statusMessage", "Event deactivated successfully");
                }
            } else {
                // Fall back to toggle behavior if action not specified
                statusChanged = eventDAO.changeEventStatus(eventId);
                if (statusChanged) {
                    request.getSession().setAttribute("statusMessage", "Event status updated successfully");
                }
            }

            if (!statusChanged) {
                // Set an error message
                request.getSession().setAttribute("errorMessage", "Failed to update event status");
            }

            response.sendRedirect("ManageEventServlet");

        } catch (SQLException ex) {
            Logger.getLogger(ChangeEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("errorMessage", "Database error: " + ex.getMessage());
            response.sendRedirect("ManageEventServlet");
        }
    }
}
