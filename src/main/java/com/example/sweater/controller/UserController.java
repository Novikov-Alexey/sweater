package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {
    @Autowired
    private UserRepo userRepo;

    @GetMapping
    public String userList(Map<String, Object> model) {
        model.put("users", userRepo.findAll());
        return "userList";
    }

    @GetMapping("/{id}")
    public String userEditForm(@PathVariable Long id, Map<String, Object> model) {
        model.put("user", findUserById(id));
        model.put("roles", Role.values());
        return "userEdit";
    }

    @PostMapping
    public String userSave(@RequestParam String username, @RequestParam Map<String, String> form, @RequestParam("userID") Long id) {
        User user = findUserById(id);

        user.setUsername(username);
        user.getRoles().clear();
        for (String key : form.keySet()) {
            Arrays.stream(Role.values())
                    .filter(role -> role.name().equals(key))
                    .findAny()
                    .ifPresent(role -> user.getRoles().add(Role.valueOf(key)));
        }
        userRepo.save(user);

        return "redirect:/user";
    }

    private User findUserById(Long id) {
        return userRepo.findById(id).orElse(null);
    }
}
