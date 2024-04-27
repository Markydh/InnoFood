package com.mark.springboot.mapper;

import com.mark.springboot.entity.User;
import java.util.List;

// @Mapper
public interface UserMapper {
    //查询所有用户信息
    List<User> findAll();

    //通过userID查找user
    User findUserByID(Integer userID);

    Integer findTotal(String username,String email,String address);
    //删除用户
    Integer insert(User user);
    //更新用户信息
    Integer update(User user);
    //通过UserID删除用户信息
    Integer deleteById(Integer id);

    List<User> findUserByPage(Integer pageNum,Integer pageSize,String username,String email,String address);

    User login(User user);

    User findUserByUsername(String username);
}
