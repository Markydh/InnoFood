<template>
  <div>
    <div class="mg-10">
      <el-input  class="ml-5" style="width: 400px" placeholder="请输入用户名" suffix-icon="el-icon-search" v-model="username"></el-input>
      <el-input  class="ml-5" style="width: 400px" placeholder="请输入电话号码" suffix-icon="el-icon-search" v-model="phone"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="info"  @click="reset">重置</el-button>
    </div>
    <el-table :data="tableData">
      <el-table-column prop="deliveryID" label="ID" width="60"></el-table-column>
      <el-table-column prop="username" label="用户名" width="100"></el-table-column>
      <el-table-column prop="nickname" label="昵称" width="100"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="phone" label="电话"></el-table-column>
      <el-table-column prop="score" label="积分" width="100"></el-table-column>
      <el-table-column prop="createDate" label="账号创建时间" ></el-table-column>
      <el-table-column  label="操作">
        <template slot-scope="scope">
          <el-button type="danger" @click="handleDelete(scope.row.deliveryID)">删除<i class="el-icon-remove-outline"></i></el-button>
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
  </div>
</template>
<script>
export default {
  name: "ZhDelivery",
  data() {
    return {
      activeTab: "管理员管理",
      pageNum: 1,
      pageSize: 2,
      username: "",
      phone: "",
      tableData: [],
      totalNum: 0,
      form: {},
      dialogFormVisible: false
    }
  },
  created() {
    this.load()
  },
  methods: {
    handleTabClick(tab) {
      // 处理标签页切换
      console.log("当前标签页:", tab.label);
    },
    //请求分页查询数据
    load() {
      this.request.get("/delivery/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          phone: this.phone,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data
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
    //重置信息
    reset() {
      this.username = ""
      this.phone = ""
      this.load()
    },
    //触发添加按钮事件
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
    },
    handleDelete(id){
      this.$confirm('是否删除此信息?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-info",
        center: true
      }).then(() => {
        this.request.delete("/delivery/" + id).then(res => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          this.load();
        })
      }).catch(() => {
        // 确认按钮点击后的处理
        this.$message({
          iconClass: 'el-icon-circle-close',
          message: '取消成功!'
        });
      });
    },
    cancel() {
      this.$message.error("取消操作")
      this.dialogFormVisible = false;
      this.load()
    }
  }
}
</script>

<style scoped>
/* 添加样式以美化表格 */
.mg-10 {
  margin-bottom: 10px;
}

/* 标签页样式 */
.el-tabs {
  margin-bottom: 20px;
}

/* 表格样式 */
.el-table {
  width: 100%; /* 调整表格宽度 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 添加投影效果 */
}

/* 表格内容居中显示 */
.el-table th, .el-table td {
  text-align: center;
}

/* 操作按钮样式 */
.el-table-column--operating {
  text-align: center;
}

/* 对话框样式 */
.dialog-footer {
  text-align: center;
}
body {
  background-color: #f5f5f5;
}
</style>