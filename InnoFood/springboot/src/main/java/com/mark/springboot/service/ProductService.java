package com.mark.springboot.service;

import com.mark.springboot.entity.Product;
import com.mark.springboot.mapper.ProductMapper;
import com.mark.springboot.mapper.ShopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    public List<Product> findProductByShopID(Integer shopID) {
        return productMapper.findProductByShopID(shopID);
    }

    public Integer save(Product product) {
        // 若获取的菜品编号为空，那么需要进行添加操作
        if(product.getProductID() == null){
            return productMapper.insert(product);
        }else{
            return productMapper.update(product);
        }
    }

    public Integer deleteProducts(List<Integer> productIds) {
        return productMapper.deleteBatch(productIds);
    }

    public Integer checkInventory(Integer productID, Integer quantity) {
        Product product = productMapper.findProductByProductID(productID);
        // 如果库存小雨此次购买数量返回0
        if(product.getProduct_rest() < quantity) {
            return 0;
        }else{
            return 1;
        }
    }

    public Integer submitOrder(Integer productID, Integer quantity) {
        Product product = productMapper.findProductByProductID(productID);
        Integer product_res = product.getProduct_rest();
        Integer sales = product.getSales();
        product_res=product_res-quantity;
        sales=sales+quantity;
        product.setProduct_rest(product_res);
        product.setSales(sales);
        return productMapper.update(product);//更新商品库存量，更新商品的
    }
}
