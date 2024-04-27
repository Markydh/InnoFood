package com.mark.springboot.mapper;

import com.mark.springboot.Dto.ProductCategorySalesDTO;
import com.mark.springboot.Dto.ProductMonthlySalesDTO;
import com.mark.springboot.Dto.ShopMonthlySalesDTO;
import com.mark.springboot.entity.Shop;
import com.mark.springboot.entity.User;

import java.util.List;

public interface ShopMapper {

    List<Shop> findAll();

    //通过shopID查找shop
    Shop findShopByShopID(Integer shopID);

    Integer insert(Shop shop);

    Integer update(Shop shop);

    //根据商家编号和店铺名称搜索指定店铺
    List<Shop> findShopByShopNameAndManagerID(String shopName, Integer managerID);

    List<Shop> findShopByManagerID(Integer managerID);

    Integer delete(Integer shopID);

    List<Shop> guess(Integer userID);

    List<ProductMonthlySalesDTO> productMonthlySales(Integer shopID);

    List<ProductCategorySalesDTO> productCategorySales(Integer shopID);

    Double getShopTotalMoney(Integer shopID);

    List<ShopMonthlySalesDTO> getShopMonthlySales(Integer shopID);

    void deleteShopByShopType(Integer id);
}