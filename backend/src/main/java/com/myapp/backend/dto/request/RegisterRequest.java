package com.myapp.backend.dto.request;

import lombok.Data;

@Data
public class RegisterRequest {
    private String firstName;

    private String lastName;

    private String email;

    private String password;

    @Override
    public String toString() {
        return "firstName: " + firstName + " lastName: " + lastName + " email: " + email + " password: " + password;
    }
}
