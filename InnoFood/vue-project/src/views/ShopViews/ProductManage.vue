<template>
  <div style="height: 100%">
    <div class="header-container">
      <!-- 菜品分类文字移到搜索框之前 -->
      <div class="category-text">菜品列表</div>

      <div class="search-box">
        <el-button class="search-btn" type="text" @click="load">
          <i class="el-icon-search" aria-hidden="true"></i>
        </el-button>
        <input type="text" class="search-txt" placeholder="请输入商品名" v-model="categoryname" />
        <div class="search-line"></div>
      </div>
    </div>

    <div class="action-buttons">
      <el-button type="success" round  @click="addFood">添加<i class="el-icon-plus el-icon--right"></i></el-button>
      <el-button type="danger" round @click="deleteSelected">批量删除<i class="el-icon-delete el-icon--right"></i></el-button>
    </div>

<!--     添加菜品-->
    <el-dialog title="菜品信息" :visible.sync="dialogFormVisible">
      <el-form label-width="80px" style="padding-left: 170px">
        <el-form-item label="菜品图片" prop="psrc">
          <el-upload
              class="avatar-uploader"
              action="http://localhost:9091/file/upload"
              :show-file-list="false"
              :on-success="handleAvatarSuccess">
            <img v-if="newFood.psrc" :src="newFood.psrc" class="avatar" style="width: 120px; height: 120px">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>


        <el-form-item label="菜品名:">
          <el-input v-model="newFood.productname" autocomplete="off" style="width: 260px"></el-input>
        </el-form-item>
        <el-form-item label="菜品类别:">
          <el-select v-model="newFood.categoryID" placeholder="请选择" style="width: 260px">
            <el-option
                v-for="category in categorys"
                :key="category.categoryID"
                :label="category.categoryname"
                :value="category.categoryID">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="单价:">
          <el-input v-model="newFood.price" autocomplete="off" style="width: 260px"></el-input>
        </el-form-item>
        <el-form-item label="库存量:">
          <el-input-number v-model="newFood.product_rest" controls-position="right" :min="1" style="width: 260px"></el-input-number>
        </el-form-item>
        <el-form-item label="菜品描述:">
          <el-input v-model="newFood.description" autocomplete="off"   type="textarea" :rows="3" style="width: 260px"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="handelCancel">取 消</el-button>
        <el-button type="primary" @click="handleConfirm">确 定</el-button>
      </div>
    </el-dialog>


    <!-- 菜品分类的表格 -->
    <el-table
        :data="tableData"
        style="width: 100%; margin-top: 20px"
        border
        :header-row-style="{ height: '100px' }"
        @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="index" label="索引" width="80"></el-table-column>
      <el-table-column label="菜品" width="180">
        <template slot-scope="scope">
          <img :src="scope.row.psrc" alt="菜品图片" style="max-width: 140px; max-height: 160px;" />
        </template>
      </el-table-column>
      <el-table-column prop="productname" label="菜品名" align="center"></el-table-column>
      <el-table-column prop="categoryname" label="菜品类别" align="center"></el-table-column>
      <el-table-column prop="price" label="单价" align="center"></el-table-column>
      <el-table-column prop="product_rest" label="库存量" align="center"></el-table-column>
      <el-table-column prop="sales" label="总销售量" align="center"></el-table-column>
      <el-table-column prop="description" label="商品描述" align="center"></el-table-column>
      <el-table-column label="操作" width="280" align="center">
        <template slot-scope="scope">
          <el-button type="success" round @click="handleEdit(scope.row)">修改<i class="el-icon-edit el-icon--right"></i></el-button>
          <el-button type="danger" round @click="handleDeleteRow(scope.row.productID)">删除<i class="el-icon-delete el-icon--right"></i></el-button>
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
   name: "ProductManage",
   data(){
     return {
       pageNum: 1,
       pageSize: 5,
       totalNum: 0,
       tableData:[],
       newFood:{},
       categoryname:"",
       categorys:[], //复选框获取该店铺的所有菜品类别
       multipleSelection:[], //复选框选中的菜品
       dialogFormVisible:false, // 添加菜品的表单可见变量
       dialogVisible:false, // 修改菜品的表单可见变量
       shopData:localStorage.getItem('shop')?JSON.parse(localStorage.getItem('shop')):{}
     }
   },
   created() {
     this.load();
   },
   methods:{
     //加载菜品函数
     load() {
        this.request.get("/product/findProductInfo/page", {
           params: {
             shopID: this.shopData.shopID,
             categoryname:this.categoryname,
             pageNum: this.pageNum,
             pageSize: this.pageSize,
           }
         }).then( res =>{
           if(!res){
             this.$message.warning("获取菜品失败");
           }else{
             this.tableData = res.data.map((item, index) => {
               return {
                 ...item,
                 index: index + 1
               };
             });
             this.totalNum=res.totalNum;
           }
        })
     },
     loadCategory(){
       // 搜索该店铺的所有菜品类别
       this.request.get("/category/search", {
         params: {
           shopID: this.shopData.shopID,
           categoryname: ""
         }
       }).then(res =>{
         console.log(res);
         this.categorys=res;
       });
     },
     handleAvatarSuccess(res){
       this.newFood.psrc=res;
     },
     // 添加菜品按钮事件
     addFood(){
       this.dialogFormVisible=true;
       this.loadCategory()
       this.newFood.shopID=this.shopData.shopID;
     },
     // 添加菜品时的确定添加事件
     handleConfirm(){
        this.request.post("/product",this.newFood).then(res =>{
            if(!res){
              this.$message.warning("添加菜品失败")
            }else{
              this.$message.success("添加成功")
              this.newFood={};
                this.dialogFormVisible = false;
              }
            })
        this.load();
        window.location.reload();
        },
     // 添加菜品时的取消添加事件
     handelCancel(){
        this.newFood={};
        this.dialogFormVisible=false;
        },
     // 删除指定行按钮事件
     handleDeleteRow(productID){
       this.request.delete("/product/"+productID).then(res =>{
         if(!res){
           this.$message.warning("删除失败")
         }else{
           this.$message.success("删除成功")
           this.load()
         }
       })
     },
     //编辑菜品事件
     handleEdit(row){
       this.newFood = row;
       // 显示对话框
       this.dialogFormVisible = true;
       // 搜索该店铺的所有菜品类别
       this.loadCategory()
     },
     // 复选框事件
     handleSelectionChange(val){
       console.log(val)
       this.multipleSelection=val
     },
     // 处理批量删除问题
     deleteSelected() {
       let productIds = this.multipleSelection.map(v =>v.productID)
       this.$confirm('是否删除此菜品类别?', '提示', {
         confirmButtonText: '删除',
         cancelButtonText: '取消',
         closeOnPressEscape: true,
         iconClass: "el-icon-info",
         center: true
       }).then(() => {
         this.request.post("/product/del/batch",productIds).then(res => {
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
   },
 }
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
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
.action-buttons{
  display: flex;
  gap: 10px; /* 根据需要调整值，以设置按钮之间所需的间隔 */
}
</style>

