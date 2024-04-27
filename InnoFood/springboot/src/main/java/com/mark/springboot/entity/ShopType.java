package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShopType {
    private Integer shopTypeID;
    private String shopTypeName;
}
