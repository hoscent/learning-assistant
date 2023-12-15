import request from '@/utils/request.js'

export const registerUser = (data) => request.post('/user/register', data)

export const loginUser = (data) => request.post('/user/login', data)

export const getUserInfo = (data) => request.get('/user/info', data)

export const addHistory = (data) => request.post('/history/add', data)

export const verifyToken = () => request.get('/user/verify')

export const getAttentionNum = () => request.get('/user/attention/num')

export const getArticle = (page, pageSize) =>
  request.get('/article/user', {
    params: {
      page,
      pageSize
    }
  })

export const getArticleNum = () => request.get('/article/user/count')
