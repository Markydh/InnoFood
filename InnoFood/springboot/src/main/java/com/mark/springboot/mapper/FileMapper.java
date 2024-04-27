package com.mark.springboot.mapper;

import com.mark.springboot.entity.Files;
import com.mark.springboot.entity.Shop;

import java.io.File;
import java.util.List;

public interface FileMapper {
    Integer insert(Files files);

    Integer update(Files files);

    List<Files> findbanner();

}
