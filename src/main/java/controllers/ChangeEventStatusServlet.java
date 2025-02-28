package controllers;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ChangeEventStatusServlet", urlPatterns = {"/changeEventStatus"})
public class ChangeEventStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the event ID from the request
            int eventId = Integer.parseInt(request.getParameter("event_id"));

            // Call the DAO method to change the event status
            EventDAO eventDAO = new EventDAO();
            boolean statusChanged = eventDAO.changeEventStatus(eventId);

            if (statusChanged) {
                response.sendRedirect("manageEvent");  // Redirect back to manage event page if status change is successful
            } else {
                response.sendRedirect("error.jsp");  // Redirect to error page if there was an issue
            }

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");  // Redirect to an error page if there's an issue
        }
    }
}
