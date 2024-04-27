<template>
 <div class="father">
   <router-link to="/"><el-button style="background-color: rgba(239,148,228,0.5); border: none;color: #FFFFFF;font-size: larger; margin-left: 20px;margin-top: 20px; height: 45px;width: 45px" circle>
     <i class="el-icon-arrow-left"></i>
   </el-button>
   </router-link>
  <div class="son">
    <div class="son-left">
    </div>
    <div class="son-right">
      <el-row type="flex" justify="center" align="middle">
        <el-form  ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px">
          <h3 style="font-size: 25px;padding-bottom: 30px;font-weight: normal;color: #595353">Sign in</h3>
          <span style="color: #a8a8ab;font-size: small">username</span>
          <el-form-item prop="username">
            <el-input v-model="user.username" ></el-input>
          </el-form-item>
          <span style="color: #a8a8ab;font-size: small">password</span>
          <el-form-item id="password" prop="password">
            <el-input v-model="user.password" show-password></el-input>
          </el-form-item>
          <Myh style="font-size: 13px">Now User </Myh>
          <router-link to="/userRegister" style="color:rgb(143,121,198);text-decoration: none;font-size: small;margin-right: 120px;">Sign Up</router-link>
          <router-link to="/" style="color:rgb(143,121,198);text-decoration: none;font-size:small">Forget Password?</router-link>
          <el-form-item>
            <el-button  style="margin-top: 48px;margin-left:20px;background-color: rgb(143,121,198);color: #FFFFFF;width: 135px;height: 30px" type="text" @click="doLogin()" round>Sign in </el-button>
          </el-form-item>
        </el-form>
      </el-row>
    </div>
  </div>
 </div>
</template>

<script>



import Myh from "@/components/Myh.vue";

export default {
  name: "UserLogin",
  components: {Myh},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" }
        ]
      }
    }
  },
  created() {
  },
  methods: {
    doLogin() {
      if (!this.user.username) {
        this.$message.error("请输入用户名！");
        return;
      } else if (!this.user.password) {
        this.$message.error("请输入密码！");
        return;
      } else {
        //校验用户名和密码是否正确;
        // this.$router.push({ path: "/personal" });
        this.request.post("/user/login", this.user).then(res => {
              // console.log("输出response.data.status", res.data.status);
              if (!res) {
                this.$message.error("您输入的用户名或密码错误！")
              } else {
                localStorage.setItem('user',JSON.stringify(res))
                this.$router.push({ path: "/User"})
                this.$message.success("登录成功")
              }
            });
      }
    },
  }
}
</script>
<style scoped>

.father {
  position: relative;
  height: 100%;
  width: 100%;
  background-image: url("/loginBG.jpg");
  background-size: 100% ,100%;
}
.son {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 48%;
  height: 65%;
  background-color: rgb(143,121,198);
  display:flex;
}
.son-left{
  height: 100%;
  background-image: url("/login.jpg");
  background-size: 112% ,100%;
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
  left: 10%;
  padding-top: 150px;
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
</style>

