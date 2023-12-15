<script setup>
import { ref, watch, onMounted, nextTick } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import { withCall } from '@/api/chat.js'
import { lineFormat, markdownFormat } from '@/utils/format.js'
import { useChatStore, useUserStore } from '@/stores/index.js'
const chatStore = useChatStore()
const userStore = useUserStore()
const detail = {
  back: true,
  title: '小智AI'
}
const textarea = ref(null)
const chatMain = ref(null)
const input = ref(null)
const content = ref('')
const changeHeight = () => {
  textarea.value.style.height = 'auto'
  if (textarea.value.scrollHeight < 113) {
    textarea.value.style.height = textarea.value.scrollHeight + 'px'
  } else {
    textarea.value.style.height = '112px'
  }
  chatMain.value.style.paddingBottom = input.value.offsetHeight + 1 + 'px'
}
watch(content, () => changeHeight())
const isRespose = ref(false)
const send = () => {
  isRespose.value = true
  let identity = {
    target: 'person',
    src: userStore.user.avatar || '/src/assets/img/default-avatar.png'
  }
  let question = content.value
  addMessage(question, identity)
  nextTick(() => {
    content.value = null
    textarea.value.value = null
  })
  changeHeight()
  withCall(question)
    .then((res) => {
      identity.target = 'robot'
      identity.src =
        'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/robot.png'
      addMessage(lineFormat(markdownFormat(res.data.data)), identity)
      isRespose.value = false
      chatStore.addHistory({
        person: question,
        robot: lineFormat(markdownFormat(res.data.data))
      })
    })
    .catch((err) => {
      identity.target = 'robot'
      identity.src =
        'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/robot.png'
      addMessage('请求错误，请联系管理员<br />' + err, identity)
      isRespose.value = false
      chatStore.addHistory({
        person: question,
        robot: '请求错误，请联系管理员<br />' + err
      })
    })
}

const isShow = ref(true)
const addMessage = (message, identity) => {
  isShow.value = false
  const newElement = document.createElement('div')
  newElement.className = `message ${identity.target}`

  const avatarElement = document.createElement('div')
  avatarElement.className = 'avatar'

  const imgElement = document.createElement('img')
  imgElement.src = identity.src

  avatarElement.appendChild(imgElement)
  newElement.appendChild(avatarElement)

  const messageBoxElement = document.createElement('div')
  messageBoxElement.className = 'message-box'

  const textElement = document.createElement('div')
  textElement.className = 'text'
  textElement.innerHTML = message

  messageBoxElement.appendChild(textElement)
  newElement.appendChild(messageBoxElement)

  chatMain.value.firstElementChild.appendChild(newElement)
  chatMain.value.firstElementChild.scrollTop = chatMain.value.scrollHeight
}

const initMessage = () => {
  if (chatStore.history.length > 0) {
    isShow.value = false
    for (const message of chatStore.history) {
      let identity = {
        target: 'person',
        src: userStore.user.avatar || '/src/assets/img/default-avatar.png'
      }
      addMessage(message.person, identity)
      identity.target = 'robot'
      identity.src =
        'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/robot.png'
      addMessage(message.robot, identity)
    }
    chatMain.value.firstElementChild.scrollTop = chatMain.value.scrollHeight
  }
}
onMounted(() => {
  isShow.value = chatMain.value.firstElementChild.innerHTML.trim() === ''
  initMessage()
})
</script>

