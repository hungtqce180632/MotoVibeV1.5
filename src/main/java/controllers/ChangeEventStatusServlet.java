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
            // lấy id và gán vào eventIdParam
            String eventIdParam = request.getParameter("event_id");
            System.out.println("Received event_id parameter: " + eventIdParam);

            // lấy action 
            String action = request.getParameter("action");
            System.out.println("Received action parameter: " + action);
            // kiểm tra id chuyển vào
            if (eventIdParam == null || eventIdParam.isEmpty()) {
                throw new IllegalArgumentException("event_id parameter is missing");
            }
            //gán thành int
            int eventId = Integer.parseInt(eventIdParam);
            System.out.println("Parsed event_id: " + eventId);

            // khởi tạo
            EventDAO eventDAO = new EventDAO();
            boolean statusChanged;

            //xet action
            // nếu active thì bật event
            if ("activate".equals(action)) {
                statusChanged = eventDAO.actEvent(eventId);
                if (statusChanged) {
                    request.getSession().setAttribute("statusMessage", "Event activated successfully");
                }
                
             // nếu deactive thì tắt event
            } else if ("deactivate".equals(action)) {
                statusChanged = eventDAO.disEvent(eventId);
                if (statusChanged) {
                    request.getSession().setAttribute("statusMessage", "Event deactivated successfully");
                }
            }

            response.sendRedirect("ManageEventServlet");

        } catch (SQLException ex) {
            Logger.getLogger(ChangeEventStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("errorMessage", "Database error: " + ex.getMessage());
            response.sendRedirect("ManageEventServlet");
        }
    }
}
