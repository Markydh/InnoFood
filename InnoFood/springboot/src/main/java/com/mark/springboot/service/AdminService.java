package com.mark.springboot.service;

import com.mark.springboot.entity.Admin;
import com.mark.springboot.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
        @Autowired
        private AdminMapper adminMapper;
        public Integer save(Admin admin){
            //更新管理员信息
            if(admin.getAdminID() == null){
               return adminMapper.insert(admin);
            }
            else{
                return adminMapper.update(admin);
            }
        }
}
