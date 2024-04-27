<template>
  <div>
    <div style="margin-bottom: 10px">
    <el-input  class="ml-5" style="width: 200px" placeholder="店铺名" suffix-icon="el-icon-search" v-model="shopName"></el-input>
    <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
    </div>
    <el-table
        :data="doneOrder"
        border
        :row-style="{height: '65px'}"
    >
      <el-table-column prop="orderID" label="订单编号" width="150"></el-table-column>
      <el-table-column prop="shopName" label="店铺名" width="150"></el-table-column>
      <el-table-column prop="username" label="客户名" width="240"></el-table-column>
      <el-table-column label="订单详情" align="center" width="400px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showOrderDetails(scope.row)" style="background-color: #ef6417;border: none;color: #FFFFFF">查看订单</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="create_time" label="创建时间"  align="center"></el-table-column>
      <el-table-column prop="order_time" label="接单时间"  align="center"></el-table-column>
      <el-table-column prop="order_time" label="完成时间"  align="center"></el-table-column>
    </el-table>

    <el-dialog :visible.sync="dialogVisible" title="订单详情" width="700px">
      <el-table :data="orderDetails">
        <!-- 订单明细列 -->
        <el-table-column prop="productname" label="商品名称"></el-table-column>
        <el-table-column prop="quantity" label="数量"></el-table-column>
        <el-table-column label="金额" align="right">
          <template slot-scope="scope">
            {{ (scope.row.quantity * scope.row.price).toFixed(2) }} 元
          </template>
        </el-table-column>
      </el-table>
      <template slot="footer">
        <el-row>
          <el-col :span="24" class="text-right">
            <span class="text-bold">总金额：</span>
            {{ calculateTotalAmount().toFixed(2) }} 元
          </el-col>
        </el-row>
      </template>
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
  name: "OrderInfo",
  data() {
    return {
      shopName:"",//根据搜索框的店铺搜索此店铺完成的所有订单
      dialogVisible:false,
      orderDetails:[],
      pageNum: 1,
      pageSize: 5,
      doneOrder: [],
      totalNum: 0,
      managerData: localStorage.getItem("manager") ? JSON.parse(localStorage.getItem("manager")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    //请求分页查询数据
    load() {
      this.request.get("/order/managerAllDoneOrder", {
        params: {
          pageNum:this.pageNum,
          pageSize:this.pageSize,
          managerID: this.managerData.managerID,
          shopName:this.shopName
        }
      }).then(res => {
        console.log(this.managerData.managerID);
        console.log(res);
        this.doneOrder = res.data;
        this.totalNum=res.totalNum;
        console.log(this.doneOrder)
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
    //订单详情表单显示
    showOrderDetails(row){
      this.request.get("/order/orderDetail",{
        params:{
          orderID:row.orderID
        }
      }).then(res =>{
        console.log(res)
        this.orderDetails=res;
      })
      this.dialogVisible=true;
    },
    // 订单总金额
    calculateTotalAmount() {
      return this.orderDetails.reduce((total, item) => {
        return total + item.quantity * item.price;
      }, 0);
    },
  }
}
</script>

<style scoped>

</style>