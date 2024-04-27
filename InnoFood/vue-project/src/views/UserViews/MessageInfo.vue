<template>
  <div class="message-info">
    <el-header class="header">
      <div class="header-content">
        <el-button type="text" icon="el-icon-arrow-left" @click="goBack" class="back-btn">
          返回
        </el-button>
        <img src="/flogo2.png" class="logo" alt="购物中心Logo">
      </div>
    </el-header>

    <div class="card-container">
      <el-card v-for="message in messages" :key="message.messageID" class="message-card" @click.native="handleCardClick(message)" style="height: auto">
        <!-- 用户头像 -->
        <div class="avatar-container">
          <img :src="message.shopPsrc" alt="Shop Avatar" class="avatar">
          <!-- 未读消息显示小红点 -->
          <el-badge v-if="message.state === 2" class="badge" is-dot :value="8"></el-badge>
          <!-- 用户名称 -->
          <p class="user-name-below-avatar">{{ message.shopName }}</p>
        </div>
        <!-- 消息主题 -->
        <div class="message-content">
          <p class="message-text" style="color: rgb(0,0,0,0.7)">{{ message.msgContent }}</p>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: "MessageInfo",
  data() {
    return {
      messages: [],
      user:localStorage.getItem('user')?JSON.parse(localStorage.getItem('user')):{},
    };
  },
  created() {
    this.loadMessageInfo();
  },
  methods: {
    //加载商家收到的新的消息
    loadMessageInfo(){
      this.request.get("/message/getUserMsg",{
        params:{
          userID:this.user.userID
        }
      }).then(res => {
        console.log(res)
        this.messages = res.data;
      })
    },

    //点击卡片更新消息的状态为已读
    handleCardClick(message){
      this.$router.push("/mine/orders")
      this.updateMessageState(message);
    },
    updateMessageState(message){
      this.request.post(`/message/updateManagerMsg?messageID=${message.messageID}`).then(res =>{})
    },
    goBack(){
      this.$router.push("/user");
    }
  }
};
</script>

<style scoped>
.message-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-image: url("/managerBG.jpg");
  background-size: cover;
  background-attachment: fixed;
  height: 100%;
}

.header {
  width: 100%;
  height: 60px;
  line-height: 60px;
  background-color: #6a8bb6;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
}

.back-btn {
  font-size: large;
}

.logo {
  height: 60px;
  width: auto;
}

.back-button {
  margin-bottom: 20px;
  margin-left: -1560px;
}

.card-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  width: 100%;
}

.message-card {
  width: 300px;
  margin: 15px;
}

.avatar-container {
  text-align: center;
  position: relative;
}

.avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  margin-bottom: 10px;
}

.badge {
  position: absolute;
  top: -10px;
  left: -10px;
}

.badge >>> .el-badge__content {
  width: 15px;
  height: 15px;
}

.user-name-below-avatar {
  margin-top: 5px;
  font-weight: bold;
}

.message-content {
  margin-top: 10px;
}

.message-text {
  word-wrap: break-word;
}
</style>
