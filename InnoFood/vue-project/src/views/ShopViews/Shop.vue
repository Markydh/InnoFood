<template>
  <div class="main">
    <el-container style="width: 100%;height: 100%">
      <ShopAside :shop="shopData"></ShopAside>
      <el-main>
        <!--            表示当前子路由会在 <router-view /> 里展示-->
        <router-view />
      </el-main>
    </el-container>
    <!--    悬浮侧边栏-->
  </div>
</template>



<script>
import ShopAside from "@/components/ShopAside.vue";

export default {
  name: 'Shop',
  components:{
    ShopAside,
  },
  data() {
    return {
      avatarSize: 40, // 初始头像大小
      shopData:localStorage.getItem('shop')?JSON.parse(localStorage.getItem('shop')):{}
    };
  },
  created() {
  },
  methods: {
  },
};
</script>

<style scoped>
.main {
  width: 100%;
  height: 100%;
  padding: 12px;
  background-image: url("/managerBG.jpg");
  background-size: 100% ,100%;
}
</style>
