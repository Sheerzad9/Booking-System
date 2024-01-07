package com.myapp.backend.controller;


import com.myapp.backend.dao.RoleDao;
import com.myapp.backend.dao.UserDao;
import com.myapp.backend.dto.request.RegisterRequest;
import com.myapp.backend.model.Role;
import com.myapp.backend.model.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    UserDao userDao;

    @Autowired
    RoleDao roleDao;

    @Autowired
    PasswordEncoder passwordEncoder;

    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody RegisterRequest registerRequest){
        if(userDao.existsByEmail(registerRequest.getEmail())){
            return new ResponseEntity<>("Email is already taken", HttpStatus.BAD_REQUEST);
        }


        UserEntity user = new UserEntity();
        user.setFirstName(registerRequest.getFirstName());
        user.setLastName(registerRequest.getLastName());
        user.setEmail(registerRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));

        // Get's the default role of customer. Only Admin can add employee role
        Role role = roleDao.findByRole("CUSTOMER").get();
        user.setRoles(Collections.singletonList(role));

        userDao.saveAndFlush(user);

        return  new ResponseEntity<>("User created successfully!", HttpStatus.OK);
    }
}
