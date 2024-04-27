<template>
<div style="height: 100%;text-align: center">
  <div class="search-box">
    <el-button class="search-btn" type="text" @click="load">
      <i class="el-icon-search" aria-hidden="true"></i>
    </el-button>
    <input type="text" class="search-txt" placeholder="请输入店铺名"  v-model="shopName" />
    <div class="search-line"></div>
  </div>


  <div class="block">
    <el-carousel height="500px" style="margin-right:20px;width: 1400px;">
      <el-carousel-item v-for="(item, index) in imgUrls" :key="index">
        <img class="image" :src="item" :alt="index + 1"/>
      </el-carousel-item>
    </el-carousel>
    <!-- 搜索框 -->
  </div>

  <h1 style="margin-top: 30px; display: inline-block;">我的店铺</h1>
  <el-row style="margin-left: 60px">
    <el-col :span="8" v-for="shop in shops" :key="shop.shopID">
      <el-card
          :body-style="{ padding: '0px' }"
          style="width: 400px; height: 200px;margin-top:20px;margin-bottom: 20px;border-radius: 15px;overflow: hidden;"
          shadow="hover"
          @click.native="handleCardClick(shop)"
      >
        <div class="card-container">
          <div class="content-container">
            <div class="image-container">
              <img :src="shop.psrc" class="rounded-image" alt="Shop Image">
            </div>
            <div class="text-container">
              <span class="shop-name">{{ shop.shopName }}</span>
              <span class="shop-address">{{ shop.address }}</span>
            </div>
          </div>
        </div>
      </el-card>
    </el-col>
  </el-row>
</div>
</template>


<script>
export default {
  name: "MyShop",
  data(){
    return{
      imgUrls:[], //广告拦
      shops:[],
      shopName:"",
      managerData:localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{}
    }
  },
  created() {
    this.load();
    this.loadBanner();
  },
  methods:{
    load() {
      // 使用axios调用后端接口，假设接口返回的数据是一个包含店铺信息的数组
      this.request.get('/shop/search',{
        params:{
          shopName:this.shopName,
          managerID:this.managerData.managerID
        }
      }).then(res =>{
        console.log(res)
        this.shops=res
      });
    },
    loadBanner() {
      this.request.get('/file/banner').then(res => {
        for (let i = 0; i < res.length; i++) {
          this.imgUrls[i] = res[i].psrc;
        }
      })
    },
    handleCardClick(shop){
      localStorage.setItem('shop',JSON.stringify(shop))
      this.$router.push('/shopIndex')
    }
  }
}
</script>



<style scoped>
.search-line {
  position: absolute;
  left: 62px;
  bottom: 10px;
  width: 0px;
  height: 2px;
  background-color: rgb(251, 121, 0);
  transition: 0.3s;
}
.search-box {
  position: absolute;
  top: 10px;
  margin-top: 10px;
  padding-bottom: 10px;
  background-color: white;
  box-shadow: 0 2px 25px 0 rgba(0, 0, 0, 0.1);
  width: 300px;
  height: 40px;
  border-radius: 40px;
  display: flex;
  z-index:999;
}
.search-txt {
  border: none;
  background: none;
  outline: none;
  padding: 0;
  color: #222;
  font-size: 14px;
  line-height: 40px;
  width: 0;
  transition: 0.4s;
}
.search-btn {
  color: #888888;
  font-size: 24px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: 0.4s;
}
.search-btn:hover{
  color: #e319d2;
}
.search-box:hover .search-txt {
  width: 200px;
  padding: 0 12px;
}
.search-box:hover .search-btn {
  background-color: #fff;
  animation: rotate 0.4s linear;
}
.search-txt:focus {
  width: 200px;
  padding: 0 12px;
}

.search-txt:focus + .search-line {
  width: 200px;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}



.el-carousel__item h3 {
  color: #475669;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
.card-container {
  margin-top: 17px;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.el-card {
  transition: transform 0.3s ease; /* 使用 transform 属性，以 0.3 秒的时间和 ease 缓动函数进行过渡 */
}
.el-card:hover {
  transform: scale(1.05); /* 通过调整缩放比例来改变弹动效果的强度 */
}

.content-container {
  display: flex;
}

.image-container {
  flex: 0 0 auto; /* 图片容器固定大小，不伸缩 */
  padding: 14px;
}


.rounded-image {
  width: 140px; /* 调整图片大小 */
  height: 140px;
  object-fit: contain;
  border-radius: 13%; /* 圆角半径，使其为圆形 */
}

.text-container {
  flex: 1; /* 文本容器伸缩，占据剩余空间 */
  padding: 14px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.shop-name {
  font-size: larger;
  font-weight: bold;
}

.shop-address {
  margin-top: 20px; /* 间距 */
  opacity: 0.7; /* 透明度 */
}

.block {
  display: flex;
  padding-top:60px;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
}

.image {
  width: 100%; /* 或者指定一个固定的宽度 */
  height: 100%; /* 或者指定一个固定的高度 */
  object-fit: cover;
}

</style>