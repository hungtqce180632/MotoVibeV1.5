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
 */
public class RevenueStatisticsDAO {

    /**
     * Lấy doanh thu theo từng tháng (số xe bán & tổng tiền).
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
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) AS total_revenue FROM orders WHERE order_status = 'Completed'";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("total_revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    /**
     * Lấy tổng số đơn hàng hoàn thành.
     */
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) AS total_orders FROM orders WHERE order_status = 'Completed'";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total_orders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
