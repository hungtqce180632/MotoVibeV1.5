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

public class MotoBikeStatisticsDAO {

    /**
     * Lấy thống kê số lượng xe bán ra theo từng mẫu xe
     */
    public List<Map<String, Object>> getMotorbikeSalesStatistics() {
        List<Map<String, Object>> motorbikeList = new ArrayList<>();
        String sql = "SELECT m.model_name, " +
                     "       COUNT(o.order_id) AS total_sold, " +
                     "       SUM(o.total_amount) AS total_revenue " +
                     "FROM orders o " +
                     "JOIN motors mo ON o.motor_id = mo.motor_id " +
                     "JOIN models m ON mo.model_id = m.model_id " +
                     "WHERE o.order_status = 'Completed' " +
                     "GROUP BY m.model_name " +
                     "ORDER BY total_sold DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> motorbike = new HashMap<>();
                motorbike.put("model_name", rs.getString("model_name"));
                motorbike.put("total_sold", rs.getInt("total_sold"));
                motorbike.put("total_revenue", rs.getDouble("total_revenue"));
                motorbikeList.add(motorbike);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motorbikeList;
    }
}
