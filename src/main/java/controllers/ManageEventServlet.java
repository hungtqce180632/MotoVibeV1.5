package controllers;

import dao.EventDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author ACER
 */
@WebServlet(name = "ManageEventServlet", urlPatterns = {"/ManageEventServlet"})
public class ManageEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all events using EventDAO
            List<Event> events = EventDAO.getAllEvents();

            // Set the events in the request scope to pass them to the JSP page
            request.setAttribute("events", events);

            // Forward the request to manage_event.jsp to display the events
            request.getRequestDispatcher("manage_event.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error fetching events: " + e.getMessage());
        }
    }
}
