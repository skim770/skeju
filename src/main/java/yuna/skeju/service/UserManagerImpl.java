package yuna.skeju.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuna.skeju.dao.UserDAO;
import yuna.skeju.model.User;

import java.util.List;

/**
 * Created by gatsby on 3/29/16.
 */
@Service
public class UserManagerImpl implements UserManager {
    @Autowired
    UserDAO dao;

    public List<User> getAllUsers() {
        return dao.getAllUsers();
    }

    public void create(User user) {
        dao.create(user);
    }
}