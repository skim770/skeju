package yuna.skeju.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuna.skeju.dao.EventDAO;
import yuna.skeju.model.Event;

import java.util.List;

/**
 * Created by ylee on 3/10/2016.
 */

@Service
public class EventManagerImpl implements EventManager {
    @Autowired
    EventDAO dao;

    public List<Event> getAllEvents() {
        return dao.getAllEvents();
    }

    public void create(Event event) {
        dao.create(event);
    }
}
