package com.mark.springboot.service;

import com.mark.springboot.entity.ShopType;
import com.mark.springboot.mapper.ShopMapper;
import com.mark.springboot.mapper.ShopTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopTypeService {
    @Autowired
    private ShopTypeMapper shopTypeMapper;

    @Autowired
    private ShopMapper shopMapper;

    public Integer save(ShopType shopType) {
        if(shopType.getShopTypeID()==null){
            return shopTypeMapper.insert(shopType);
        }else{
            return shopTypeMapper.update(shopType);
        }
    }

    public String findShopTypeNameByID(Integer shopTypeID){
        return shopTypeMapper.findShopTypeNameByID(shopTypeID);
    }

    /***
     * 管理员删除店铺类别，应该把所有属于此类别的店铺全部删除
     * @param id
     * @return
     */
    public Integer deleteById(Integer id) {
        shopMapper.deleteShopByShopType(id);
        return shopTypeMapper.deleteById(id);
    }
}