<template>
  <HeaderNav style="z-index: 9" :detail="detail" />
  <div class="chat">
    <div class="chat-box">
      <div class="background"></div>
      <div class="content" ref="chatMain">
        <div class="main"></div>
        <div class="point" v-if="isShow">
          <div class="logo"><img src="@/assets/img/logo.png" alt="" /></div>
          欢迎使用智慧学伴，我是AI小智，有什么问题可以问我哦。例如：<br />请为我规划一份Java学习路线
        </div>
        <div class="warning" v-show="isRespose">
          <div class="warning-text">正在回答中</div>
        </div>
      </div>
      <div class="input" ref="input">
        <textarea
          type="text"
          rows="1"
          placeholder="请输入问题"
          v-model="content"
          ref="textarea"
        />
        <div class="submit">
          <button type="button" @click="send" :disabled="isRespose">
            发送
          </button>
        </div>
      </div>
      <van-watermark style="z-index: 0" content="智慧学伴" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.chat {
  height: 100%;
  .chat-box {
    width: 100%;
    height: 100%;
    position: relative;
    display: flex;
    z-index: 5;
    .background {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: radial-gradient(
          circle at 100% 0,
          #efe8eb 0,
          rgba(239, 232, 235, 0) 33%
        ),
        radial-gradient(
          circle at 100% 25%,
          #e8ebea 0,
          hsla(160, 7%, 92%, 0) 39%
        ),
        radial-gradient(
          circle at 100% 36%,
          hsla(160, 7%, 92%, 0.6) 0,
          hsla(160, 7%, 92%, 0) 38%
        ),
        linear-gradient(180deg, #efeaef, #dcdcf5 99%);
      z-index: -1;
    }
    .content {
      width: 100%;
      height: 100%;
      line-height: 20px;
      color: #000;
      font-size: 14px;
      padding-bottom: 49px;
      position: relative;
      z-index: 5;
      .main {
        padding: 10px 10px 0;
        width: 100%;
        height: 100%;
        overflow-y: auto;
        display: flex;
        flex-direction: column;
        margin-bottom: 10px;
        :deep(.message) {
          display: flex;
          font-size: 14px;
          position: relative;
          margin-bottom: 12px;
          &.person {
            justify-content: end;
            flex-direction: row-reverse;
            .avatar {
              margin-left: 8px;
            }
            .message-box {
              background-color: #30c0ff;
            }
          }
          &.robot {
            .avatar {
              margin-right: 8px;
            }
          }
          .avatar {
            flex-shrink: 0;
            width: 34px;
            height: 34px;
            border-radius: 100%;
            overflow: hidden;
            img {
              width: 100%;
              height: 100%;
            }
          }
          .message-box {
            max-width: 88%;
            background-color: #fff;
            padding: 6px 8px;
            border-radius: 8px;
            .text {
              word-break: break-all;
              word-wrap: break-word;
              color: #000;
            }
          }
        }
      }
      .point {
        position: absolute;
        top: 20px;
        left: 15px;
        right: 15px;
        background-color: rgba(255, 255, 255, 0.5);
        border-radius: 12px;
        padding: 8px 12px;
        .logo {
          width: 100%;
          height: 40px;
          display: flex;
          align-items: center;
          justify-content: center;
          margin-bottom: 8px;
          img {
            height: 100%;
          }
        }
      }
    }
    .warning {
      position: fixed;
      bottom: 80px;
      width: 100%;
      display: flex;
      justify-content: center;
      .warning-text {
        color: #fff;
        background-color: #ff976a;
        padding: 8px 16px;
        border-radius: 4px;
      }
    }
    .cursor {
      margin-left: 2px;
      width: 6px;
      height: 20px;
      background-color: #fff;
      animation: blink 1s infinite;
      z-index: 5;
    }

    @keyframes blink {
      0% {
        opacity: 1;
      }
      50% {
        opacity: 0;
      }
      100% {
        opacity: 1;
      }
    }
    .input {
      position: fixed;
      background-color: #fff;
      border-top: 1px solid #eee;
      width: 100%;
      bottom: 0;
      padding: 8px 10px;
      display: flex;
      z-index: 9;
      align-items: center;
      textarea {
        width: 100%;
        line-height: 1rem;
        border-radius: 18px;
        padding: 8px 10px;
        background-color: #f5f4f6;
        border: none;
        font-size: 14px;
        resize: none;
        word-break: break-all;
      }
      .submit {
        margin-left: 6px;
        flex-shrink: 0;
        button {
          background: linear-gradient(
            90deg,
            rgb(50, 197, 255),
            rgb(25, 137, 250)
          );
          border-radius: 20px;
          border: none;
          padding: 7px 10px;
          color: #fff;
          font-size: 14px;
        }
      }
    }
  }
}
</style>
