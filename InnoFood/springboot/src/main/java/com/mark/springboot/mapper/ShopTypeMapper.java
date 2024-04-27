package com.mark.springboot.mapper;

import com.mark.springboot.entity.ShopType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopTypeMapper {

    Integer insert(ShopType shopType);

    Integer update(ShopType shopType);

    List<ShopType> findAll();

    String findShopTypeNameByID(Integer shopTypeID);

    Integer deleteById(@Param("id") Integer id);
}
