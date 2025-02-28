package controllers;

import dao.EventDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.http.HttpServlet;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

@WebServlet(name = "EditEventServlet", urlPatterns = {"/EditEventServlet"})
@MultipartConfig

public class EditEventServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "images";  // Directory to store images

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get event_id from the request
            int eventId = Integer.parseInt(request.getParameter("id"));
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(eventId);  // Fetch the event from DB
            request.setAttribute("event", event);  // Set the event as an attribute
            request.getRequestDispatcher("edit_event.jsp").forward(request, response);  // Forward to the edit page

        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");  // Redirect to an error page if there's an issue
        } catch (SQLException ex) {
            Logger.getLogger(EditEventServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String contextPath = request.getContextPath();

        try {
            int eventId = Integer.parseInt(request.getParameter("event_id"));
            String eventName = request.getParameter("event_name").trim();
            String eventDetails = request.getParameter("event_details").trim();
            String dateStart = request.getParameter("date_start").trim();
            String dateEnd = request.getParameter("date_end").trim();
            boolean eventStatus = Boolean.parseBoolean(request.getParameter("event_status"));

            Part filePart = request.getPart("event_image");
            byte[] imageBytes = null;
            if (filePart != null && filePart.getSize() > 0) {
                try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
                     InputStream inputStream = filePart.getInputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        baos.write(buffer, 0, bytesRead);
                    }
                    imageBytes = baos.toByteArray();
                }
            }

            Event event = new Event(eventName, eventDetails, null, dateStart, dateEnd, eventStatus, 0);
            event.setEvent_id(eventId);

            EventDAO.updateEvent(event, imageBytes);
            response.sendRedirect("ManageEventServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/error.jsp?message=Error updating event: " + e.getMessage());
        }
    }
}
