package yuna.skeju.service;

import yuna.skeju.model.User;

import java.util.List;

/**
 * Created by gatsby on 3/29/16.
 */
public interface UserManager {
    List<User> getAllUsers();
    void create(User user);
}