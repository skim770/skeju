package yuna.skeju.mapper;

import yuna.skeju.model.User;

import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ylee on 3/27/2016.
 */
public class UserMapper implements RowMapper<User> {
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
        User user = new User();
        user.setId(rs.getString("Id"));
        user.setFbId(rs.getString("FbId"));
        return user;
    }
}
