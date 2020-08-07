package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Map<String, Object> model) {
        model.put("users", userService.findAll());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/{id}")
    public String userEditForm(@PathVariable Long id, Map<String, Object> model) {
        model.put("user", userService.findUserById(id));
        model.put("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(@RequestParam String username, @RequestParam Map<String, String> form, @RequestParam("userID") Long id) {
        userService.saveUser(username, form, id);
        return "redirect:/user";
    }

    @GetMapping("profile")
    public String getProfile(Map<String, Object> model, @AuthenticationPrincipal User user) {
        model.put("username", user.getUsername());
        model.put("email", user.getEmail());
        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(@AuthenticationPrincipal User user, @RequestParam String password, @RequestParam String email) {
        userService.updateProfile(user, password, email);
        return "redirect:/user/profile";
    }

}
