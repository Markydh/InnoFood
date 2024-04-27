package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryOrdersDTO {
    private Integer order_year;
    private Integer order_month;
    private Integer monthly_order;

}
