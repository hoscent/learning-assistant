import request from '@/utils/request.js'

export const getSignboard = (type, limit) =>
  request.get('/home/signboard', {
    params: {
      type,
      limit
    }
  })

export const getCategory = () => request.get('/home/resources/category')

export const getResources = (page, pageSize, type, categoryId) =>
  request.get('/home/resources', {
    params: {
      page,
      pageSize,
      type,
      categoryId
    }
  })

export const getResourcesDetail = (id) =>
  request.get('/home/resources/detail', {
    params: {
      id
    }
  })

export const countView = (data) => request.get('/history/num', { params: data })

export const getCollectionList = (id) =>
  request.get('/home/resources/collection', {
    params: {
      id
    }
  })
