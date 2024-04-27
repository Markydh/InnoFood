package com.mark.springboot.mapper;

import com.mark.springboot.Dto.DeliveryOrdersDTO;
import com.mark.springboot.entity.Delivery;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeliveryMapper {
    Integer insert(Delivery delivery);

    Integer update(Delivery delivery);

    Delivery login(Delivery delivery);
    Delivery findDeliveryByUsername(String username);

    List<Delivery> findDeliveryByPage(Integer pageNum, Integer pageSize, String username, String phone);

    Integer findTotal(String username, String phone);

    Delivery findDeliveryByID(Integer deliveryID);

    Integer deleteByID(@Param("id")Integer id);

    List<DeliveryOrdersDTO> findMonthlyOrders(Integer deliveryID);

    Integer findMonthlyOrder(Integer deliveryID);

    Delivery findDeliveryByDeliveryID(Integer deliveryID);
}
