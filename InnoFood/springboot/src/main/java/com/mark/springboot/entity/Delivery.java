package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery {
    private Integer deliveryID;
    private String username;
    private String password;
    private String email;
    private String phone;
    private Double score;
    private String psrc;
    private String createDate;
}
