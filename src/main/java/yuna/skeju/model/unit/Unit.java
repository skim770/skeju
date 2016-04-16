package yuna.skeju.model.unit;

import yuna.skeju.type.UnitType;

import java.io.Serializable;

/**
 * Created by ylee on 3/10/2016.
 */
public class Unit implements Serializable {
    static final long serialVersionUID = 1L;
    private UnitType cls;
    private String sid;
    private String id;
    private int width;
    private int height;
    private String dockzone;
    private String doorslot;
    private String transform;

    /*
        public Unit(String sid, String id, int width, int height, String dockzone, String doorslot, String transform) {
            this.sid = sid;
            this.id = id;
            this.cls = UnitType.Event;
            this.width = width;
            this.height = height;
            this.dockzone = dockzone;
            this.doorslot = doorslot;
            this.transform = transform;
        }
    */
    public String getSid() {
        return this.sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public UnitType getCls() {
        return UnitType.Slot;
    }

    public UnitType setCls() {
        return this.cls = UnitType.Slot;
    }

    //public void setCls(UnitType cls) {
    //   this.cls = cls;
    // }

    public int getWidth() {
        return this.width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return this.height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getDockzone() {
        return this.dockzone;
    }

    public void setDockzone(String dockzone) {
        this.dockzone = dockzone;
    }

    public String getDoorslot() {
        return this.doorslot;
    }

    public void setDoorslot(String doorslot) {
        this.doorslot = doorslot;
    }

    public String getTransform() {
        return this.transform;
    }

    public void setTransform(String transform) {
        this.transform = transform;
    }
}
