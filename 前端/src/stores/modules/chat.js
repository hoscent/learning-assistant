import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useChatStore = defineStore(
  'chat',
  () => {
    const history = ref([])
    const setHistory = (data) => {
      history.value = data
    }
    const addHistory = (data) => {
      history.value.push(data)
    }
    return {
      history,
      setHistory,
      addHistory
    }
  },
  {
    persist: true
  }
)
