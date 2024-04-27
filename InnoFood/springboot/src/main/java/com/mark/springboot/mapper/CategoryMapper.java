package com.mark.springboot.mapper;

import com.mark.springboot.entity.Product_category;

import java.util.List;

public interface CategoryMapper {

    List<Product_category> findCategoryByShopID(Integer shopID);

    List<Product_category> findCategoryByCategoryName(Integer shopID,String categoryname);

    Integer delete(Integer categoryID);

    Integer update(Product_category productCategory);

    Integer insert(Product_category productCategory);

    Integer deleteBatch(List<Integer> categoryIds);

    String findCategoryNameByID(Integer categoryID);
}
