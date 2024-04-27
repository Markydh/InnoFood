<template>
  <div class="InnoFood-system">
    <el-container>
      <el-header>
        <!-- 在el-header中渲染店铺logo和菜品类别 -->
        <div class="header-content">
          <img :src="shopData.psrc" alt="店铺Logo" class="shop-logo" />
          <div
              v-for="category in categorys"
              :key="category.categoryID"
              class="category-link"
              @click="scrollToCategory(category.categoryID)"
          >
            {{ category.categoryname }}
          </div>
          <div class="header-buttons">
            <el-button @click="backToUserHome" circle style="font-size: large;margin-right: 20px;border: none"><i class="el-icon-arrow-right"></i></el-button>
          </div>
        </div>
      </el-header>

      <el-main ref="mainContainer">



        <div class="block">
          <el-carousel height="500px" style="margin-top: -14px;width: 1400px" arrow="never">
            <el-carousel-item v-for="(item, index) in imgUrls" :key="index">
              <img class="image" :src="item" :alt="index + 1"/>
            </el-carousel-item>
          </el-carousel>
          <!-- 搜索框 -->
          <div class="search-box" :class="{ 'hovered': productname || isHovered }" @mouseover="isHovered = true" @mouseleave="isHovered = false">
            <el-button class="search-btn" type="text">
              <i class="el-icon-search" aria-hidden="true"></i>
            </el-button>
            <input type="text" class="search-txt" placeholder="请输入菜品名" v-model="productname"/>
            <div class="search-line"></div>
            <!-- 在搜索框下方显示已过滤的店铺名称 -->
            <ul v-if="filteredProducts.length > 0 && productname !== ''" class="search-results">
              <el-dropdown style="margin-left: -12px;margin-top:10px;width: 100%">
              <li v-for="product in filteredProducts" :key="product.productID" @click="navigateToProductCard(product)">
                {{ product.productname }}
              </li>
              </el-dropdown>
            </ul>
          </div>
        </div>

          <!-- 在el-main中渲染根据不同类别展示的菜品 -->
            <div
                v-for="category in categorys"
                :key="category.categoryID"
                :ref="`categorySection_${category.categoryID}`"
            >
              <h2 class="category-title">{{ category.categoryname }}</h2>
              <!-- 使用el-card展示菜品 -->
              <div class="menu-item-container" style="display: flex; justify-content: center; align-items: center;">
                      <el-card
                          v-for="menuItem in category.menuItems"
                          :key="menuItem.productID"
                          @click.native="showPurchaseDialog(menuItem)"
                          :body-style="{ padding: '0px' }"
                          style="width: 250px; height: auto;margin-top:20px;margin-bottom: 20px;border-radius: 15px;overflow: hidden;margin-right: 20px"
                          shadow="hover"
                          :data-product-id="menuItem.productID"
                      >
                        <img :src="menuItem.psrc" class="image">
                        <div style="padding: 14px; line-height:2;" >
                            <span class="product-name">{{ menuItem.productname }}</span><br>
                          <Myh>销量:</Myh> <span class="product-sales">{{ menuItem.sales }}</span><br>
                          <Myh>价格:</Myh> <span class="product-price">{{ menuItem.price }}</span><br>
                          <Myh>商品描述:<br></Myh><span class="product-description">{{ menuItem.description }}</span><br>
                        </div>
                      </el-card>
              </div>
        </div>

        <el-dialog
            title="加入购物车"
            :visible.sync="dialogVisible"
            width="30%"
            center
            @close.native="handleClose"
        >
          <el-form :model="formData" ref="purchaseForm" :rules="rules" label-width="80px">
            <el-form-item label="菜品图片" prop="psrc">
              <img v-if="selectedProduct.psrc" :src="selectedProduct.psrc" class="avatar" style="width: 120px; height: 120px">
            </el-form-item>
            <el-form-item label="菜品名称">
              <span>{{ selectedProduct.productname }}</span>
            </el-form-item>
            <el-form-item label="单价">
              <span>{{ selectedProduct.price }}</span>
            </el-form-item>
            <el-form-item label="购买数量:">
              <el-input-number v-model="formData.quantity" controls-position="right" :min="1" style="width: 150px"></el-input-number>
            </el-form-item>
            <!-- 其他表单项，根据需求添加 -->
            <el-form-item>
              <el-button type="primary" @click="addToCart">加入购物车</el-button>
            </el-form-item>
          </el-form>
        </el-dialog>
      </el-main>
      <!-- 购物车部分 -->
      <div v-if="isCartNotEmpty" class="shopping-cart">
        <el-collapse :model.sync="shoppingCartVisible">
          <el-collapse-item  name="1">
            <!-- 手风琴头部样式修改-->
            <template slot="title">
              <el-badge :value="cart.length" class="shopping-cart-badge">
              <i class="el-icon-shopping-cart-1" style="font-size: 50px;color: black;padding-left: 40px;padding-top: 5px"></i>
              </el-badge>
            </template>

            <!-- 商品信息 -->
            <el-row v-for="(item, index) in cart" :key="index" style="display: flex;align-items: center;">
              <el-col :span="6" style="padding-left: 40px"><img :src="item.psrc" class="avatar" style="width: 80px; height: 80px"></el-col>
              <el-col :span="6">{{ item.productname }}</el-col>
              <el-col :span="3">{{item.price}}</el-col>
              <el-col :span="3" >{{ item.quantity }}</el-col>
              <el-col :span="3">
                <!-- 加减符号和删除功能 -->
                <el-button @click="decreaseQuantity(index)">-</el-button>
                <el-button @click="increaseQuantity(index)">+</el-button>
                <el-button type="danger" @click="removeItem(index)">删除</el-button>
              </el-col>
            </el-row>

            <!-- 结算订单 含总计 -->
            <el-row style="display: flex;align-items: center;text-align:center;">
              <el-col :span="18" style="text-align: right; padding-left: 770px;">
                <strong>总计：</strong>
              </el-col>
              <el-col :span="12" style="padding-left: 110px">
                <span>{{ totalPrice }}</span>
              </el-col>
              <el-col :span="24" style="text-align: right; padding-right: 265px; margin-top: 20px;">
                <el-button type="primary" @click="checkout">结算订单</el-button>
              </el-col>
            </el-row>
          </el-collapse-item>
        </el-collapse>
      </div>
    </el-container>
  </div>
