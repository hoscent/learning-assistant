import axios from 'axios'
import { useUserStore } from '@/stores'
import { showToast, showLoadingToast, closeToast } from 'vant'
import 'vant/es/toast/style'
import router from '@/router'

const baseURL = 'http://end.match.hoscent.com'

const instance = axios.create({
  baseURL,
  timeout: 10000
})

instance.defaults.headers.post['Content-Type'] = 'application/json'

instance.interceptors.request.use(
  (config) => {
    showLoadingToast({
      message: '加载中...',
      forbidClick: true,
      duration: 10000
    })

    const userStore = useUserStore()
    if (userStore.token) {
      config.headers.Authorization = userStore.token
    }
    return config
  },
  (err) => Promise.reject(err)
)

instance.interceptors.response.use(
  (res) => {
    closeToast()
    if (res.data.code === 200) return res
    showToast(res.data.msg || 'server exception')
    return Promise.reject(res.data)
  },
  (err) => {
    showToast(err.response.data.msg || 'server exception')
    if (err.response.status === 401) {
      router.push('/login')
    }
    closeToast()
    return Promise.reject(err)
  }
)

export default instance
export { baseURL }
