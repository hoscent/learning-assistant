<script setup name="loginPage">
import { ref } from 'vue'
import { registerUser, loginUser } from '@/api/user.js'
import { showToast } from 'vant'
import 'vant/es/toast/style'
import { useUserStore } from '@/stores'
import { useRouter } from 'vue-router'

const user = {
  username: '',
  password: '',
  rePassword: ''
}
const formModel = ref({ ...user })
const isLogin = ref(true)
const changePage = () => {
  isLogin.value = !isLogin.value
  formModel.value = { ...user }
}
const usernameRef = ref(null)
const passwordRef = ref(null)
const repasswordRef = ref(null)
const verifyUsername = (e) => {
  const regex = /^[a-zA-Z0-9]{5,16}$/
  if (!regex.test(e.target.value)) {
    usernameRef.value.innerHTML = '账号长度为5-16位，只能包含字母、数字'
    return false
  }
  usernameRef.value.innerHTML = ''
  return true
}
const verifyPassword = (e) => {
  const regex = /^[\S]{6,18}$/
  if (!regex.test(e.target.value)) {
    passwordRef.value.innerHTML = '密码必须为非空字符，长度为6-18位'
    return false
  }
  passwordRef.value.innerHTML = ''
  return true
}
const verifyRepassword = (e) => {
  if (formModel.value.password !== e.target.value) {
    repasswordRef.value.innerHTML = '两次输入密码不一致'
    return false
  }
  repasswordRef.value.innerHTML = ''
  return true
}
const router = useRouter()
const login = () => {
  loginUser(formModel.value).then((res) => {
    const userStore = useUserStore()
    userStore.setToken(res.data.data)
    showToast('登录成功')
    router.replace('/home')
  })
}
const register = () => {
  registerUser(formModel.value).then((res) => {
    if (res.data.code === 200) {
      showToast(res.data.data)
    }
  })
}
</script>

<template>
  <div class="mask"><div class="box"></div></div>
  <div class="login">
    <div class="logo">
      <div class="logoBox">
        <img src="@/assets/img/logo.png" />
      </div>
    </div>
    <div class="container" v-if="isLogin">
      <div class="form">
        <div class="form-item">
          <van-icon name="user-o" />
          <input
            v-model="formModel.username"
            class="inp"
            maxlength="11"
            placeholder="请输入账号"
            type="text"
            required
          />
        </div>
        <div class="form-item">
          <i class="iconfont icon-password"></i>
          <input
            v-model="formModel.password"
            class="inp"
            maxlength="11"
            placeholder="请输入密码"
            type="password"
            required
          />
        </div>
      </div>

      <div class="login-btn" @click="login">登录</div>
    </div>
    <div class="container" v-else>
      <div class="form">
        <div class="form-item">
          <van-icon name="user-o" />
          <input
            v-model="formModel.username"
            class="inp"
            maxlength="11"
            placeholder="请输入账号"
            type="text"
            @input="verifyUsername"
            required
          />
          <div class="warn" ref="usernameRef"></div>
        </div>
        <div class="form-item">
          <i class="iconfont icon-password"></i>
          <input
            v-model="formModel.password"
            class="inp"
            maxlength="11"
            placeholder="请输入密码"
            type="password"
            @input="verifyPassword"
            required
          />
          <div class="warn" ref="passwordRef"></div>
        </div>
        <div class="form-item">
          <i class="iconfont icon-password"></i>
          <input
            v-model="formModel.rePassword"
            class="inp"
            maxlength="11"
            placeholder="请再次输入密码"
            type="password"
            @input="verifyRepassword"
            required
          />
          <div class="warn" ref="repasswordRef"></div>
        </div>
      </div>

      <div class="login-btn" @click="register">注册</div>
    </div>
    <div class="bottomOption">
      <a @click="changePage" href="javascript:void(0)">
        {{ isLogin ? '注册' : '登录' }}
      </a>
      <a href="javascript:void(0)">忘记密码</a>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.mask {
  width: 100%;
  height: 100vh;
  position: fixed;
  background-color: #fff;
  .box {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('@/assets/img/bg-pattern.png') no-repeat;
    background-position: 100%;
    background-size: cover;
    z-index: 1;
  }
}
.login {
  height: 100vh;
  position: relative;
  padding: 49px 29px;
  z-index: 10;
  .title {
    margin-bottom: 20px;
    h3 {
      font-size: 26px;
      font-weight: normal;
    }
    p {
      line-height: 40px;
      font-size: 14px;
      color: #b8b8b8;
    }
  }
  .logo {
    height: 100px;
    padding: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 60px;
    z-index: 9;
    .logoBox {
      width: 80px;
      height: 80px;
      text-align: center;
      img {
        width: 100%;
        height: 100%;
      }
      h4 {
        font-size: 20px;
        font-weight: 400;
      }
    }
  }
  .container {
    .form-item {
      padding: 8px 12px;
      margin-bottom: 22px;
      display: flex;
      align-items: center;
      background-color: #f4f4f4;
      border-radius: 39px;
      position: relative;
      .iconfont {
        width: 16px;
        height: 16px;
        font-size: 18px;
        line-height: 14px;
        bottom: 0;
      }
      .inp {
        margin-left: 4px;
        display: block;
        border: none;
        outline: none;
        height: 32px;
        font-size: 14px;
        background-color: inherit;
        flex: 1;
      }
      .warn {
        font-size: 12px;
        color: red;
        position: absolute;
        bottom: -16px;
      }
    }

    .login-btn {
      width: 100%;
      height: 42px;
      margin-top: 39px;
      background: linear-gradient(90deg, #32c5ff, #1989fa);
      color: #fff;
      border-radius: 39px;
      box-shadow: 0 10px 20px 0 rgba(0, 0, 0, 0.1);
      letter-spacing: 2px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }

  .bottomOption {
    display: block;
    font-size: 14px;
    margin: 0 8px;
    margin-top: 12px;
    display: flex;
    justify-content: space-between;
    a {
      color: #cea26a;
    }
  }
}
</style>
