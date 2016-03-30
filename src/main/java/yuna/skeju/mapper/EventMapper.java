package yuna.skeju.mapper;

import org.springframework.jdbc.core.RowMapper;
import yuna.skeju.model.Event;
import yuna.skeju.type.EventType;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ylee on 3/24/2016.
 */
public class EventMapper implements RowMapper<Event> {
    public Event mapRow(ResultSet rs, int rowNum) throws SQLException {
        Event event = new Event();
        event.setCls(rs.getString("Cls").equals("first") ? EventType.first : EventType.second);
        event.setEventIdentifier(rs.getString("EventId"));
        event.setUserId(rs.getString("UserId"));
        event.setOtherId(rs.getString("OtherId"));
        event.setAvailability(rs.getString("Availability"));
        event.setStartDate(rs.getString("StartDate"));
        event.setEndDate(rs.getString("EndDate"));
        event.setAllDay(rs.getString("AllDay"));
        event.setOccurrenceDate(rs.getString("OccurenceDate"));
        event.setIsDetached(rs.getString("IsDetached"));
        event.setOrganizer(rs.getString("Organizer"));
        event.setStatus(rs.getString("Status"));

        return event;
    }
}
