<template>
  <div style="height:100%">
    <el-container style="height: 100%; ">
      <!--      header部分-->
      <el-header style="padding:0px;height: 75px;">
        <div style="text-align: right; font-size: 12px;line-height: 60px;background-color:white;display: flex">
          <div style="padding-left: 130px;padding-top:15px;width: 500px;display:flex;text-align: center;flex: 1">
            <el-image
                style="width: 50px; height: 50px; border-radius: 20%;margin-right: 10px;margin-top: 10px"
                :src="user.psrc"
                :fit="fits">
            </el-image>
            <h1 style="color: #000000;font-size:25px;font-weight: normal;margin-top: 5px">确认订单</h1>
          </div>
          <div style="padding-right: 100px;padding-top:20px;display: flex;text-align: center">
            <el-dropdown style="width: 200px;height:50px;cursor:pointer;">
              <div style="display: flex;align-items: center;right: 0%;position: absolute">
                <el-image
                    style="width: 40px; height: 40px; border-radius: 50%;margin-right: 10px"
                    :src="user.psrc"
                    :fit="fits">
                </el-image>
                <span style="color: #000000;">{{user.username}}</span>
                <i class="el-icon-arrow-down" style="margin-right: 20px;color:#000000"></i>
              </div>
              <el-dropdown-menu slot="dropdown" style="width: 80px;">
                <el-dropdown-item>
                  <span style="text-decoration:none" @click="$router.push('/')">退出</span>
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            <Myh style="font-size:medium">/ 我的订单</Myh>
          </div>
        </div>
      </el-header>
      <!--  下划线-->
      <el-divider></el-divider>
      <el-main style="background-color: #f5f5f5; display: flex; justify-content: center;">
        <!-- 中间的居中div -->
        <div style="background-color: #ffffff;width: 80%;height: 300px">
          <el-row :gutter="16" style="padding-top: 30px">
            <el-col :span="8"><div class="grid-content bg-purple" style="margin-left: 10px;margin-bottom: -15px">收货地址</div></el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="8">
              <div class="grid-content bg-purple" style="border:1px solid rgba(0,0,0,0.2);width: 200px;height: 140px;margin-left: 10px">
                <div style="width: 70%;margin-left: 10px;margin-top: 15px">
                  <span style="padding-top: 5px">{{user.username}}</span><br>
                  <span style="padding-top: 5px;font-size: small;font-weight: normal;color: rgb(0,0,0,0.6)">{{user.phone}}</span><br>
                  <span style="padding-top: 5px;font-size: small;font-weight: normal;color: rgb(0,0,0,0.6)">{{user.address}}</span>
                </div>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="16">
            <el-col :span="8"><div class="grid-content bg-purple" style="margin-left: 10px;margin-bottom: -15px">商品</div></el-col>
          </el-row>

          <div style="background-color: #FFFFFF;padding-top: 10px;font-size: 13px; font-weight: normal; /* 设置字体加粗 */" >
            <!--          商品信息-->
            <el-row v-for="(item, index) in cart" :key="index" type="flex" justify="center" align="middle">
              <el-col :span="6" style="padding-left: 40px"><img :src="item.psrc" class="avatar" style="width: 50px; height: 50px"></el-col>
              <el-col :span="6" >{{ item.productname }}</el-col>
              <el-col :span="6" >{{item.price}}元×{{item.quantity}}</el-col>
              <el-col :span="6" >{{ item.price*item.quantity}}</el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row :gutter="20">
              <el-col :span="20"><div class="grid-content bg-purple"  id="mapContainer"></div></el-col>
              <el-col :span="4">
                <div style="width: 70%;margin-left: 10px;margin-top: 15px">
                  <span style="padding-top: 5px">商品数：{{ totalQuantity }}</span><br>
                  <span style="padding-top: 5px;font-size: small;font-weight: normal;color: rgb(0,0,0,0.6)">商品总价：{{subtotal}}</span><br>
                  <span style="padding-top: 5px;font-size: small;font-weight: normal;color: rgb(0,0,0,0.6)">运费：{{shippingFee}}</span><br><br>
                  <span style="padding-top: 5px;font-size: small;font-weight: normal;color: rgb(0,0,0,0.6)">总金额：{{totalAmount}}</span><br>
                </div>
              </el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row :gutter="16">
              <el-col :span="8"><div class="grid-content bg-purple" style="margin-left: 10px;margin-bottom: -15px">支付方式</div></el-col>
            </el-row>

            <el-row :gutter="16">
              <el-col :span="4">
                <div class="grid-content bg-purple" style="margin-left: 10px;margin-bottom: -15px">
                  <label class="radio-wrapper radio-border" :style="{'border-color': ((pickedPay === 'alipay') ? '#409eff' : '#d7dae2')}">
                    <input style="margin-left:10px" type="radio" name="pay" v-model="pickedPay" @change="handlePaymentChange('alipay')" />
                    <img class="icon" src="/AliPay.jpg">
                    <span class="text">支付宝支付</span>
                  </label>
                </div>
              </el-col>
              <el-col :span="4">
                <div class="grid-content bg-purple" style="margin-left: -50px;margin-bottom: -10px">
                  <label class="radio-wrapper radio-border" :style="{'border-color': ((pickedPay === 'wechat') ? '#409eff' : '#d7dae2'), 'margin-left':'20px'}">
                    <input style="margin-left:10px" type="radio" name="pay" v-model="pickedPay" @change="handlePaymentChange('wechat')" />
                    <img class="icon" src="/WPay.jpg">
                    <span class="text">微信支付</span>
                  </label>
                </div>
              </el-col>
            </el-row>

            <el-row :gutter="20">
              <el-col :span="9"><div class="grid-content bg-purple"></div></el-col>
              <el-col :span="9"><div class="grid-content bg-purple"></div></el-col>
              <el-col :span="3" style="padding-right: -100px">
                <div class="grid-content bg-purple" style="margin-left: -63px">
                  <el-button plain style="width:130px;color: #5d5e5d" @click="backCart">返回购物车</el-button>
                </div>
              </el-col>
              <el-col :span="3">
                <div class="grid-content bg-purple" style="margin-left:-40px;margin-bottom: 20px">
                  <el-button type="warning" style="width:130px;background-color: #ef6417;color: #FFFFFF" @click="pay">提交订单</el-button>
                </div>
              </el-col>
            </el-row>
          </div>
        </div>
      </el-main>

    </el-container>
  </div>
