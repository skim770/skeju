package yuna.skeju.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import yuna.skeju.model.Event;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

@Repository("eventDAO")
public class EventDAOImpl implements EventDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<Event>();
        return events;
    }

    public void create(Event event) {
        String query = "INSERT INTO event VALUES(?,?,?)";
        this.jdbcTemplate.update(query, event.getCls().toString());
    }
}
