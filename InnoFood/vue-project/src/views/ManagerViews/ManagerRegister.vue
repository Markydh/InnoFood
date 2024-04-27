<template>
  <div class="father">
    <router-link to="/managerLogin"><el-button style="background-color: rgba(239,148,228,0.5); border: none;color: #FFFFFF;font-size: larger; margin-left: 20px;margin-top: 20px; height: 45px;width: 45px" circle>
      <i class="el-icon-arrow-left"></i>
    </el-button>
    </router-link>
    <div class="son">
      <div class="son-left">
      </div>
      <div class="son-right">
        <el-row type="flex" justify="center" align="middle">
          <el-form  ref="loginForm" :model="manager" :rules="rules" status-icon label-width="80px">
            <h3 style="font-size: 25px;padding-bottom: 30px;font-weight: normal;color: #595353">Register Now</h3>
            <span style="color: #a8a8ab;font-size: small">username</span>
            <el-form-item prop="username">
              <el-input v-model="manager.username" ></el-input>
            </el-form-item>
            <span style="color: #a8a8ab;font-size: small">nickname</span>
            <el-form-item prop="nickname">
              <el-input v-model="manager.nickname" ></el-input>
            </el-form-item>
            <span style="color: #a8a8ab;font-size: small">email</span>
            <el-form-item prop="email">
              <el-input v-model="manager.email" ></el-input>
            </el-form-item>
            <span style="color: #a8a8ab;font-size: small">phone</span>
            <el-form-item prop="phone">
              <el-input v-model="manager.phone" ></el-input>
            </el-form-item>
            <span style="color: #a8a8ab;font-size: small">password</span>
            <el-form-item id="password" prop="password">
              <el-input v-model="manager.password" show-password></el-input>
            </el-form-item>
            <span style="color: #a8a8ab;font-size: small">confirm password</span>
            <el-form-item  prop="cpwd">
              <el-input v-model="manager.cpwd" show-password></el-input>
            </el-form-item>
            <Myh style="font-size: 13px">Now Mananger </Myh>
            <router-link to="/register" style="color:rgb(143,121,198);text-decoration: none;font-size: small;margin-right: 120px;">Help</router-link>
            <router-link to="/managerLogin" style="color:rgb(143,121,198);text-decoration: none;font-size:small">Have Account?</router-link>
            <el-form-item>
              <el-button  style="margin-top: 58px;margin-left:20px;background-color: rgb(143,121,198);color: #FFFFFF;width: 135px;height: 30px" type="text" @click="register()" round>Register </el-button>
            </el-form-item>
          </el-form>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: "ManagerRegister",
  data() {
    return {
      manager: {
        username: "",
        password: "",
        nickname:"",
        email:"",
        phone:"",
        address:"",
        cpwd:""
      },
      rules: {
        username: [{
          required: true,
          type: 'string',
          message: 'please input username',
          trigger: 'blur'
        }],
        nickname: [{
          required: true,
          type: 'string',
          message: 'please input nickname',
          trigger: 'blur'
        }],
        email: [{
          required: true,
          type: 'email',
          message: 'please input email',
          trigger: 'blur'
        }],
        phone: [{
          required: true,
          type: 'string',
          message: 'please input phone',
          trigger: 'blur'
        }],
        password: [{
          required: true,
          message: 'please input password',
          trigger: 'blur'
        }],
        cpwd: [{
          required: true,
          message: 'confirm password',
          trigger: 'blur'
        }, {
          validator: (rule, value, callback) => {
            if (value === '') {
              callback(new Error('input password again'))
            } else if (value !== this.manager.password) {
              callback(new Error('The two passwords are inconsistent'))
            } else {
              callback()
            }
          },
          trigger: 'blur'
        }]
      }

    }
  },
  created() {
  },
  methods: {
    register(){
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          this.request.get("/manager/register",{
            params:{
              username:this.manager.username
            }
          }).then(response =>{
            console.log(response)
            if(response == 0){
              this.$message.warning('用户名已存在，请选择其他用户名');
              this.manager = {};
            }else{
              this.request.post("/manager", this.manager).then(res => {
                console.log(res)
                console.log(this.manager)
                if (!res) {
                  this.$message.error("注册失败");
                } else {
                  this.$message.success("注册成功");
                  this.$router.push({ path: "/managerLogin" });
                }
              });
            }
          })
        } else {
          // 表单验证失败，不执行注册逻辑，提示用户
          this.$message.warning('注册信息不能为空')
        }
      });
    }
  }
}
</script>
<style scoped>

.father {
  position: relative;
  height: 100%;
  background-image: url("/registerBg.jpg");
  background-size: 100% ,100%;
}
.son {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 68%;
  height: 90%;
  background-color: rgb(143,121,198);
  display:flex;
}
.son-left{
  height: 100%;
  background-image: url("/register.jpg");
  background-size: 108% ,100%;
  box-flex: 5;/*灵活度*/
  -webkit-box-flex: 5; /* Safari and Chrome */
  -moz-box-flex: 5; /* Firefox */
  -webkit-flex: 5;
  -ms-flex: 5;
  flex: 5;
}
.son-right{
  height: 100%;
  background-color: #FFFFFF;
  box-flex: 6;/*灵活度*/
  -webkit-box-flex: 6; /* Safari and Chrome */
  -moz-box-flex: 6; /* Firefox */
  -webkit-flex: 6;
  -ms-flex: 6;
  flex: 6;
}
.el-form{
  left: 5%;
  padding-top: 100px;
  position: relative;
}

.el-input{
  left: -24%;
  font-size: medium;
  position: relative;
}
.el-input >>> .el-input__inner {
  width: 340px;
  border-top-width: 0px;
  border-left-width: 0px;
  border-right-width: 0px;
  border-bottom-width: 1px;
}
.login-box {
  border: 1px solid #DCDFE6;
  width: 350px;
  margin: 180px auto;
  padding: 35px 35px 15px 35px;
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  box-shadow: 0 0 25px #909399;
}

.login-title {
  text-align: center;
  margin: 0 auto 40px auto;
  color: #303133;
}
.el-form-item__error {
  left: -23% !important;
  left: unset;
}
</style>
