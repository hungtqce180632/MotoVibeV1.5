package controllers;

import dao.EventDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "CreateEventServlet", urlPatterns = {"/CreateEventServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class CreateEventServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        eventDAO = new EventDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String contextPath = request.getContextPath();

        try {
            // Get user_id from session (default to 1 if not set)
            HttpSession session = request.getSession();
            int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 1;
            System.out.println("User ID: " + userId);

            // Get form data
            String eventName = request.getParameter("event_name").trim();
            if (eventName.isEmpty()) {
                throw new IllegalArgumentException("Event name is required");
            }

            String eventDetails = request.getParameter("event_detail").trim();
            if (eventDetails.isEmpty()) {
                throw new IllegalArgumentException("Event details are required");
            }

            String dateStartStr = request.getParameter("date_start").trim();
            String dateEndStr = request.getParameter("date_end").trim();
            if (dateStartStr.isEmpty() || dateEndStr.isEmpty()) {
                throw new IllegalArgumentException("Start and end dates are required");
            }

            // Parse dates
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateStart = LocalDate.parse(dateStartStr, formatter);
            LocalDate dateEnd = LocalDate.parse(dateEndStr, formatter);
            if (dateEnd.isBefore(dateStart)) {
                throw new IllegalArgumentException("End date must be after start date");
            }

            // Handle file upload
            Part filePart = request.getPart("event_image");
            if (filePart == null || filePart.getSize() == 0) {
                throw new IllegalArgumentException("Event image is required");
            }
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            byte[] imageBytes = new byte[(int) filePart.getSize()];
            try (InputStream inputStream = filePart.getInputStream()) {
                inputStream.read(imageBytes);
            }

            // Create event object
            Event event = new Event(eventName, eventDetails, fileName, dateStart.toString(), dateEnd.toString(), true, userId);

            // Save to database
            boolean isCreated = eventDAO.createEvent(event, imageBytes);
            if (!isCreated) {
                throw new Exception("Failed to create event");
            }

            response.sendRedirect("ManageEventServlet");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(contextPath + "/error.jsp?message=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/error.jsp?message=Unexpected error: " + e.getMessage());
        }
    }
}