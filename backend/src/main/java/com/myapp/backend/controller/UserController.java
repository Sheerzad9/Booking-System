package com.myapp.backend.controller;

import com.myapp.backend.dao.UserDao;
import com.myapp.backend.dto.request.GetUserByEmailRequest;
import com.myapp.backend.model.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;

@Controller
@RequestMapping("/public")
public class UserController {
    @Autowired
    UserDao userDao;

    @GetMapping("/user")
    public ResponseEntity<Object> getUserByEmail(@RequestBody GetUserByEmailRequest getUserByEmailRequest) {
        try {
         Optional<UserEntity> user = userDao.findByEmail(getUserByEmailRequest.getEmail());
         if (user.isPresent()) {
             return new ResponseEntity<>(user, HttpStatus.OK);
         }

         String errorMsg = getUserByEmailRequest.getEmail() == null ?
                 String.format("User with %s email not found in the database.", getUserByEmailRequest.getEmail())
                 : "Request body is invalid, please be sure that there is 'email' key value in the request.";
         return new ResponseEntity<>( errorMsg, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>("Something went wrong", HttpStatus.BAD_REQUEST);
        }
    }
}
