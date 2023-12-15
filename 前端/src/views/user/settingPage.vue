<script setup>
import HeaderNav from '@/components/HeaderNav.vue'
import { useUserStore } from '@/stores'
import { showConfirmDialog } from 'vant'
import { useRouter } from 'vue-router'
import 'vant/es/dialog/style'
const userStore = useUserStore()
const router = useRouter()
const detail = {
  back: true,
  title: '设置'
}
const quitLogin = () => {
  showConfirmDialog({
    title: '提示',
    message: '确认退出登录？'
  })
    .then(() => {
      userStore.clearToken()
      userStore.clearUser()
      router.replace('/login')
    })
    .catch()
}
</script>

<template>
  <HeaderNav :detail="detail"></HeaderNav>
  <div class="setting">
    <van-cell-group inset>
      <van-cell title="个人信息" is-link />
      <van-cell title="账户安全" is-link />
    </van-cell-group>
    <div class="sliper"></div>
    <van-cell-group inset>
      <van-cell title="帮助" is-link />
      <van-cell title="关于" is-link />
    </van-cell-group>
    <div class="sliper"></div>
    <div class="item">
      <van-button @click="quitLogin" type="primary" color="#fff" block
        >退出登录</van-button
      >
    </div>
  </div>
</template>

<style lang="scss" scoped>
.setting {
  margin-top: 12px;
  .sliper {
    width: 100%;
    padding: 6px 0;
  }
  .item {
    padding: 0 16px;
    .van-button {
      border-radius: 8px;
      :deep(.van-button__content) {
        .van-button__text {
          color: red;
        }
      }
    }
  }
}
</style>
