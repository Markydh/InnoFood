<template>
  <div style="height: 100%">
  <div class="father">
    <!-- 左上角按钮 -->
    <div class="top-left-button" @click="goBack">
      <el-button style="background-color: rgba(239,148,228,0.5); border: none;color: #FFFFFF;font-size: larger; margin-left: 20px;margin-top: 20px; height: 45px;width: 45px" circle>
        <i class="el-icon-arrow-left"></i>
      </el-button>
    </div>
    <div class="son1" @mouseover="showDropdown1">
      <transition name="slide">
        <div v-if="isDropdownVisible1" class="dropdown" @mouseleave="hideDropdown1">
          <div class="text">
            <Myh>欢迎来到网上购物系统</Myh>
            <br><br><br>
            <Myh>商家登陆入口</Myh>
            <br>
          </div>
          <el-button class="userBtn" @click="buttonClick1">Log IN</el-button>
        </div>
      </transition>
    </div>

    <div class="son2" @mouseover="showDropdown2">
      <transition name="slide">
        <div v-if="isDropdownVisible2" class="dropdown" @mouseleave="hideDropdown2">
          <div class="text">
            <Myh>欢迎来到网上购物系统</Myh>
            <br><br><br>
            <Myh>管理员登陆入口</Myh>
            <br>
          </div>
          <el-button class="userBtn" @click="buttonClick2">Log IN</el-button>
        </div>
      </transition>
    </div>
  </div>
  </div>
</template>



<script>
import Myh from "@/components/Myh.vue";

export default {
  name: "backPlatForm",
  components: {Myh},
  data(){
    return{
      isDropdownVisible1: false,
      isDropdownVisible2: false,
    }
  },
  methods: {
    showDropdown1() {
      this.isDropdownVisible1 = true;
    },
    showDropdown2(){
      this.isDropdownVisible2 = true;
    },
    hideDropdown1() {
      this.isDropdownVisible1 = false;
    },
    hideDropdown2() {
      this.isDropdownVisible2 = false;
    },
    buttonClick1() {
      // 处理按钮点击事件
      this.$router.push('/managerLogin')
      this.$message.info("商家登录")
    },
    buttonClick2() {
      // 处理按钮点击事件
      this.$router.push('/adminLogin')
      this.$message.info("管理员登录")
    },
    goBack(){
      this.$router.push("/");
    }
  }
}
</script>


<style scoped>
.father{
  position: relative;
  height: 100%;
  background-image: url("/BGhome.png");
  background-size: 100% ,80%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.son1{
  width: 300px;
  height: 470px;
  margin-left: 100px;
  background-image: url("/shopper_index.jpg");
  background-size: 130% ,100%;
}
.son2{
  width: 300px;
  height: 470px;
  margin-left: 300px;
  background-image: url("/manager_index.jpg");
  background-size: 130% ,100%;
}
.slide-enter-active, .slide-leave-active {
  transition: transform 0.5s ease;
}
.slide-enter, .slide-leave-to {
  transform: translateY(-100%);
}
.dropdown {
  position: relative;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.text{
  font-size: medium;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  top: -30%;
  height: 40%; /* 或者设置一个具体的高度 */
  width: 70%;
}
.userBtn{
  background: transparent;
  border: 0;
  border-radius: 0;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 20px;
  padding: 15px 50px;
  position: relative;
}
.userBtn:before {
  transition: all 0.8s cubic-bezier(0.7, -0.5, 0.2, 2);
  content: '';
  width: 1%;
  height: 100%;
  background: #c53b37;
  position: absolute;
  top: 0;
  left: 0;
}
.userBtn span {
  mix-blend-mode: darken;
}

.userBtn:hover:before {
  background: #9edafc;
  width: 100%;
}
.top-left-button {
  position: absolute;
  top: 20px;
  left: 20px;
  cursor: pointer;
  color: white;
  font-size: 18px;
}
</style>