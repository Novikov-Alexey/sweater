package com.example.sweater.controller;

import com.example.sweater.domain.User;
import com.example.sweater.domain.dto.CaptchaResponseDto;
import com.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
@RequestMapping("/registration")
public class RegistrationController {

    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String secret;

    @GetMapping
    public String registration() {
        return "registration";
    }

    @PostMapping
    public String addUser(@RequestParam("passwordСonfirmation") String passwordСonfirmation, @RequestParam("g-recaptcha-response") String captchaResponse, @Valid User user, BindingResult bindingResult, Map<String, Object> model) {

        String url = String.format(CAPTCHA_URL, secret, captchaResponse);
        CaptchaResponseDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);

        if (!response.isSuccess()) {
            model.put("captchaError", "Fill captcha");
        }

        if (response.getErrorCodes() != null && !response.getErrorCodes().isEmpty()) {
            model.put("captchaCodeError", response.getErrorCodes().toString());
        }

        if (StringUtils.isEmpty(passwordСonfirmation)) {
            model.put("passwordСonfirmationError", "Password Сonfirmation cannot be empty");
        }

        if (user.getPassword() != null && !user.getPassword().equals(passwordСonfirmation)) {
            model.put("passwordError", "Password are different!");
        }

        if (bindingResult.hasErrors()) {
            model.putAll(ControllerUtils.getErrors(bindingResult));
        }

        if (ControllerUtils.errorExists(model)) return "registration";

        if (!userService.addUser(user)) {
            model.put("usernameError", "User exists!");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Map<String, Object> model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.put("message", "User successfully activated");
            model.put("messageType", "success");
        } else {
            model.put("message", "Activation code is not found");
            model.put("messageType", "danger");
        }
        return "login";
    }
}
