<template>
  <div style="height: 100%">
    <div style="display: flex; align-items: center;margin-bottom: -30px">
      <div class="search-box">
        <el-button class="search-btn" type="text" @click="load">
          <i class="el-icon-search" aria-hidden="true"></i>
        </el-button>
        <input type="text" class="search-txt" placeholder="请输入店铺类别名" v-model="shopTypeName" />
        <div class="search-line"></div>
      </div>
      <div style="margin-left: auto;">
        <el-button @click="addShop">添加<i class="el-icon-plus el-icon--right"></i></el-button>
      </div>
    </div>

<!--    店铺添加表单-->
    <el-dialog title="店铺信息" :visible.sync="dialogFormVisible">
      <el-form label-width="80px" style="padding-left: 170px">
        <el-form-item label="店铺图片" prop="psrc">
          <el-upload
              class="avatar-uploader"
              action="http://localhost:9091/file/upload"
              :show-file-list="false"
              :on-success="handleAvatarSuccess">
            <img v-if="newShopForm.psrc" :src="newShopForm.psrc" class="avatar" style="width: 120px; height: 120px">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="店铺名:">
          <el-input v-model="newShopForm.shopName" autocomplete="off" style="width: 300px"></el-input>
        </el-form-item>
        <el-form-item label="店铺类别:">
          <el-select v-model="newShopForm.shopTypeID" placeholder="请选择" style="width: 300px">
            <el-option
                v-for="shopType in shopTypes"
                :key="shopType.shopTypeID"
                :label="shopType.shopTypeName"
                :value="shopType.shopTypeID">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="地址:">
          <el-input v-model="newShopForm.address" autocomplete="off" style="width: 300px"></el-input>
        </el-form-item>
        <el-form-item label="描述:">
          <el-input v-model="newShopForm.description" autocomplete="off"   type="textarea" :rows="3" style="width: 300px"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="handelCancel">取 消</el-button>
        <el-button type="primary" @click="handleConfirm">确 定</el-button>
      </div>
    </el-dialog>


  <el-table
      :data="shopForm"
      border
      style="width: 100%;margin-top:40px "
      :header-row-style="{ height: '80px' }"
      @row-click="handleRowClick"
  >
    <el-table-column label="店铺" width="180">
      <template slot-scope="scope">
        <img :src="scope.row.psrc" alt="店铺图片" style="max-width: 100%; max-height: 150px;" />
      </template>
    </el-table-column>
    <el-table-column prop="shopName" label="店铺名称" width="180"></el-table-column>
    <el-table-column prop="shopTypeName" label="店铺类别" width="150"></el-table-column>
    <el-table-column prop="address" label="店铺地址"></el-table-column>
    <el-table-column prop="description" label="店铺描述"></el-table-column>
    <el-table-column label="星级" width="180">
      <template slot-scope="scope">
        <!-- 使用 yellow-star 类来调整星星的颜色 -->
        <span :class="{ 'yellow-star': true }">{{ generateStars(scope.row.star) }}</span>
      </template>
    </el-table-column>
    <el-table-column label="店铺状态" prop="state" width="100">
      <template slot-scope="scope">
        <el-button
            @click.stop="toggleStatus(scope.row)"
            :type="scope.row.state === 1 ? 'success' : 'primary'"
        >
          {{ scope.row.state === 1 ? '营业中' : '已冻结' }}
        </el-button>
      </template>
    </el-table-column>
    <el-table-column label="操作" width="220" align="center">
      <template slot-scope="scope">
        <!-- 删除按钮 -->
        <el-button type="primary" icon="el-icon-edit" @click.stop="handleEdite(scope.row)">修改</el-button>
        <el-button type="danger" icon="el-icon-delete" @click.stop="handleDelete(scope.row.shopID)">删除</el-button>
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
  name: "ShopManage",
  data() {
    return {
      pageNum: 1,
      pageSize: 5,
      totalNum: 0,
      shopForm: [],
      shopTypeName: "",
      dialogFormVisible:false,
      newShopForm:{},
      shopTypes:[], //复选框获取所有店铺类别
      managerData:localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{}
    };
  },
  created() {
    this.load(); // 在组件创建时调用方法获取数据
  },
  methods: {
     load() {
      // 使用axios调用后端接口，假设接口返回的数据是一个包含店铺信息的数组
       this.request.get('/shop/findShopInfo/page',{
         params:{
           shopTypeName:this.shopTypeName,
           managerID:this.managerData.managerID,
           pageNum: this.pageNum,
           pageSize: this.pageSize,
         }
       }).then(res =>{
         console.log(res)
         this.shopForm=res.data;
         this.totalNum=res.totalNum;
       });
    },
    // 搜索所有店铺类别
    loadShopTypes(){
      this.request.get("/shopType/search").then(res =>{
        console.log(res);
        this.shopTypes=res;
      });
    },
    reset(){
       this.shopName=''
       this.search()
    },
    generateStars(starValue) {
      // 根据业务规则生成星星
      const roundedStars = Math.round(starValue);
      return '★'.repeat(roundedStars);
    },
    toggleStatus(row) {

      if (!this.isButtonClicked) {
        // 切换状态逻辑
        row.state = row.state === 1 ? 0 : 1;
        console.log(row);
        // 其他更新状态的逻辑，例如调用 API 更新后端状态等
        this.request.post('/shop',row).then(res => {
          if(res){
            console.log("success");
            this.load();
          }else{
            this.$message.info("操作失败");
            this.load();
          }
        })
      }
      this.isButtonClicked = false; // 重置按钮点击状态
    },
    addShop(){
       // 将商家ID复制给新的店铺，绑定此商家
      this.newShopForm.managerID=this.managerData.managerID
      this.loadShopTypes();
      this.dialogFormVisible=true
    },
    handleAvatarSuccess(res){
      this.newShopForm.psrc=res;
    },
    handleConfirm(){
       this.request.post('/shop',this.newShopForm).then(res =>{
         if(!res){
           this.$message.warning("添加失败")
         }else{
           this.$message.success("添加成功")
           //刷新界面
           window.location.reload();
         }
       })
       this.dialogFormVisible=false;
       this.load();
    },
    handelCancel(){
      this.dialogFormVisible=false;
      this.load();
    },
    //删除店铺
    handleDelete(shopID){
      this.$confirm('是否删除此店铺?', '提示', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        closeOnPressEscape: true,
        iconClass: "el-icon-info",
        center: true
      }).then(() => {
        this.request.delete("/shop/" + shopID).then(res => {
          this.$notify({
            title: '成功',
            message: '店铺已移出',
            type: 'success'
          });
          this.load();
        })
      }).catch(() => {
        // 确认按钮点击后的处理
        this.$notify.error({
          title: '失败',
          message: '已返回，未删除店铺'
        });
      });
    },
    handleRowClick(row){
       localStorage.setItem('shop',JSON.stringify(row))
       this.$router.push('/shop')
    },
    // 修改店铺信息
    handleEdite(row){
     this.dialogFormVisible=true;
      this.newShopForm=row;
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
};
</script>

<style scoped>
.yellow-star {
  color: #e319d2;
}
.search-line {
  position: absolute;
  left: 62px;
  bottom: 10px;
  width: 0px;
  height: 2px;
  background-color: rgb(251, 121, 0);
  transition: 0.3s;
}
.search-box {
  position: absolute;
  top: 10px;
  margin-top: 10px;
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
.search-btn:hover{
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
.img {
  width: 80px;
  height: 80px;
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
</style>
