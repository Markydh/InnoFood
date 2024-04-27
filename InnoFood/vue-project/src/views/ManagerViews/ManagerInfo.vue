<template>
  <div style="position:relative">
    <el-card style="width: 70%;">
      <el-descriptions class="margin-top" title="简介" :column="2" border>
        <template slot="extra">
          <el-button type="primary" size="small" @click="updateManagerInfo">修改个人信息</el-button>
        </template>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-picture-outline"></i>
            头像
          </template>
          <img class="img" :src="manager.psrc" alt="" />
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            用户名
          </template>
          {{ manager.username }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-s-custom"></i>昵称
          </template>
          {{ manager.nickname }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-message"></i>
            邮箱Email
          </template>
          {{ manager.email }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            手机号码
          </template>
          {{ manager.phone }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            账号状态
          </template>
          <el-button
              v-if="manager.state === 1"
              type="success"
          >
          已激活
          </el-button>
          <el-button
              v-else
              type="danger"
              style="background-color: #07b5fd;border: none"

          >
          冻结
          </el-button>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-time"></i>
            创建时间
          </template>
          {{ manager.createDate }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>




      <el-dialog
          title="修改个人信息"
          :visible.sync="dialogVisible"
          width="60%"
          :before-close="handleClose"
      >
        <div style="display: flex; justify-content: center; align-items: center; height: 100%;">
          <el-form :model="managerForm" :rules="rules" ref="form" label-width="150px" style="width: 60%;">
            <!-- 完整的表单内容 -->
            <el-form-item label="头像" prop="psrc">
            <el-upload
                class="avatar-uploader"
                action="http://localhost:9091/file/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess">
              <img v-if="managerForm.psrc" :src="managerForm.psrc" class="avatar" style="width: 120px; height: 120px">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
            </el-form-item>
            <el-form-item label="商家编号" prop="managerID">
              <el-input v-model="managerForm.managerID" disabled style="width: 350px"></el-input>
            </el-form-item>
            <el-form-item label="用户名" prop="account">
              <el-input v-model="managerForm.username" disabled style="width: 350px"></el-input>
            </el-form-item>
            <el-form-item label="账号密码" prop="password">
              <el-input v-model="managerForm.password" show-password style="width: 350px"></el-input>
            </el-form-item>
            <el-form-item label="昵称" prop="nickname">
              <el-input v-model="managerForm.nickname" style="width: 350px"></el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="managerForm.email" style="width: 350px"></el-input>
            </el-form-item>
            <el-form-item label="手机号码" prop="mobilePhoneNumber">
              <el-input v-model="managerForm.phone" style="width: 350px"></el-input>
            </el-form-item>
          </el-form>
        </div>

        <span slot="footer" class="dialog-footer">
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" @click="submit">提交</el-button>
    </span>
      </el-dialog>

  </div>
</template>

<script>
export default {
  name: "ManagerInfo",
  data() {
    return {
      manager:localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{},
      dialogVisible: false,
      managerForm:{

      },
      rules: {
        nickname: [
          { required: true, message: "昵称不能为空", trigger: "blur" },
        ],
        password: [
          { required: true, message: "账号密码不能为空", trigger: "blur" },
        ],
      },
    };
  },
  mounted() {
  },
  methods: {
    // 修改个人信息按钮事件
    updateManagerInfo(){
      this.managerForm=this.manager
        this.dialogVisible=true
    },
    // 提交修改
    submit(){
      this.request.post("/manager", this.managerForm).then(res => {
        if (res) {
          this.$message.success("修改成功")
          this.dialogVisible=false;
          localStorage.setItem('manager',JSON.stringify(this.manager))
          //刷新界面
          window.location.reload();
        } else {
          this.$message.success("保存失败")
          this.dialogVisible=false;
        }
      })
    },
    // 取消修改
    handleClose() {
      this.dialogVisible = false;
      this.$emit("flesh");
      this.manager=localStorage.getItem('manager')?JSON.parse(localStorage.getItem('manager')):{}
    },
    handleAvatarSuccess(res){
      this.managerForm.psrc=res;
    }
  },
};
</script>

<style scoped>
.el-card{
    margin-top: 200px;
    margin-left: 100px;
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
