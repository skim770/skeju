package yuna.skeju.service;

import yuna.skeju.model.Event;

import java.util.List;

/**
 * Created by ylee on 3/10/2016.
 */
public interface EventManager {
    List<Event> getAllEvents();

    void create(Event event);
}
