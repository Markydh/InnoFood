package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shop {
    private Integer shopID;
    private Integer managerID;
    private String  shopName;
    private String  psrc;
    private String  description;
    private String  address;
    private Double  star;
    private Integer state;
    private Integer shopTypeID;//店铺类别编号
}
