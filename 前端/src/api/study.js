import request from '@/utils/request.js'

export const addRecord = (data) => request.post('/study/record', data)

export const getRecord = () => request.get('/study/record')

export const getRecordWeek = () => request.get('/study/record/week')

export const getCharts = () => request.get('/study/charts')

export const getHistoryList = (date) =>
  request.get('/study/record/history', {
    params: {
      dateStr: date
    }
  })
