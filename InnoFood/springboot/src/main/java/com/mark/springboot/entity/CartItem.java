package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    private Integer productID; //商品编号
    private String psrc;
    private String productname;//商品名称
    private Double price;      //商品单价
    private Integer quantity;  //商品数量
}
