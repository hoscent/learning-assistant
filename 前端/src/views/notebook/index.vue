<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import {
  getNotesList,
  getClassList,
  deleteUserNote,
  addUserClass
} from '@/api/notebook'
import { showToast } from 'vant'
import 'vant/es/toast/style'
import { getDate } from '@/utils/format'
import { nextTick } from 'vue'
const router = useRouter()
const addShow = ref(false)
const categoryShow = ref(false)
const handleOutsideClick = (event) => {
  if (!event.target.closest('.openMenu')) {
    addShow.value = false
  }
  if (!event.target.closest('.category')) {
    categoryShow.value = false
  }
}
onMounted(() => {
  document.addEventListener('click', handleOutsideClick)
})
onBeforeUnmount(() => {
  document.removeEventListener('click', handleOutsideClick)
})
const addClassShow = ref(false)
const className = ref(null)
const orginalClass = [
  {
    text: '全部笔记',
    value: null
  },
  {
    text: '未分类',
    value: 0
  }
]
const classList = ref([])
const addClass = () => {
  addUserClass(className.value).then((res) => {
    if (res.data.data == true) {
      showToast('添加成功')
      addClassShow.value = false
      className.value = null
      getClass()
    }
  })
}
const getClass = () => {
  classList.value = [...orginalClass]
  getClassList().then((res) => {
    const data = res.data.data
    if (data.length > 0) {
      const newData = data.map((item) => {
        return {
          text: item.title,
          value: item.id
        }
      })
      newData.forEach((item) => {
        classList.value.push(item)
      })
    }
  })
}
const currentClass = ref({
  text: '全部笔记',
  value: null
})
const selectClass = (item) => {
  currentClass.value.text = item.text
  currentClass.value.value = item.value
}
const notesList = ref([])
const getNotes = () => {
  getNotesList().then((res) => {
    notesList.value = res.data.data
  })
}
const deleteNote = (id) => {
  nextTick(() => {
    deleteUserNote(id).then(() => {
      showToast('删除成功')
      notesList.value = notesList.value.filter((item) => {
        return item.id != id
      })
    })
  })
}
const visitNote = (id) => {
  router.push({
    path: '/user/notebook/edit',
    query: {
      id: id
    }
  })
}
onMounted(() => {
  getClass()
  getNotes()
})
</script>
<template>
  <div class="notebook">
    <div class="notebook-header">
      <div class="left">
        <van-icon @click="router.back()" name="arrow-left" />
        <img
          src="https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/other/notes.png"
          alt=""
        />
        <div class="desc">
          <div class="title">Notes</div>
          <div class="category" @click="categoryShow = !categoryShow">
            <div class="text">{{ currentClass.text }}</div>
            <van-icon name="arrow" />
          </div>
        </div>
        <div class="category-menu" :class="{ show: categoryShow }">
          <div
            class="menu-item"
            v-for="item in classList"
            :key="item.text"
            @click="selectClass(item)"
          >
            {{ item.text }}
          </div>
        </div>
      </div>
      <div class="right">
        <div class="go-item openMenu" @click="addShow = !addShow">
          <van-icon name="plus" />
        </div>
        <div class="go-item"><van-icon name="thumb-circle-o" /></div>
        <div class="go-item"><van-icon name="search" /></div>
        <div class="card-box" :class="{ show: addShow }">
          <div class="card-item" @click="addClassShow = true">新建笔记本</div>
          <div class="card-item" @click="router.push('/user/notebook/edit')">
            添加笔记
          </div>
        </div>
      </div>
    </div>
    <div class="notebook-list">
      <div v-if="notesList.length > 0">
        <van-swipe-cell v-for="item in notesList" :key="item.id">
          <div class="notebook-item" @click="visitNote(item.id)">
            <div class="title">{{ item.title }}</div>
            <div class="content text-ellipsis-1">{{ item.text }}</div>
            <van-tag type="primary">{{ getDate(item.gmtModified) }}</van-tag>
          </div>
          <template #right>
            <van-button
              square
              @click="deleteNote(item.id)"
              text="删除"
              type="danger"
              class="delete-button"
            />
          </template>
        </van-swipe-cell>
      </div>
      <div style="height: 100vh" v-else>
        <van-empty description="暂无笔记" />
      </div>
    </div>
    <van-action-sheet v-model:show="addClassShow" title="新建笔记本">
      <div class="content">
        <input type="text" v-model="className" placeholder="笔记本名称" />
        <van-button type="primary" round block @click="addClass"
          >添加</van-button
        >
      </div>
    </van-action-sheet>
  </div>
