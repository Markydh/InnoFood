<template>
  <div class="body">
    <el-container>
      <el-header>
        <el-menu class="nav" mode="horizontal"
                 text-color="#ffd04b" active-text-color="#ffd04b" :style="{ backgroundColor: headerColor }">
          <img src="/flogo2.png" alt="Logo" class="logo-image">
          <el-menu-item index="0" style="margin-left: 100px" @click="scrollToTop">热门</el-menu-item>
          <el-menu-item v-for="item in navMenu" :key="item.shopTypeID" :href="'#' + item.shopTypeID"
                        @click="scrollToCategory(item.shopTypeID)">
            {{ item.shopTypeName }}
          </el-menu-item>
          <el-submenu index="2">
            <template slot="title">筛选</template>
            <el-menu-item index="2-1">评价最高</el-menu-item>
            <el-menu-item index="2-2">销量最高</el-menu-item>
            <el-menu-item index="2-3">距离最近</el-menu-item>
          </el-submenu>
          <el-image circle :src="user.psrc"
                     style="margin-left: 0px; border-radius: 50%;margin-top: 7px;width: 45px; height: 45px;">
            </el-image>
          <div class="right-menu">
            <el-menu-item>
              <el-col :span="12">
                <el-dropdown style=" margin-left: -12px">
                <span class="el-dropdown-link" style="margin-left: 0px;color: #FFFFFF">
                  {{ '你好, ' + user.username }}<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item icon="el-icon-s-check">
                      <router-link :to="{ name: 'mine'}" style="text-decoration: none; color: inherit;">个人中心
                      </router-link>
                    </el-dropdown-item>
                    <el-dropdown-item icon="el-icon-s-comment">
                      <el-badge :value="messageCount" :max="10" class="item" :hidden="messageCount == 0">
                      <router-link :to="{ name: 'MessageInfo'}" style="text-decoration: none; color: inherit;">
                        消息中心
                      </router-link>
                      </el-badge>
                    </el-dropdown-item>
                    <el-dropdown-item icon="el-icon-remove">
                      <router-link :to="{ name: 'index'}" style="text-decoration: none; color: inherit;">退出登录
                      </router-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
              </el-col>
            </el-menu-item>
          </div>
        </el-menu>
      </el-header>
      <el-main>

        <div class="fatherBlockGuess" style="margin-top: 70px">
          <!--        走马灯-->
          <div class="block">
            <el-carousel height="450px" style="margin-top: -14px">
              <el-carousel-item v-for="(item, index) in imgUrls" :key="index">
                <img class="image" :src="item" :alt="index + 1"/>
              </el-carousel-item>
            </el-carousel>
            <!-- 搜索框 -->
            <div class="search-box" :class="{ 'hovered': shopName || isHovered }" @mouseover="isHovered = true" @mouseleave="isHovered = false">
              <el-button class="search-btn" type="text">
                <i class="el-icon-search" aria-hidden="true"></i>
              </el-button>
              <input type="text" class="search-txt" placeholder="请输入菜品名" v-model="shopName"/>
              <div class="search-line"></div>
              <!-- 在搜索框下方显示已过滤的店铺名称 -->
              <ul v-if="filteredShops.length > 0 && shopName !== ''" class="search-results">
                <el-dropdown style="margin-left: -12px">
                  <li v-for="shop in filteredShops" :key="shop.shopID" @click="enterShop(shop.shopID)">
                    {{ shop.shopName }}
                  </li>
                </el-dropdown>
              </ul>

            </div>
          </div>
          <!--        猜你喜欢-->
          <div class="guess" style="margin-top: 20px">
            <span class="text" style="font-size: 30px; color: rgba(239,49,128,0.78); font-weight: bold;">猜你喜欢</span>
          </div>
          <div class="guessLike " style="width: 1200px; margin-top: 15px ">
            <el-row style="width: 100%; display: flex; justify-content: space-between;">
              <el-col :span="6" v-for="(guessimage, index) in guessLikeInfo" :key="index" style="margin-inline: 10px;">
                <el-card class="card">
                  <img :src="guessimage.psrc" class="shopimage"/>
                  <div class="card-content">
                    <span class="shop-name">{{ guessimage.shopName }}</span>
                    <el-button type="text" class="button" @click="enterShop(guessimage.shopID)">进店看看</el-button>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </div>
          <!--        菜单-->
          <div class="MenuType" style="margin-top: 20px">
            <div v-for="(id, index) in navMenu" :key="id.shopTypeID" :ref="'menuItemSection_' + id.shopTypeID">
              <div class="menuTitle">
                <span class="text"
                      style="font-size: 30px; color: rgb(237,174,95); font-weight: bold;">{{ id.shopTypeName }}</span>
              </div>
              <div class="card-container" style="margin-top: 15px">
                <el-row :gutter="20" style="width: 100%">
                  <el-col :span="6" v-for="(shopimage, index) in shopInfo" :key="index">
                    <el-card class="card" v-if="shopimage.psrc !== '' && shopimage.shopTypeID === id.shopTypeID">
                      <img :src="shopimage.psrc" class="shopimage"/>
                      <div class="card-content">
                        <span class="shop-name">{{ shopimage.shopName }}</span>
                        <el-button type="text" class="button" @click="enterShop(shopimage.shopID)">进店看看</el-button>
                      </div>
                    </el-card>
                  </el-col>
                </el-row>
              </div>
            </div>
          </div>

        </div>

      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {},
      messageCount: 0, //消息条数
      imgUrls: [],
      navMenu: [],
      shopInfo: [],
      guessLikeInfo: [],
      headerColor: 'rgba(66,56,59,0.62)', // 初始颜色
      showEditDialog: false,
      searchKeyword: '',
      shopName: '',
      filteredShopNames: [],
      isHovered:''
    };
  },
  computed: {
    filteredShops() {
      const searchKeyword = this.shopName.toLowerCase();
      return this.shopInfo.filter(shop => shop.shopName.toLowerCase().includes(searchKeyword));
    },
  },
  created() {
    window.addEventListener('scroll', this.handleScroll);
    this.loadMenuItem();
    this.loadshopItem();
    this.loadBanner();
    this.loadguessLikeInfo();
    this.loadMessageCount();
    // this.$forceUpdate();
  },
  // mounted() {
  //   window.addEventListener('scroll', this.handleScroll);
  //   this.loadMenuItem();
  //   this.loadshopItem();
  //   this.loadBanner();
  //   this.loadguessLikeInfo();
  // },

  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    //跳转到指定的店铺类别目录下
    scrollToCategory(index) {
      const sectionRef = this.$refs['menuItemSection_' + index];
      if (sectionRef && sectionRef.length > 0) {
        const element = sectionRef[0];
        const offsetTop = element.offsetTop;
        window.scrollTo({
          top: offsetTop,
          behavior: 'smooth'
        });
      }
    },
    scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    },
    handleScroll() {
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
      if (scrollTop > 0) {
        this.headerColor = 'rgba(255,255,255,0.1)'; // 如果滚动条不在顶部，降低不透明度
      } else {
        this.headerColor = 'rgba(66,56,59,0.62)'; // 如果滚动条在顶部，恢复原来的颜色
      }
    },
   loadMenuItem(){
      this.request.get('/shopType/search').then(res => {
        this.navMenu = res;
      })
    },
    loadBanner() {
      this.request.get('/file/banner').then(res => {
        for (let i = 0; i < res.length; i++) {
          this.imgUrls[i] = res[i].psrc;
        }
        // console.log(res);
        // console.log(this.imgUrls)
      })
    },
    //加载商家收到的新的消息
    loadMessageCount(){
     this.request.get("/message/getUserMsg",{
       params:{
         userID:this.user.userID
      }
     }).then(res => {
       console.log(res)
      this.messageCount = res.newMsgNum;
     })
    },
    collapse() { //点击收缩f按钮触发
      this.isCollapse = !this.isCollapse
      if (this.isCollapse) { //收缩
        this.sideWidth = 64
        this.collapseBtnClass = 'el-icon-s-unfold'
        this.logoTextShow = false
      } else {//展开
        this.sideWidth = 200
        this.collapseBtnClass = 'el-icon-s-fold'
        this.logoTextShow = true
      }
    },
    loadshopItem() {
      this.request.get('/shop').then(res => {
        this.shopInfo = res;
      })
    },
    loadguessLikeInfo() {
      this.request.get('shop/guess', {
        params: {
          userID: this.user.userID
        }
      }).then(res => {
        // console.log(res);
        this.guessLikeInfo = res;
      })
    },

    enterShop(shopID) {
      const selectedShop = this.shopInfo.find(shop => shop.shopID === shopID);
      // 将店铺信息存储到本地存储中
      localStorage.setItem('shop', JSON.stringify(selectedShop));
      // 跳转到店铺详情页
      this.$router.push('/shopIndex');
    },
  },

}
</script>
<style scoped>
.card {
  flex: 1;
  margin-bottom: 20px;
  transition: box-shadow 0.3s; /* 添加阴影的过渡效果 */
}

