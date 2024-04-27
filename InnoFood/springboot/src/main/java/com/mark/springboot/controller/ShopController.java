package com.mark.springboot.controller;

import com.mark.springboot.Dto.ProductCategorySalesDTO;
import com.mark.springboot.Dto.ProductMonthlySalesDTO;
import com.mark.springboot.Dto.ShopInfo;
import com.mark.springboot.Dto.ShopMonthlySalesDTO;
import com.mark.springboot.entity.Shop;
import com.mark.springboot.mapper.ShopMapper;
import com.mark.springboot.service.ShopService;
import com.mark.springboot.service.ShopTypeService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    private ShopService shopService;

    @Autowired
    private ShopMapper shopMapper;

    @Autowired
    private ShopTypeService shopTypeService;

    /***
     * 查找所有店铺信息
     * @return
     */
    @GetMapping
    public List<Shop> findAll(){
        return shopMapper.findAll();
    }


    @GetMapping("/findShopByShopID")
    public Shop findShopByShopID(@RequestParam Integer shopID){
        return shopMapper.findShopByShopID(shopID);
    }

    /***
     * 根据商家编号 查找商家所有的所有店铺
     * @param shopName
     * @param managerID
     * @return
     */
    @GetMapping("/search")
    public List<Shop> search(@RequestParam String shopName,@RequestParam Integer managerID){
        shopName="%"+shopName+"%";
        return shopMapper.findShopByShopNameAndManagerID(shopName,managerID);
    }

    /***
     * 添加或更新店铺
     * @param shop
     * @return
     */
    @PostMapping
    public Integer save(@RequestBody Shop shop){
        return shopService.save(shop);
    }

    /***
     * 根据店铺编号删除店铺
     * @param shopID
     * @return
     */
    @DeleteMapping("/{shopID}")
    public Integer delete(@PathVariable Integer shopID){
        return shopService.deleteShop(shopID);

    }


    /**
     * 分页查找店铺 shop
     * @param managerID
     * @param shopTypeName
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/findShopInfo/page")
    public Map<String, Object> findShopInfo(@RequestParam Integer managerID, @RequestParam String shopTypeName, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        List<ShopInfo> shopInfoList = new ArrayList<>();
        Map<String, Object> res = new HashMap<>();

        // 在这里获取产品信息和类别名
        List<Shop> shops = shopMapper.findShopByManagerID(managerID);

        for (Shop shop : shops) {
            ShopInfo shopInfo = new ShopInfo();
            // 将产品信息复制到 DTO 中
            BeanUtils.copyProperties(shop, shopInfo);
            // 获取并设置类别名
            shopInfo.setShopTypeName(shopTypeService.findShopTypeNameByID(shop.getShopTypeID()));
            if (shopInfo.getShopTypeName().contains(shopTypeName)) {
                shopInfoList.add(shopInfo);
            }
        }

        Integer totalNum = shopInfoList.size();//总条数

        // 计算子列表的范围，确保不越界
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(pageNum * pageSize, totalNum);

        List<ShopInfo> data = shopInfoList.subList(startIndex, endIndex);
        // 分页查询结果
        res.put("totalNum", totalNum);
        res.put("data", data);
        return res;
    }

    @GetMapping("/guess")
    public List<Shop> guess(@RequestParam Integer userID){
        return shopMapper.guess(userID);
    }

    // 当月本店铺每个菜品的销售量
    @GetMapping("/productMonthlySales")
    public List<ProductMonthlySalesDTO> productMonthlySales(@RequestParam Integer shopID){
        return shopMapper.productMonthlySales(shopID);
    }

    @GetMapping("/productCategorySales")
    public List<ProductCategorySalesDTO> productCategorySales(@RequestParam Integer shopID){
        return shopMapper.productCategorySales(shopID);
    }

    @GetMapping("/shopTotalMoney")
    public Double getShopTotalMoney(@RequestParam Integer shopID){
        return shopMapper.getShopTotalMoney(shopID);
    }

    @GetMapping("/shopMonthlySales")
    public List<ShopMonthlySalesDTO> getShopMonthlySales(@RequestParam Integer shopID){
        return shopMapper.getShopMonthlySales(shopID);
    }
}
