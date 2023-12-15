<script setup>
import { useRouter } from 'vue-router'
defineProps({
  detail: Object
})
const router = useRouter()
const onClickLeft = () => {
  router.back()
}
</script>
<template>
  <van-nav-bar
    :title="detail.title"
    :left-arrow="detail.back"
    @click-left="onClickLeft"
  >
    <template #right>
      <slot name="right"></slot>
    </template>
  </van-nav-bar>
</template>

<style lang="scss" scoped>
.van-nav-bar {
  width: 100%;
  position: fixed;
  top: 0;
  --van-nav-bar-icon-color: #333;
  :deep(van-nav-bar__content) {
    .van-nav-bar__title {
      font-weight: 400;
    }
  }
  :deep(.van-nav-bar__left) {
    padding-left: 10px;
    .van-icon {
      font-size: 20px;
    }
  }
}
</style>
