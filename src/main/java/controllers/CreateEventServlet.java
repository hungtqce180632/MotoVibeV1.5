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

    private final EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String contextPath = request.getContextPath();

        try {
            // user_Id luôn bằng 1 vì admin luôn là user đầu tiên
            int userId = 1;
            System.out.println("User ID: " + userId);

            // Lấy dữ liệu từ form
            String eventName = request.getParameter("event_name").trim();
            //check name rỗng
            if (eventName.isEmpty()) {
                throw new IllegalArgumentException("Event name is required");
            }

            String eventDetails = request.getParameter("event_detail").trim();
            //check detail rỗng
            if (eventDetails.isEmpty()) {
                throw new IllegalArgumentException("Event details are required");
            }
            // Lấy ngày bắt đầu và kết thúc của sự kiện
            String dateStartStr = request.getParameter("date_start").trim();
            String dateEndStr = request.getParameter("date_end").trim();
            if (dateStartStr.isEmpty() || dateEndStr.isEmpty()) {
                throw new IllegalArgumentException("Start and end dates are required");
            }

            
            // Chuyển đổi chuỗi ngày thành đối tượng LocalDate
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateStart = LocalDate.parse(dateStartStr, formatter);
            LocalDate dateEnd = LocalDate.parse(dateEndStr, formatter);
            // Kiểm tra logic ngày kết thúc phải sau ngày bắt đầu
            if (dateEnd.isBefore(dateStart)) {
                throw new IllegalArgumentException("End date must be after start date");
            }

            // Handle file upload
            Part filePart = request.getPart("event_image");
            if (filePart == null || filePart.getSize() == 0) {
                throw new IllegalArgumentException("Event image is required");
            }
            
            // We don't need the filename anymore as we're storing the image in the database
            // Just read the bytes
            byte[] imageBytes = new byte[(int) filePart.getSize()];
            try (InputStream inputStream = filePart.getInputStream()) {
                inputStream.read(imageBytes);
            }

            // Tạo đối tượng Event với đường dẫn hình ảnh là null vì sẽ lưu trực tiếp vào DB
            Event event = new Event(eventName, eventDetails, null, dateStart.toString(), dateEnd.toString(), true, userId);

            // Lưu sự kiện và hình ảnh vào cơ sở dữ liệu
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