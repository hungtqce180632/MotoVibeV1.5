package controllers;

import dao.EventDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "CreateEventServlet", urlPatterns = {"/CreateEventServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class CreateEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        eventDAO = new EventDAO();
        System.out.println("CreateEventServlet initialized");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String contextPath = request.getContextPath();

        try {
            System.out.println("Starting event creation process...");

            // Get user_id from session
            HttpSession session = request.getSession(true); // Create session if none
            if (session.getAttribute("user_id") == null) {
                session.setAttribute("user_id", 1); // Temporary for testing
                System.out.println("No user_id in session, set to 1 for testing");
            }
            int userId = (Integer) session.getAttribute("user_id");
            System.out.println("User ID: " + userId);

            // Get form data
            String eventName = request.getParameter("event_name");
            if (eventName == null || eventName.trim().isEmpty()) {
                throw new IllegalArgumentException("Event name is required");
            }
            eventName = eventName.trim();
            System.out.println("Event Name: " + eventName);

            String eventDetails = request.getParameter("event_detail");
            if (eventDetails == null || eventDetails.trim().isEmpty()) {
                throw new IllegalArgumentException("Event details are required");
            }
            eventDetails = eventDetails.trim();
            System.out.println("Event Details: " + eventDetails);

            String dateStartStr = request.getParameter("date_start");
            String dateEndStr = request.getParameter("date_end");
            if (dateStartStr == null || dateEndStr == null) {
                throw new IllegalArgumentException("Start and end dates are required");
            }
            System.out.println("Date Start: " + dateStartStr + ", Date End: " + dateEndStr);

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
            System.out.println("Image File: " + fileName);

            // Convert image to byte array
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try (InputStream inputStream = filePart.getInputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    baos.write(buffer, 0, bytesRead);
                }
            }
            byte[] imageBytes = baos.toByteArray();
            System.out.println("Image Size: " + imageBytes.length + " bytes");

            // Create event object
            Event event = new Event(eventName, eventDetails, fileName, 
                                   dateStart.toString(), dateEnd.toString(), true, userId);
            System.out.println("Event object: " + event);

            // Save to database
            System.out.println("Attempting to save event...");
            boolean isCreated = eventDAO.createEvent(event, imageBytes);
            if (!isCreated) {
                throw new Exception("Failed to create event in database - check logs for SQL error");
            }

            System.out.println("Event created successfully, redirecting to listevents");
            response.sendRedirect(contextPath + "/listevents");

        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("Validation error: " + e.getMessage());
            response.sendRedirect(contextPath + "/error.jsp?message=" + e.getMessage());
        } catch (Exception e) {
            System.err.println("Unexpected error in CreateEventServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(contextPath + "/error.jsp?message=Unexpected error: " + e.getMessage());
        }
    }
}