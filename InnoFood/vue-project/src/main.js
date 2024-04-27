import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import './assets/globlal.css'
import request from "@/utils/request"
import * as echarts from "echarts"
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'


Vue.config.productionTip = false

Vue.use(ElementUI,{size:"small"})

Vue.use(Vuetify)

Vue.prototype.request=request

Vue.prototype.$echarts = echarts

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
