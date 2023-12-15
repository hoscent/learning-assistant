import request from '@/utils/request.js'

export const pushArticle = (data) => request.post('/article/push', data)

export const getCategoryList = () => request.get('/article/category')

export const getArticleList = (page, pageSize, categoryId) =>
  request.get('/article/list', {
    params: {
      page,
      pageSize,
      categoryId
    }
  })

export const getArticleDetail = (id) =>
  request.get('/article/detail', { params: { id } })

export const publishComment = (data) => request.post('/article/comment', data)

export const getCommentList = (page, pageSize, articleId) =>
  request.get('/article/comment', {
    params: {
      page,
      pageSize,
      article: articleId
    }
  })

export const getCommentCount = (id) =>
  request.get('/article/count/comment', { params: { id } })
