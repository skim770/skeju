package yuna.skeju.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import yuna.skeju.mapper.UserMapper;
import yuna.skeju.model.User;

import javax.sql.DataSource;
import java.util.List;

/**
 * Created by gatsby on 3/29/16.
 */

@Repository("userDAO")
public class UserDAOImpl implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<User> getAllUsers() {
        String query = "SELECT * FROM user"; //  where id = ?"
        List<User> users = jdbcTemplate.query(query, new UserMapper());
        return users;
    }

    public void create(User user) {
        String query = "INSERT INTO user VALUES(?,?)";
        this.jdbcTemplate.update(query, "User", user.getId(), user.getFbId());
    }
}
