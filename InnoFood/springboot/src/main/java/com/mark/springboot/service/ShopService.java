package com.mark.springboot.service;

import com.mark.springboot.entity.Shop;
import com.mark.springboot.mapper.ProductMapper;
import com.mark.springboot.mapper.ShopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopService {
    @Autowired
    private ShopMapper shopMapper;

    @Autowired
    private ProductMapper productMapper;

    public Integer save(Shop shop){
        if(shop.getShopID() == null){
            return shopMapper.insert(shop);
        }else{
            return shopMapper.update(shop);
        }
    }

    public Integer deleteShop(Integer shopID) {
        productMapper.deleteProductByShopID(shopID);
        return shopMapper.delete(shopID);
    }
}