</template>

<script>
import Myh from "@/components/Myh.vue";

export default {
  name: "ShopIndex",
  components: {Myh},
  data() {
    return {
      shopData: localStorage.getItem("shop") ? JSON.parse(localStorage.getItem("shop")) : {},
      isHovered:'',
      productname:'',
      imgUrls:[],
      products:[],  //该店铺的所有产品
      categorys:[],   // 获取该店铺的所有菜品类别
      dialogVisible:false,// 购买表单是否显示的变量
      cart:localStorage.getItem('cart')?JSON.parse(localStorage.getItem('cart')):[],       // 购物车数组
      selectedProduct: {}, // 选中的菜品
      shoppingCartVisible: false, // 购物车折叠面板是否展开
      formData:{
        quantity: 1,
      },    // 购买表单
      rules: {
        quantity: [
          { required: true, message: '请输入购买数量', trigger: 'blur' },
          { type: 'number', message: '购买数量必须为数字值', trigger: 'blur' },
          { min: 1, message: '购买数量必须大于等于1', trigger: 'blur' },
        ],
        // 其他规则，根据需求添加
      },
    };
  },

  created() {
    this.loadCategory();
    this.loadProducts();
    this.loadBanner();
  },
  computed: {
    filteredProducts() {
      const searchKeyword = this.productname.toLowerCase();
      return this.products.filter(product => product.productname.toLowerCase().includes(searchKeyword));
    },
    // 计算 总价格
    totalPrice() {
      return this.cart.reduce((total, item) => total + item.price * item.quantity, 0).toFixed(2);
    },
    // 判断购物车内是否有菜品，若没有菜品不显示
    isCartNotEmpty() {
      return this.cart.length > 0;
    },
  },
  methods: {
    // 加载该店铺的所有菜品类别名
    loadCategory() {
      // 搜索该店铺的所有菜品类别
      this.request.get("/category/search", {
        params: {
          shopID: this.shopData.shopID,
          categoryname: ""
        }
      }).then(res => {
        // console.log(res);
        this.categorys = res.map(category => {
          return {
            ...category,
            menuItems: [] // 为菜单项初始化一个空数组
          };
        });
        // 现在，加载每个类别的菜单项
        this.loadMenuItems();
      });
    },
    loadProducts(){
      this.request.get("/product/findProductByShopID",{
        params:{
          shopID:this.shopData.shopID
        }
      }).then(res =>{
        this.products=res;
        console.log(res);
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
    // 获取每个菜品类别的所有菜品
    loadMenuItems() {
      this.categorys.forEach(category => {
        this.request.get("/product/findProductByCategoryID", {
          params: {
            shopID: this.shopData.shopID,
            categoryID: category.categoryID
          }
        }).then(menuItems => {
          // console.log(menuItems)
          // 将菜品信息添加到类别的menuItems数组中
          category.menuItems = menuItems.map(item => {
            return {
              productID: item.productID,
              productname: item.productname,
              psrc: item.psrc,
              sales: item.sales,
              price: item.price,
              description: item.description
            };
          });
        });
      });
    },

    // 新方法，用于导航到所选菜品卡片
    navigateToProductCard(product) {
      // 找到所选产品的类别 ID
      const categoryId = this.categorys.find(category =>
          category.menuItems.some(item => item.productID === product.productID)
      ).categoryID;

      // 滚动到类别部分
      this.scrollToCategory(categoryId);

      // 等待类别部分渲染完成
      this.$nextTick(() => {
        // 找到产品卡片元素并滚动到它
        const productCard = this.$refs[`categorySection_${categoryId}`][0].querySelector(`[data-product-id="${product.productID}"]`);
        if (productCard) {
          productCard.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      });
    },

    // 实现从导航条点击的菜品类别索引到内容页下的菜品类别的菜品目录下
    scrollToCategory(categoryID) {
      const sectionRef = this.$refs[`categorySection_${categoryID}`];
      if (sectionRef) {
        sectionRef[0].scrollIntoView({behavior: "smooth", block: "start"});
      }
    },
    // 显示添加该商品到购物车的表单
    showPurchaseDialog(menuItem) {
      this.dialogVisible = true;
      this.selectedProduct = menuItem;
      // console.log(this.selectedProduct)
    },
    // 更新购物车存储
    updateLocalStorage() {
      localStorage.setItem('cart', JSON.stringify(this.cart));
    },
    // 加入购物车
    addToCart() {
      this.$refs.purchaseForm.validate((valid) => {
        if (valid) {
          // 验证通过，执行加入购物车的逻辑
          const cartItem = {
            productID: this.selectedProduct.productID,
            psrc: this.selectedProduct.psrc,
            productname: this.selectedProduct.productname,
            price: this.selectedProduct.price,
            quantity: this.formData.quantity,
            // 其他属性...
          };
          this.cart.push(cartItem);
          this.selectedProduct = {}; // 清空selectedProduct所选菜品
          this.updateLocalStorage(); // 更新本地存储
          // 关闭购物车表格
          this.dialogVisible = false;
          this.formData.quantity = 1;
        }
      });
    },

    // 返回到用户主页
    backToUserHome(){
      this.$router.push("/User");
    },
    handleClose() {
      // 关闭购物车表格时重置表单数据
      this.$refs.purchaseForm.resetFields();
      this.formData.quantity = 1;
      this.dialogVisible = false;
    },
    // 在购物车中删除菜品
    decreaseQuantity(index) {
      if (this.cart[index].quantity > 1) {
        this.cart[index].quantity--;
        this.updateLocalStorage();
      }
    },
    // 在购物车中添加菜品
    increaseQuantity(index) {
      this.cart[index].quantity++;
      this.updateLocalStorage();
    },
    // 移出商品
    removeItem(index) {
      this.cart.splice(index, 1);
      if (this.cart.length === 0) this.shoppingCartVisible = false;
      this.updateLocalStorage();
    },
    //结算订单 对每个商品库存进行判断 若库存少于购买数量出现错误，若大于则更新商品的销售情况和库存情况
    checkout() {
      // 在跳转到结算页面前检查购物车商品库存
      let insufficiency = true;

      // 使用 Promise.all 来等待所有请求完成
      Promise.all(
          this.cart.map(item =>
              this.request.post(`/product/checkInventory?productID=${item.productID}&quantity=${item.quantity}`)
          )
      )
          .then(responses => {
            // responses 是一个包含所有请求结果的数组
            for (let i = 0; i < responses.length; i++) {
              const res = responses[i];

              // 库存不够
              if (res === 0) {
                // 如果购物车中有商品购买数量大于库存删除该商品
                this.removeItem(i);
                insufficiency = false;
              }
            }

            // 在这里进行判断是否需要跳转到结算页面
            if (insufficiency) {
              this.$router.push('/checkOrder');
            } else {
              // 如果库存不足，显示提示信息
              this.$message.error('库存不足，请重新选择商品。');
            }
          })
          .catch(error => {
            console.error('An error occurred during inventory check:', error);
          });
    },
  }
};
</script>

<style scoped>

.InnoFood-system {
  height: 100%;
  width: 100%;
  margin: 0 auto;
  overflow: hidden;
}

.el-container {
  height: 100%;
}

.el-header {
  background-color: white;
  color: #333;
  text-align: center;
  line-height: 60px;
  position: fixed;
  width: 100%;
  z-index: 1000;
}

.header-content {
  display: flex;
  align-items: center;
  padding: 0 10px; /* 调整这里的值来改变商品类别名之间的间距 */
}
.shop-logo {
  margin-right: 600px;
  max-width: 100px;
  max-height: 60px;
}
.header-buttons {
  position: absolute;
  top: 12px; /* 调整 top 值，使其适应你的布局需求 */
  right: 10px; /* 调整右边距 */
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.el-main {
  width: 100%;
  background-image: url("/managerBG.jpg");
  background-size: cover;
  background-attachment: fixed;
  color: #333;
  text-align: center;
  line-height: 160px;
  padding-top: 60px;
  height: 100%;
  overflow-y: auto;
}

.category-link {
  cursor: pointer;
  text-decoration: none;
  color: #333;
  margin-left: 30px;
  font-weight: bold;
}




.category-title {
  margin-bottom: 10px; /* 调整类别标题和菜品之间的间距，根据需要 */
}



.menu-item-container {
  display: flex;
  flex-wrap: wrap; /* 允许菜品在容器宽度不足时换行 */
}


.el-card {
  margin: 10px; /* 调整卡片之间的间距 */
  transition: transform 0.3s ease; /* 使用 transform 属性，以 0.3 秒的时间和 ease 缓动函数进行过渡 */
}

.el-card:hover {
  transform: scale(1.05); /* 通过调整缩放比例来改变弹动效果的强度 */
}

.image {
  width: 100%;
  display: block;
}

.product-name {
  font-size: larger;
  font-weight: bold;
}

.product-sales {
  font-size: medium;
}
.product-price {
  font-size: medium;
  font-weight: lighter;
}
.product-description{
  margin-top: 20px; /* 间距 */
  opacity: 0.7; /* 透明度 */
}

/* 购物车样式*/
.shopping-cart {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: #fff;
  padding: 10px;
  box-shadow: 0px -5px 10px rgba(0, 0, 0, 0.1);
  z-index: 999; /* 确保购物车在其他元素之上 */
}


.block {
  display: flex;
  padding-top: 50px;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
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
  line-height: 30px;
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
  width: 100%;
  cursor: pointer;
}
.search-results li:hover {
  width: 100%;
  background-color: #b49db1; /* 可选：鼠标悬停时改变背景颜色 */
}

.image {
  width: 100%; /* 或者指定一个固定的宽度 */
  height: 100%; /* 或者指定一个固定的高度 */
  object-fit: cover;
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

</style>