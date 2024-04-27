<template>
  <div  class="admin-container">
    <div class="mg-10">
      <el-input  class="ml-5" style="width: 400px" placeholder="请输入用户名" suffix-icon="el-icon-search" v-model="username"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="info"  @click="reset">重置</el-button>
    </div>
    <div class="mg-10">
      <el-button type="primary" @click="handleAdd">新增<i class="el-icon-circle-plus-outline" ></i></el-button>
    </div>
    <el-table :data="tableData">
      <el-table-column prop="adminID" label="ID" width="100px"></el-table-column>
      <el-table-column prop="username" label="用户名" width="200px"></el-table-column>
      <el-table-column prop="password" label="密码" width="200px"></el-table-column>

      <el-table-column  label="操作">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)">编辑<i class="el-icon-edit"></i></el-button>
          <el-button type="danger" @click="handleDelete(scope.row.adminID)">删除<i class="el-icon-remove-outline"></i></el-button>
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

    <el-dialog title="用户信息 " :visible.sync="dialogFormVisible">
      <el-form label-width="80px" style="padding-left: 170px">
        <el-form-item label="用户名:">
          <el-input v-model="form.username" autocomplete="off" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="密码:">
          <el-input v-model="form.password" show-password autocomplete="off" style="width: 250px"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
export default {
  name: "ZhAdmin",
  data() {
    return {
      pageNum: 1,
      pageSize: 2,
      username: "",
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
    },
    //请求分页查询数据
    load() {
      this.request.get("/admin/page", {
        params: {
          pageNum: parseInt(this.pageNum),
          pageSize: parseInt(this.pageSize),
          username: this.username,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data
        this.totalNum = res.totalNum
        console.log(this.tableData)
        console.log("字段名列表:", Object.keys(this.tableData[0] || {}))
      })
    },
    //触发选框事件获取当前页面大小
    handleSizeChange(currentSize) {
      // console.log(currentSize)
      this.pageSize = currentSize
      this.load()
    },
    //触发选框事件获取当前页面页码
    handleCurrentChange(currentNum) {
      // console.log(currentNum)
      this.pageNum = currentNum
      this.load()
    },
    //重置信息
    reset() {
      this.username = ""
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
        this.request.delete("/admin/" + id).then(res => {
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
      this.request.post("/admin", this.form).then(res => {
        console.log('Save response:', res);
        if (res) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false;
          this.load()
        } else {
          this.$message.success("保存失败")
          this.dialogFormVisible = false;
          this.load()
        }
      }).catch(error => {
        console.error('Save request failed', error);
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