<script name="user" setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores'
import { storeToRefs } from 'pinia'
import { getAttentionNum } from '@/api/user'
const router = useRouter()
const userStore = useUserStore()
const { user } = storeToRefs(userStore)
const attention = ref({
  attentionsCount: 0,
  fansCount: 0
})
const getAttention = () => {
  getAttentionNum().then((res) => {
    attention.value = res.data.data
  })
}
onMounted(() => {
  getAttention()
})
</script>
<template>
  <div class="user">
    <div class="header">
      <van-icon
        @click="router.push('/user/setting')"
        class="setting"
        name="setting-o"
      />
      <div class="head-page" @click="router.push('/user/info')">
        <div class="head-user">
          <div class="head-img">
            <img
              :src="user.avatar || '/src/assets/img/default-avatar.png'"
              alt=""
            />
          </div>
          <div class="info">
            <div class="mobile">{{ user.nickname || user.username }}</div>
            <div class="study">初学者</div>
          </div>
        </div>
        <div class="shelter"></div>
      </div>

      <div class="my-asset">
        <div class="asset">
          <div class="asset-item">
            <span>{{ attention.attentionsCount }}</span>
            <span>关注</span>
          </div>
          <div class="sliper"></div>
          <div class="asset-item">
            <span>{{ attention.fansCount }}</span>
            <span>粉丝</span>
          </div>
        </div>
      </div>
    </div>
    <div class="ability-navbar">
      <div class="ability-navbar-item">
        <van-icon name="clock-o" />
        <span>浏览历史</span>
      </div>
      <div class="ability-navbar-item">
        <van-icon name="star-o" />
        <span>收藏夹</span>
      </div>
      <div class="ability-navbar-item" @click="router.push('/user/notebook')">
        <van-icon name="records-o" />
        <span>笔记</span>
      </div>
    </div>

    <div class="service">
      <div class="title">我的服务</div>
      <div class="content">
        <div class="content-item">
          <van-icon name="question-o" />
          <span>帮助</span>
        </div>
        <div class="content-item">
          <van-icon name="envelop-o" />
          <span>意见反馈</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.user {
  min-height: 100vh;
  background-color: #f7f7f7;
  padding-bottom: 50px;
}

.header {
  height: 154px;
  position: relative;
  .setting {
    position: absolute;
    right: 15px;
    top: -34px;
    font-size: 20px;
    color: #666;
    z-index: 5;
  }
  .head-page {
    height: 130px;
    background-image: url('http://cba.itlike.com/public/mweb/static/background/user-header2.png');
    background-size: cover;
    background-repeat: no-repeat;
    position: relative;
    .head-user {
      position: relative;
      display: flex;
      top: 28px;
      z-index: 5;
      .head-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        overflow: hidden;
        margin: 0 10px;
        img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }
      }
    }
    .shelter {
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0;
      height: 100px;
      background: linear-gradient(
        to bottom,
        rgba(255, 255, 255, 0),
        rgba(244, 244, 244, 1)
      );
      z-index: 1;
    }
  }

  .info {
    z-index: 5;
    .mobile {
      margin-bottom: 5px;
      color: #c59a46;
      font-size: 16px;
      font-weight: bold;
    }
    .study {
      display: inline-block;
      background-color: #3c3c3c;
      padding: 3px 5px;
      border-radius: 5px;
      color: #e0d3b6;
      font-size: 12px;
    }
  }

  .my-asset {
    position: absolute;
    top: 100px;
    left: 10px;
    right: 10px;
    display: flex;
    padding: 6px 0;
    border-radius: 8px;
    font-size: 14px;
    background-color: #fff;
    z-index: 5;
    .asset {
      display: flex;
      justify-content: space-evenly;
      flex: 3;
      .asset-item {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        span:first-child {
          margin-bottom: 5px;
          font-size: 16px;
        }
      }
    }
    .sliper {
      width: 1px;
      background-color: #ccc;
    }
  }
}

.ability-navbar {
  margin-top: 50px;
  display: flex;
  padding: 15px 0;
  margin: 10px;
  font-size: 14px;
  background-color: #fff;
  border-radius: 5px;
  .ability-navbar-item {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 25%;
    .van-icon {
      font-size: 24px;
      margin-bottom: 5px;
    }
  }
}

.service {
  font-size: 14px;
  background-color: #fff;
  border-radius: 5px;
  margin: 10px;
  .title {
    color: #888;
    height: 40px;
    line-height: 40px;
    padding: 0 15px;
    font-size: 12px;
  }
  .content {
    display: flex;
    justify-content: flex-start;
    flex-wrap: wrap;
    font-size: 14px;
    background-color: #fff;
    border-radius: 5px;
    .content-item {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      width: 25%;
      margin-bottom: 20px;

      .van-icon {
        font-size: 24px;
        margin-bottom: 5px;
      }
    }
  }
}
</style>
