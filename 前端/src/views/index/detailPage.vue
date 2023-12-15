<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import { useRoute } from 'vue-router'
import { showToast } from 'vant'
import 'vant/es/toast/style'
import { getResourcesDetail, getCollectionList } from '@/api/home'
import { addRecord } from '@/api/study'
import { addHistory } from '@/api/user'
import PDF from 'pdf-vue3'
import { padZero } from '@/utils/format'
import { addUserNote } from '@/api/notebook'
const route = useRoute()
const detail = {
  back: true,
  title: '详情'
}
const time = ref(0)
const seconds = ref(0)
const addTime = setInterval(() => {
  seconds.value++
  if (seconds.value >= 60) {
    time.value++
    seconds.value = 0
  }
}, 1000)
onBeforeUnmount(() => {
  clearInterval(addTime)
  if (seconds.value > 30) time.value++
  const data = {
    subject: resourceBody.value.tabs,
    time: time.value
  }
  addRecord(data)
})
const resourceBody = ref({})
const resourcesDetail = () => {
  getResourcesDetail(route.query.id).then((res) => {
    resourceBody.value = res.data.data
    addUserHistory()
    if (resourceBody.value.type === 'video') {
      getCollection()
    }
  })
}
const changeDetail = (id) => {
  getResourcesDetail(id).then((res) => {
    resourceBody.value = res.data.data
    addUserHistory()
  })
}

const addUserHistory = () => {
  const data = {
    targetId: route.query.id,
    type: resourceBody.value.type === 'book' ? 0 : 1
  }
  addHistory(data)
}
onMounted(() => {
  resourcesDetail()
})
const showShare = ref(false)
const options = [
  { name: '微信', icon: 'wechat' },
  { name: 'QQ', icon: 'qq' },
  { name: '复制链接', icon: 'link' }
]

const onSelect = (option) => {
  showToast('分享成功')
  console.log(option.name)
  showShare.value = false
}

const isCollection = ref(false)
const collectionList = ref([])
const collectionDescription = ref('')
const getCollection = () => {
  if (resourceBody.value.collectionId > 0) {
    isCollection.value = true
    getCollectionList(resourceBody.value.collectionId).then((res) => {
      collectionList.value = res.data.data
      collectionDescription.value =
        collectionList.value.collection.description + '<br>'
    })
  }
}
const bookMoreShow = ref(false)
const noteActionShow = ref(false)
const noteContent = ref(null)
const addNote = () => {
  const data = {
    title: '未命名笔记-' + noteContent.value.slice(0, 10),
    content: noteContent.value,
    text: noteContent.value
  }
  addUserNote(data).then(() => {
    noteActionShow.value = false
    bookMoreShow.value = false
    noteContent.value = ''
  })
}
</script>

<template>
  <HeaderNav :detail="detail">
    <template v-if="resourceBody.type === 'book'" #right
      ><van-icon
        style="font-size: 20px"
        @click="bookMoreShow = true"
        name="ellipsis"
    /></template>
  </HeaderNav>
  <div class="detail">
    <div v-if="resourceBody.type === 'book'">
      <div class="book">
        <div class="book-info">
          <div class="cover">
            <img :src="resourceBody.cover" alt="" />
          </div>
          <h3 class="title">{{ resourceBody.title }}</h3>
          <div class="author">作者：{{ resourceBody.author }}</div>
        </div>
        <div class="description">
          <div class="introduction">
            简介<van-tag type="primary">{{ resourceBody.tabs }}</van-tag>
          </div>
          <div class="introduction-main">{{ resourceBody.description }}</div>
        </div>
      </div>
      <PDF :src="resourceBody.path"></PDF>
      <van-action-sheet v-model:show="bookMoreShow">
        <van-grid>
          <van-grid-item icon="star-o" text="添加收藏" />
          <van-grid-item
            icon="records-o"
            @click="noteActionShow = true"
            text="添加笔记"
          />
        </van-grid>
      </van-action-sheet>
    </div>
    <div v-else>
      <video
        :poster="resourceBody.cover"
        :src="resourceBody.path"
        style="width: 100%; height: 200px; background-color: #000"
        autoplay
        controls
      ></video>
      <div class="video-main">
        <div class="header">简介</div>
        <div class="title">{{ resourceBody.title }}</div>
        <div class="other">
          <div class="author">
            <van-icon name="user-circle-o" />{{ resourceBody.author }}
          </div>
          <div class="description">
            <span v-if="isCollection" v-html="collectionDescription"></span>
            {{ resourceBody.description }}
          </div>
        </div>
        <div class="episodes" v-if="isCollection">
          <div class="point">选集</div>
          <div class="episodes-box">
            <div
              class="episodes-item"
              v-for="item in collectionList.resources"
              :key="item.id"
              @click="changeDetail(item.id)"
              :class="{ active: item.id === resourceBody.id }"
            >
              <div class="text-ellipsis-2">
                {{ padZero(item.episodes) }} {{ item.title }}
              </div>
            </div>
          </div>
        </div>
        <div class="items">
          <div class="item">
            <van-icon name="star-o" />
            <div class="name">收藏</div>
          </div>
          <div class="item" @click="showShare = true">
            <van-icon name="share-o" />
            <div class="name">分享</div>
          </div>
          <div class="item" @click="noteActionShow = true">
            <van-icon name="records-o" />
            <div class="name">添加笔记</div>
          </div>
        </div>
        <van-share-sheet
          v-model:show="showShare"
          title="立即分享给好友"
          :options="options"
          @select="onSelect"
        />
      </div>
    </div>
  </div>
  <van-action-sheet v-model:show="noteActionShow" title="添加笔记">
    <div class="content">
      <textarea rows="5" class="notes" v-model="noteContent"></textarea>
      <van-button type="primary" round block @click="addNote">添加</van-button>
    </div>
  </van-action-sheet>
