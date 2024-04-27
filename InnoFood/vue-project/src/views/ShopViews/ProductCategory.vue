<template>
  <div style="height: 100%">
    <div class="header-container">
      <!-- 菜品分类文字移到搜索框之前 -->
      <div class="category-text">菜品分类</div>

      <div class="search-box">
        <el-button class="search-btn" type="text" @click="load">
          <i class="el-icon-search" aria-hidden="true"></i>
        </el-button>
        <input type="text" class="search-txt" placeholder="请输入类别名" v-model="categoryname" />
        <div class="search-line"></div>
      </div>
    </div>

    <div class="action-buttons">
      <el-button type="success" round  @click="addCategory">添加<i class="el-icon-plus el-icon--right"></i></el-button>
      <el-button type="danger" round @click="deleteSelected">批量删除<i class="el-icon-delete el-icon--right"></i></el-button>
    </div>


    <!--    菜品类别添加表单-->
    <el-dialog title="添加菜品类别" :visible.sync="dialogFormVisible">
      <el-form label-width="80px" style="padding-left: 170px">
        <el-form-item label="菜品类别:">
          <el-input v-model="categoryNameInput" autocomplete="off" style="width: 260px"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="handelCancel">取 消</el-button>
        <el-button type="primary" @click="handleConfirm">确 定</el-button>
      </div>
    </el-dialog>


    <!-- 添加菜品分类的表格 -->
    <el-table
        :data="tableData"
        style="width: 100%; margin-top: 20px"
        border
        @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="index" label="索引" width="80"></el-table-column>
      <el-table-column prop="categoryname" label="菜品分类名" align="center"></el-table-column>
      <el-table-column label="操作" width="500" align="center">
        <template slot-scope="scope">
          <el-button type="success" round @click="handleEdit(scope.row)">编辑<i class="el-icon-edit el-icon--right"></i></el-button>
          <el-button type="danger" round @click="handleDeleteRow(scope.row.categoryID)">删除<i class="el-icon-delete el-icon--right"></i></el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name: "ProductCategory",
  created() {
    this.load()
  },
  data() {
    return {
      tableData: [],  // 表格数据
      multipleSelection:[], //复选框选中的菜品分类
      categoryname:"",
      categoryNameInput:"",
      dialogFormVisible:false,  // 表单是否可见
      newCategory:{},
      shopData:localStorage.getItem('shop')?JSON.parse(localStorage.getItem('shop')):{} //读取shop的数据，绑定店铺
    };
  },
  methods: {
    //加载商品类别信息
    load() {
      this.request.get("/category/search", {
        params: {
          shopID: this.shopData.shopID,
          categoryname: this.categoryname
        }
      }).then(res => {
        console.log(res)
        if (!res) {
          this.$message.warning("获取商品失败");
        } else {
          // 为每一行添加 index 属性，从 1 开始递增
          this.tableData = res.map((item, index) => {
            return {
              ...item,
              index: index + 1
            };
          });
        }
      });
    },
    // 处理菜品类别添加逻辑
    addCategory() {
      this.newCategory.shopID=this.shopData.shopID
      this.dialogFormVisible=true
    },
    // 处理成功添加
    handleConfirm() {
      this.newCategory.categoryname=this.categoryNameInput;
      this.request.post("/category",this.newCategory).then(res => {
        this.$message.success("更新成功");
        this.categoryNameInput="";
        this.load(); // 添加后刷新表格数据
      }).catch(error => {
        // 处理添加错误
        this.$message.error("添加失败：" + error.message);
      });

      this.dialogFormVisible = false;
    },
    // 处理取消添加
    handelCancel(){
      this.categoryNameInput="";
      this.dialogFormVisible=false
    },

    // 复选框事件
    handleSelectionChange(val){
      console.log(val)
      this.multipleSelection=val
    },
    // 处理批量删除问题
    deleteSelected() {
      let categoryIds = this.multipleSelection.map(v =>v.categoryID)
      this.$confirm('是否删除此菜品类别?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-info",
        center: true
      }).then(() => {
        this.request.post("/category/del/batch",categoryIds).then(res => {
          this.$notify({
            title: '成功',
            message: '菜品类别已移出',
            type: 'success'
          });
          this.load();
        })
      }).catch(() => {
        // 确认按钮点击后的处理
        this.$notify.error({
          title: '失败',
          message: '已返回，未删除此菜品类别'
        });
      });
    },

    // 编辑行的逻辑
    handleEdit(row) {
      this.categoryNameInput=row.categoryname;
      this.newCategory.categoryID=row.categoryID;
      this.newCategory.shopID=this.shopData.shopID;
      this.dialogFormVisible=true;
      this.load();
    },
    // 删除按钮事件
    handleDeleteRow(categoryID) {
      this.$confirm('是否删除此菜品类别?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-info",
        center: true
      }).then(() => {
        this.request.delete("/category/" + categoryID).then(res => {
          this.$notify({
            title: '成功',
            message: '菜品已移出',
            type: 'success'
          });
          this.load();
        })
      }).catch(() => {
        // 确认按钮点击后的处理
        this.$notify.error({
          title: '失败',
          message: '已返回，未删除此菜品'
        });
      });
    },
  },
};
</script>

<style scoped>
.header-container {
  position: relative;
  display: flex;
  align-items: center;
  margin-bottom: -30px;
}

.category-text {
  margin-right: 10px; /* 可调整右边距 */
  font-size: 16px;
  color: #555;
}

.search-box {
  position: relative;
  margin-left: 10px;
  padding-bottom: 10px;
  background-color: white;
  box-shadow: 0 2px 25px 0 rgba(0, 0, 0, 0.1);
  width: 300px;
  height: 40px;
  border-radius: 40px;
  display: flex;
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

.search-btn:hover {
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

.action-buttons {
  margin-top: 50px;
  margin-bottom: 40px;
}

.action-buttons el-button {
  margin-right: 50px;
}

</style>
