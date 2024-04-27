package com.mark.springboot.controller;


import com.mark.springboot.entity.ShopType;
import com.mark.springboot.mapper.ShopTypeMapper;
import com.mark.springboot.service.ShopTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/shopType")
public class ShopTypeController {

    @Autowired
    private ShopTypeMapper shopTypeMapper;

    @Autowired
    private ShopTypeService shopTypeService;

//    修改和新增
    @PostMapping("/save")
    public Integer save(@RequestBody ShopType shopType) {
        return shopTypeService.save(shopType);
    }

    @GetMapping("/search")
    public List<ShopType> search() {
        return shopTypeMapper.findAll();
    }

//    删除
    @DeleteMapping("/{id}")
    public Integer delete(@PathVariable Integer id){
        return shopTypeService.deleteById(id);
    }
}
