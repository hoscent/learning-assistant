<script setup>
import { ref } from 'vue'
const active = ref(0)
</script>

<template>
  <div>
    <router-view v-slot="{ Component }">
      <keep-alive :include="['home', 'community']">
        <component :is="Component" />
      </keep-alive>
    </router-view>
    <van-tabbar v-model="active" inactive-color="#000" route>
      <van-tabbar-item to="/home" icon="wap-home-o">首页</van-tabbar-item>
      <van-tabbar-item to="/study"
        ><i class="iconfont icon-xuexiyuandi"></i>学习</van-tabbar-item
      >
      <van-tabbar-item to="/community" icon="smile-comment-o"
        >社区</van-tabbar-item
      >
      <van-tabbar-item to="/user" icon="user-o">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>
