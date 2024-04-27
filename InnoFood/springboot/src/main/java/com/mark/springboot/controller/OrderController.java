package com.mark.springboot.controller;

import com.mark.springboot.Dto.CartItemDTO;
import com.mark.springboot.Dto.MonthMoneyDTO;
import com.mark.springboot.Dto.OrderDto;
import com.mark.springboot.entity.Order;
import com.mark.springboot.entity.OrderDetail;
import com.mark.springboot.mapper.OrderMapper;
import com.mark.springboot.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderService orderService;

    /***
     * 创建新的订单，同时添加到订单明细表里，再发信息给商家店铺
     * @param cartItemDTO
     * @return 订单的订单编号
     */
    @PostMapping
    public Integer createOrder(@RequestBody CartItemDTO cartItemDTO){
        System.out.println("Received POST request to /order");
        return orderService.createOrder(cartItemDTO);
    }

    /***
     * 商家接单 更新订单状态 并发送信息给用户通知商家已经接单
     * @param orderID
     * @return
     */
    @PostMapping("/shopPickOrder")
    public Integer shopPickOrder(@RequestParam Integer orderID){
        return orderService.shopPickOrder(orderID);
    }

    /***
     * 骑手接单 更新订单状态 并发送信息给用户，通知用户外卖已发送
     * @param orderID
     * @return
     */
    @PostMapping("/deliveryPickOrder")
    public Integer deliveryPickOrder(@RequestParam(name = "orderID") Integer orderID,
                                     @RequestParam(name = "deliveryID") Integer deliveryID) {
        // 为骑手添加
        return orderService.deliveryPickOrder(orderID,deliveryID);
    }




    /***
     * 分页查询新生成的订单
     * @param pageNum
     * @param pageSize
     * @param shopID
     * @return
     */
    @GetMapping("/newOrder/page")
    public Map<String,Object> findNewOrderByShopID(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam Integer shopID){
        Map<String, Object> res=new HashMap<>();
        List<OrderDto> data= orderService.findNewOrderByShopID(shopID,pageNum,pageSize);
        Integer totalNum = orderService.countNewOrderNum(shopID);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }

    /***
     * 分页查询商家已经接单的订单
     * @param pageNum
     * @param pageSize
     * @param shopID
     * @return
     */
    @GetMapping("/historyOrder/page")
    public Map<String,Object> findOldOrderByShopID(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam Integer shopID){
        Map<String, Object> res=new HashMap<>();
        List<OrderDto> data= orderService.findOldOrderByShopID(shopID,pageNum,pageSize);
        Integer totalNum = orderService.countOldOrderNum(shopID);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }

    /***
     * 分页查询等待骑手接单的订单
     * @param pageNum
     * @param pageSize
     * @return
     */
    @GetMapping("/deliveryToPickOrder/page")
    public Map<String,Object> findDeliveryToPickOrder(@RequestParam Integer pageNum, @RequestParam Integer pageSize){
        Map<String, Object> res=new HashMap<>();
        pageNum=(pageNum-1)*pageSize;
        List<OrderDto> data= orderService.findDeliveryToPickOrder(pageNum,pageSize);
        Integer totalNum = orderMapper.countAllDeliveryToPickOrder();
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }

    @GetMapping("/deliveryDoneOrder/page")
    public Map<String,Object> findDeliveryToPickOrder(@RequestParam Integer pageNum, @RequestParam Integer pageSize,@RequestParam Integer deliveryID){
        Map<String, Object> res=new HashMap<>();
        pageNum=(pageNum-1)*pageSize;
        List<OrderDto> data= orderMapper.findDeliveryDoneOrder(pageNum,pageSize,deliveryID);
        Integer totalNum = orderMapper.countDeliveryDoneOrder(deliveryID);
        res.put("totalNum",totalNum);
        res.put("data",data);
        return res;
    }


    @GetMapping("/orderDetail")
    public List<OrderDetail> findOrderDetailByOrderID(@RequestParam Integer orderID){
        return orderMapper.findOrderDetailByOrderID(orderID);
    }

    /***
     * 商家获取所有已完成的订单
     * @param managerID
     * @return
     */
    @GetMapping("/managerAllDoneOrder")
    public Map<String,Object> findDoneOrderByManagerID(@RequestParam Integer pageNum,@RequestParam Integer pageSize,@RequestParam Integer managerID,@RequestParam String shopName){
        shopName = "%"+shopName+"%";
        Map<String, Object> res=new HashMap<>();
        //获取了订单信息
        List<OrderDto> OrderDtos= orderService.findDoneOrderByManagerID(managerID,shopName);

        Integer totalNum = OrderDtos.size();

        // 计算子列表的范围，确保不越界
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(pageNum * pageSize, totalNum);

        List<OrderDto> data = OrderDtos.subList(startIndex, endIndex);

        res.put("data",data);
        res.put("totalNum",totalNum);
        return res;
    }

    // 根据用户id获取订单分页
    @GetMapping("/page")
    public Map<String, Object> findOrderByPage(@RequestParam Integer pageNum,
                                               @RequestParam Integer pageSize,
                                               @RequestParam Integer userID,
                                               @RequestParam(required = false) Integer orderState) {
        pageNum = (pageNum - 1) * pageSize;

        Map<String, Object> res = new HashMap<>();
        List<Order> data = orderMapper.findOrderByPage(pageNum, pageSize, userID, orderState);
        Integer totalNum = orderMapper.findTotal(userID, orderState);
        res.put("totalNum", totalNum);
        res.put("data", data);
        return res;
    }

    // 根据订单id获取订单详情
    @GetMapping("/detail")
    public List<OrderDetail> findDetailByOrderId(@RequestParam Integer orderID) {
        return orderMapper.findDetailByOrderId(orderID);
    }


    // 根据用户id和订单状态获取相应条件订单条数
    @GetMapping("/count")
    public Integer getCountByUserId(@RequestParam Integer userID, @RequestParam Integer order_state) {
        return orderMapper.getCountByUserId(userID,order_state);
    }

    // 获取该用户本月总支出
    @GetMapping("/money")
    public Integer getMoney(@RequestParam Integer userID){
        return orderMapper.getMoney(userID);
    }


    @GetMapping("/monthmoney")
    public List<MonthMoneyDTO> getMonthMoney(@RequestParam Integer userID){
        return orderMapper.getMonthMoney(userID);
    }

    @PostMapping("/arrived")
    public Integer updateOrderStateTo3(@RequestParam Integer orderID){
        return orderMapper.updateOrderStateTo3(orderID);
    }

}
