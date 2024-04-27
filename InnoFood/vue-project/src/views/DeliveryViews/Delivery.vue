<template>
  <div class="main">
    <el-container style="width: 100%;height: 100%">
      <DeliveryAside :delivery="deliveryData"></DeliveryAside>
      <el-main>
        <!--            表示当前子路由会在 <router-view /> 里展示-->
        <router-view />
      </el-main>
    </el-container>
    <!--    悬浮侧边栏-->
  </div>
</template>



<script>
import DeliveryAside from "@/components/DeliveryAside.vue";

export default {
  name: 'Delivery',
  components:{
    DeliveryAside,
  },
  data() {
    return {
      avatarSize: 40, // 初始头像大小
      deliveryData:localStorage.getItem('delivery')?JSON.parse(localStorage.getItem('delivery')):{}
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
//background-color: rgba(167, 105, 210, 0.6);
  background-image: url("/managerBG.jpg");
  background-size: 100% ,100%;
}
</style>
