package models;

public class Event {

    private int event_id;
    private String event_name;
    private String event_details;
    private String image;
    private String date_start;
    private String date_end;
    private boolean event_status;
    private int user_id;

    public Event() {
    }

    public Event(String event_name, String event_details, String image, String date_start, String date_end, boolean event_status) {
        this.event_name = event_name;
        this.event_details = event_details;
        this.image = image;
        this.date_start = date_start;
        this.date_end = date_end;
        this.event_status = event_status;
    }

    public Event(String event_name, String event_details, String image, String date_start, String date_end, boolean event_status, int user_id) {
        this.event_name = event_name;
        this.event_details = event_details;
        this.image = image;
        this.date_start = date_start;
        this.date_end = date_end;
        this.event_status = event_status;
        this.user_id = user_id;
    }

    public int getEvent_id() { return event_id; }
    public void setEvent_id(int event_id) { this.event_id = event_id; }
    public String getEvent_name() { return event_name; }
    public void setEvent_name(String event_name) { this.event_name = event_name; }
    public String getEvent_details() { return event_details; }
    public void setEvent_details(String event_details) { this.event_details = event_details; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getDate_start() { return date_start; }
    public void setDate_start(String date_start) { this.date_start = date_start; }
    public String getDate_end() { return date_end; }
    public void setDate_end(String date_end) { this.date_end = date_end; }
    public boolean isEvent_status() { return event_status; }
    public void setEvent_status(boolean event_status) { this.event_status = event_status; }
    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    @Override
    public String toString() {
        return "Event{event_id=" + event_id + ", event_name=" + event_name + ", event_details=" + event_details 
               + ", image=" + image + ", date_start=" + date_start + ", date_end=" + date_end 
               + ", event_status=" + event_status + ", user_id=" + user_id + '}';
    }
}