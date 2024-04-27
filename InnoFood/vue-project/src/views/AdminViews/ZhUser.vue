<template>
  <div class="body">
    <el-tabs>
      <el-tab-pane label="用户">
      <div class="Zh-User">
      <div class="mg-10">
        <el-input  class="ml-5" style="width: 300px" placeholder="请输入用户名" suffix-icon="el-icon-search" v-model="username"></el-input>
        <el-input  class="ml-5" style="width: 300px" placeholder="请输入邮箱" suffix-icon="el-icon-search" v-model="email"></el-input>
        <el-input  class="ml-5" style="width: 300px" placeholder="请输入地址" suffix-icon="el-icon-search" v-model="address"></el-input>
        <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
        <el-button type="info"  @click="reset">重置</el-button>
      </div>
      <el-table :data="tableData">
        <el-table-column prop="userID" label="ID" width="60"></el-table-column>
        <el-table-column prop="username" label="用户名" width="100"></el-table-column>
        <el-table-column prop="nickname" label="昵称" width="100"></el-table-column>
        <el-table-column prop="email" label="邮箱"></el-table-column>
        <el-table-column prop="phone" label="电话"></el-table-column>
        <el-table-column prop="address" label="地址" width="200"></el-table-column>
        <el-table-column prop="score" label="积分" width="100"></el-table-column>
        <el-table-column prop="createDate" label="账号创建时间" ></el-table-column>
        <el-table-column  label="操作">
        <template slot-scope="scope">
          <el-button type="danger" @click="handleDelete(scope.row.userID)">删除<i class="el-icon-remove-outline"></i></el-button>
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
    </el-tab-pane>
<!--      商家按用户名、邮箱、电话搜索-->
<!--表格显示ID、用户名、昵称、邮箱、电话-->
      <el-tab-pane label="商家">
        <div class="Zh-Manager">
          <ZhManager/>
        </div>
      </el-tab-pane>
<!--      骑手按用户名、电话、邮箱、评分搜索-->
<!--      表格显示ID、用户名、电话、邮箱、评分-->
      <el-tab-pane label="骑手">
        <div class="Zh-Delivery">
          <ZhDelivery/>
        </div>
      </el-tab-pane>
<!--      管理员按用户名搜索-->
<!--      表格显示ID、用户名、密码-->
      <el-tab-pane label="管理员">
        <div class="Zh-Admin">
          <ZhAdmin/>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ZhManager from "@/views/AdminViews/ZhManager.vue";
import ZhDelivery from "@/views/AdminViews/ZhDelivery.vue";
import ZhAdmin from "@/views/AdminViews/ZhAdmin.vue";

export default {
  name: "User",
  components: {ZhAdmin, ZhDelivery, ZhManager},
  data() {
    return {
      pageNum: 1,
      pageSize: 2,
      username: "",
      email: "",
      address: "",
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
    //请求分页查询数据
    load() {
      this.request.get("/user/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          email: this.email,
          address: this.address
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
      this.email = ""
      this.address = ""
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
    handleDelete(id) {
      this.$confirm('是否删除此信息?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-info",
        center: true
      }).then(() => {
        this.request.delete("/user/" + id).then(res => {
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
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false;
          this.load()
        } else {
          this.$message.success("保存失败")
          this.dialogFormVisible = false;
          this.load()
        }
      })
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
.mg-10 {
  margin-bottom: 10px;
}

.el-tabs {
  margin-bottom: 20px;
}

.el-table {
  width: 100%; /* 调整表格宽度 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 添加投影效果 */
}

.el-table th, .el-table td {
  text-align: center;
}
/* 操作按钮样式 */
.el-table-column--operating {
  text-align: center;
}

.dialog-footer {
  text-align: center;
}
</style>