.card:hover {
  box-shadow: 0 4px 8px rgb(13, 35, 68); /* 鼠标悬停时的阴影效果 */
  transform: scale(1.05); /* 鼠标悬停时的略微放大效果 */
}

.body {
  position: relative;
}

.body::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(42, 189, 155, 0.1); /* 透明度为0.5的黑色背景 */
}

.body {
  width: 100%;
  background-image: url("/managerBG.jpg");
  background-size: cover;
  background-attachment: fixed;
}

.nav {
  width: 100%;
  height: 100%;
  padding: 0px;
  background-size: 100%, 100%;
  position: relative; /* 添加相对定位 */
}

.search-box {
  position: absolute;
  top: 80px;
  right: 250px;
  margin-top: 280px;
  padding-bottom: 10px;
  background-color: rgba(255, 255, 255, 0.26);
  //box-shadow: 0 2px 25px 0 rgba(0, 0, 0, 0.1);
  width: 180px;
  height: 30px;
  border-radius: 10px;
  display: flex;
  z-index: 999;
  transition: background-color 0.4s; /* 添加背景颜色的过渡效果 */
}
.search-box.hovered {
  background-color: #fff;
}


.search-txt {
  border: none;
  background: none;
  outline: none;
  padding: 0;
  color: #222;
  font-size: 14px;
  line-height: 35px;
  width: 0;
  margin-top: 5px;
  transition: 0.4s;
  z-index: 998;
}

