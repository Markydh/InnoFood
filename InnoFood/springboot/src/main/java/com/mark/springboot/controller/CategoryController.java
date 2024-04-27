package com.mark.springboot.controller;


import com.mark.springboot.entity.Product_category;
import com.mark.springboot.mapper.CategoryMapper;
import com.mark.springboot.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private CategoryService categoryService;

    /**
     *  根据店铺编号 查询店铺所有的所有菜品分类
     * @param shopID
     * @return
     */
    @GetMapping
    public List<Product_category> findCategoryByShopID(@RequestParam Integer shopID){
        return categoryMapper.findCategoryByShopID(shopID);
    }


    /***
     * 根据店铺编号，和搜索框中的类别名，模糊搜索该店铺的类别情况
     * @param shopID
     * @param categoryname
     * @return
     */
    @GetMapping("/search")
    public List<Product_category> search(@RequestParam Integer shopID,@RequestParam String categoryname){
        categoryname="%"+categoryname+"%";
        return categoryMapper.findCategoryByCategoryName(shopID,categoryname);
    }

    /***
     * 新增或更新菜品类别
     * @param productCategory
     * @return
     */
    @PostMapping
    public Integer save(@RequestBody Product_category productCategory){
        return categoryService.save(productCategory);
    }

    /***
     * 批量删除菜品类别
     * @param categoryIds
     * @return
     */
    @PostMapping("/del/batch")
    public Integer deleteCategories(@RequestBody List<Integer> categoryIds) {
        // 在 CategoryService 中实现批量删除逻辑
        return categoryService.deleteCategories(categoryIds);
    }

    /***
     * 简单的删除一个菜品类别
     * @param categoryID
     * @return
     */
    @DeleteMapping("/{categoryID}")
    public Integer delete(@PathVariable Integer categoryID) {
           return categoryMapper.delete(categoryID);
    }
}
