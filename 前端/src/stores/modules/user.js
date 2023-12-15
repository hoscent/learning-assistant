import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getUserInfo, verifyToken } from '@/api/user.js'
export const useUserStore = defineStore(
  'user',
  () => {
    const user = ref(null)
    const token = ref('')
    const setToken = (t) => {
      token.value = t
    }
    const getUser = () => {
      getUserInfo(null).then((res) => {
        user.value = res.data.data
      })
    }

    const verifyTokenLegal = () => {
      return verifyToken().then((res) => {
        return res.data.data
      })
    }

    const clearToken = () => {
      token.value = ''
    }

    const clearUser = () => {
      user.value = {}
    }

    return {
      user,
      token,
      setToken,
      getUser,
      clearToken,
      clearUser,
      verifyTokenLegal
    }
  },
  {
    persist: true
  }
)