.search-btn {
  color: #000000;
  font-size: 18px;
  width: 30px;
  height: 30px;
  border-radius: 100%;
  margin-left: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: 0.4s;
  z-index: 998;
}

.search-box:hover .search-txt {
  width: 180px;
  padding: 0 12px;
}

.search-box:hover .search-btn {
  background-color: #fff;
  animation: rotate 0.4s linear;
}

.search-txt:focus {
  width: 180px;
  padding: 0 12px;
}

.search-txt:focus + .search-line {
  width: 180px;
}

/*搜索框下方*/
.search-results {
  position: absolute;
  top: 100%; /* 将结果放置在搜索框下方 */
  left: 0;
  width: 100%;
  list-style: none;
  padding: 5px;
  margin-top: -15px;
  background-color: rgba(255, 255,255, 1);
  z-index: 997;
  border-radius: 10px;
}

.search-results li {
  padding: 8px;
  width: 100%;
  cursor: pointer;
}


.el-header {
  width: 100%;
  height: 100%;
  padding: 0px;
  background-size: 100%, 100%;
  position: fixed; /* 添加相对定位 */
  z-index: 1000;
}

.el-menu-item:hover {
  background-color: rgba(159, 142, 142, 0.50) !important;
}

.logo-image {
  background-image: url("/logo_4.png");
  position: absolute; /* 设置绝对定位 */
  top: -8px; /* 图片顶部与父元素顶部对齐 */
  left: -3px; /* 图片左侧与父元素左侧对齐 */
  width: 85px; /* 调整图片宽度 */
  height: auto; /* 调整图片高度 */
}

.right-menu {
  float: right;
  height: 60px;
  width: 100px;
}

.el-dropdown, .el-dropdown-menu {
  /* 隐藏下拉菜单的箭头 */
  /* 注意：替换下面的伪元素选择器和属性名以匹配实际使用的样式 */

  ::before,
  ::after {
    display: none;
  }
}

.fatherBlockGuess {
  display: flex;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
  flex-direction: column; /* 垂直布局 */
}

.block {
  display: flex;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
}

.image {
  width: 100%; /* 或者指定一个固定的宽度 */
  height: 100%; /* 或者指定一个固定的高度 */
  object-fit: cover;
}

.el-carousel {
  width: 1200px; /* 设置为所需的宽度 */
}

.guess {
  display: flex;
  justify-content: center; /* 水平居中 */
  width: 1200px; /* 设置为所需的宽度 */
  background-color: rgba(38, 123, 144, 1);
}

.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 450px;
  margin: 5px;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.guessLike {
  width: 1200px;
  display: flex;
  justify-content: center; /* 水平居中 */
}

.MenuType {
  width: 1200px;
  display: flex;
  justify-content: center; /* 水平居中 */
  flex-direction: column
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

.el-col {
  height: auto; /* 这将使el-col的高度自适应内容 */
}

.el-card {
  flex: 1; /* 让 el-card 等分父容器的宽度 */
  margin-bottom: 20px; /* 添加间距，使卡片之间有一定的间隔 */
}

.card-container {
  display: flex;
  justify-content: space-between;
}

.guessLike .card,
.MenuType .card {
  height: 100%;
}

.guessLike .shopimage,
.MenuType .shopimage {
  width: 100%;
  height: 180px; /* 调整图片高度 */
  object-fit: cover;
}

.guessLike .card-content,
.MenuType .card-content {
  padding: 14px;
}

.guessLike .shop-name,
.MenuType .shop-name {
  font-size: 16px;
  font-weight: bold;
  display: block;
  margin-bottom: 10px;
}

.guessLike .button,
.MenuType .button {
  float: right;
}

.menuTitle {
  text-align: center;
  background-color: rgba(194, 28, 67, 1); /* Change color and opacity as needed */
  padding: 10px; /* Add padding for better visual appearance */
  margin-top: 10px; /* Add margin for spacing */
}

.text {
  font-size: 30px;
  color: rgb(237, 174, 95);
  font-weight: bold;
}
.el-dropdown-item  .el-badge {
  margin-right: 10px; /* 根据需要调整 el-badge 与链接之间的间距 */
}
</style>