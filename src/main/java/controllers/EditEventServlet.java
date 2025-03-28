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
            // Lấy event_id từ tham số request
            int eventId = Integer.parseInt(request.getParameter("id"));
            EventDAO eventDAO = new EventDAO();
            // Lấy thông tin sự kiện từ cơ sở dữ liệu
            Event event = eventDAO.getEventById(eventId);
            // Đặt đối tượng event làm thuộc tính của request dùng jsp
            request.setAttribute("event", event);
            request.getRequestDispatcher("edit_event.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
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
            // Lấy dữ liệu từ form
            int eventId = Integer.parseInt(request.getParameter("event_id"));
            String eventName = request.getParameter("event_name").trim();
            String eventDetails = request.getParameter("event_details").trim();
            String dateStart = request.getParameter("date_start").trim();
            String dateEnd = request.getParameter("date_end").trim();
            boolean eventStatus = Boolean.parseBoolean(request.getParameter("event_status"));

            Part filePart = request.getPart("event_image");
            byte[] imageBytes = null;
            if (filePart != null && filePart.getSize() > 0) {
                try ( ByteArrayOutputStream baos = new ByteArrayOutputStream();  InputStream inputStream = filePart.getInputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        baos.write(buffer, 0, bytesRead);
                    }
                    imageBytes = baos.toByteArray();
                }
            }
            // Tạo đối tượng Event từ dữ liệu form
            Event event = new Event(eventName, eventDetails, null, dateStart, dateEnd, eventStatus, 0);
            event.setEvent_id(eventId);
            // Cập nhật thông tin sự kiện vào cơ sở dữ liệu
            EventDAO.updateEvent(event, imageBytes);
            response.sendRedirect("ManageEventServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/error.jsp?message=Error updating event: " + e.getMessage());
        }
    }
}
