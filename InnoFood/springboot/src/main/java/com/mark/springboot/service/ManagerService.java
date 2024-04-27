package com.mark.springboot.service;

import com.mark.springboot.entity.Manager;
import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.ManagerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ManagerService {
    @Autowired
    private ManagerMapper managerMapper;

    public Integer findManagerByUsername(String username){
        Manager manager = managerMapper.findManagerByUsername(username);
        if (manager != null) {
            return 0; //存在相同用户名，向前端返回0
        } else {
            return 1;
        }
    }

    public Integer save(Manager manager) {
        if(manager.getManagerID() == null){
            return managerMapper.insert(manager);
        }else{
            return managerMapper.update(manager);
        }
    }
}
