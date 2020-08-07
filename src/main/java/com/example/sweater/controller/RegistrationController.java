package com.example.sweater.controller;

import com.example.sweater.domain.User;
import com.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
    @Autowired
    UserService userService;

    @GetMapping
    public String registration() {
        return "registration";
    }

    @PostMapping
    public String addUser(User user, Map<String, Object> model) {

        if (!userService.addUser(user)) {
            model.put("message", "User exists!");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Map<String, Object> model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.put("message", "User successfully activated");
        } else {
            model.put("message", "Activation code is not found");
        }
        return "login";
    }
}
