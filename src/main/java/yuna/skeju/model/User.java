package yuna.skeju.model;

/**
 * Created by ylee on 3/27/2016.
 */
public class User {
    static final long serialVersionUID = 1L;
    private String id;
    private String fbId;

/*
    public User(String id, String fbId) {
        this.id = id;
        this.fbId = fbId;
    }
    */

    public String getId() {
        return this.id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getFbId() {
        return this.fbId;
    }
    public void setFbId(String fbId) {
        this.fbId = fbId;
    }

    @Override
    public String toString() {
        return "User [id=" + this.id + ", fbId=" + this.fbId + "]";
    }
}
