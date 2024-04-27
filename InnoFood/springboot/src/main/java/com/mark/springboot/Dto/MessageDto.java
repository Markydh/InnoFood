package com.mark.springboot.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MessageDto {
    private  Integer messageID;
    private  Integer userID;
    private  Integer shopID;
    private  Integer deliveryID;
    private  Integer orderID;
    private  String  msgContent;   //消息内容
    private  String  msgTime;      //消息创建时间
    private Integer  state;
    private  String  userPsrc;     //用户头像
    private  String  username;     //用户名
    private  String  managerPsrc;  //商家头像
    private  String  shopPsrc;     //店铺头像
    private  String  shopName;     //店铺名
}
