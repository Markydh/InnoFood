package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ManagerShopPriceDTO {
    // 店铺当月销售额
    private int shopID;
    private String shopName;
    private double totalPrice;
}
