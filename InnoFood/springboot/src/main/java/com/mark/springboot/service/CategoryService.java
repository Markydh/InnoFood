package com.mark.springboot.service;

import com.mark.springboot.Dto.ProductInfo;
import com.mark.springboot.entity.Product;
import com.mark.springboot.entity.Product_category;
import com.mark.springboot.mapper.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService{
    @Autowired
    private CategoryMapper categoryMapper;


    // 更新或增加菜品类别
    public Integer save(Product_category productCategory){
        if(productCategory.getCategoryID()==null){
           return categoryMapper.insert(productCategory);
        }else{
            return categoryMapper.update(productCategory);
        }
    }

    //删除菜品类别
    public Integer deleteCategories(List<Integer> categoryIds) {
         return categoryMapper.deleteBatch(categoryIds);
    }

    //
    public String findCategoryNameByID(Integer categoryID){
        return categoryMapper.findCategoryNameByID(categoryID);
    }
}
