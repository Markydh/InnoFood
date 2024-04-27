<template>
  <div style="text-align: right; font-size: 12px;line-height: 60px;background-color:rgba(98,96,96,0.3);display: flex">
    <img src="/flogo2.png" alt="Logo" class="logo-image">
  <div style="padding-left: 30px;width: 200px;text-align: left;flex: 1; margin-left: 60px"><h1 style="color: cornsilk">智享餐饮</h1></div>
    <el-dropdown style="width: 200px;height:50px;cursor:pointer;">
    <div style="display: flex;align-items: center;right: 0%;position: absolute">
      <el-image
          style="width: 40px; height: 40px; border-radius: 50%;margin-right: 10px"
          :src="user.psrc"
          fit="cover">
      </el-image>
      <span style="color: #FFFFFF;">{{user.username}}</span>
      <i class="el-icon-arrow-down" style="margin-right: 20px;color:#FFFFFF"></i>
    </div>
        <el-dropdown-menu slot="dropdown" style="width: 80px;">
          <el-dropdown-item>
            <span style="text-decoration:none" @click="logout">退出</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
  </div>
</template>


<script>
export default {
  name: "Header",
  data(){
    return{
      user: localStorage.getItem('user')?JSON.parse(localStorage.getItem('user')):{}
    }
  },
  methods:{
    logout(){
      this.$router.push("/")
      this.$message.success("退出成功")
    }
  }
}
</script>

<style>
.logo-image {
  background-image: url("/logo_4.png");
  position: absolute; /* 设置绝对定位 */
  top: -8px; /* 图片顶部与父元素顶部对齐 */
  left: -3px; /* 图片左侧与父元素左侧对齐 */
  width: 85px; /* 调整图片宽度 */
  height: auto; /* 调整图片高度 */
}
</style>