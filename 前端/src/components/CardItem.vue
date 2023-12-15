<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { dateFormat } from '@/utils/format.js'
import { countView } from '@/api/home.js'
const prop = defineProps({
  resource: {
    type: Object
  }
})
const router = useRouter()
const jumpRouter = (type, id) => {
  if (type) {
    router.push(`/home/detail?type=video&id=${id}`)
  } else {
    router.push(`/home/detail?type=text&id=${id}`)
  }
}
const view = ref(0)
const countV = () => {
  const data = {
    targetId: prop.resource.id,
    type: prop.resource.type === 'video' ? 1 : 0
  }
  countView(data).then((res) => {
    view.value = res.data.data
  })
}
countV()
</script>

<template>
  <div
    class="card-item"
    :class="{ video: resource.type === 'video' }"
    @click="jumpRouter(resource.type === 'video', resource.id)"
  >
    <div class="left">
      <img :src="resource.cover" alt="" />
    </div>
    <div class="right">
      <p class="tit text-ellipsis-2">
        <van-tag color="rgb(209 209 209)">{{
          resource.type == 'book' ? '书籍' : '视频'
        }}</van-tag
        >{{ resource.title }}
      </p>
      <div class="bottom">
        <p v-if="resource.type === 'book'">
          <van-tag round type="primary">{{ resource.tabs }}</van-tag>
        </p>
        <p class="author">
          <van-icon name="user-circle-o" />{{ resource.author }}
        </p>
        <p v-if="resource.type === 'book'" class="content text-ellipsis-1">
          {{ resource.description }}
        </p>
        <p class="content text-ellipsis-1" v-if="resource.type === 'video'">
          <van-icon name="video-o" />{{ view }} ·
          {{ dateFormat(resource.gmtCreate) }}
        </p>
      </div>
      <van-button
        @click="jumpRouter(resource.type === 'video', resource.id)"
        v-if="resource.type === 'book'"
        round
        size="small"
        type="primary"
        >阅读</van-button
      >
    </div>
  </div>
</template>

<style lang="scss" scoped>
.card-item {
  height: 130px;
  padding: 10px;
  background-color: #fff;
  display: flex;
  border-bottom: 1px solid #eee;
  .left {
    width: 90px;
    height: 100%;
    border-radius: 5px;
    overflow: hidden;
    img {
      display: block;
      width: 100%;
      height: 100%;
    }
  }

  .van-icon {
    margin-right: 2px;
  }
  .van-tag {
    margin-right: 4px;
  }

  .right {
    flex: 1;
    font-size: 14px;
    line-height: 1.3;
    padding: 5px 10px;
    display: flex;
    flex-direction: column;
    position: relative;
    .tit {
      height: 36.4px;
    }
    .bottom {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      .author,
      .content {
        color: #999;
        font-size: 13px;
        padding-right: 76px;
      }
    }
    .van-button {
      position: absolute;
      bottom: 0;
      right: 0;
      height: 28px;
      padding: 0 24px;
    }
  }
}
.card-item.video {
  height: 110px;
  .left {
    height: 90px;
    width: 140px;
  }
  .bottom {
    justify-content: end;
  }
}
</style>
