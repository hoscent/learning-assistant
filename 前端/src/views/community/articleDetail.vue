<script setup>
import { ref, onMounted, computed, watch } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import NewsItem from '@/components/NewsItem.vue'
import { useRoute } from 'vue-router'
import {
  getArticleDetail,
  publishComment,
  getCommentList,
  getCommentCount
} from '@/api/article.js'
import { getTimeDifference } from '@/utils/format.js'
import { showToast } from 'vant'
import { addHistory } from '@/api/user'
import { countView } from '@/api/home.js'
const route = useRoute()
const detail = {
  back: true,
  title: '详情'
}
const articleDetail = ref(null)
const artilceId = route.query.queryId
const countComment = ref(0)
const getArticle = () => {
  getArticleDetail(artilceId).then((res) => {
    const data = res.data.data
    articleDetail.value = data
    console.log(articleDetail.value.content)
    receivedId.value = data.user.id
    addUserHistoy()
    getComment()
    const viewData = {
      targetId: articleDetail.value.id,
      type: 2
    }
    countView(viewData).then((res) => {
      view.value = res.data.data
    })
    getCommentNum()
  })
}
const getCommentNum = () => {
  getCommentCount(articleDetail.value.id).then((res) => {
    countComment.value = res.data.data
  })
}
const view = ref(0)
const addUserHistoy = () => {
  const data = {
    targetId: artilceId,
    type: 2
  }
  addHistory(data)
}
const images = computed(() => {
  const image = articleDetail.value.image.replace(/\[|\]/g, '')
  return image.split(',')
})
const commentList = ref([])
const getComment = () => {
  getCommentList(1, 20, articleDetail.value.id).then((res) => {
    commentList.value = res.data.data.records
  })
}
onMounted(() => {
  getArticle()
})

const isComment = ref(false)
const commentInput = ref(null)
const content = ref('')
const changeHeight = () => {
  commentInput.value.style.height = 'auto'
  if (commentInput.value.scrollHeight < 113) {
    commentInput.value.style.height = commentInput.value.scrollHeight + 'px'
  } else {
    commentInput.value.style.height = '112px'
  }
}
watch(content, () => changeHeight())
const onComment = () => {
  isComment.value = true
}
const offComment = () => {
  if (content.value.trim() === '') {
    isComment.value = false
  }
}
const receivedId = ref(null)
const sendComment = () => {
  const data = {
    cid: 0,
    comment: content.value,
    articleID: articleDetail.value.id,
    receivedId: receivedId.value
  }
  publishComment(data).then((res) => {
    content.value = ''
    showToast(res.data.data)
    getComment()
    getCommentNum()
    offComment()
  })
}
</script>

<template>
  <HeaderNav :detail="detail" />
  <div class="article" v-if="articleDetail">
    <div class="article-title">
      <h1 class="title text-ellipsis-2">{{ articleDetail.title }}</h1>
      <div class="time">{{ getTimeDifference(articleDetail.gmtCreate) }}</div>
      <div class="extra">
        <div class="left">
          <div class="item"><van-icon name="eye-o" />{{ view }}</div>
          <div class="item"><van-icon name="chat-o" />{{ countComment }}</div>
          <div class="item">
            <van-icon name="good-job-o" />{{ articleDetail.praiseNum }}
          </div>
        </div>
        <div class="right">{{ articleDetail.categoryName }}</div>
      </div>
    </div>
    <div class="article-user">
      <div class="avatar">
        <img
          :src="
            articleDetail.user.avatar || '/src/assets/img/default-avatar.png'
          "
          alt=""
        />
      </div>
      <div class="info">
        <div class="name">
          {{ articleDetail.user.nickname || articleDetail.user.username }}
          <div class="ip"><van-tag type="primary">IP:重庆</van-tag></div>
        </div>
        <div class="description">
          {{ articleDetail.user.description || '暂无简介' }}
        </div>
      </div>
    </div>
    <div class="article-main">
      <div class="content" v-html="articleDetail.content"></div>
      <div class="image" v-if="images.length > 0">
        <img v-for="(item, index) in images" :key="index" :src="item" alt="" />
      </div>
    </div>
    <div class="article-comment">
      <div v-if="commentList.length > 0">
        <div class="comment-header">评论({{ countComment }})</div>
        <NewsItem
          :isComment="true"
          v-for="item in commentList"
          :key="item.id"
          :item="item"
        ></NewsItem>
      </div>
      <div v-else>
        <van-empty description="暂无评论" />
      </div>
    </div>
    <div class="article-footer" :class="{ commentShow: isComment }">
      <textarea
        ref="commentInput"
        rows="1"
        placeholder="评论一下"
        v-model="content"
        @focus="onComment"
        @blur="offComment"
      />
      <div class="extra-items">
        <div class="item"><van-icon name="star-o" />收藏</div>
        <div class="item"><van-icon name="good-job-o" />点赞</div>
        <div class="item"><van-icon name="share-o" />转发</div>
      </div>
      <van-button
        @click="sendComment"
        v-show="isComment"
        type="primary"
        size="small"
        >评论</van-button
      >
    </div>
  </div>
  <div v-else>
    <van-empty description="文章不存在或已被删除" />
  </div>
