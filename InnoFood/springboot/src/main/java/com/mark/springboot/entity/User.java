package com.mark.springboot.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer userID;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private String phone;
    private String address;
    private Integer score; //积分
    private String psrc;
    private Integer state;//账号状态
    private String createDate;
}
