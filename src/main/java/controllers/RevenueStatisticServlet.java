/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.AppointmentDAO;
import dao.RevenueStatisticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import models.UserAccount;

/**
*    Document   : RevenueStatisticServlet
*    Created on : Feb 23, 2025, 4:11:08 AM
*    Author     : hieunmce181623
*/

@WebServlet(name = "RevenueStatisticServlet", urlPatterns = {"/revenueStatistic"})
public class RevenueStatisticServlet extends HttpServlet {

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
            out.println("<title>Servlet RevenueStatisticServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueStatisticServlet at " + request.getContextPath() + "</h1>");
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
        // Khởi tạo đối tượng DAO để lấy dữ liệu thống kê doanh thu
        RevenueStatisticsDAO revenueDAO = new RevenueStatisticsDAO();
        
        // Lấy tháng được chọn từ tham số yêu cầu (nếu có)
        String monthFilter = request.getParameter("monthFilter");
        
        // Lấy danh sách các tháng có sẵn để hiển thị trên dropdown
        List<String> availableMonths = revenueDAO.getAvailableMonths();
        
        // Lấy dữ liệu doanh thu dựa trên tháng đã chọn hoặc tất cả các tháng nếu không có bộ lọc
        List<Map<String, Object>> revenueData;
        if (monthFilter != null && !monthFilter.isEmpty()) {
            // Lấy doanh thu cho tháng được chọn
            revenueData = revenueDAO.getMonthlyRevenueByMonth(monthFilter);
        } else {
            // Lấy doanh thu cho tất cả các tháng
            revenueData = revenueDAO.getMonthlyRevenue(); // Fetch all data if no filter
        }
        
        // Lấy tổng doanh thu và tổng số đơn hàng
        double totalRevenue = revenueDAO.getTotalRevenue();
        int totalOrders = revenueDAO.getTotalOrders();
        
        // Đưa dữ liệu vào request để sử dụng trong trang JSP
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("monthFilter", monthFilter); // Lưu tháng đã chọn vào trang
        request.setAttribute("availableMonths", availableMonths); // Lấy các tháng có sẵn để hiển thị dropdown
        
        // Chuyển tiếp dữ liệu đến trang JSP
        request.getRequestDispatcher("revenue_statistic.jsp").forward(request, response);
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
        processRequest(request, response);
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
