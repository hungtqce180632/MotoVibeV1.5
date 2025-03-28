/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.MotoBikeStatisticsDAO;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 * Document   : MotoBikeStatisticsServlet
 * Created on : Feb 23, 2025, 4:11:08 AM
 * Author     : hieunmce181623
 */

/**
 * Servlet xử lý thống kê doanh thu xe máy.
 * Servlet này xử lý các yêu cầu GET và POST, lấy dữ liệu thống kê xe máy từ cơ sở dữ liệu và hiển thị trên trang JSP.
 */
@WebServlet(name = "MotoBikeStatisticsServlet", urlPatterns = {"/motorbikeStatistics"})
public class MotoBikeStatisticsServlet extends HttpServlet {

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
            out.println("<title>Servlet MotoBikeStatisticsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MotoBikeStatisticsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Phương thức xử lý yêu cầu HTTP GET.
     * Lấy dữ liệu thống kê doanh thu xe máy từ DAO và chuyển đến trang JSP để hiển thị.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException nếu có lỗi trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi trong quá trình nhập/xuất
     */
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin lọc mẫu xe từ yêu cầu HTTP
        String modelFilter = request.getParameter("modelFilter");

        // Tạo đối tượng DAO để lấy dữ liệu từ cơ sở dữ liệu
        MotoBikeStatisticsDAO motoDAO = new MotoBikeStatisticsDAO();

        // Lấy dữ liệu thống kê doanh thu xe máy từ DAO, có thể lọc theo mẫu xe
        List<Map<String, Object>> motorbikeData = motoDAO.getMotorbikeSalesStatistics(modelFilter);

        // Lấy danh sách các mẫu xe có sẵn để hiển thị trong dropdown
        List<String> motorbikeModels = motoDAO.getMotorbikeModels();
        
        // Kiểm tra nếu không có dữ liệu, tạo danh sách trống
        if (motorbikeData == null || motorbikeData.isEmpty()) {
            motorbikeData = new ArrayList<>(); // Danh sách rỗng nếu không tìm thấy dữ liệu
        }

        // Gửi dữ liệu vào JSP thông qua các thuộc tính của request
        request.setAttribute("motorbikeData", motorbikeData);
        request.setAttribute("motorbikeModels", motorbikeModels);

        // Chuyển hướng tới trang JSP để hiển thị kết quả
        request.getRequestDispatcher("motorbike_statistics.jsp").forward(request, response);
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
