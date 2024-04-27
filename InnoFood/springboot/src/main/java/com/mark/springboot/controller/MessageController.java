package com.mark.springboot.controller;

import com.mark.springboot.Dto.MessageDto;
import com.mark.springboot.entity.Delivery;
import com.mark.springboot.entity.Message;
import com.mark.springboot.entity.Shop;
import com.mark.springboot.entity.User;
import com.mark.springboot.mapper.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private ShopMapper shopMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private DeliveryMapper deliveryMapper;

    /***
     * 获取该商家的所有接单消息，并统计新的消息的数量
     * @param managerID
     * @return
     */
    @GetMapping("/getManagerMsg")
    public Map<String,Object> getManagerMsg(@RequestParam Integer managerID){
        Map<String,Object> res = new HashMap<>();
        List<Shop> shops = shopMapper.findShopByManagerID(managerID);
        List<MessageDto> result = new ArrayList<>();
        Integer newMsgNum=0;
        for (Shop shop : shops){
            // 获取指定店铺编号的新消息
            List<Message> messages = messageMapper.getManagerMsgByShopID(shop.getShopID());
            for(Message message:messages){
                MessageDto messageDto=new MessageDto();
                User user = userMapper.findUserByID(message.getUserID());
                BeanUtils.copyProperties(message, messageDto);
                messageDto.setUserPsrc(user.getPsrc());
                messageDto.setUsername(user.getUsername());
                result.add(messageDto);
            }
            newMsgNum+=messageMapper.getNewManagerMsgNumByShopID(shop.getShopID());
        }
        res.put("newMsgNum",newMsgNum);
        res.put("data",result);
        return res;
    }

    /***
     * 更新商家收到的信息的状态
     * @param messageID
     * @return
     */
    @PostMapping("/updateManagerMsg")
    public Integer updateManagerMsg(@RequestParam Integer messageID){
        return messageMapper.updateManagerMsg(messageID);
    }

    /***
     * 获取商家发送给用户的所有新消息，并统计新的消息的数量
     * @param userID
     * @return
     */
    @GetMapping("/getUserMsg")
    private Map<String,Object> getUserMsg(@RequestParam Integer userID){
        Map<String,Object> res = new HashMap<>();
        List<MessageDto> result = new ArrayList<>();
        List<Message> messages = messageMapper.getUserMsgByUserID(userID);
        for(Message message:messages){
            MessageDto messageDto=new MessageDto();
            if(message.getShopID()!=null){
                Shop shop = shopMapper.findShopByShopID(message.getShopID());
                BeanUtils.copyProperties(message, messageDto);
                messageDto.setShopPsrc(shop.getPsrc());
                messageDto.setShopName(shop.getShopName());
                result.add(messageDto);
            }if(message.getDeliveryID()!=null){
                Delivery delivery = deliveryMapper.findDeliveryByDeliveryID(message.getDeliveryID());
                BeanUtils.copyProperties(message, messageDto);
                messageDto.setShopPsrc(delivery.getPsrc());
                messageDto.setShopName(delivery.getUsername());
                result.add(messageDto);
            }
        }
        Integer newMsgNum = messages.size();
        res.put("newMsgNum",newMsgNum);
        res.put("data",result);
        return res;
    }

    /***
     * 更新用户信息 标记为已读
     * @param messageID
     * @return
     */
    @PostMapping("/updateUserMsg")
    public Integer updateUserMsg(@RequestParam Integer messageID){
        return messageMapper.updateUserMsg(messageID);
    }
}
