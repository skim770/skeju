package yuna.skeju.dao;

import yuna.skeju.model.Event;

import javax.sql.DataSource;
import java.util.List;

/**
 * Created by ylee on 3/10/2016.
 */
public interface EventDAO {
    List<Event> getAllEvents();

    void setDataSource(DataSource ds);

    void create(Event event);
}
