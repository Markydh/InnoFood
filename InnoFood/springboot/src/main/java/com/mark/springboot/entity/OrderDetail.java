package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {
    private Integer detailID;
    private Integer orderID;
    private Integer productID;
    private String  productname;
    private Integer quantity;
    private Double  price;
}
