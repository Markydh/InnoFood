package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 用来做中间类，获取对应商品的类别名
public class ProductInfo {
    private Integer productID;
    private Integer categoryID;
    private Integer shopID;
    private String  productname;
    private String psrc;
    private Integer product_rest;
    private Integer sales;
    private Double price;
    private String description;
    private String categoryname;
}
