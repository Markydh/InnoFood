import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  { path: '/', name: 'index', component: () => import('../views/Index.vue') },
  { path: '/backPlatForm', name: 'BackPlatForm', component: () => import('../views/BackPlatform.vue') },

    //管理员路由
  { path: '/adminLogin', name: 'AdminLogin', component: () => import('../views/AdminViews/AdminLogin.vue')},
  {
    path: '/admin/',
    name: 'Admin',
    component: () => import('../views/AdminViews/Admin.vue'),
    redirect:"/admin/home",
    children:[
      { path: 'home', name: 'Home', component: () => import('../views/AdminViews/Home.vue') },
      { path: 'user', name: 'User', component: () => import('../views/AdminViews/ZhUser.vue') },
      { path: 'shop', name: 'Shop', component: ()  => import('../views/AdminViews/Shop.vue') }
    ]
  },
    //用户路由
  { path: '/userLogin', name: 'UserLogin', component: () => import('../views/UserViews/UserLogin.vue') },
  { path: '/userRegister', name: 'UserRegister', component: () => import('../views/UserViews/UserRegister.vue') },
  { path: '/checkOrder', name: 'CheckOrder', component: () => import('../views/UserViews/CheckOrder.vue') },
  { path: '/messageInfo', name: 'MessageInfo', component: () => import('../views/UserViews/MessageInfo.vue') },
  { path: '/user', name: 'user', component: () => import('../views/UserViews/User.vue'),},

    //商户路由
  { path: '/managerLogin', name: 'ManagerLogin', component: () => import('../views/ManagerViews/ManagerLogin.vue')},
  { path: '/managerRegister', name: 'ManagerRegister', component: () => import('../views/ManagerViews/ManagerRegister.vue')},
  {
    path: '/manager',
    name: 'Manager',
    component: () => import('../views/ManagerViews/Manager.vue'),
    redirect: "/manager/home",
    children: [
      { path: 'home', name: 'Home', component: () => import('../views/ManagerViews/Home.vue') },
      { path: 'shopManage', name: 'ShopManage', component: () => import('../views/ManagerViews/ShopManage.vue') },
      { path: 'managerInfo', name: 'ManagerInfo', component: () => import('../views/ManagerViews/ManagerInfo.vue') },
      { path: 'myShop', name: 'MyShop', component: () => import('../views/ManagerViews/MyShop.vue') },
      { path: 'orderInfo', name: 'OrderInfo', component: () => import('../views/ManagerViews/OrderInfo.vue') },
      { path: 'messageInfo', name: 'MessageInfo', component: () => import('../views/ManagerViews/MessageInfo.vue') },
    ]
  },

    //店铺路由
  {
    path: '/shop',
    name: 'Shop',
    component: () => import('../views/ShopViews/Shop.vue'),
    redirect: "/shop/home",
    children: [
      { path: 'home', name: 'Home', component: () => import('../views/ShopViews/Home.vue') },
      { path: 'productManage', name: 'ProductManage', component: () => import('../views/ShopViews/ProductManage.vue')},
      { path: 'productCategory', name: 'ProductCategory', component: () => import('../views/ShopViews/ProductCategory.vue')},
      { path: 'newOrder', name: 'NewOrder', component: () => import('../views/ShopViews/NewOrder.vue')},
      { path: 'historyOrder', name: 'HistoryOrder', component: () => import('../views/ShopViews/HistoryOrder.vue')},
    ]
  },
  { path: '/shopIndex', name: 'ShopIndex', component: () => import('../views/ShopViews/ShopIndex.vue')},



    //骑手路由
  { path: '/deliveryLogin', name: 'DeliveryLogin', component: () => import('../views/DeliveryViews/DeliveryLogin.vue')},
  { path: '/deliveryRegister', name: 'DeliveryRegister', component: () => import('../views/DeliveryViews/DeliveryRegister.vue')},
  {
    path: '/delivery',
    name: 'Delivery',
    component: () => import('../views/DeliveryViews/Delivery.vue'),
    redirect: "/delivery/home",
    children: [
      { path: 'home', name: 'Home', component: () => import('../views/DeliveryViews/Home.vue') },
      { path: 'newOrder', name: 'NewOrder', component: () => import('../views/DeliveryViews/NewOrder.vue')},
      { path: 'historyOrder', name: 'HistoryOrder', component: () => import('../views/DeliveryViews/HistoryOrder.vue')},
      { path: 'deliveryInfo', name: 'DeliveryInfo', component: () => import('../views/DeliveryViews/DeliveryInfo.vue')},
    ]
  },

  {path: '/mine/', name: 'mine', component: () => import('../views/UserViews/Mine.vue'),
    redirect: "/mine/personinfo/",
    children: [
      {path: 'orders', name: 'orders', component: () => import('../views/UserViews/orders.vue')},  //订单页面
      {path: 'personinfo', name: 'personinfo', component: () => import('../views/UserViews/personInfo.vue')},  //个人信息页面
      {path: 'visible', name: 'visible', component: () => import('../views/UserViews/visible.vue')},  //个人信息页面
    ]
  },


  //其他路由
  { path: '/show', name: 'Show', component: () => import('../views/Show.vue')},
  { path: '/diagram', name: 'Diagram', component: () => import('../views/diagram.vue')},
  { path: '/about', name: 'About', component: () => import('../views/About.vue')},
]
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
