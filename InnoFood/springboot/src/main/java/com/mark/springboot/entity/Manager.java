package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Manager {
    private Integer managerID;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String nickname;
    private String psrc;
    private int state;
    private String createDate;
}
