package com.mark.springboot.mapper;

import com.mark.springboot.entity.Product;

import java.util.List;

public interface ProductMapper {
    List<Product> findAll();

    List<Product> findProductByShopID(Integer shopID);

    Integer insert(Product product);

    Integer update(Product product);

    Integer delete(Integer productID);

    Integer deleteBatch(List<Integer> productIds);

    List<Product> findProductByCategoryID(Integer shopID, Integer categoryID);

    Product findProductByProductID(Integer productID);

    void deleteProductByShopID(Integer shopID);
}
