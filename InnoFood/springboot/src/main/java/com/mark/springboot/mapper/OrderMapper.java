package com.mark.springboot.mapper;


import com.mark.springboot.Dto.MonthMoneyDTO;
import com.mark.springboot.Dto.OrderDto;
import com.mark.springboot.entity.Order;
import com.mark.springboot.entity.OrderDetail;

import java.util.List;

public interface OrderMapper {

    void insertOrder(Order order);

    void insertOrderDetail(OrderDetail orderDetail);

    List<Order> findNewOrderByShopID(Integer shopID, Integer pageNum, Integer pageSize);

    Integer countNewOrderNum(Integer shopID);

    Integer updateOrderStateTo1(Integer orderID);

    Integer countOldOrderNum(Integer shopID);

    List<Order> findOldOrderByShopID(Integer shopID, Integer pageNum, Integer pageSize);

    List<OrderDetail> findOrderDetailByOrderID(Integer orderID);

    //通过店铺编号查询订单
    List<Order> findDoneOrderByShopID(Integer shopID);

    List<Order> findDeliveryToPickOrder(Integer pageNum, Integer pageSize);

    Integer countAllDeliveryToPickOrder();

    Integer updateOrderStateTo2(Integer orderID,Integer deliveryID);

    List<OrderDto> findDeliveryDoneOrder(Integer pageNum, Integer pageSize, Integer deliveryID);

    Integer countDeliveryDoneOrder(Integer deliveryID);

    Order findOrderByOrderID(Integer orderID);

    List<Order> findOrderByPage(Integer pageNum, Integer pageSize, Integer userID, Integer orderState);

    Integer findTotal(Integer userID, Integer orderState);

    List<OrderDetail> findDetailByOrderId(Integer orderID);

    Integer getCountByUserId(Integer userID, Integer order_state);

    Integer getMoney(Integer userID);

    List<MonthMoneyDTO> getMonthMoney(Integer userID);

    Integer updateOrderStateTo3(Integer orderID);

}
