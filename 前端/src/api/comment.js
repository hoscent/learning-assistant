import request from '@/utils/request.js'

export const getCommentNum = () => request.get('/comment/not_read')

export const getCommentList = (current, size) =>
  request.get('/comment/list', { params: { current, size } })
