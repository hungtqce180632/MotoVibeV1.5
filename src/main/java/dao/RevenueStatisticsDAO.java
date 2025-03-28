/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * DAO để lấy dữ liệu thống kê doanh thu.
 *
 * @author hieunmce181623
 */
public class RevenueStatisticsDAO {

    /**
     * Lấy doanh thu theo từng tháng (số xe bán & tổng tiền).
     * 
     * @return danh sách doanh thu theo tháng
     */
    public List<Map<String, Object>> getMonthlyRevenue() {
        List<Map<String, Object>> revenueList = new ArrayList<>();
        String sql = "SELECT FORMAT(o.create_date, 'yyyy-MM') AS month, "
                + "       COUNT(o.order_id) AS total_sales, "
                + "       SUM(o.total_amount) AS total_revenue "
                + "FROM orders o "
                + "WHERE o.order_status = 'Completed' "
                + "GROUP BY FORMAT(o.create_date, 'yyyy-MM') "
                + "ORDER BY month";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> revenue = new HashMap<>();
                revenue.put("month", rs.getString("month"));
                revenue.put("total_sales", rs.getInt("total_sales"));
                revenue.put("total_revenue", rs.getDouble("total_revenue"));
                revenueList.add(revenue);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueList;
    }

    /**
     * Lấy tổng doanh thu từ tất cả đơn hàng đã hoàn thành.
     * 
     * @return tổng doanh thu từ các đơn hàng hoàn thành
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) AS total_revenue FROM orders WHERE order_status = 'Completed'";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("total_revenue"); // Trả về tổng doanh thu
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0; // Trả về 0 nếu không có dữ liệu
    }

    /**
     * Lấy tổng số đơn hàng hoàn thành.
     * 
     * @return tổng số đơn hàng hoàn thành
     */
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) AS total_orders FROM orders WHERE order_status = 'Completed'";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total_orders"); // Trả về tổng số đơn hàng hoàn thành
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu không có dữ liệu
    }

    /**
     * Lấy tất cả các tháng có trong dữ liệu (distinct months).
     * 
     * @return danh sách các tháng có trong dữ liệu
     */
    public List<String> getAvailableMonths() {
        List<String> months = new ArrayList<>();
        // Câu truy vấn SQL lấy các tháng duy nhất có trong dữ liệu đơn hàng
        String sql = "SELECT DISTINCT FORMAT(o.create_date, 'yyyy-MM') AS month "
                + "FROM orders o "
                + "WHERE o.order_status = 'Completed' "
                + "ORDER BY month";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                months.add(rs.getString("month"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return months;
    }

     /**
     * Lấy thống kê doanh thu theo tháng đã chọn.
     * 
     * @param monthFilter tháng cần lọc
     * @return danh sách doanh thu theo tháng đã lọc
     */
    public List<Map<String, Object>> getMonthlyRevenueByMonth(String monthFilter) {
        List<Map<String, Object>> revenueList = new ArrayList<>();
         // Câu truy vấn SQL lấy doanh thu theo tháng đã chọn
        String sql = "SELECT FORMAT(o.create_date, 'yyyy-MM') AS month, "
                + "       COUNT(o.order_id) AS total_sales, "
                + "       SUM(o.total_amount) AS total_revenue "
                + "FROM orders o "
                + "WHERE o.order_status = 'Completed' "
                + "  AND FORMAT(o.create_date, 'yyyy-MM') = ? "
                + "GROUP BY FORMAT(o.create_date, 'yyyy-MM') "
                + "ORDER BY month";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, monthFilter);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> revenue = new HashMap<>();
                    revenue.put("month", rs.getString("month"));
                    revenue.put("total_sales", rs.getInt("total_sales"));
                    revenue.put("total_revenue", rs.getDouble("total_revenue"));
                    revenueList.add(revenue);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueList; // Trả về danh sách doanh thu theo tháng đã lọc
    }
}
