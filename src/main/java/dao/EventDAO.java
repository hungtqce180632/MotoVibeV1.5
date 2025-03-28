package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import models.Event;
import utils.DBContext;

public class EventDAO {

    public boolean createEvent(Event event, byte[] imageBytes) {
        String sql = "INSERT INTO events (event_name, event_details, image, date_start, date_end, event_status, user_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("Database connection is null - check DBContext configuration");
                return false;
            }
            System.out.println("Database connection established");

            try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        Event event = null;

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set the event_id parameter to the prepared statement
            stmt.setInt(1, eventId);

            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Map the result set to an Event object
                    event = new Event();
                    event.setEvent_id(rs.getInt("event_id"));
                    event.setEvent_name(rs.getString("event_name"));
                    event.setEvent_details(rs.getString("event_details"));
                    
                    // Handle the image data
                    byte[] imageBytes = rs.getBytes("image");
                    if (imageBytes != null) {
                        // Store the actual bytes in a custom attribute
                        event.setImageBytes(imageBytes);
                        event.setImage("data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imageBytes));
                    } else {
                        event.setImage(null);
                    }
                    
                    event.setDate_start(rs.getDate("date_start") != null ? rs.getDate("date_start").toString() : null);
                    event.setDate_end(rs.getDate("date_end") != null ? rs.getDate("date_end").toString() : null);
                    event.setEvent_status(rs.getBoolean("event_status"));  // Assuming event_status is a boolean
                    event.setUser_id(rs.getInt("user_id"));
                }
            }
        } catch (SQLException ex) {
            throw new SQLException("Error while retrieving event: " + ex.getMessage(), ex);
        }

        return event;  // Return the event object or null if no event found
    }

    public static List<Event> getAllEventsAvailable() throws SQLException {
        String sql = "SELECT * FROM events WHERE event_status = 1 AND date_end > CAST(GETDATE() AS date)";
        List<Event> events = new ArrayList<>();

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Event event = new Event();
                event.setEvent_id(rs.getInt("event_id"));
                event.setEvent_name(rs.getString("event_name"));
                event.setEvent_details(rs.getString("event_details"));
                
                // Handle the image data - store event_id instead of hardcoded text
                byte[] imageBytes = rs.getBytes("image");
                if (imageBytes != null && imageBytes.length > 0) {
                    // For performance reasons, we don't set the full base64 image for list view
                    // Just indicate that the image exists
                    event.setImage("exists");
                } else {
                    event.setImage(null);
                }
                
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

    // Method to get all events (without filter)
    public static List<Event> getAllEvents() throws SQLException {
        String sql = "SELECT event_id, event_name, event_details, image, date_start, date_end, event_status, user_id FROM events"; // No filter applied here
        List<Event> events = new ArrayList<>();

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Event event = new Event();
                event.setEvent_id(rs.getInt("event_id"));
                event.setEvent_name(rs.getString("event_name"));
                event.setEvent_details(rs.getString("event_details"));
                
                // Handle the image data - store event_id instead of hardcoded text
                byte[] imageBytes = rs.getBytes("image");
                if (imageBytes != null && imageBytes.length > 0) {
                    // For performance reasons, we don't set the full base64 image for list view
                    // Just indicate that the image exists
                    event.setImage("exists");
                } else {
                    event.setImage(null);
                }
                
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

    public static boolean updateEvent(Event event, byte[] imageBytes) throws SQLException {
        String sql = "UPDATE [MotoVibeDB].[dbo].[events] SET event_name = ?, event_details = ?, image = ?, date_start = ?, date_end = ?, event_status = ? WHERE event_id = ?";
        try ( Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.out.println("Database connection is null - check DBContext configuration");
                return false;
            }
            try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, event.getEvent_name());
                stmt.setString(2, event.getEvent_details());
                if (imageBytes != null && imageBytes.length > 0) {
                    stmt.setBytes(3, imageBytes);
                } else {
                    stmt.setNull(3, java.sql.Types.VARBINARY);
                }
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                stmt.setDate(4, java.sql.Date.valueOf(LocalDate.parse(event.getDate_start(), formatter)));
                stmt.setDate(5, java.sql.Date.valueOf(LocalDate.parse(event.getDate_end(), formatter)));
                stmt.setBoolean(6, event.isEvent_status());
                stmt.setInt(7, event.getEvent_id());

                int affectedRows = stmt.executeUpdate();
                System.out.println("Updated " + affectedRows + " rows for event_id: " + event.getEvent_id());
                return affectedRows > 0;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in updateEvent: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEvent(int eventId) throws SQLException {
        String sql = "DELETE FROM events WHERE event_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean changeEventStatus(int eventId) throws SQLException {
        String sql = "UPDATE events SET event_status = NOT event_status WHERE event_id = ?";

        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("Database connection is null - check DBContext configuration");
                return false;
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Set the event_id parameter
                stmt.setInt(1, eventId);

                // Execute the update query
                int rowsAffected = stmt.executeUpdate();

                // Return true if the status was successfully updated
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error changing event status: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Explicitly disable an event by setting event_status to false
     * @param eventId the ID of the event to disable
     * @return true if successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean disEvent(int eventId) throws SQLException {
        String sql = "UPDATE events SET event_status = 0 WHERE event_id = ?";
        System.out.println("Attempting to disable event ID: " + eventId);

        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("Database connection is null - check DBContext configuration");
                return false;
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Set the event_id parameter
                stmt.setInt(1, eventId);
                System.out.println("Executing SQL: " + sql + " with parameter: " + eventId);

                // Execute the update query
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected by disabling event: " + rowsAffected);

                // Return true if the status was successfully updated
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error disabling event: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Explicitly activate an event by setting event_status to true
     * @param eventId the ID of the event to activate
     * @return true if successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean actEvent(int eventId) throws SQLException {
        String sql = "UPDATE events SET event_status = 1 WHERE event_id = ?";
        System.out.println("Attempting to activate event ID: " + eventId);

        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("Database connection is null - check DBContext configuration");
                return false;
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Set the event_id parameter
                stmt.setInt(1, eventId);
                System.out.println("Executing SQL: " + sql + " with parameter: " + eventId);

                // Execute the update query
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected by activating event: " + rowsAffected);

                // Return true if the status was successfully updated
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error activating event: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}
