<template>
  <div>
    <span class="demonstration"></span>
    <el-date-picker
        v-model="searchTime"
        type="datetime"
        placeholder="选择日期时间"
        align="right"
        :picker-options="pickerOptions">
    </el-date-picker>
    <el-table
        :data="newOrder"
        border
        :row-style="{height: '65px'}"
    >
      <el-table-column prop="orderID" label="订单编号" width="150"></el-table-column>
      <el-table-column prop="username" label="客户名" width="240"></el-table-column>
      <el-table-column label="订单详情" align="center" width="400px">
        <template slot-scope="scope">
          <!-- 在每一行的按钮上绑定点击事件 -->
          <el-button  @click="showOrderDetails(scope.row)" style="background-color: #ef6417;border: none;color: #FFFFFF">查看订单</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="create_time" label="创建时间"  align="center"></el-table-column>
      <el-table-column  label="操作" align="center" width="200px">
        <template slot-scope="scope">
          <el-button @click="pickOrder(scope.row.orderID)" style="background-color: #1d4ae8;border: none;color: #FFFFFF">接单<i class="el-icon-eleme"></i></el-button>
        </template>
      </el-table-column>
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
  name: "NewOrder",
  data() {
    return {
      pickerOptions: {
        shortcuts: [{
          text: '今天',
          onClick(picker) {
            picker.$emit('pick', new Date());
          }
        }, {
          text: '昨天',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24);
            picker.$emit('pick', date);
          }
        }, {
          text: '一周前',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
            picker.$emit('pick', date);
          }
        }]
      },
      dialogVisible:false, //订单明细表是否可见变量
      orderDetails: [], //订单明细列表
      pageNum: 1,
      pageSize: 5,
      newOrder: [],
      totalNum: 0,
      searchTime:"",
      shopData: localStorage.getItem("shop") ? JSON.parse(localStorage.getItem("shop")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    //请求分页查询数据
    load() {
      this.request.get("/order/newOrder/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          shopID: Number(this.shopData.shopID)
        }
      }).then(res => {
        console.log("totalNum",res)
        this.newOrder = res.data
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
        // 向后端发送请求，更新订单状态为1 并且发送信息给用户和骑手
        this.request.post(`/order/shopPickOrder?orderID=${id}`).then(res => {
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