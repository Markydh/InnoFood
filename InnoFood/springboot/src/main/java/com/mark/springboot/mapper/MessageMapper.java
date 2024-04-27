package com.mark.springboot.mapper;

import com.mark.springboot.entity.Message;

import java.util.List;

public interface MessageMapper {
    List<Message> getManagerMsgByShopID(Integer shopID);

    Integer getNewManagerMsgNumByShopID(Integer shopID);

    Integer updateManagerMsg(Integer messageID);

    List<Message> getUserMsgByUserID(Integer userID);

    Integer updateUserMsg(Integer messageID);

    void insert(Message message);
}
