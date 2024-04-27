package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShopMonthlySalesDTO {
    private Integer shop_year;
    private Integer shop_month;
    private Integer shop_sales;
}
