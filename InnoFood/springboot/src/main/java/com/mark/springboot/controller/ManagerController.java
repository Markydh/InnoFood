package com.mark.springboot.controller;

import com.mark.springboot.Dto.EveryShopOrderDTO;
import com.mark.springboot.Dto.ManagerShopPriceDTO;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.mapper.ManagerMapper;
import com.mark.springboot.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/manager")
public class ManagerController {
    @Autowired
   private ManagerMapper managerMapper;
    @Autowired
    private ManagerService managerService;

    //获取商家信息
    @GetMapping
    public List<Manager> findAll(){
        return managerMapper.findAll();
    }

    @GetMapping("/search")
    public Manager findManagerByID(@RequestParam Integer managerID){
        return managerMapper.findManagerByID(managerID);
    }

    @PostMapping("/login")
    public Manager login(@RequestBody Manager manager){
        return managerMapper.login(manager);
    }

    @GetMapping("/register")
    public Integer findManagerByUsername(@RequestParam String username) {
        return managerService.findManagerByUsername(username);
    }

    @PostMapping
    public  Integer save(@RequestBody Manager manager){
        return managerService.save(manager);
    }

    @GetMapping("/page")
    public Map<String,Object> findUserByPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam(required = false) String username, @RequestParam(required = false) String email){
        pageNum=(pageNum-1)*pageSize;
        if (username == null) {
            username = "%"; // 或者任何其他默认值
        } else {
            username = "%" + username + "%";
        }
        if (email == null) {
            email = "%";
        } else{
            email= "%" + email + "%";
        }
        Map<String, Object> res=new HashMap<>();
        List<Manager> data=managerMapper.findManagerByPage(pageNum,pageSize,username,email);
        Integer totalNum=managerMapper.findTotal(username,email);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }

    //冻结
    @PostMapping("/frost")
    public Integer managerFrost(@RequestBody Manager manager){return managerMapper.managerFrost(manager);}
    //解除冻结
    @PostMapping("/thaw")
    public Integer managerThaw(@RequestBody Manager manager){return managerMapper.managerThaw(manager);}

    // 根据 managerID 获取 本月所有店铺营业额
    @GetMapping("/totalPrice")
    public Integer findTotalPriceByManagerId(@RequestParam Integer managerID){
        return managerMapper.findTotalPriceByManagerId(managerID);
    }

    // 返回shopID, ShopName, 当月总营业额
    @GetMapping("/shopTotal")
    public List<ManagerShopPriceDTO> findShopTotalByManagerId(@RequestParam Integer managerID){
        return managerMapper.findShopTotalByManagerId(managerID);
    }

    // 返回每个店铺当月的订单数
    @GetMapping("/shopOrders")
    public List<EveryShopOrderDTO> findShopOrders(@RequestParam Integer managerID){
        return managerMapper.findShopOrders(managerID);
    }

}
