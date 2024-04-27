package com.mark.springboot.service;

import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;
    public Integer save(User user){
        //新增或更新用户信息
        if(user.getUserID() == null){
            return userMapper.insert(user);
        }
        else{
            return userMapper.update(user);
        }
    }
    public Integer findUserByUsername(String username){
        User user = userMapper.findUserByUsername(username);
        if (user != null) {
            return 0; //存在相同用户名，向前端返回0
        } else {
            return 1;
        }
    }
}
