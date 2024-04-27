package com.mark.springboot.controller;

import com.mark.springboot.Dto.DeliveryOrdersDTO;
import com.mark.springboot.entity.Delivery;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.DeliveryMapper;
import com.mark.springboot.service.DeliveryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/delivery")
public class DeliveryController {
    @Autowired
    private DeliveryMapper deliveryMapper;

    @Autowired
    private DeliveryService deliveryService;

    //用户登录，用来判断前端传入的用户是否存在数据库中
    @PostMapping("/login")
    public Delivery login(@RequestBody Delivery delivery){
        return deliveryMapper.login(delivery);
    }

    //用户注册，在用户注册时判断用户名是否存在，若存在返回0给前端，不存在则返回1
    @GetMapping("/register")
    public Integer findDeliveryByUsername(@RequestParam String username) {
        return deliveryService.findDeliveryByUsername(username);
    }

    @PostMapping
    public  Integer save(@RequestBody Delivery delivery){
        return deliveryService.save(delivery);
    }


    // 获取配送员每月配送订单数
    @GetMapping("/monthlyOrders")
    public List<DeliveryOrdersDTO> findMonthlyOrders(@RequestParam Integer deliveryID){
        return deliveryMapper.findMonthlyOrders(deliveryID);
    }

    // 获取当月接单数
    @GetMapping("/monthlyPickOrder")
    public Integer findMonthlyOrder(@RequestParam Integer deliveryID){
        return deliveryMapper.findMonthlyOrder(deliveryID);
    }


    @GetMapping("/search")
    public Delivery findDeliveryByID(@RequestParam Integer deliveryID){
        return deliveryMapper.findDeliveryByID(deliveryID);
    }

    @GetMapping("/page")
    public Map<String,Object> findDeliveryByPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam(required = false) String username, @RequestParam(required = false) String phone){
        pageNum=(pageNum-1)*pageSize;
        if (username == null) {
            username = "%"; // 或者任何其他默认值
        } else {
            username = "%" + username + "%";
        }
        if (phone == null){
            phone = "%";
        } else {
            phone="%"+phone+"%";
        }
        Map<String, Object> res=new HashMap<>();
        List<Delivery> data=deliveryMapper.findDeliveryByPage(pageNum,pageSize,username,phone);
        Integer totalNum=deliveryMapper.findTotal(username,phone);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }

    @DeleteMapping("/{id}")
    public Integer DeleteByID(@PathVariable Integer id){return deliveryMapper.deleteByID(id);}
}
