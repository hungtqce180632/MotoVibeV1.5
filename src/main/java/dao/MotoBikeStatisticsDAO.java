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
 * DAO để lấy dữ liệu thống kê doanh thu xe máy
 * 
 * @author hieunmce181623
 */
public class MotoBikeStatisticsDAO {

    /**
     * Lấy thống kê số lượng xe bán ra theo từng mẫu xe
     * 
     * @param modelFilter Mẫu xe lọc (nếu có)
     * @return Danh sách thống kê doanh thu xe máy (số lượng bán và tổng doanh thu) theo từng mẫu xe
     */
    public List<Map<String, Object>> getMotorbikeSalesStatistics(String modelFilter) {
        List<Map<String, Object>> motorbikeList = new ArrayList<>();
        
        // Câu truy vấn SQL để lấy thống kê số lượng xe bán ra và tổng doanh thu
        String sql = "SELECT m.model_name, "
                + "       COUNT(o.order_id) AS total_sold, "
                + "       SUM(o.total_amount) AS total_revenue "
                + "FROM orders o "
                + "JOIN motors mo ON o.motor_id = mo.motor_id "
                + "JOIN models m ON mo.model_id = m.model_id "
                + "WHERE o.order_status = 'Completed' ";

        // Nếu có mẫu xe lọc, thêm điều kiện vào câu truy vấn SQL
        if (modelFilter != null && !modelFilter.isEmpty()) {
            sql += "AND m.model_name = ? ";
        }

        // Sắp xếp theo số lượng xe bán ra giảm dần
        sql += "GROUP BY m.model_name "
                + "ORDER BY total_sold DESC";

        // Kết nối tới cơ sở dữ liệu và thực thi câu truy vấn
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Nếu có mẫu xe lọc, gán tham số vào câu truy vấn
            if (modelFilter != null && !modelFilter.isEmpty()) {
                ps.setString(1, modelFilter); // Gán giá trị mẫu xe lọc vào câu truy vấn
            }

            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua kết quả truy vấn và thêm vào danh sách
                while (rs.next()) {
                    Map<String, Object> motorbike = new HashMap<>();
                    motorbike.put("model_name", rs.getString("model_name"));
                    motorbike.put("total_sold", rs.getInt("total_sold"));
                    motorbike.put("total_revenue", rs.getDouble("total_revenue"));
                    motorbikeList.add(motorbike);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motorbikeList;  // Trả về danh sách thống kê
    }

    /**
     * Lấy danh sách các mẫu xe có sẵn trong cơ sở dữ liệu để lọc
     * 
     * @return Danh sách các mẫu xe
     */
    public List<String> getMotorbikeModels() {
        List<String> models = new ArrayList<>();
        
        // Câu truy vấn SQL để lấy các mẫu xe duy nhất từ cơ sở dữ liệu
        String sql = "SELECT DISTINCT model_name FROM models";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            // Duyệt qua kết quả truy vấn và thêm vào danh sách các mẫu xe
            while (rs.next()) {
                models.add(rs.getString("model_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return models;  // Trả về danh sách các mẫu xe
    }
}
