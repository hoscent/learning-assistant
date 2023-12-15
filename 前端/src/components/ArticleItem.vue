<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { getTimeDifference } from '@/utils/format.js'
import { getCommentCount } from '@/api/article.js'
import { countView } from '@/api/home.js'
const router = useRouter()
const jumpArticle = (articleId) => {
  router.push(`/community/article?queryId=${articleId}`)
}
const prop = defineProps({
  item: Object
})

const images = computed(() => {
  const image = prop.item.image.replace(/\[|\]/g, '')
  return image.split(',')
})
const commentNum = ref(0)
const getComment = async () => {
  const res = await getCommentCount(prop.item.id)
  commentNum.value = res.data.data
}
getComment()

const view = ref(0)
const countV = () => {
  const data = {
    targetId: prop.item.id,
    type: 2
  }
  countView(data).then((res) => {
    view.value = res.data.data
  })
}
countV()
</script>

<template>
  <div class="article-item" @click="jumpArticle(item.id)">
    <div class="left" v-if="images.length === 1 && images[0].trim() != ''">
      <img :src="images[0]" alt="" />
    </div>
    <div class="right">
      <p class="tit text-ellipsis-1">{{ item.title }}</p>
      <div class="info">
        <p class="content text-ellipsis-3">{{ item.content }}</p>
        <div class="image" v-if="images.length > 2">
          <img
            v-for="(item, index) in images.slice(0, 3)"
            :key="index"
            :src="item"
            alt=""
          />
        </div>
        <div class="author">
          <div>
            <van-icon name="user-circle-o" />{{
              item.user.nickname || item.user.username
            }}&nbsp;{{ getTimeDifference(item.gmtCreate) }}
          </div>
          <div class="items">
            <div class="item"><van-icon name="eye-o" />{{ view }}</div>
            <div class="item"><van-icon name="chat-o" />{{ commentNum }}</div>
            <div class="item">
              <van-icon name="good-job-o" />{{ item.praiseNum }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.article-item {
  padding: 10px;
  background-color: #fff;
  display: flex;
  position: relative;
  .left {
    width: 110px;
    height: 110px;
    border-radius: 5px;
    overflow: hidden;
    margin-right: 10px;
    img {
      display: block;
      width: 100%;
      height: 100%;
    }
  }

  .van-icon {
    margin-right: 2px;
  }

  .right {
    flex: 1;
    font-size: 14px;
    line-height: 1.3;
    display: flex;
    flex-direction: column;
    position: relative;
    .tit {
      height: 18.4px;
    }
    .info {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      .author,
      .content {
        color: #999;
        font-size: 12px;
        margin-top: 2px;
      }
      .author {
        margin-top: 4px;
      }
    }
    .image {
      margin-top: 2px;
      width: 100%;
      display: flex;
      justify-content: space-between;
      img {
        width: 110px;
        height: 110px;
        border-radius: 5px;
      }
    }
  }

  :deep(.author) {
    color: #999;
    font-size: 12px;
    display: flex;
    justify-content: space-between;
    .items {
      display: flex;
      align-items: center;
      .item {
        margin-right: 6px;
        .van-icon {
          margin-right: 2px;
        }
      }
    }
  }
}
.article-item:after {
  content: '';
  display: block;
  width: 94%;
  position: absolute;
  bottom: 0;
  border-bottom: 1px solid #eee;
}
</style>
