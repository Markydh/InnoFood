<script>
export default {
  name: "orderState2",
  data() {
    return {
      userData: JSON.parse(localStorage.getItem('user')) || {},
      tableData: [],
      detailData: [],
      pageNum: 1,
      pageSize: 5,
      totalNum: 0,
      dialogVisible: false,
      dialogConfirmArrive: false,
      orderID: 0,
    }
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.request.get('/order/page', {
        params: {
          pageSize: this.pageSize,
          pageNum: this.pageNum,
          userID: this.userData.userID,
          orderState: 2
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data;
        this.totalNum = res.totalNum;
      })
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val; // 更新 pageSize
      this.pageNum = 1; // 重置 pageNum
      this.load();
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.pageNum = val;
      this.load();
    },
    findDetail(id) {
      console.log(id)
      this.loadDetail(id);
      this.dialogVisible = true;
    },
    loadDetail(id) {
      console.log(id)
      this.request.get(`/order/detail?orderID=${id}`).then(res => {
        this.detailData = res;
      });
    },

    handleRowClick(row) {
      this.orderID = row.orderID;
    },

    queding() {
      this.dialogVisible = false;
    },

    confirmWin() {
      this.dialogConfirmArrive = true;
    },

    confirmArrive() {
      this.handleArrived(this.orderID);
      this.dialogConfirmArrive = false;
    },
    handleArrived(id) {
      this.request.post(`/order/arrived?orderID=${id}`).then(res => {
        if (res) {
          this.$message.success("保存成功")
          this.dialogConfirmArrive = false;
          this.load();
        } else {
          this.$message.error("保存失败")
          this.dialogConfirmArrive = false;
        }
      })
    }

  },
}
</script>

<template>
  <div class="content">

    <el-table :data="tableData" @row-click="handleRowClick">
      <el-table-column prop="orderID" label="订单编号" :width="90"></el-table-column>
      <el-table-column prop="deliveryID" label="配送员ID" :width="80"></el-table-column>
      <el-table-column prop="total_price" label="订单总金额" :width="100"></el-table-column>
      <el-table-column prop="order_time" label="店铺接单时间"></el-table-column>
      <el-table-column prop="pick_time" label="配送员接单时间"></el-table-column>

      <el-table-column prop="order_state" label="订单状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.order_state === 2" type="warning">骑手已接单</el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <div class="button-container">
            <el-button type="primary" @click="findDetail(scope.row.orderID)">查看详情</el-button>
            <el-button type="success" @click="confirmWin">确认送达</el-button>
          </div>
        </template>
      </el-table-column>

    </el-table>

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

    <div v-if="dialogVisible">
      <el-dialog title="订单详情" :visible.sync="dialogVisible" width="60%">
        <span>
          <el-table :data="detailData">
            <el-table-column prop="orderID" label="订单id"></el-table-column>
            <el-table-column prop="productname" label="菜品"></el-table-column>
            <el-table-column prop="quantity" label="数量"></el-table-column>
            <el-table-column prop="price" label="价格"></el-table-column>
          </el-table>
        </span>
        <span slot="footer" class="dialog-footer">
          <el-button type="primary" @click="queding">确 定</el-button>
        </span>
      </el-dialog>
    </div>

    <div v-if="dialogConfirmArrive">
      <el-dialog
          title="提示"
          :visible.sync="dialogConfirmArrive"
          width="30%"
          center>
        <span>确认送达吗</span>
        <span slot="footer" class="dialog-footer">
    <el-button @click="dialogConfirmArrive = false">取 消</el-button>
    <el-button type="primary" @click="confirmArrive">确 定</el-button>
  </span>
      </el-dialog>
    </div>


  </div>
</template>

<style scoped>
.content {
  padding: 20px;
}

.dialog-footer {
  justify-content: flex-end;
}

.button-container {
  display: flex;
  gap: 5px;
  align-items: center;
}

.button-container .el-button {
  width: 100px; /* 根据实际情况调整按钮宽度 */
}
</style>