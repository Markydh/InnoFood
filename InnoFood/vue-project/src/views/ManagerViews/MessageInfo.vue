<template>

  <div class="message-info">
    <el-card v-for="message in messages" :key="message.messageID" class="message-card" @click.native="handleCardClick(message)">
      <!-- 用户头像 -->
      <div class="avatar-container">
        <img :src="message.userPsrc" alt="User Avatar" class="avatar">
        <!-- 未读消息显示小红点 -->
        <el-badge v-if="message.state === 0" class="badge" is-dot :value="8"></el-badge>
        <!-- 用户名称 -->
        <p class="user-name-below-avatar">{{ message.username }}</p>
      </div>
      <!-- 消息主题 -->
      <div class="message-content">
        <p class="message-text" style="color: rgb(0,0,0,0.7)">{{ message.msgContent }}</p>
      </div>
    </el-card>
  </div>
</template>

<script>
 export default {
   name: "MessageInfo",
   data() {
   return {
     messages: [],
     manager:localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{},
   };
 },
   created() {
     this.loadMessageInfo();
   },
   methods: {
     //加载商家收到的新的消息
     loadMessageInfo(){
       this.request.get(`/message/getManagerMsg?managerID=${this.manager.managerID}`).then(res => {
         console.log(res)
         this.messages = res.data;
       })
     },

     //点击卡片进入接单界面
     handleCardClick(message){
       this.request.get("/shop/findShopByShopID",{params: {
           shopID: message.shopID
         }
       }).then( res =>{
         this.updateMessageState(message);
         localStorage.setItem("shop",JSON.stringify(res));
       });
       this.$router.push("/Shop/NewOrder");
     },
     //更新消息的状态为已读
     updateMessageState(message){
       this.request.post(`/message/updateManagerMsg?messageID=${message.messageID}`).then(res =>{})
     }
   }
 };
</script>

<style scoped>
.message-info {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.message-card {
  width: 300px;
  margin: 15px;
}

.avatar-container {
  text-align: center;
  position: relative; /* 添加相对定位，以便设置 badge 的绝对定位 */
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
  margin-top: 5px; /* 调整用户名称与头像之间的垂直间距 */
  font-weight: bold;
}

.message-content {
  margin-top: 10px;
}

.message-text {
  word-wrap: break-word;
}
</style>