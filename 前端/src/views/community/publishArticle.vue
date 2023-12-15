<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import HeaderNav from '@/components/HeaderNav.vue'
import { pushArticle, getCategoryList } from '@/api/article.js'
import { showToast } from 'vant'
import 'vant/es/toast/style'

const router = useRouter()
const detail = {
  back: true,
  title: '发布文章'
}
const content = ref('')
const articleForm = ref({
  title: '',
  content: '',
  category: '',
  images: []
})
const fieldValue = ref('')
const showPicker = ref(false)
const category = ref([])
const getCategory = () => {
  getCategoryList().then((res) => {
    category.value = res.data.data
    category.value.forEach((item) => {
      item.value = item.id
    })
  })
}
const onConfirm = ({ selectedOptions }) => {
  showPicker.value = false
  fieldValue.value = selectedOptions[0].text
  articleForm.value.category = selectedOptions[0].value
}
onMounted(() => {
  getCategory()
})
const fileList = ref([])
const push = () => {
  if (articleForm.value.title.trim().length <= 0) {
    showToast('请输入标题')
    return
  }
  if (content.value.trim().length <= 0) {
    showToast('请输入内容')
    return
  }
  if (articleForm.value.category <= 0) {
    showToast('请选择分类')
    return
  }
  for (let fileContent of fileList.value) {
    articleForm.value.images.push(fileContent.content)
  }
  articleForm.value.content = content.value.replace(/\n/g, '<br/>')
  pushArticle(articleForm.value).then((res) => {
    showToast(res.data.data)
    router.back()
  })
}
</script>

<template>
  <HeaderNav :detail="detail">
    <template #right>
      <van-button
        @click="push"
        type="primary"
        round
        size="small"
        style="height: 26px"
        >发布</van-button
      >
    </template>
  </HeaderNav>
  <div class="publish">
    <div class="publish-box">
      <div class="title">
        <input type="text" v-model="articleForm.title" placeholder="文章标题" />
      </div>
      <div class="content">
        <van-field
          v-model="fieldValue"
          is-link
          readonly
          label="分类"
          placeholder="选择分类"
          @click="showPicker = true"
          style="margin-bottom: 4px"
        />
        <textarea
          name="article"
          id="article"
          rows="22"
          placeholder="请输入文章内容"
          v-model="content"
        ></textarea>
        <van-popup v-model:show="showPicker" round position="bottom">
          <van-picker
            :columns="category"
            @cancel="showPicker = false"
            @confirm="onConfirm"
          />
        </van-popup>

        <van-uploader v-model="fileList" :max-count="9" multiple />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.publish {
  background-color: #fff;
  width: 100%;
  height: 100%;
  padding: 54px 12px 8px 12px;
  .publish-box {
    width: 100%;
    height: 100%;
    .title {
      border-bottom: 1px solid #eee;
      input {
        width: 100%;
        border: none;
        background-color: transparent;
        height: 40px;
        line-height: 40px;
      }
    }
    .content {
      margin: 0 -6px;
      margin-top: 8px;
      .van-field {
        padding-left: 6px;
        padding-right: 6px;
      }
      textarea {
        font-size: 14px;
        width: 100%;
        resize: none;
        border: none;
        padding: 4px 6px;
      }
      .image {
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
  }
}
</style>
