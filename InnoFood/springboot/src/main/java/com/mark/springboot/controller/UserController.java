package com.mark.springboot.controller;

import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.UserMapper;
import com.mark.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController{
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserService userService;



    //新增和修改
    @PostMapping
    public Integer save(@RequestBody User user){
        return userService.save(user);
    }

    //用户登录，用来判断前端传入的用户是否存在数据库中
    @PostMapping("/login")
    public User login(@RequestBody User user){
        return userMapper.login(user);
    }
    //查询用户信息
    @GetMapping
    public List<User> findAll(){
        return userMapper.findAll();
    }

    @GetMapping("/findUserByID")
    public User findUserByID(@RequestParam Integer userID){
        return userMapper.findUserByID(userID);
    }

    //用户注册，在用户注册时判断用户名是否存在，若存在返回0给前端，不存在则返回1
    @GetMapping("/register")
    public Integer findUserByUsername(@RequestParam String username) {
          return userService.findUserByUsername(username);
    }

    //通过id删除用户信息
    @DeleteMapping("/{id}")
    public Integer delete(@PathVariable Integer id){
        return userMapper.deleteById(id);
    }
    //实现分页查询用户信息
    //接口路径:/user/page
    //@RequestParam
    @GetMapping("/page")
    public Map<String,Object> findUserByPage(@RequestParam Integer pageNum,@RequestParam Integer pageSize,@RequestParam String username,@RequestParam String email,@RequestParam String address){
        pageNum=(pageNum-1)*pageSize;
        username ="%"+username+"%";
        email="%"+email+"%";
        address="%"+address+"%";
        Map<String, Object> res=new HashMap<>();
        List<User> data=userMapper.findUserByPage(pageNum,pageSize,username,email,address);
        Integer totalNum=userMapper.findTotal(username,email,address);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }
}
