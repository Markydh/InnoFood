package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShopInfo {
    private Integer shopID;
    private Integer managerID;
    private String  shopName;
    private String  psrc;
    private String  description;
    private String  address;
    private Double  star;
    private Integer state;
    private Integer shopTypeID;//店铺类别编号
    private String shopTypeName; //店铺类别名称
}
