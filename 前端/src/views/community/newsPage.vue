<script setup>
import { ref, onMounted } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import NewsItem from '@/components/NewsItem.vue'
import { getCommentList } from '@/api/comment'
const detail = {
  back: true,
  title: '消息'
}
const commentList = ref([])
const getList = (page, size) => {
  getCommentList(page, size).then((res) => {
    commentList.value = res.data.data.records
  })
}
onMounted(() => {
  getList(1, 20)
})
</script>

<template>
  <HeaderNav :detail="detail" />
  <div class="news">
    <div class="content" v-if="commentList.length > 0">
      <NewsItem
        v-for="item in commentList"
        :key="item.id"
        :item="item"
      ></NewsItem>
    </div>
    <div class="empty" v-else>
      <van-empty image-size="10rem" description="暂无消息" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.news {
  .content {
    font-size: 14px;
    .news-item {
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
  }
}
</style>
