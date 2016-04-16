package yuna.skeju.dao;

import yuna.skeju.model.User;

import javax.sql.DataSource;
import java.util.List;

/**
 * Created by ylee on 3/27/2016.
 */
public interface UserDAO {
    List<User> getAllUsers();

    void setDataSource(DataSource ds);

    void create(User user);
}
