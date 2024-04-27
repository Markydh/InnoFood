package com.mark.springboot.mapper;


import com.mark.springboot.Dto.EveryShopOrderDTO;
import com.mark.springboot.Dto.ManagerShopPriceDTO;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;

import java.util.List;

public interface ManagerMapper {

    List<Manager> findAll();

    Integer insert(Manager manager);

    Integer update(Manager manager);

    Manager login(Manager manager);

    Manager findManagerByID(Integer managerID);

    Manager findManagerByUsername(String username);

    List<Manager> findManagerByPage(Integer pageNum, Integer pageSize, String username, String email);

    Integer findTotal(String username, String email);

    Integer managerFrost(Manager managerMapper);

    Integer managerThaw(Manager managerMapper);

    Integer findTotalPriceByManagerId(Integer managerID);

    List<ManagerShopPriceDTO> findShopTotalByManagerId(Integer managerID);

    List<EveryShopOrderDTO> findShopOrders(Integer managerID);
}
