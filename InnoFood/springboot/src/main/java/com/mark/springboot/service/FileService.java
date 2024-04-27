package com.mark.springboot.service;

import com.mark.springboot.entity.Files;
import com.mark.springboot.entity.ShopType;
import com.mark.springboot.mapper.FileMapper;
import com.mark.springboot.mapper.ShopTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;

@Service
public class FileService {
    @Autowired
    private FileMapper fileMapper;

    public Integer save(Files files) {
        if(files.getId()==null){
            return fileMapper.insert(files);
        }else{
            return fileMapper.update(files);
        }
    }
}
