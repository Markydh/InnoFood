<script>
import user from "../AdminViews/ZhUser.vue";

export default {
  name: "personInfo",
  computed: {
    user() {
      return user
    }
  },
  data() {
    return {
      userData: {},
      avatarSize: 40,
      size: '',
      form: {},
      dialogFormVisible: false,
      formLabelWidth: '120px',
    };

  },
  methods: {
    load() {
      this.request.get('/user/findUserByID', {
        params: {
          userID: this.userData.userID
        }
      }).then(res => {
        console.log(res)
        // this.user = res
        this.userData = this.form
      });
    },
    handleEdit(row) {
      this.form = Object.assign({}, row)
      this.dialogFormVisible = true
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false;
          localStorage.setItem('user', JSON.stringify(this.form))
          this.load();
        } else {
          this.$message.success("保存失败")
          this.dialogFormVisible = false;
        }
      })
    },
    cancel() {
      this.dialogFormVisible = false
    },
    handleAvatarSuccess(res) {
      this.form.psrc = res
    }
  },
  created() {
    this.userData = JSON.parse(localStorage.getItem('user')) || {};
  },
}
</script>

<template>
  <div class="content">

    <div class="avatar" style="width: 80px;height:80px ;margin-top: 5%">
      <el-image shape="circle" size="large" :src="userData.psrc"
                 style="margin-left: 30px; width: 120px; height: 120px;border-radius: 50%">
      </el-image>
    </div>

    <div style="margin-left: 200px;width: auto;margin-top: -120px;">
      <el-descriptions title="个人信息" direction="vertical" :column="4" border class="custom-description">
        <el-descriptions-item label="账号">{{ userData.username }}</el-descriptions-item>
        <el-descriptions-item label="昵称">{{ userData.nickname }}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{ userData.phone }}</el-descriptions-item>
        <el-descriptions-item label="收货地址">{{ userData.address }}</el-descriptions-item>
        <el-descriptions-item label="email">{{ userData.email }}</el-descriptions-item>
        <el-descriptions-item label="score">{{ userData.score }}</el-descriptions-item>
        <el-descriptions-item label="注册日期">{{ userData.createDate }}</el-descriptions-item>
      </el-descriptions>
    </div>


    <el-button type="primary" size="medium" @click="handleEdit(userData)" style="margin-left: 3%; margin-top: 2%">
      修改信息
    </el-button>

    <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form :model="form" label-width="12%">
        <el-upload
            class="avatar-uploader"
            action="http://localhost:9091/file/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess">
          <img v-if="form.psrc" :src="form.psrc" class="avatar"
               style="width: 120px; height: 120px; margin-left: 50%; margin-bottom: 20%">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <el-form-item label="账号">
          <el-input v-model="form.username" :value="userData.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password" :value="userData.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" :value="userData.nickname"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" :value="userData.phone"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" :value="userData.address"></el-input>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.email" :value="userData.email"></el-input>
        </el-form-item>
        <el-form-item label="积分">
          <el-input v-model="form.score" :value="userData.score" disabled></el-input>
        </el-form-item>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>

    </el-dialog>

  </div>
</template>

<style scoped>
.upload-demo {
  margin-top: 2%;
  margin-left: 3%;
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
