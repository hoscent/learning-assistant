import request from '@/utils/request.js'

export const getClassList = () => request.get('/notebook/class')

export const getNotesList = () => request.get('/notebook/list')

export const addUserNote = (data) => request.post('/notebook/add', data)

export const deleteUserNote = (id) => request.delete(`/notebook/delete/${id}`)

export const updateNote = (data) => request.put('/notebook/update', data)

export const addUserClass = (title) =>
  request.post('/notebook/add/class', title)

export const getNoteDetail = (bookId) =>
  request.get('/notebook/detail', {
    params: {
      bookId
    }
  })
