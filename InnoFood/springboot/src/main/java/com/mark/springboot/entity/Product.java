package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    private Integer productID;
    private Integer categoryID;
    private Integer shopID;
    private String  productname;
    private String psrc;
    private Integer product_rest;
    private Integer sales;
    private Double price;
    private String description;
}
