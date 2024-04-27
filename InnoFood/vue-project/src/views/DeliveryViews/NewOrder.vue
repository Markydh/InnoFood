<template>
  <div>
    <el-table
        :data="deliveryPickOrder"
        border
        :row-style="{height: '65px'}"
    >
      <el-table-column prop="orderID" label="订单编号" width="150"></el-table-column>

      <el-table-column label="客户基本信息" align="center" width="300px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showUserInfoDetails(scope.row)" style="background-color: #e75bb3;border: none;color: #FFFFFF">查看客户</el-button>
        </template>
      </el-table-column>
      <el-table-column label="店铺基本信息" align="center" width="300px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showShopInfoDetails(scope.row)" style="background-color: #2189c0;border: none;color: #FFFFFF">店铺客户</el-button>
        </template>
      </el-table-column>
      <el-table-column label="路线规划" align="center" width="300px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="watchRoad(scope.row)" style="background-color: #2189c0;border: none;color: #FFFFFF">查看路线</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="order_time" label="商家接单时间"  align="center"></el-table-column>
      <el-table-column  label="操作" align="center" width="200px">
        <template slot-scope="scope">
          <el-button @click="pickOrder(scope.row.orderID)" style="background-color: #1d4ae8;border: none;color: #FFFFFF">接单<i class="el-icon-eleme"></i></el-button>
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


<!--     路线查看-->
    <el-dialog :visible.sync="RoadInfoVisible"  v-if="RoadInfoVisible" width="1200px" height="100px" style="margin-top:-100px;margin-bottom: 100px">
      <RoadInfo/>
    </el-dialog>

<!--    店铺基本信息查询-->
    <el-dialog :visible.sync="ShopInfoVisible"  width="700px">
        <el-descriptions title="店铺基本信息" :column="1" border>
          <el-descriptions-item label="店铺名" label-class-name="my-label" content-class-name="my-content">{{shopInfo.shopName}}</el-descriptions-item>
          <el-descriptions-item label="店铺地址" :contentStyle="{'text-align': 'left'}">{{shopInfo.address}}</el-descriptions-item>
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
import RoadInfo from "@/components/RoadInfo.vue";

export default {
  name: "NewOrder",
  components: {RoadInfo},
  data() {
    return {
      address:{},
      UserInfoVisible:false, //用户信息是否可见变量
      ShopInfoVisible:false, //店铺信息是否可见变量
      RoadInfoVisible:false,//路线规划信息是否可见变量
      userInfo: {}, //用户信息列表
      shopInfo: {}, //店铺信息列表
      pageNum: 1,
      pageSize: 5,
      deliveryPickOrder: [],  //等待骑手接单的订单
      totalNum: 0,
      searchTime:"",
      deliveryData:localStorage.getItem('delivery')?JSON.parse(localStorage.getItem('delivery')):{},
    }
  },
  created() {
    this.load()
  },
  methods: {
    //请求分页查询数据
    load() {
      this.request.get("/order/deliveryToPickOrder/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        console.log(res)
        this.deliveryPickOrder = res.data
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
    //接单操作
    pickOrder(id){
      this.$confirm('是否接单?', '提示', {
        confirmButtonText: '接单',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-eleme",
        center: true
      }).then(() => {
        // 向后端发送请求，更新订单状态为2
        var deliveryID=this.deliveryData.deliveryID;
        this.request.post(`/order/deliveryPickOrder?orderID=${id}&deliveryID=${deliveryID}`).then(res => {
          if (res) {
            this.$message({
              type: 'success',
              message: '接单成功!'
            });
            // 接单成功后重新加载订单数据
            this.load();
          } else {
            this.$message({
              type: 'error',
              message: '接单失败，请稍后重试!'
            });
          }
        });
      });
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
        this.userAddress=res.address;
      })
      this.UserInfoVisible=true;
    },
    //商家信息显示
    showShopInfoDetails(row){
      this.request.get("/shop/findShopByShopID",{
        params:{
          shopID:row.shopID
        }
      }).then(res =>{
        console.log(res)
        this.shopInfo=res;
        this.shopAddress=res.address;
      })
      this.ShopInfoVisible=true;
    },
    watchRoad(row){
      this.address.userAddress=row.userAddress;
      this.address.shopAddress=row.shopAddress;
      console.log( this.address);
      localStorage.setItem("address",JSON.stringify(this.address));
      this.RoadInfoVisible=true;
    }
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
