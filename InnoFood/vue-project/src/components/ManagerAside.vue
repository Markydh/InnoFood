<!-- SidebarCard.vue -->
<template>
  <v-hover v-slot="{ hover }">
    <v-card :class="{ 'expanded-card': hover, 'collapsed-card': !hover }" @mouseover="expandSidebar" @mouseleave="collapseSidebar">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar :size="avatarSize" class="avatar-transition" >
            <v-img :src="manager.psrc"></v-img>
          </v-list-item-avatar>
          <v-list-item-content style="margin-left: 20px">
            <v-list-item-title class="text-h6">
              {{ manager.username }}
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ manager.email }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider></v-divider>

      <v-list nav dense>
        <router-link to="/Manager/Home" style=" text-decoration: none;">
        <v-list-item link style="margin-top: 15px">
          <i class="el-icon-s-home" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">主页</v-list-item-title>
        </v-list-item>
        </router-link>


        <v-list-item link style="margin-top: 15px" @click="toggleSubOptions">
          <i class="el-icon-s-shop" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">店铺中心</v-list-item-title>
        </v-list-item>

        <v-list nav dense  v-if="showSubOptions">
          <router-link to="/Manager/MySHop" style=" text-decoration: none;">
            <v-list-item link style="margin-top: 15px">
              <i class="el-icon-school" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
              <v-list-item-title style="margin-left: 10px;font-size: 15px">我的店铺</v-list-item-title>
            </v-list-item>
          </router-link>


<!--          店铺管理模块还未完成 2023/11/25-->
          <router-link to="/Manager/ShopManage" style=" text-decoration: none;">
            <v-list-item link style="margin-top: 15px">
              <i class="el-icon-menu" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
              <v-list-item-title style="margin-left: 10px;font-size: 15px">店铺管理</v-list-item-title>
            </v-list-item>
          </router-link>
        </v-list>

        <router-link to="/Manager/OrderInfo" style=" text-decoration: none;">
        <v-list-item link style="margin-top: 15px">
          <i class="el-icon-s-order" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">订单查询</v-list-item-title>
        </v-list-item>
        </router-link>

        <router-link to="/Manager/MessageInfo" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <el-badge :value="messageCount" :max="10" class="item" :hidden="messageCount == 0">
            <i class="el-icon-chat-dot-square" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            </el-badge>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">消息</v-list-item-title>
          </v-list-item>
        </router-link>

        <router-link to="/Manager/ManagerInfo" style=" text-decoration: none;">
        <v-list-item link style="margin-top: 15px">
          <i class="el-icon-user-solid" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
          <v-list-item-title style="margin-left: 10px;font-size: 15px">商家信息</v-list-item-title>
        </v-list-item>
        </router-link>



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
             <el-button type="primary" @click="changeAccount">切换账号</el-button>
            </span>
        </el-dialog>
      </v-list>

    </v-card>
  </v-hover>
</template>

<script>
import manager from "@/views/ManagerViews/Manager.vue";

export default {
  name:"ManagerAside",
  props: {
    manager: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      avatarSize: 40, // 初始头像大小
      messageCount:0, //消息数
      dialogVisible: false,
      showSubOptions: false
    };
  },
  created() {
    this.loadMessage();
  },
  methods: {
    loadMessage(){
      this.request.get(`/message/getManagerMsg?managerID=${this.manager.managerID}`).then(res =>{
        console.log(res)
          this.messageCount=res.newMsgNum;
      })
    },
    expandSidebar() {
      this.avatarSize = 60; // 鼠标悬浮时头像变大
    },
    collapseSidebar() {
      this.avatarSize = 40; // 鼠标离开时头像恢复原来的大小
      this.showSubOptions=false;
    },
    toggleSubOptions(){
      this.showSubOptions = !this.showSubOptions;
    },
    showDialog() {
     this.dialogVisible=true;
    },
    // 退出登录和切换账号时要清除存储区内key:manager的内容
    logOut(){
      localStorage.removeItem("manager")
      this.dialogVisible=false;
      this.$message.info('退出成功')
      this.$router.push('/')
    },
    changeAccount(){
      localStorage.removeItem("manager")
      this.dialogVisible=false;
      this.$message.info('切换成功')
      this.$router.push('/managerLogin')
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