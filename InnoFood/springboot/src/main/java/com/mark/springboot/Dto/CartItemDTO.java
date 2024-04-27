package com.mark.springboot.Dto;

import com.mark.springboot.entity.CartItem;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItemDTO {
    private List<CartItem> cart;
    private Integer userID;
    private Integer shopID;
    private Double shippingFee;  //配送费
    private Double subtotal;     //商品总价
    private Double totalAmount;  //订单总费用
}
