package com.mark.springboot.mapper;

import com.mark.springboot.entity.Admin;
import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    List<Admin> findAll();

    Integer update(Admin admin);

    Admin login(Admin admin);


    List<Admin> findAdminByPage(Integer pageNum, Integer pageSize, String username);

    Integer findTotal(String username);


    Admin findAdminByID(Integer adminID);

    Integer deleteByID(@Param("id") Integer id);

    Integer insert(Admin admin);
}
