package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDto {
    private Integer orderID;  //订单编号
    private Integer userID;   //用户编号
    private Integer shopID;   //店铺编号
    private Integer deliveryID;  //配送员编号
    private String create_time;  //订单创建时间
    private Integer order_state;  //订单状态（0：商家未接单，1：商家接单骑手未接单，2：骑手接单但是未送达，3：订单送达）
    private Double good_total;   //菜品总价格
    private Double delivery_price; //配送价格
    private Double total_price;  //订单总价格
    private String order_time;   //店铺接单时间
    private String pick_time;    //配送员接单时间
    private String arrive_time;  //外卖送达时间
    private String username;    //用户名
    private String shopName;    //店铺名
    private String userAddress; //用户地址
    private String shopAddress; //用户地址
}
