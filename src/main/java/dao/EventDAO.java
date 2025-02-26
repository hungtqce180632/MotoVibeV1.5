package dao;

import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import models.Event;

public class EventDAO {

    public boolean createEvent(Event event, byte[] imageBytes) {
        String sql = "INSERT INTO events (event_name, event_details, image, date_start, date_end, event_status, user_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("Database connection is null - check DBContext configuration");
                return false;
            }
            System.out.println("Database connection established");

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, event.getEvent_name());
                stmt.setString(2, event.getEvent_details());
                if (imageBytes != null && imageBytes.length > 0) {
                    stmt.setBytes(3, imageBytes);
                    System.out.println("Image set as binary, size: " + imageBytes.length);
                } else {
                    stmt.setNull(3, java.sql.Types.VARBINARY);
                    System.out.println("Image set as NULL");
                }

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                stmt.setDate(4, java.sql.Date.valueOf(LocalDate.parse(event.getDate_start(), formatter)));
                stmt.setDate(5, java.sql.Date.valueOf(LocalDate.parse(event.getDate_end(), formatter)));
                stmt.setBoolean(6, event.isEvent_status());
                stmt.setInt(7, event.getUser_id());

                System.out.println("Executing SQL: " + sql);
                System.out.println("Parameters: " + event + ", Image size: " + (imageBytes != null ? imageBytes.length : 0));

                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    System.out.println("Event inserted successfully: " + event);
                    return true;
                } else {
                    System.out.println("No rows affected, insertion failed: " + event);
                    return false;
                }
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in createEvent: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    public Event getEventById(int eventId) throws SQLException {
        String sql = "SELECT * FROM events WHERE event_id = ?";
        Event event = new Event();

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    event.setEvent_id(rs.getInt("event_id"));
                    event.setEvent_name(rs.getString("event_name"));
                    event.setEvent_details(rs.getString("event_details"));
                    event.setImage(rs.getBytes("image") != null ? "Image stored" : null);
                    event.setDate_start(rs.getDate("date_start") != null ? rs.getDate("date_start").toString() : null);
                    event.setDate_end(rs.getDate("date_end") != null ? rs.getDate("date_end").toString() : null);
                    event.setEvent_status(rs.getBoolean("event_status"));
                    event.setUser_id(rs.getInt("user_id"));
                }
            }
        }
        return event;
    }

    public static List<Event> getAllEventsAvailable() throws SQLException {
        String sql = "SELECT * FROM events WHERE event_status = 1 AND date_end > CAST(GETDATE() AS date)";
        List<Event> events = new ArrayList<>();

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql); 
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Event event = new Event();
                event.setEvent_id(rs.getInt("event_id"));
                event.setEvent_name(rs.getString("event_name"));
                event.setEvent_details(rs.getString("event_details"));
                event.setImage(rs.getBytes("image") != null ? "Image stored" : null);
                event.setDate_start(rs.getDate("date_start") != null ? rs.getDate("date_start").toString() : null);
                event.setDate_end(rs.getDate("date_end") != null ? rs.getDate("date_end").toString() : null);
                event.setEvent_status(rs.getBoolean("event_status"));
                event.setUser_id(rs.getInt("user_id"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
}