package com.mark.springboot.controller;

import com.mark.springboot.Dto.ProductInfo;
import com.mark.springboot.entity.Product;
import com.mark.springboot.mapper.ProductMapper;
import com.mark.springboot.service.CategoryService;
import com.mark.springboot.service.ProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private  ProductService productService;

    @Autowired
    private CategoryService categoryService;

    /***
     * 查找所有商品信息
     * @return
     */
    @GetMapping
    public List<Product> findAll(){
        return productMapper.findAll();
    }


    @GetMapping("/findProductByShopID")
    public List<Product> findProductByShopID(@RequestParam Integer shopID){
        return productMapper.findProductByShopID(shopID);
    }

    /***
     * 获得产品信息，目的是根据第三方表获得菜品的类别 (根据搜索框的菜品类别名)
     * @param shopID
     * @param categoryname
     * @return
     */
    @GetMapping("/findProductInfo/page")
    public Map<String, Object> findProductInfo(@RequestParam Integer shopID, @RequestParam String categoryname, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        List<ProductInfo> productInfoList = new ArrayList<>();
        Map<String, Object> res = new HashMap<>();

        // 在这里获取产品信息和类别名
        List<Product> products = productService.findProductByShopID(shopID);

        for (Product product : products) {
            ProductInfo productInfo = new ProductInfo();
            // 将产品信息复制到 DTO 中
            BeanUtils.copyProperties(product, productInfo);
            // 获取并设置类别名
            productInfo.setCategoryname(categoryService.findCategoryNameByID(product.getCategoryID()));
            if (productInfo.getCategoryname().contains(categoryname)) {
                productInfoList.add(productInfo);
            }
        }

        Integer totalNum = productInfoList.size();//总条数

        // 计算子列表的范围，确保不越界
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(pageNum * pageSize, totalNum);

        List<ProductInfo> data = productInfoList.subList(startIndex, endIndex);
        // 分页查询结果
        res.put("totalNum", totalNum);
        res.put("data", data);
        return res;
    }


    @GetMapping("/findProductByCategoryID")
    public List<Product> findProductByCategoryID(@RequestParam Integer shopID, @RequestParam Integer categoryID){
        return productMapper.findProductByCategoryID(shopID,categoryID);
    }

    @PostMapping
    public Integer save(@RequestBody Product product){
        return productService.save(product);
    }

    /***
     * 简单的删除一个菜品
     * @param productID
     * @return
     */
    @DeleteMapping("/{productID}")
    public Integer delete(@PathVariable Integer productID) {
        return productMapper.delete(productID);
    }

    /***
     * 批量删除菜品类别
     * @param productIds
     * @return
     */
    @PostMapping("/del/batch")
    public Integer deleteCategories(@RequestBody List<Integer> productIds) {
        // 在 CategoryService 中实现批量删除逻辑
        return productService.deleteProducts(productIds);
    }

    @PostMapping("/checkInventory")
    public Integer checkInventory(@RequestParam Integer productID, @RequestParam Integer quantity){
        return productService.checkInventory(productID,quantity);
    }

    @PostMapping("/submitOrder")
    public Integer submitOrder(@RequestBody Integer productID,@RequestBody Integer quantity){
        System.out.println("Received POST request to /product/submitOrder");
        return productService.submitOrder(productID,quantity);
    }
}
