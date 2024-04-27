package com.mark.springboot.controller;

import com.mark.springboot.entity.Admin;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.AdminMapper;
import com.mark.springboot.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private AdminService adminService;
    @GetMapping
    public List<Admin> findAll(){
        return adminMapper.findAll();
    }

    @PostMapping
    public Integer save(@RequestBody Admin admin){
        return adminService.save(admin);
    }

    @PostMapping("/login")
    public Admin login(@RequestBody Admin admin){
        return adminMapper.login(admin);
    }


    @GetMapping("/search")
    public Admin findAdminByID(@RequestParam Integer adminID){
        return adminMapper.findAdminByID(adminID);
    }

    @DeleteMapping("/{id}")
    public Integer DeleteByID(@PathVariable Integer id){return adminMapper.deleteByID(id);}

    @GetMapping("/page")
    public Map<String,Object> findAdminByPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam(required = false) String username){
        pageNum=(pageNum-1)*pageSize;
        if (username == null) {
            username = "%"; // 或者任何其他默认值
        } else {
            username = "%" + username + "%";
        }
        Map<String, Object> res=new HashMap<>();
        List<Admin> data=adminMapper.findAdminByPage(pageNum,pageSize,username);
        Integer totalNum=adminMapper.findTotal(username);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }
}
