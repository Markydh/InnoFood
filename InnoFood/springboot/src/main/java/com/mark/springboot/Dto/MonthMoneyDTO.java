package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MonthMoneyDTO {
    // 用户该月消费总数
    private int month1;
    private int year;
    private double totalSpent;
}
