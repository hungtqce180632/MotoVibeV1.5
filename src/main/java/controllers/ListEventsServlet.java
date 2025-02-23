/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import dao.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Event;
import org.checkerframework.checker.units.qual.A;

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
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListEventsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListEventsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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

        try {
            EventDAO eventDAO = new EventDAO();
            List<Event> events = eventDAO.getAllEventsAvailable();

            request.setAttribute("events", events);

            request.getRequestDispatcher("list_event.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy giá trị event_id từ request
        String eventIdParam = request.getParameter("event_id");

        if (eventIdParam == null || eventIdParam.isEmpty()) {
            response.sendRedirect("listevents"); // Nếu không có event_id, quay lại danh sách
            return;
        }

        int eventId = Integer.parseInt(eventIdParam); // Chuyển đổi thành số nguyên
        EventDAO eventDAO = new EventDAO();

        try {
            Event event = eventDAO.getEventById(eventId); // Lấy thông tin sự kiện từ database

            if (event == null) {
                request.setAttribute("error", "Event not found!");
            } else {
                request.setAttribute("event", event);
            }

            // Chuyển tiếp dữ liệu đến trang event_detail.jsp
            request.getRequestDispatcher("event_detail.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error retrieving event details", e);
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
