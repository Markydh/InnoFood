package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
//消息类，用户，商家，骑手接受消息
public class Message {
    private  Integer messageID;
    private  Integer userID;
    private  Integer shopID;
    private  Integer orderID;
    private  Integer deliveryID;
    private  String  msgContent;  //消息内容
    private  String msgTime;      //消息创建时间
    private  Integer state;
}
