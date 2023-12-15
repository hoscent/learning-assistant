<script name="home" setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import CardItem from '@/components/CardItem.vue'
import { getSignboard, getResources, getCategory } from '@/api/home'
const router = useRouter()
const banners = ref([])
const navBar = ref([])
const active = ref('recommend')
const jumping = (go) => {
  router.push(go)
}
const getBanner = () => {
  getSignboard(0, 8).then((res) => {
    banners.value = res.data.data
  })
}
const getNavBar = () => {
  getSignboard(1, 10).then((res) => {
    navBar.value = res.data.data
  })
}
const resourcesList = ref([])
const getResourcesList = (type, category) => {
  getResources(1, 20, type, category).then((res) => {
    resourcesList.value = res.data.data.records
  })
}
const catrgoryOption = ref(null)
const categoryList = ref([])
getCategory().then((res) => {
  categoryList.value = res.data.data.map((item) => {
    return {
      text: item.text,
      value: item.id
    }
  })
  categoryList.value.unshift({
    text: '全部',
    value: null
  })
  categoryList.value.push({
    text: '其他',
    value: 0
  })
})

onMounted(() => {
  getBanner()
  getNavBar()
  getResourcesList(null)
})
watch([active, catrgoryOption], ([activeNewVal, categoryNewVal]) => {
  if (activeNewVal === 'recommend') {
    getResourcesList(null, categoryNewVal)
  } else {
    getResourcesList(activeNewVal, categoryNewVal)
  }
})
</script>

<template>
  <!-- 搜索框 -->
  <van-search
    readonly
    shape="round"
    placeholder="请在此输入搜索关键词"
    @click="$router.push('/search')"
  />
  <div class="home">
    <!-- 轮播图 -->
    <div class="my-swipe">
      <van-swipe :autoplay="3000" indicator-color="white">
        <van-swipe-item v-for="(item, index) in banners" :key="index">
          <a :href="item.link">
            <img :src="item.image" alt="" />
          </a>
        </van-swipe-item>
      </van-swipe>
    </div>

    <!-- 导航 -->
    <van-grid class="van-grid" column-num="5" icon-size="40">
      <van-grid-item
        v-for="(item, index) in navBar"
        :key="index"
        :icon="item.image"
        :text="item.title"
        @click="jumping(item.link)"
      />
    </van-grid>

    <van-tabs v-model:active="active" swipeable shrink>
      <van-tab name="recommend" title="推荐"></van-tab>
      <van-tab name="video" title="视频"></van-tab>
      <van-tab name="book" title="书籍"></van-tab>
    </van-tabs>

    <div class="show-list">
      <van-dropdown-menu>
        <van-dropdown-item v-model="catrgoryOption" :options="categoryList" />
      </van-dropdown-menu>

      <div v-if="resourcesList.length > 0">
        <CardItem
          v-for="item in resourcesList"
          :key="item.id"
          :resource="item"
        ></CardItem>
      </div>
      <div v-else>
        <van-empty description="暂无该类资源" />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
// 搜索框样式定制
.van-search {
  position: fixed;
  width: 100%;
  height: 46px;
  border-bottom: 1px solid #eee;
  z-index: 999;
}

.home {
  // 分类导航部分
  .my-swipe {
    padding: 8px;
    background-color: #fff;
    overflow: hidden;
    position: relative;
    .van-swipe {
      border-radius: 8px;
      overflow: hidden;
      .van-swipe-item {
        height: 160px;
        color: #fff;
        font-size: 20px;
        text-align: center;
        img {
          width: 100%;
          height: 160px;
        }
      }
    }
  }

  .van-grid {
    background-color: #fff;
    border-radius: 0 0 8px 8px;
    overflow: hidden;
  }

  .van-tabs {
    top: 4px;
    :deep(.van-tabs__nav) {
      background-color: transparent;
    }
    :deep(.van-tabs__line) {
      display: none;
    }
  }

  .show-list {
    background-color: #fff;
    border-radius: 8px 8px 0 0;
    overflow: hidden;
    .van-dropdown-menu {
      margin-top: 6px;
      :deep(.van-dropdown-menu__bar) {
        height: 20px;
        box-shadow: none;
        .van-dropdown-menu__item {
          justify-content: flex-end;
          margin-right: 20px;
          .van-ellipsis {
            font-size: 12px;
            color: #444;
          }
        }
      }
    }
  }
}
</style>
