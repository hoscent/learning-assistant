<script name="community" setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import ArticleItem from '@/components/ArticleItem.vue'
import { getCategoryList, getArticleList } from '@/api/article.js'
import { getCommentNum } from '@/api/comment'
const active = ref('recommend')
const router = useRouter()
const category = ref([])
const getCategory = () => {
  getCategoryList().then((res) => {
    category.value = res.data.data
  })
}
const articleList = ref([])
const getArticle = (categoryId) => {
  getArticleList(1, 20, categoryId).then((res) => {
    articleList.value = res.data.data.records
  })
}
const notReadComment = ref(0)
onMounted(() => {
  getCategory()
  getArticle(active.value)
  getCommentNum().then((res) => {
    notReadComment.value = res.data.data
  })
})
watch(active, (newVal) => {
  getArticle(newVal)
})
</script>

<template>
  <!-- 搜索框 -->
  <div class="search">
    <van-search
      readonly
      shape="round"
      placeholder="请在此输入搜索关键词"
      @click="$router.push('/search')"
    >
    </van-search>
    <i
      @click="$router.push('/community/news')"
      class="iconfont icon-notice"
      style="margin-top: 10px; font-size: 22px"
    ></i>
    <van-badge
      :content="notReadComment"
      v-show="notReadComment > 0"
      max="99"
      @click="router.push('/news')"
    >
    </van-badge>
  </div>
  <div class="community">
    <div style="width: 100%; height: 100%">
      <van-tabs v-model:active="active">
        <van-tab name="attention" title="关注"></van-tab>
        <van-tab name="recommend" title="推荐"></van-tab>
        <van-tab
          v-for="item in category"
          :key="item.id"
          :name="item.id"
          :title="item.text"
        ></van-tab>
      </van-tabs>
      <div class="show-list" v-if="articleList.length > 0">
        <ArticleItem
          v-for="item in articleList"
          :key="item.id"
          :item="item"
        ></ArticleItem>
      </div>
      <div class="empty" v-else>
        <van-empty image-size="10rem" description="暂无内容" />
        <van-button
          v-show="active !== 'attention'"
          type="default"
          round
          size="small"
          @click="router.push('/community/publish')"
          >发布第一篇</van-button
        >
      </div>
      <div class="publish" @click="router.push('/community/publish')">
        <van-icon name="plus" />
      </div>
      <van-back-top bottom="19vh" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.search {
  position: fixed;
  width: 100%;
  height: 46px;
  background-color: #fff;
  border-bottom: 1px solid #eee;
  display: flex;
  align-items: center;
  z-index: 999;
  .van-search {
    padding-right: 0;
    height: 45px;
    flex: 1;
    :deep(.van-search__action) {
      padding: 0 16px;
    }
  }
  .iconfont {
    padding: 0 15px;
  }
  .van-badge {
    &.van-badge--top-right {
      position: absolute;
      transform: translate(-20%, 30%);
    }
  }
}
.community {
  .show-list {
    background-color: #fff;
    overflow: hidden;
    word-break: break-all;
  }
  .empty {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .publish {
    position: fixed;
    right: 30px;
    bottom: 80px;
    border-radius: 100%;
    background-color: #1989fa;
    padding: 10px;
    cursor: pointer;
    display: flex;
    align-items: center;
    .van-icon {
      color: #fff;
      font-size: 20px;
      font-weight: bold;
    }
  }
}
</style>
