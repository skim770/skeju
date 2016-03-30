package yuna.skeju.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import yuna.skeju.model.User;
import yuna.skeju.service.UserManager;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by ylee on 3/27/2016.
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserManager manager;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<User> getAllUsers(Model model) {
        model.addAttribute("user", manager.getAllUsers());
        return manager.getAllUsers();
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity addUser(@RequestParam("id") String id, @RequestParam("fbId") String fbId) { //
        User user = new User();
        user.setId(id);
        user.setFbId(fbId);
        manager.create(user);
        return new ResponseEntity(user, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public String getUser(@PathVariable String userId) {
        return String.format("Looking for User %s\n", userId);
    }

}

