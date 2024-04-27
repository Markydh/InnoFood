<template>
  <div class="main">
    <el-container style="width: 100%;height: 100%">
      <ManagerAside :manager="managerData"></ManagerAside>
      <el-main>
<!--            表示当前子路由会在 <router-view /> 里展示-->
        <router-view />
      </el-main>
    </el-container>
<!--    悬浮侧边栏-->
  </div>
</template>



<script>
import ManagerAside from "@/components/ManagerAside.vue";
import {MessageBox} from "element-ui";

export default {
  name: 'Manager',
  components:{
    ManagerAside,
  },
  data() {
    return {
      avatarSize: 40, // 初始头像大小
      managerData:localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{}
    };
  },
  created() {
    // 检查 managerData.state 字段，如果为 1，则弹出警告框
    if (this.managerData.state === 1) {
      this.showAlert();
    }
  },
  methods: {
    showAlert() {
      MessageBox.alert(
          "当前账户已冻结，请联系管理员！",
          "警告",
          {
            confirmButtonText: "确定",
            type: "warning",
            callback: this.$router.push("/backPlatForm")
          }
      );
    },
  },
};
</script>

<style scoped>
.main {
  width: 100%;
  height: 100%;
  padding: 12px;
  //background-color: rgba(167, 105, 210, 0.6);
  background-image: url("/managerBG.jpg");
  background-size: 100% ,100%;
}
</style>
