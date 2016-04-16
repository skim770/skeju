package yuna.skeju.model;

import yuna.skeju.type.EventType;

/**
 * Created by ylee on 3/10/2016.
 */
public class Event {
    static final long serialVersionUID = 1L;
    private EventType cls;
    private String eventIdentifier;
    private String userId;
    private String otherId;

    private String availability;
    private String startDate;
    private String endDate;
    private String allDay;
    private String occurrenceDate;
    private String isDetached;
    private String organizer;
    private String status;

    public EventType getCls() {
        return this.cls;
    }
    public void setCls(EventType cls) {
        this.cls = cls;
    }
    public String getEventIdentifier() {
        return this.eventIdentifier;
    }
    public void setEventIdentifier(String eventIdentifier) {
        this.eventIdentifier = eventIdentifier;
    }
    public String getUserId() {
        return this.userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getOtherId() {
        return this.otherId;
    }
    public void setOtherId(String otherId) {
        this.otherId = otherId;
    }
    public String getAvailability() {
        return this.availability;
    }
    public void setAvailability(String availability) {
        this.availability = availability;
    }
    public String getStartDate() {
        return this.startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    public String getEndDate() {
        return this.endDate;
    }
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    public String getAllDay() {
        return this.allDay;
    }
    public void setAllDay(String allDay) {
        this.allDay = allDay;
    }
    public String getOccurrenceDate() {
        return this.occurrenceDate;
    }
    public void setOccurrenceDate(String occurrenceDate) {
        this.occurrenceDate = occurrenceDate;
    }
    public String getIsDetached() {
        return this.isDetached;
    }
    public void setIsDetached(String isDetached) {
        this.isDetached = isDetached;
    }
    public String getOrganizer() {
        return this.organizer;
    }
    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }
    public String getStatus() {
        return this.status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
