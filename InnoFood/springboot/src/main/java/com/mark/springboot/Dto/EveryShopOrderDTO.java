package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EveryShopOrderDTO {
    private Integer order_shopID;
    private String order_shopName;
    private Integer monthly_orders;
}
