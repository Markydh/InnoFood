<!-- SidebarCard.vue -->
<template>
  <v-hover v-slot="{ hover }">
    <v-card :class="{ 'expanded-card': hover, 'collapsed-card': !hover }" @mouseover="expandSidebar" @mouseleave="collapseSidebar">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar :size="avatarSize" class="avatar-transition" >
            <v-img :src="shop.psrc"></v-img>
          </v-list-item-avatar>
          <v-list-item-content style="margin-left: 20px">
            <v-list-item-title class="text-h6">
              {{ shop.shopName }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider></v-divider>

      <v-list nav dense>
        <router-link to="/Shop/Home" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <i class="el-icon-s-home" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">主页</v-list-item-title>
          </v-list-item>
        </router-link>


        <router-link to="/Shop/ProductManage" style=" text-decoration: none;">
        <v-list-item link style="margin-top: 15px">
          <i class="el-icon-food" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">菜品列表</v-list-item-title>
        </v-list-item>
        </router-link>

        <router-link to="/Shop/productCategory" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <i class="el-icon-dish" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">菜品类别</v-list-item-title>
          </v-list-item>
        </router-link>

        <v-list-item link style="margin-top: 15px" @click="toggleSubOptions">
          <i class="el-icon-s-order" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">订单管理</v-list-item-title>
        </v-list-item>
        <v-list nav dense  v-if="showSubOptions">
          <router-link to="/Shop/NewOrder" style=" text-decoration: none;">
            <v-list-item link style="margin-top: 15px">
              <el-badge :value="totalNum" :max="10" class="item" :hidden="totalNum == 0">
              <i class="el-icon-message-solid" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
              </el-badge>
              <v-list-item-title style="margin-left: 10px;font-size: 15px">新的订单</v-list-item-title>
            </v-list-item>
          </router-link>


          <router-link to="/Shop/HistoryOrder" style=" text-decoration: none;">
            <v-list-item link style="margin-top: 15px">
              <i class="el-icon-thumb" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
              <v-list-item-title style="margin-left: 10px;font-size: 15px">已接订单</v-list-item-title>
            </v-list-item>
          </router-link>
        </v-list>

        <el-button  class="bottom-right-btn" type="text" @click="showDialog">
          <i class="el-icon-s-operation" style="margin: 0 0px; font-size: 35px; color: #f831c9"></i>
        </el-button>

        <el-dialog
            title="提示"
            :visible.sync="dialogVisible"
            width="30%"
            center>
          <span>你要进行的操作时</span>
          <span slot="footer" class="dialog-footer">
            <el-button @click="logOut">退出登录</el-button>
             <el-button type="primary" @click="changeAccount">返回商家界面</el-button>
            </span>
        </el-dialog>
      </v-list>

    </v-card>
  </v-hover>
</template>

<script>

import shop from "@/views/ShopViews/Shop.vue";

export default {
  name:"ShopAside",
  props: {
    shop: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      totalNum:0,   //新的订单数
      avatarSize: 40, // 初始头像大小
      dialogVisible: false,
      showSubOptions: false,
      shopData: localStorage.getItem("shop") ? JSON.parse(localStorage.getItem("shop")) : {},
    };
  },
  created() {
    this.countNum();
  },
  methods: {
    //请求分页查询数据
    countNum() {
      this.request.get("/order/newOrder/page", {
        params: {
          pageNum:0,
          pageSize:0,
          shopID: this.shopData.shopID
        }
      }).then(res => {
        this.totalNum = res.totalNum
      })
    },
    expandSidebar() {
      this.avatarSize = 60; // 鼠标悬浮时头像变大
    },
    collapseSidebar() {
      this.avatarSize = 40; // 鼠标离开时头像恢复原来的大小
      this.showSubOptions=false;
    },
    // 点击父选项框 子选项框展开
    toggleSubOptions(){
      this.showSubOptions = !this.showSubOptions;
    },
    showDialog() {
      this.dialogVisible=true;
    },
    // 退出登录和切换账号时要清除存储区内key:manager的内容
    logOut(){
      localStorage.removeItem("shop")
      this.dialogVisible=false;
      this.$message.info('退出成功')
      this.$router.push('/')
    },
    changeAccount(){
      localStorage.removeItem("shop")
      this.dialogVisible=false;
      this.$router.push('/manager')
      this.$message.info('商家界面')
    }
  },
};
</script>

<style>
.expanded-card {
  height: 100%;
  width: 20%; /* 调整展开时的宽度 */
  transition: width 0.3s; /* 添加过渡效果 */
}

.collapsed-card {
  height: 100%;
  width: 80px; /* 调整缩小版的宽度 */
  transition: width 0.5s; /* 添加过渡效果 */
}

.avatar-transition-enter-active,
.avatar-transition-leave-active {
  transition: all 1s;
}

.avatar-transition-enter, .avatar-transition-leave-to /* .avatar-transition-leave-active in <2.1.8 */ {
  transform: scale(1);
}

.avatar-transition-enter-to, .avatar-transition-leave /* .avatar-transition-enter-active in <2.1.8 */ {
  transform: scale(1.5);
}

.bottom-right-btn {
  position: absolute;
  bottom: 10px;
  left: 10px;
}
/* 根据需要设置其他样式 */
</style>