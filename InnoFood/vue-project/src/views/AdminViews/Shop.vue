<template>
  <div>
    <el-tabs :tab-position="tabPosition" style="height: 200px;">
      <el-tab-pane label="类别管理" class="tab-pane">
        <!-- 类别管理 -->
        <div class="category-management">
          <el-button @click="showAddDialog = true" class="add-button">新增类别</el-button>
          <el-table :data="shopType.slice((currentPage - 1) * pageSize, currentPage * pageSize)" class="table">
            <el-table-column prop="shopTypeName" label="店铺类型名称"></el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button type="primary" @click="openEditDialog(scope.row)" class="edit-button">编辑</el-button>
                <el-button type="danger" @click="deleteType(scope.row.shopTypeID)" class="delete-button">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :current-page="currentPage"
              :page-sizes="[5, 10, 15, 20]"
              :page-size="pageSize"
              layout="total, sizes, prev, pager, next, jumper"
              :total="shopType.length"
              class="pagination"
          ></el-pagination>
        </div>

        <!-- 新增类别的对话框 -->
        <el-dialog title="新增类别" :visible.sync="showAddDialog" class="dialog" :center="true">
          <el-input v-model="newTypeName" placeholder="请输入类别名称"></el-input>
          <span slot="footer" class="dialog-footer">
            <el-button @click="showAddDialog = false">取消</el-button>
            <el-button type="primary" @click="addType">确定</el-button>
          </span>
        </el-dialog>

        <!-- 编辑类别的对话框 -->
        <el-dialog title="编辑类别" :visible.sync="isEditDialogVisible" class="dialog">
          <el-input v-model="editTypeName" placeholder="请输入类别名称"></el-input>
          <span slot="footer" class="dialog-footer">
            <el-button @click="closeEditDialog">取消</el-button>
            <el-button type="primary" @click="editType">确定</el-button>
          </span>
        </el-dialog>
      </el-tab-pane>

      <el-tab-pane label="banner管理">
        <!-- 店铺管理 -->
        <div class="banner-management">
          <banner/>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import banner from "@/views/AdminViews/banner.vue";

export default {
  name: 'Shop',
  data() {
    return {
      tabPosition: 'top',
      shopType: [],
      currentPage: 1,
      pageSize: 10,
      showAddDialog: false, // 控制新增类别对话框的显示
      isEditDialogVisible: false, // 控制编辑类别对话框的显示
      newTypeName: '', // 新增类别的名称
      editTypeName: '', // 编辑类别的名称
      editTypeId: null // 正在编辑的类别的ID
    };
  },
  created() {
    this.load();
  },
  components:{banner},
  methods: {
    load() {
      this.request.get('/shopType/search').then(res => {
        this.shopType = res;
      });
    },
    handleSizeChange(val) {
      this.pageSize = val;
    },
    handleCurrentChange(val) {
      this.currentPage = val;
    },
    // 新增类别的方法
    addType() {
      this.request.post('/shopType/save', { shopTypeName: this.newTypeName }).then(res => {
        // 添加成功后，重新加载类别列表
        this.load();
        // 关闭对话框
        this.showAddDialog = false;
        // 清空输入框
        this.newTypeName = '';
      });
    },
    openEditDialog(row) {
      this.editTypeId = row.shopTypeID;
      this.editTypeName = row.shopTypeName;
      this.showEditDialog = true;
    },
    // 编辑类别的方法
    editType() {
      // 在调试时输出 editTypeId 的值
      console.log('editTypeId:', this.editTypeId);

      // 检查 editTypeId 是否为有效值
      if (this.editTypeId === null || this.editTypeId === undefined) {
        console.error('Invalid editTypeId:', this.editTypeId);
        return;
      }

      this.request.post('/shopType/save', {
        shopTypeID: this.editTypeId,
        shopTypeName: this.editTypeName
      }).then(res => {
        // 编辑成功后，重新加载类别列表
        this.load();
        // 关闭对话框
        this.showEditDialog = false;
        // 清空输入框
        this.editTypeName = '';
        this.editTypeId = null;
      }).catch(error => {
        // 在控制台输出错误信息以便调试
        console.error('Error editing type:', error);
      });
    },
    closeEditDialog() {
      // 取消编辑时清空数据
      this.editTypeName = '';
      this.editTypeId = null;
      this.showEditDialog = false;
    },
    // 删除类别的方法
    deleteType(id) {
      this.$confirm('是否删除此信息?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: 'el-icon-info',
        center: true
      })
          .then(() => {
            this.request.delete('/shopType/' + id).then(res => {
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
              this.load();
            });
          })
          .catch(() => {
            // 取消按钮点击后的处理
            this.$message({
              iconClass: 'el-icon-circle-close',
              message: '取消成功!'
            });
          });
    },
    // 显示编辑类别的对话框
    showEditDialog(row) {
      this.editTypeId = row.shopTypeID;
      this.editTypeName = row.shopTypeName;
      this.isEditDialogVisible = true;
    }
  }
};
</script>

<style scoped>
.tab-pane {
  background-color: #f4f4f4;
  padding: 15px;
  border-radius: 5px;
}

.category-management {
  background-color: #fff;
  padding: 15px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.add-button {
  background-color: #409eff;
  color: #fff;
}

.table {
  margin-top: 15px;
}

.edit-button,
.delete-button {
  color: #fff;
}

.pagination {
  margin-top: 15px;
}

.store-management {
  background-color: #f0f0f0;
  padding: 15px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>
