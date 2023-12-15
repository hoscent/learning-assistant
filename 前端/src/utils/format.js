export const lineFormat = (text) => {
  return text.replace(/\n/g, '<br />')
}

export const markdownFormat = (text) => {
  let code = ''
  const regex = /```([\w-]+)[\s\S]*?```/g
  const match = text.match(regex)
  if (match) {
    code = '<pre>' + match + '</pre>'
  }
  return text.replace(regex, code)
}

export const dateFormat = (dateStr) => {
  var date = new Date(dateStr)
  var year = date.getFullYear()
  var month = padZero(date.getMonth() + 1)
  var day = padZero(date.getDate())
  return year + '-' + month + '-' + day
}

export const dateDayFormat = (dateStr) => {
  var date = new Date(dateStr)
  return padZero(date.getDate())
}

export const padZero = (number) => {
  return number < 10 ? '0' + number : number
}

export const getTimeDifference = (dateString) => {
  const currentDate = new Date()
  const givenDate = new Date(dateString)
  const differenceInSeconds = Math.abs((currentDate - givenDate) / 1000)

  if (differenceInSeconds < 60) {
    return '刚刚'
  } else if (differenceInSeconds < 3600) {
    // 在1小时内
    const minutes = Math.floor(differenceInSeconds / 60)
    return `${minutes}分钟前`
  } else if (differenceInSeconds < 86400) {
    // 在1小时-24小时内
    const hours = Math.floor(differenceInSeconds / 3600)
    return `${hours}小时前`
  } else if (differenceInSeconds < 604800) {
    // 在1-7天内
    const days = Math.floor(differenceInSeconds / 86400)
    return `${days}天前`
  } else {
    const currentYear = currentDate.getFullYear()
    const givenYear = givenDate.getFullYear()
    if (currentYear === givenYear) {
      // 超过7天并且在本年
      return givenDate.toLocaleDateString() // 格式：10-23
    } else {
      // 不在本年
      return givenDate.toISOString().split('T')[0] // 格式：2023-10-23
    }
  }
}

export const getCreateTime = (dateString) => {
  const date = new Date(dateString)
  return (
    date.getFullYear() +
    '年' +
    (date.getMonth() + 1) +
    '月' +
    date.getDate() +
    '日加入'
  )
}

export const getDateLine = (dateString) => {
  const currentDate = new Date()
  const date = new Date(dateString)
  const differenceInSeconds = Math.abs((currentDate - date) / 1000)

  if (differenceInSeconds < 86400) {
    return '今天'
  } else if (differenceInSeconds < 172800) {
    return '昨天'
  } else if (differenceInSeconds < 259200) {
    return '前天'
  } else {
    if (currentDate.getFullYear() === date.getFullYear()) {
      return `${padZero(date.getMonth() + 1)}/${padZero(date.getDate())}`
    } else {
      return `${date.getFullYear()}/${padZero(date.getMonth() + 1)}/${padZero(
        date.getDate()
      )}`
    }
  }
}

export const getDate = (dateString) => {
  const date = new Date(dateString)
  const current = new Date()
  const dateYear = date.getFullYear()
  const currentYear = current.getFullYear()
  const dateMonth = date.getMonth() + 1
  const dateDay = date.getDate()
  if (dateYear === currentYear) {
    return `${dateMonth}月${dateDay}日`
  }
  return `${dateYear}年${dateMonth}月${dateDay}日`
}
