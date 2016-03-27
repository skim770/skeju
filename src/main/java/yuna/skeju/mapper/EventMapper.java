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
        event.setId(rs.getString("Id"));
        event.setName(rs.getString("Name"));
        return event;
    }
}
