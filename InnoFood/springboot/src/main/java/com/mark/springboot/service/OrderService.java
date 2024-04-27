package com.mark.springboot.service;

import com.mark.springboot.Dto.CartItemDTO;
import com.mark.springboot.Dto.OrderDto;
import com.mark.springboot.entity.*;
import com.mark.springboot.mapper.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private ShopMapper shopMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private DeliveryMapper deliveryMapper;
    /***
     * 创建新的订单，同时添加到订单明细表里，再发信息给商家店铺
     * @param cartItemDTO
     * @return
     */
    public Integer createOrder(CartItemDTO cartItemDTO) {

        Order order = getOrder(cartItemDTO);
        orderMapper.insertOrder(order);

        List<CartItem> cartItems = cartItemDTO.getCart();
        for (CartItem item : cartItems) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderID(order.getOrderID());  // 这里使用数据库生成的 orderID
            orderDetail.setProductID(item.getProductID());
            orderDetail.setProductname(item.getProductname());
            orderDetail.setQuantity(item.getQuantity());
            orderDetail.setPrice(item.getPrice());
            // 保存订单明细
            orderMapper.insertOrderDetail(orderDetail);
        }

        // 发送消息
        Shop shop = shopMapper.findShopByShopID(cartItemDTO.getShopID());
        User user = userMapper.findUserByID(cartItemDTO.getUserID());
        Message message = new Message();
        message.setUserID(user.getUserID());
        message.setShopID(shop.getShopID());
        message.setOrderID(order.getOrderID());
        message.setState(0);
        SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
        sdf.applyPattern("yyyy-MM-dd HH:mm:ss a");// a为am/pm的标记
        Date date = new Date();// 获取当前时间

        String msgContent = "用户"+user.getUsername()+"于"+sdf.format(date)+"在"+shop.getShopName()+"提交了一份订单，"+"订单编号为 "+order.getOrderID();
        message.setMsgContent(msgContent);
        messageMapper.insert(message);
        System.out.println(message.getOrderID());
        return order.getOrderID();
    }

    // 给Order赋值
    private static Order getOrder(CartItemDTO cartItemDTO) {
        Integer userID;
        Integer shopID;
        Double delivery_price;  //配送费
        Double good_total;     //商品总价
        Double total_price;  //订单总费用
        userID = cartItemDTO.getUserID();
        shopID = cartItemDTO.getShopID();
        delivery_price= cartItemDTO.getShippingFee();
        good_total= cartItemDTO.getSubtotal();
        total_price= cartItemDTO.getTotalAmount();
        // 创建订单
        Order order = new Order();
        order.setUserID(userID);
        order.setShopID(shopID);
        order.setDelivery_price(delivery_price);
        order.setGood_total(good_total);
        order.setTotal_price(total_price);
        return order;
    }

    /***
     * 根据店铺编号查询新生成的订单
     * @param shopID
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<OrderDto> findNewOrderByShopID(Integer shopID, Integer pageNum, Integer pageSize) {
        pageNum = (pageNum - 1) * pageSize;
        List<Order> orders = orderMapper.findNewOrderByShopID(shopID, pageNum, pageSize);
        // 创建一个用于存储 OrderDto 的列表
        List<OrderDto> orderDtos = new ArrayList<>();
        for (Order order : orders) {
            // 对于每个订单，获取对应的用户信息
            User user = userMapper.findUserByID(order.getUserID());
            // 创建一个 OrderDto 对象，将订单信息和用户名都复制到该对象中
            OrderDto orderDto = new OrderDto();
            BeanUtils.copyProperties(order, orderDto);
            orderDto.setUsername(user.getUsername());
            // 将 OrderDto 对象添加到列表中
            orderDtos.add(orderDto);
        }
        return orderDtos;
    }

    /***
     * 计算指定店铺的新订单数
     * @param shopID
     * @return
     */
    public Integer countNewOrderNum(Integer shopID) {
        return orderMapper.countNewOrderNum(shopID);
    }

    /***
     * 根据店铺编号查询已经接单的订单
     * @param shopID
     * @param pageNum
     * @param pageSize
     * @return
     */

    public List<OrderDto> findOldOrderByShopID(Integer shopID, Integer pageNum, Integer pageSize) {
        pageNum = (pageNum - 1) * pageSize;
        List<Order> orders = orderMapper.findOldOrderByShopID(shopID, pageNum, pageSize);
        // 创建一个用于存储 OrderDto 的列表
        List<OrderDto> orderDtos = new ArrayList<>();
        for (Order order : orders) {
            // 对于每个订单，获取对应的用户信息
            User user = userMapper.findUserByID(order.getUserID());
            // 创建一个 OrderDto 对象，将订单信息和用户名都复制到该对象中
            OrderDto orderDto = new OrderDto();
            BeanUtils.copyProperties(order, orderDto);
            orderDto.setUsername(user.getUsername());
            // 将 OrderDto 对象添加到列表中
            orderDtos.add(orderDto);
        }
        return orderDtos;
    }

    /***
     * 计算指定店铺的已经订单总数
     * @param shopID
     * @return
     */
    public Integer countOldOrderNum(Integer shopID) {
        return orderMapper.countOldOrderNum(shopID);
    }

    /***
     * 通过商家编号查找已经完成的订单
     * @param managerID
     * @return
     */
    public List<OrderDto> findDoneOrderByManagerID(Integer managerID,String shopName) {
        List<Shop> shops = shopMapper.findShopByShopNameAndManagerID(shopName,managerID);
        List<OrderDto> result = new ArrayList<>();

        for (Shop shop : shops) {
            // 获取每个商店的已完成订单
            List<Order> completedOrders = orderMapper.findDoneOrderByShopID(shop.getShopID());

            // 转换为DTO并添加到结果列表
            result.addAll(mapToOrderDtoList(completedOrders));
        }
        return result;
    }

    /***
     * 将Order转换为DTO
     * @param orders
     * @return
     */
    private List<OrderDto> mapToOrderDtoList(List<Order> orders) {
        List<OrderDto> orderDtos = new ArrayList<>();
        for (Order order : orders) {
            // 获取对应的用户信息
            User user = userMapper.findUserByID(order.getUserID());
            // 获取对应的店铺信息
            Shop shop = shopMapper.findShopByShopID(order.getShopID());
            // 创建 OrderDto 对象，将订单信息和用户名复制到该对象中
            OrderDto orderDto = new OrderDto();
            BeanUtils.copyProperties(order, orderDto);
            // 设置用户名
            orderDto.setUsername(user.getUsername());
            // 设置店铺名
            orderDto.setShopName(shop.getShopName());
            // 将 OrderDto 对象添加到列表中
            orderDtos.add(orderDto);
        }
        return orderDtos;
    }

    public List<OrderDto> findDeliveryToPickOrder(Integer pageNum, Integer pageSize) {
        List<Order> orders = orderMapper.findDeliveryToPickOrder(pageNum,pageSize);
        List<OrderDto> result = new ArrayList<>();
        for (Order order : orders) {
            User user = userMapper.findUserByID(order.getUserID());
            Shop shop = shopMapper.findShopByShopID(order.getShopID());
            OrderDto orderDto = new OrderDto();
            BeanUtils.copyProperties(order, orderDto);
            orderDto.setUserAddress(user.getAddress());
            orderDto.setShopAddress(shop.getAddress());
            result.add(orderDto);
        }
        return result;
    }

    public Integer shopPickOrder(Integer orderID) {
        //获得订单信息
        Order order = orderMapper.findOrderByOrderID(orderID);
        //获得商家信息
        Shop shop = shopMapper.findShopByShopID(order.getShopID());
        Message message = new Message();
        message.setUserID(order.getUserID());
        message.setShopID(order.getShopID());
        message.setOrderID(orderID);
        message.setState(2);  //2表示消息是发给用户的
        SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
        sdf.applyPattern("yyyy-MM-dd HH:mm:ss a");// a为am/pm的标记
        Date date = new Date();// 获取当前时间
        String msgContent = "店铺："+shop.getShopName()+"于"+sdf.format(date)+"接单，快递员正在快马加鞭赶来，请您耐心等待";
        message.setMsgContent(msgContent);
        //发送信息
        messageMapper.insert(message);
        //更新订单状态
        return orderMapper.updateOrderStateTo1(orderID);
    }

    public Integer deliveryPickOrder(Integer orderID, Integer deliveryID) {
        //获得订单信息
        Order order = orderMapper.findOrderByOrderID(orderID);
        //获得骑手信息
        Delivery delivery = deliveryMapper.findDeliveryByDeliveryID(deliveryID);
        Message message = new Message();
        message.setUserID(order.getUserID());
        message.setOrderID(orderID);
        message.setDeliveryID(deliveryID);
        message.setState(2);  //2表示消息是发给用户的
        SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
        sdf.applyPattern("yyyy-MM-dd HH:mm:ss a");// a为am/pm的标记
        Date date = new Date();// 获取当前时间
        String msgContent = "快递员："+delivery.getUsername()+"于"+sdf.format(date)+"到达商家，请耐心等待";
        message.setMsgContent(msgContent);
        //发送信息
        messageMapper.insert(message);
        //更新订单状态
        return orderMapper.updateOrderStateTo2(orderID, deliveryID);
    }
}
