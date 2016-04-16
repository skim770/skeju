package yuna.skeju.model;

import yuna.skeju.type.EventType;

import java.io.Serializable;

/**
 * Created by ylee on 3/7/2016.
 */


public class Point implements Serializable{
    static final long serialVersionUID = 1L;
    private EventType cls;
    private String pid;
    private String id;
    private String dockzone;
    private int x;
    private int y;
    private int r;

    /*
    public Point(String cls, String id, int x, int y, int r, String dockzone) {
        this.cls = cls;
        this.id = id;
        this.x = x;
        this.y = y;
        this.r = r;
        this.dockzone = dockzone;
    }
    */

    public EventType getCls() {
        return this.cls;
    }

    public void setCls(EventType type) {
        this.cls = type;
    }

    public String getPid() {
        return this.pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getX() {
        return this.x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return this.y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getR() {
        return this.r;
    }

    public void setR(int r) {
        this.r = r;
    }

    public String getDockzone() {
        return this.dockzone;
    }

    public void setDockzone(String dockzone) {
        this.dockzone = dockzone;
    }

    @Override
    public String toString() {
        return "Point [id=" + this.pid + ", x=" + this.x + ", cls=" + this.cls
                + ", y=" + this.y + "]";
    }
}