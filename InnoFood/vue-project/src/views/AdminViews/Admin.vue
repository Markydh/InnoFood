<template>
  <div style="height:100%" class="content">
    <el-container style="height: 100%; ">
      <el-header style="padding:0px ">
       <Header/>
      </el-header>
      <el-container>
          <el-aside width="200px" height="100%" style="background-color: rgba(255,255,255,0.3);box-shadow: 2px 0 6px rgb(0 21 41 / 35% )">
            <AdminAside/>
          </el-aside>
        <el-container>
          <el-main>
<!--            表示当前子路由会在 <router-view /> 里展示-->
            <router-view />
          </el-main>
          <el-footer><h1 style="color: #e35d0f; font-size: 20px">智享餐饮，味蕾的智慧之选，让美味一键可享！</h1></el-footer>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>


<style scoped>

.el-footer{
  background-color: rgba(255, 255, 255, 0.2);
  line-height: 60px;
  text-align: center;
  color:cornsilk;
}
</style>

<script>
import AdminAside from "@/components/AdminAside.vue";
import Header from "@/components/Header.vue";

export default {
  name: 'Admin',
  components: {Header, AdminAside},
  methods: {
  }
}
</script>
<style>
.content{
  width: 100%;
  background-image: url("/index.jpg");
  background-size: cover;
  background-attachment: fixed;
}
</style>