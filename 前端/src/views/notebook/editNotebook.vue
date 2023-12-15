<script setup>
import { ref } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'
import { addUserNote, getNoteDetail, updateNote } from '@/api/notebook'
import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()
const getDetail = () => {
  if (route.query.id > 0) {
    getNoteDetail(route.query.id).then((res) => {
      noteTitle.value = res.data.data.title
      quill.value.setHTML(res.data.data.content)
    })
  }
}
getDetail()
const detail = {
  back: true,
  title: '编辑笔记'
}
const noteTitle = ref('')
const quill = ref(null)
const options = {
  modules: {
    toolbar: [
      // 加粗 斜体 下划线 删除线 -----['bold', 'italic', 'underline', 'strike']
      // 引用  代码块-----['blockquote', 'code-block']
      // 1、2 级标题-----[{ header: 1 }, { header: 2 }]
      // 有序、无序列表-----[{ list: 'ordered' }, { list: 'bullet' }]
      // 上标/下标-----[{ script: 'sub' }, { script: 'super' }]
      // 文本方向-----[{'direction': 'rtl'}]
      // 字体大小-----[{ size: ['small', false, 'large', 'huge'] }]
      // 标题-----[{ header: [1, 2, 3, 4, 5, 6, false] }]
      // 字体颜色、字体背景颜色-----[{ color: [] }, { background: [] }]
      // 字体种类-----[{ font: [] }]
      // 对齐方式-----[{ align: [] }]
      // 清除文本格式-----['clean']
      // 链接、图片、视频-----['link', 'image', 'video']
      [
        'bold',
        'italic',
        'underline',
        'strike',
        'blockquote',
        'code-block',
        { header: 1 },
        { header: 2 },
        { list: 'ordered' },
        { list: 'bullet' },
        { script: 'sub' },
        { script: 'super' },
        { direction: 'rtl' },
        { size: ['small', false, 'large', 'huge'] },
        { header: [1, 2, 3, 4, 5, 6, false] },
        { color: [] },
        { background: [] },
        { font: [] },
        { align: [] },
        'clean',
        'link'
      ]
    ]
  },
  readOnly: false
}
const editNote = () => {
  const data = {
    title: noteTitle.value,
    content: quill.value.getHTML(),
    text: quill.value.getText()
  }
  if (route.query.id > 0) {
    data.id = route.query.id
    updateNote(data)
  } else {
    addUserNote(data).then(() => {
      router.back()
    })
  }
}
</script>

<template>
  <HeaderNav :detail="detail">
    <template #right>
      <van-icon @click="editNote" style="font-size: 20px" name="success" />
    </template>
  </HeaderNav>
  <div class="edit-notes">
    <div class="note-box">
      <div class="title-box">
        <input type="text" placeholder="标题" v-model="noteTitle" />
      </div>
      <div class="note-content">
        <QuillEditor ref="quill" :options="options"></QuillEditor>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.edit-notes {
  overflow-y: unset;
  width: 100%;
  height: 100vh;
  background-color: #fff;
  .note-box {
    width: 100%;
    height: 100%;
    overflow-y: auto;
    .title-box {
      padding: 4px 10px;
      input {
        width: 100%;
        height: 36px;
        border: none;
        font-weight: bold;
      }
    }
    :deep(.note-content) {
      height: 100%;
      padding-bottom: 10px;
      .ql-toolbar.ql-snow {
        height: 26px;
        padding: 0;
        margin: 0 4px;
        border: none;
        border-bottom: 2px solid #f5f5f5;
        display: flex;
        overflow-x: auto;
        position: sticky;
        top: 0;
        background: #fff;
        z-index: 99;
        &::-webkit-scrollbar {
          display: none;
        }
        .ql-formats {
          flex-shrink: 0;
          display: flex;
        }
      }
      .ql-container.ql-snow {
        border: none;
        padding: 0 10px;
        font-size: 14px;
        .ql-editor {
          padding: 0;
          padding-top: 10px;
        }
      }
    }
  }
}
</style>
