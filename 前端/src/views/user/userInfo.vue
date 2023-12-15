<script setup>
import { ref, onMounted } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import ArticleItem from '@/components/ArticleItem.vue'
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores'
import { getAttentionNum, getArticle, getArticleNum } from '@/api/user'
import { getCreateTime } from '@/utils/format.js'
const userStore = useUserStore()
const { user } = storeToRefs(userStore)
const detail = {
  back: true,
  title: '个人中心'
}
const attention = ref({
  attentionsCount: 0,
  fansCount: 0
})
const articleList = ref([])
const articleNum = ref(0)
const getAttention = () => {
  getAttentionNum().then((res) => {
    attention.value = res.data.data
  })
}
const getArticleList = (page, pageSize) => {
  getArticle(page, pageSize).then((res) => {
    articleList.value = res.data.data.records
  })
}
onMounted(() => {
  getAttention()
  getArticleList(1, 20)
  getArticleNum().then((res) => {
    articleNum.value = res.data.data
  })
})
</script>

<template>
  <HeaderNav :detail="detail" />
  <div class="userInfo">
    <div class="background"></div>
    <div class="user-main">
      <div class="userAvatar">
        <img
          :src="user.avatar || '/src/assets/img/default-avatar.png'"
          alt=""
        />
      </div>
      <div class="more-right">
        <div class="items"><div class="item">编辑个人资料</div></div>
      </div>
      <div class="nickname">
        {{ user.nickname || user.username }}
        <div class="username">@{{ user.username }}</div>
      </div>
      <div class="description">
        {{ user.description || '该用户很懒，暂没有任何介绍' }}
      </div>
      <div class="description">
        <van-icon name="notes-o" />{{ getCreateTime(user.gmtCreate) }}
      </div>
      <div class="attention">
        <div class="item">
          <div class="num">{{ attention.attentionsCount }}</div>
          <div class="text">正在关注</div>
        </div>
        <div class="item">
          <div class="num">{{ attention.fansCount }}</div>
          <div class="text">关注</div>
        </div>
      </div>
    </div>
    <div class="article-list">
      <div v-if="articleList.length > 0">
        <div class="title">文章({{ articleNum }})</div>
        <ArticleItem
          v-for="item in articleList"
          :key="item.id"
          :item="item"
        ></ArticleItem>
      </div>
      <div v-else><van-empty image-size="10rem" description="暂无内容" /></div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.userInfo {
  .background {
    width: 100%;
    height: 160px;
    background: url('@/assets/img/background.jpg') no-repeat;
    background-size: cover;
  }
  .user-main {
    width: 100%;
    position: relative;
    padding: 8px 12px;
    background-color: #fff;
    border-bottom: 1px solid #eee;
    display: flex;
    flex-direction: column;
    .userAvatar {
      margin-top: -42px;
      width: 68px;
      height: 68px;
      border: 2px solid #fff;
      border-radius: 100%;
      overflow: hidden;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .more-right {
      position: absolute;
      top: 12px;
      right: 12px;
      .items {
        display: flex;
        .item {
          padding: 4px 12px;
          border: 1px solid #333;
          font-size: 14px;
          border-radius: 20px;
          background-color: #fff;
          color: #333;
          &.other {
            background-color: #333;
            color: #fff;
          }
        }
      }
    }
    .nickname {
      margin-top: 8px;
      font-size: 20px;
      font-weight: 600;
      display: flex;
      align-items: center;
      .username {
        font-size: 13px;
        color: #888;
        font-weight: 400;
        margin-left: 6px;
      }
    }
    .description {
      font-size: 13px;
      color: #888;
      margin-top: 6px;
      .van-icon {
        margin-right: 4px;
      }
    }
    .attention {
      display: flex;
      font-size: 13px;
      margin-top: 6px;
      .item {
        display: flex;
        align-items: center;
        margin-right: 10px;
        .num {
          color: #333;
        }
        .text {
          color: #888;
          margin-left: 4px;
        }
      }
    }
  }
  .article-list {
    .title {
      padding: 5px 8px;
      font-size: 12px;
      color: #888;
    }
  }
}
</style>