</template>

<style lang="scss" scoped>
.notebook {
  width: 100%;
  height: 100%;
  position: relative;
  background-color: #fff;
  .notebook-header {
    width: 100%;
    height: 54px;
    padding: 6px 8px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: fixed;
    top: 0;
    background-color: #fff;
    z-index: 99;
    .left {
      display: flex;
      align-items: center;
      position: relative;
      .van-icon {
        font-size: 24px;
        margin-right: 8px;
      }
      img {
        width: 36px;
        height: 36px;
      }
      .desc {
        margin-left: 4px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        font-weight: bold;
        .title {
          font-size: 13px;
        }
        .category {
          width: 140px;
          display: flex;
          font-size: 16px;
          align-items: center;
          .van-icon {
            top: 1px;
            font-size: 14px;
          }
        }
      }
      .category-menu {
        transform: scaleY(0);
        transform-origin: top;
        position: absolute;
        border: 1px solid #f5f5f5;
        box-shadow: #f5f5f5 0px 0px 10px;
        padding: 8px 0;
        background-color: #fff;
        left: 62px;
        top: 40px;
        border-radius: 6px;
        transition: transform 0.3s ease-in-out;
        &.show {
          transform: scaleY(1);
        }
        .menu-item {
          font-size: 14px;
          font-weight: 400;
          height: 32px;
          line-height: 32px;
          padding: 0 16px;
          &:hover {
            background-color: #f5f5f5;
          }
        }
      }
    }
    .right {
      display: flex;
      align-items: center;
      position: relative;
      flex-direction: row-reverse;
      flex: 1;
      .go-item {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        .van-icon {
          font-size: 20px;
        }
      }
      .card-box {
        position: absolute;
        top: 34px;
        right: 10px;
        border-radius: 6px;
        border: 1px solid #f5f5f5;
        box-shadow: #f5f5f5 0px 0px 10px;
        display: flex;
        flex-direction: column;
        padding: 8px 0;
        background-color: #fff;
        scale: 0;
        transition: scale 0.3s ease-in-out;
        transform-origin: top right;
        &.show {
          scale: 1;
        }
        .card-item {
          font-size: 14px;
          height: 32px;
          line-height: 32px;
          padding: 0 20px;
          &:hover {
            background-color: #f5f5f5;
          }
        }
      }
    }
  }
  .notebook-list {
    padding-top: 54px;
    .notebook-item {
      padding: 10px 0;
      margin: 0 8px;
      background-color: #fff;
      &:not(:last-child) {
        border-bottom: 2px solid #f6f6f6;
      }
      div:not(:last-child) {
        margin-bottom: 2px;
      }
      .title {
        font-size: 16px;
        font-weight: bold;
      }
      .content {
        font-size: 14px;
        color: #888;
      }
      .van-tag {
        color: #808080;
        background: #f5f5f5;
        border-radius: 4px;
      }
    }
    .delete-button {
      height: 100%;
    }
  }
  .van-action-sheet {
    .content {
      padding: 16px 16px 50px;
      input {
        width: 100%;
        height: 40px;
        padding: 4px 6px;
        border-radius: 8px;
        border: 2px solid #f5f5f5;
        margin-bottom: 16px;
      }
    }
  }
}
</style>
