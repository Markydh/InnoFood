<template>
  <div class="admin-aside">
    <el-menu :default-openeds="['1', '3']" router>
      <el-menu-item index="/Admin/Home">
        <i class="el-icon-message"></i>
        <span slot="title">主页</span>
      </el-menu-item>
      <el-menu-item index="/admin/user">
        <i class="el-icon-user-solid"></i>
        <span slot="title">信息管理</span>
      </el-menu-item>
      <el-menu-item index="/admin/shop">
        <i class="el-icon-s-goods"></i>
        <span slot="title">商铺管理</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
export default {
  name: "AdminAside"
};
</script>

<style scoped>
.admin-aside {
  height: 100%;
  overflow: hidden;
  background-color: rgba(255, 255, 255, 0);
}

.el-menu {
  background-color: rgba(255, 155, 155, 0);
  text-color: rgba(255, 255, 255, 0);
}
</style>
