import request from '@/utils/request.js'

export const withCall = (question) => request.post('/api/chat', question)
