<script>
import orderAll from "@/views/UserViews/orderComponents/orderAll.vue";
import orderState0 from "@/views/UserViews/orderComponents/orderState0.vue";
import orderState1 from "@/views/UserViews/orderComponents/orderState1.vue";
import orderState2 from "@/views/UserViews/orderComponents/orderState2.vue";
import orderState3 from "@/views/UserViews/orderComponents/orderState3.vue";

export default {
  name: "orders",
  components: {
    orderAll, orderState0, orderState1, orderState2, orderState3
  },
  data() {
    return {
      activeName: 'third',
    }
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    },
  },
}
</script>

<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick" class="order-tabs">
      <el-tab-pane label="未处理" name="first">
        <transition name="fade">
          <orderState0 v-if="activeName === 'first'"/>
        </transition>
      </el-tab-pane>

      <el-tab-pane label="商家已接单" name="second">
        <transition name="fade">
          <orderState1 v-if="activeName === 'second'"/>
        </transition>
      </el-tab-pane>

      <el-tab-pane label="骑手已接单" name="third">
        <transition name="fade">
          <orderState2 v-if="activeName === 'third'"/>
        </transition>
      </el-tab-pane>

      <el-tab-pane label="已送达" name="fourth">
        <transition name="fade">
          <orderState3 v-if="activeName === 'fourth'"/>
        </transition>
      </el-tab-pane>

      <el-tab-pane label="全部" name="fifth">
        <transition name="fade">
          <orderAll v-if="activeName === 'fifth'"/>
        </transition>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<style scoped>
.order-tabs {
  margin-top: 20px;
}

.el-tabs__item {
  margin-right: 10px;
}

.el-tabs__active-bar {
  height: 2px;
  background-color: #409eff;
}

.el-tab-pane {
  padding: 10px;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
