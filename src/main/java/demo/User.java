package demo;

/**
 * Created by wm2016 on 2/3/16.
 */
public class User {
	private int userId;
	private String username;
	public User(int userId, String username) {
		this.userId = userId;
		this.username = username;
	}

	public int getUserId() {
		return this.userId;
	}

	public String  getUsername() {
		return this.username;
	}
}