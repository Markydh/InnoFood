<script>
export default {
  name: "MineAside",
  data() {
    return {
      UserData: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {}
    };
  },
  methods: {
    goBack() {
      this.$router.push('/User');
    },
    load() {
      this.request.get("/user/search", {
        params: {
          userID: this.UserData.userID
        }
      }).then(res => {
        console.log(res)
      });
    },
  }
}
</script>

<template>
  <el-container style="background: url('/index.jpg') center center fixed; background-size: cover; height: 100%">

    <el-header class="header">
      <div class="header-content">
        <el-button type="text" icon="el-icon-arrow-left" @click="goBack" class="back-btn">
          返回
        </el-button>

        <img src="/flogo2.png" class="logo" alt="购物中心Logo">

      </div>
    </el-header>

    <el-container>
      <el-aside width="200px" style="height: 100%; background: rgba(255, 255, 255, 0.7);">
        <div class="menu">
          <el-menu default-active="1" class="el-menu-vertical-demo">
            <router-link to="/mine/personinfo/" class="menu-link">
              <el-menu-item>
                <i class="el-icon-user"></i>
                个人信息
              </el-menu-item>
            </router-link>

            <router-link to="/mine/orders/" class="menu-link">
              <el-menu-item>
                <i class="el-icon-s-order"></i>
                历史订单
              </el-menu-item>
            </router-link>

            <router-link to="/mine/visible/" class="menu-link">
              <el-menu-item>
                <i class="el-icon-s-finance"></i>
                支出分析
              </el-menu-item>
            </router-link>

            <router-link to="/userLogin" class="menu-link">
              <el-menu-item>
                <i class="el-icon-refresh"></i>
                切换账号
              </el-menu-item>
            </router-link>
          </el-menu>
        </div>
      </el-aside>

      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>


<style scoped>
.header {
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

.menu {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.el-menu {
  background: none;
  box-shadow: none;
}

.menu-link {
  text-decoration: none;
}

.el-menu-item {
  font-size: 15px;
  text-align: center;
  margin-top: 5%;
  width: 100%;
}

.el-menu-item i {
  margin-right: 5px;
}

.el-menu-item:hover {
  background-color: #e6f7ff;
  color: #409eff;
}

.el-menu-item.is-active {
  background-color: #f0f9ff;
  color: #409eff;
}
</style>
