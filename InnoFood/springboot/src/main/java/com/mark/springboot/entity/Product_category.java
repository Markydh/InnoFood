package com.mark.springboot.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product_category {
    private Integer categoryID;
    private String  categoryname;
    private Integer shopID;
}
