<!-- SidebarCard.vue -->
<template>
  <v-hover v-slot="{ hover }">
    <v-card :class="{ 'expanded-card': hover, 'collapsed-card': !hover }" @mouseover="expandSidebar" @mouseleave="collapseSidebar">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar :size="avatarSize" class="avatar-transition" >
            <v-img :src="delivery.psrc"></v-img>
          </v-list-item-avatar>
          <v-list-item-content style="margin-left: 20px">
            <v-list-item-title class="text-h6">
              {{ delivery.username }}
            </v-list-item-title>
            <v-list-item-subtitle>
              电话：{{ delivery.phone }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider></v-divider>

      <v-list nav dense>
        <router-link to="/Delivery/Home" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <i class="el-icon-s-home" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">主页</v-list-item-title>
          </v-list-item>
        </router-link>


        <router-link to="/Delivery/NewOrder" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <el-badge :value="totalNum" :max="10" class="item" :hidden="totalNum == 0">
            <i class="el-icon-bell" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            </el-badge>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">新的订单</v-list-item-title>
          </v-list-item>
        </router-link>

        <router-link to="/Delivery/HistoryOrder" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <i class="el-icon-thumb" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">已接订单</v-list-item-title>
          </v-list-item>
        </router-link>

        <router-link to="/Delivery/DeliveryInfo" style=" text-decoration: none;">
          <v-list-item link style="margin-top: 15px">
            <i class="el-icon-user-solid" style="margin: 0 0px; font-size: 45px; color: #f831c9"></i>
            <v-list-item-title style="margin-left: 10px;font-size: 15px">骑手信息</v-list-item-title>
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

export default {
  name:"DeliveryAside",
  props: {
    delivery: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      totalNum:0, //新的订单数
      avatarSize: 40, // 初始头像大小
      dialogVisible: false,
      showSubOptions: false
    };
  },
  created() {
    this.countNum();
  },
  methods: {
    //查询订单数
    countNum() {
      this.request.get("/order/deliveryToPickOrder/page", {
        params: {
          pageNum: 0,
          pageSize: 0,
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
    toggleSubOptions(){
      this.showSubOptions = !this.showSubOptions;
    },
    showDialog() {
      this.dialogVisible=true;
    },
    // 退出登录和切换账号时要清除存储区内key:manager的内容
    logOut(){
      localStorage.removeItem("delivery")
      this.dialogVisible=false;
      this.$message.info('退出成功')
      this.$router.push('/')
    },
    changeAccount(){
      localStorage.removeItem("delivery")
      this.dialogVisible=false;
      this.$message.info('切换成功')
      this.$router.push('/deliveryLogin')
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