</template>

<style lang="scss" scoped>
.article {
  .article-title {
    background-color: #fff;
    padding: 8px 10px;
    display: flex;
    flex-direction: column;
    border-bottom: 1px solid #eee;
    .title {
      color: #222226;
      font-size: 14px;
      font-weight: 600;
    }
    .time,
    .extra {
      font-size: 12px;
      color: #999;
      margin-top: 4px;
    }
    .extra {
      display: flex;
      justify-content: space-between;
      .left {
        display: flex;
        .item {
          margin-right: 6px;
          .van-icon {
            margin-right: 2px;
          }
        }
      }
    }
  }
  .article-user {
    display: flex;
    align-items: center;
    background-color: #fff;
    padding: 8px 10px;
    border-bottom: 1px solid #eee;
    .avatar {
      width: 38px;
      height: 38px;
      border-radius: 100%;
      overflow: hidden;
      margin-right: 8px;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .info {
      display: flex;
      flex-direction: column;
      justify-content: space-around;
      .name {
        display: flex;
        align-items: center;
        .van-tag {
          color: #666;
          margin-left: 12px;
          background-color: rgba(0, 0, 0, 0.1);
        }
      }
      .description {
        font-size: 12px;
        color: #999;
      }
    }
  }
  .article-main {
    background-color: #fff;
    padding: 8px 10px;
    .content {
      font-size: 14px;
      word-wrap: break-word;
      word-break: break-all;
    }
    .image {
      width: 100%;
      margin-top: 12px;
      display: flex;
      flex-wrap: wrap;
      img {
        border-radius: 4px;
        margin-bottom: 6px;
        width: 32%;
        &:not(:nth-child(3n)) {
          margin-right: 2%;
        }
      }
    }
  }
  .article-comment {
    background-color: #fff;
    margin-top: 8px;
    .comment-header {
      padding: 8px 10px;
      border-bottom: 1px solid #eee;
      font-size: 14px;
    }
  }
  .article-footer {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #fff;
    padding: 8px 10px;
    border-top: 1px solid #eee;
    display: flex;
    align-items: center;
    textarea {
      width: 58%;
      border: none;
      resize: none;
      height: 34px;
      line-height: 16px;
      font-size: 14px;
      padding: 8.6px 10px;
      background-color: #f4f4f4;
      border-radius: 16px;
    }
    .van-button {
      margin-left: 10px;
    }
    .extra-items {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: space-evenly;
      .item {
        display: flex;
        align-items: center;
        flex-direction: column;
        font-size: 12px;
        .van-icon {
          font-size: 16px;
        }
      }
    }
    &.commentShow {
      .extra-items {
        display: none;
      }
      textarea {
        width: auto;
        flex: 1;
      }
    }
  }
}
</style>
