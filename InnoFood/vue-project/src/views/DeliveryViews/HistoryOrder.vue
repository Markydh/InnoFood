<template>
  <div>
    <el-table
        :data="deliveryDoneOrder"
        border
        :row-style="{height: '65px'}"
    >
      <el-table-column prop="orderID" label="订单编号" width="150"></el-table-column>

      <el-table-column label="客户基本信息" align="center" width="400px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showUserInfoDetails(scope.row)" style="background-color: #e75bb3;border: none;color: #FFFFFF">查看客户</el-button>
        </template>
      </el-table-column>
      <el-table-column label="店铺基本信息" align="center" width="400px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showShopInfoDetails(scope.row)" style="background-color: #2189c0;border: none;color: #FFFFFF">店铺客户</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="order_time" label="商家接单时间"  align="center"></el-table-column>
      <el-table-column prop="pick_time" label="配送员接单时间"  align="center"></el-table-column>
      <el-table-column label="是否送达" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.arrive_time ? '已送达' : '未送达' }}</span>
        </template>
      </el-table-column>
    </el-table>

    <!--    用户基本信息查询-->
    <el-dialog :visible.sync="UserInfoVisible" width="700px">
      <el-descriptions title="客户基本信息" :column="3" border>
        <el-descriptions-item label="客户名" label-class-name="my-label" content-class-name="my-content">{{userInfo.username}}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{userInfo.phone}}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{userInfo.email}}</el-descriptions-item>
        <el-descriptions-item label="详细地址" :contentStyle="{'text-align': 'left'}">{{userInfo.address}}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>

    <!--    店铺基本信息查询-->
    <el-dialog :visible.sync="ShopInfoVisible"  width="700px">
      <el-descriptions title="店铺基本信息" :column="1" border>
        <el-descriptions-item label="店铺名" label-class-name="my-label" content-class-name="my-content">
          <div v-if="shopInfo.shopName">{{ shopInfo.shopName }}</div>
          <div v-else>店铺已不存在</div>
        </el-descriptions-item>
        <el-descriptions-item label="店铺地址" :contentStyle="{'text-align': 'left'}">
          <div v-if="shopInfo.address">{{shopInfo.address}}</div>
          <div v-else>无法获取地址</div>
        </el-descriptions-item>
      </el-descriptions>
    </el-dialog>

    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 15]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="totalNum">
      </el-pagination>
    </div>

  </div>
</template>

<script>
export default {
  name: "HistoryOrder",
  data() {
    return {
      UserInfoVisible:false, //用户信息是否可见变量
      ShopInfoVisible:false, //店铺信息是否可见变量
      userInfo: {}, //用户信息列表
      shopInfo: {}, //店铺信息列表
      pageNum: 1,
      pageSize: 5,
      deliveryDoneOrder: [],  //等待骑手接单的订单
      totalNum: 0,
      searchTime:"",
      deliveryData: localStorage.getItem("delivery") ? JSON.parse(localStorage.getItem("delivery")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    //请求分页查询数据
    load() {
      this.request.get("/order/deliveryDoneOrder/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          deliveryID:this.deliveryData.deliveryID
        }
      }).then(res => {
        this.deliveryDoneOrder = res.data
        this.totalNum = res.totalNum
      })
    },
    //触发选框事件获取当前页面大小
    handleSizeChange(currentSize) {
      console.log(currentSize)
      this.pageSize = currentSize
      this.load()
    },
    //触发选框事件获取当前页面页码
    handleCurrentChange(currentNum) {
      console.log(currentNum)
      this.pageNum = currentNum
      this.load()
    },
    //用户信息表单显示
    showUserInfoDetails(row){
      this.request.get("/user/findUserByID",{
        params:{
          userID:row.userID
        }
      }).then(res =>{
        console.log(res)
        this.userInfo=res;
      })
      this.UserInfoVisible=true;
    },
    showShopInfoDetails(row){
      this.request.get("/shop/findShopByShopID",{
        params:{
          shopID:row.shopID
        }
      }).then(res =>{
        console.log(res)
        this.shopInfo=res;
      })
      this.ShopInfoVisible=true;
    },
  }
}
</script>

<style scoped>
.my-label {
  background: #E1F3D8;
}

.my-content {
  background: #FDE2E2;
}
</style>
