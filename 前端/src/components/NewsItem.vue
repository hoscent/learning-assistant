<script setup>
import { ref } from 'vue'
import { getTimeDifference } from '@/utils/format.js'
import { getArticleDetail } from '@/api/article.js'
const props = defineProps({
  isComment: {
    type: Boolean,
    default: false
  },
  item: {
    type: Object
  }
})
const title = ref(null)
getArticleDetail(props.item.articleId).then((res) => {
  title.value = res.data.data.title
})
</script>

<template>
  <div class="news-item">
    <div class="user-avatar">
      <img
        :src="item.user.avatar || '/src/assets/img/default-avatar.png'"
        alt=""
      />
    </div>
    <div class="content-body">
      <div class="user-info">
        <div class="user-name">
          {{ item.user.nickname || item.user.username }}
          <div class="ip" v-if="isComment">
            <van-tag type="primary">IP:重庆</van-tag>
          </div>
        </div>
        <div class="time">{{ getTimeDifference(item.gmtCreate) }}</div>
      </div>
      <div class="history" v-if="!isComment">
        <div class="answer">回复我的文章</div>
        <div class="main">{{ title }}</div>
      </div>
      <div class="main">{{ item.content }}</div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.news-item {
  font-size: 14px;
  padding: 10px 15px;
  background-color: #fff;
  display: flex;
  border-bottom: 1px solid #eee;
  .user-avatar {
    img {
      width: 35px;
      height: 35px;
      border-radius: 100%;
    }
  }
  .content-body {
    display: flex;
    flex-direction: column;
    margin-left: 8px;
    flex: 1;
    .user-info {
      height: 35px;
      display: flex;
      justify-content: center;
      flex-direction: column;
      .user-name {
        display: flex;
        .van-tag {
          color: #666;
          margin-left: 12px;
          background-color: rgba(0, 0, 0, 0.1);
        }
      }
      .time {
        font-size: 12px;
        color: #999;
      }
    }
    .history {
      padding: 10px 8px;
      border-radius: 4px;
      background-color: rgba($color: #555, $alpha: 0.1);
      .answer {
        font-size: 12px;
        color: #999;
      }
      .main {
        color: #555;
      }
    }
    .main {
      margin-top: 8px;
    }
  }
}
</style>
