package yuna.skeju.model;

import yuna.skeju.type.EventType;

/**
 * Created by ylee on 3/10/2016.
 */
public class Event {
    static final long serialVersionUID = 1L;
    private EventType cls;
    private String name;
    private String id;


    public EventType getCls() {
        return this.cls;
    }

    public void setCls(EventType type) {
        this.cls = type;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String pid) {
        this.name = name;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

}
