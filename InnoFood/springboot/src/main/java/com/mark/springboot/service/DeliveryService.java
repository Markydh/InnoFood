package com.mark.springboot.service;

import com.mark.springboot.entity.Delivery;
import com.mark.springboot.mapper.DeliveryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeliveryService {

    @Autowired
    private DeliveryMapper deliveryMapper;
    public Integer save(Delivery delivery){
        //新增或更新用户信息
        if(delivery.getDeliveryID() == null){
            return deliveryMapper.insert(delivery);
        }
        else{
            return deliveryMapper.update(delivery);
        }
    }
    public Integer findDeliveryByUsername(String username){
        Delivery delivery = deliveryMapper.findDeliveryByUsername(username);
        if (delivery != null) {
            return 0; //存在相同用户名，向前端返回0
        } else {
            return 1;
        }
    }
}