</template>

<style lang="scss" scoped>
.detail {
  background-color: #fff;
  .book {
    width: 100vw;
    height: calc(100vh - 46px);
    background-color: #fceac2;
    display: flex;
    flex-direction: column;
    .book-info {
      padding-top: 16px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      .cover {
        width: 110px;
        height: 140px;
        border-radius: 4px;
        overflow: hidden;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .title {
        font-weight: 400;
        margin-top: 12px;
      }
      .author {
        display: flex;
        align-items: center;
        margin-top: 12px;
        font-size: 13px;
      }
    }
    .description {
      flex: 1;
      margin-top: 12px;
      background-color: #fcf5e6;
      padding: 12px 28px;
      .introduction {
        font-size: 16px;
        font-weight: 600;
        display: flex;
        align-items: center;
        .van-tag {
          color: #666;
          margin-left: 12px;
          background-color: rgba(0, 0, 0, 0.1);
        }
      }
      .introduction-main {
        margin-top: 10px;
        font-size: 14px;
        line-height: 24px;
        color: #666;
      }
    }
  }
  .video-main {
    background-color: #fff;
    display: flex;
    flex-direction: column;
    .header {
      color: #1989fa;
      padding: 8px 0;
      padding-left: 12px;
      font-size: 14px;
      border-bottom: 1px solid #eee;
    }
    .title {
      font-size: 16px;
      color: #000;
      display: flex;
      flex-direction: column;
      padding: 12px;
      padding-bottom: 4px;
    }
    .other {
      padding-left: 12px;
      padding-right: 12px;
      display: flex;
      flex-direction: column;
      font-size: 13px;
      color: #888;
      div {
        display: flex;
        align-items: center;
        padding-bottom: 4px;
        &.description {
          flex-direction: column;
          align-items: start;
        }
      }
      .van-icon {
        margin-top: 2px;
        font-size: 14px;
        margin-right: 4px;
      }
    }
    .episodes {
      margin-top: 4px;
      .point {
        font-size: 12px;
        padding: 0 12px;
      }
      .episodes-box {
        display: flex;
        padding: 8px 12px;
        padding-top: 4px;
        overflow-x: auto !important;
        &::-webkit-scrollbar {
          display: none;
        }
        .episodes-item {
          width: 80px;
          height: 40px;
          border-radius: 4px;
          flex-shrink: 0;
          background-color: #f5f5f5;
          font-size: 12px;
          padding: 4px 6px;
          display: flex;
          align-items: center;
          &:not(:last-child) {
            margin-right: 8px;
          }
        }
        .episodes-item.active {
          color: #1989fa;
        }
      }
    }
    .items {
      padding: 12px;
      display: flex;
      align-items: center;
      .item {
        width: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        .van-icon {
          font-size: 26px;
        }
        .name {
          font-size: 14px;
        }
      }
      .item:hover {
        background-color: rgba($color: #000000, $alpha: 0.1);
      }
    }
  }
}
.content {
  padding: 12px 12px 10px;
  .notes {
    width: 100%;
    border-radius: 8px;
    padding: 4px 6px;
    border: 2px solid #f5f5f5;
    resize: none;
    margin-bottom: 6px;
  }
}
</style>