</template>

<script>

import Myh from "@/components/Myh.vue";
import axios from "axios";

export default {

  name: "CheckOrder",
  components: {Myh},
  data(){
    return{
      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      shop:localStorage.getItem("shop") ? JSON.parse(localStorage.getItem("shop")) : {},
      cart:localStorage.getItem("cart") ? JSON.parse(localStorage.getItem("cart")):[],
      fits: "cover",
      request: axios, // Assuming you are using axios for HTTP requests
      pickedPay: ""
    }
  },
  computed:{
    totalQuantity() {
      // 计算商品数量之和
      return this.cart.reduce((total, item) => total + item.quantity, 0);
    },
    subtotal() {
      // 计算商品总价
      return this.cart.reduce((total, item) => total + item.price * item.quantity, 0)
    },

    shippingFee() {
      return 2; //运费示例
    },

    totalAmount() {
      const totalAmount = this.subtotal + this.shippingFee;
      return totalAmount.toFixed(2);
    },
  },
  methods: {
    // 返回店铺界面
    backCart(){
      this.$router.push({path:'/shopIndex'})
    },
    // 确认支付
    pay(){
      // 记录订单
      const cartItem = {
        cart: this.cart,
        shippingFee:this.shippingFee, //配送费
        subtotal:this.subtotal,      //商品总价
        totalAmount:this.totalAmount, //订单总费用
        userID:this.user.userID,
        shopID:this.shop.shopID,
      };

      // 提交订单给后端
      this.sendOrder(cartItem);

      //更新商品信息
      this.updateProduct()

      // 展示支付码，并在5秒后执行其他操作
      this.showQRCode();

      setTimeout(() => {
        localStorage.removeItem("cart");
        this.$router.push('/user');
      }, 2500);
    },
    //更新商品的信息，库存量以及销售量
    // 修改前端代码
    updateProduct(){
      Promise.all(
          this.cart.map(item =>
              this.request.post("http://localhost:9091/product/submitOrder", { productID: item.productID, quantity: item.quantity })
          )
      ).then( res =>{
        console.log("更新商品完毕")
      })
    },
    // 提交订单明细传递给后端
    sendOrder(cartItem) {
      // Send an HTTP POST request to the backend API
      this.request.post("http://localhost:9091/order",cartItem)
          .then(response => {
            // Handle the response from the backend if needed
            console.log('Order sent successfully:', response);
          })
          .catch(error => {
            // Handle errors
            console.error('Error sending order:', error);
          });
    },
    // 展示支付码
    showQRCode(){
      const messageHtml = `
  <div style="display: flex; justify-content: center; align-items: center;">
      <img src="/WeChatPay.JPG" alt="QR Code" style="width: 100%; max-width: 300px;">
    </div>
  `;
      this.$alert(messageHtml, {
        dangerouslyUseHTMLString: true, // 允许使用 HTML 片段
      });
    },
  }
}
</script>

<style scoped>
.el-row {
  margin-bottom: 10px;
  &:last-child {
    margin-bottom: 0;
  }
}
.el-col {
  border-radius: 4px;
}
.bg-purple-dark {
  background: #ffffff;
}
.bg-purple {
  background: #ffffff;
}
.bg-purple-light {
  background: #ffffff;
}
.grid-content {
  border-radius: 4px;
  min-height: 36px;
}
.row-bg {
  padding: 10px 0;
  background-color: #f9fafc;
}
.radio-wrapper {
  display: flex;
  flex-direction: row;
  align-items: center;
  .icon {
    width: 30px;
    height: 30px;
    margin-left: 5px;
    margin-right: 5px;
  }
  .text {
    font-size: 14px;
  }
}
.radio-border {
  width: 160px;
  height: 50px;
  border-radius: 5px;
  border: 1px solid #d7dae2;
}
</style>