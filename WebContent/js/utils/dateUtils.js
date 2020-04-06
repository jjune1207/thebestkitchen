function addDay (date, cnt, separator) {
  date = new Date(date.replace(/-/g, '/'))
  if (date.constructor !== Date) {
    return ''
  }

  date.setDate(date.getDate() + cnt)

  var month = date.getMonth() + 1
  var day = date.getDate()

  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }
  const reDate = date.getFullYear() + separator + month + separator + day

  return reDate
}

function addMonth (date, cnt, separator) {
  if (date.constructor !== Date) {
    return ''
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }

  var newDate = new Date(date.getFullYear(), date.getMonth() + cnt, date.getDate())
  const newDateEndDay = new Date(date.getFullYear(), date.getMonth() + cnt + 1, 0)
  if (newDate.getMonth() !== newDateEndDay.getMonth()) {
    newDate = newDateEndDay
  }
  var month = newDate.getMonth() + 1
  var day = newDate.getDate()

  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }

  return newDate.getFullYear() + separator + month + separator + day
}

function getStrDate (date, separator) {
  if (date.constructor !== Date) {
    date = new Date(date.replace(/-/g, '/'))
  }
  if (date.constructor !== Date) {
    return ''
  }

  var month = date.getMonth() + 1
  var day = date.getDate()

  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }
  const reDate = date.getFullYear() + separator + month + separator + day

  return reDate
}

function getStrYMDHM (date, separator) {
  date = new Date(date.replace(/-/g, '/'))
  if (date.constructor !== Date) {
    return ''
  }

  var month = date.getMonth() + 1
  var day = date.getDate()
  var hours = date.getHours()
  var minutes = date.getMinutes()

  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }
  if (hours < 10) {
    hours = '0' + hours
  }
  if (minutes < 10) {
    minutes = '0' + minutes
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }
  const reDate = date.getFullYear() + separator + month + separator + day + ' ' + hours + ':' + minutes

  return reDate
}

function getStrYMDHMSS (date, separator) {
  if (date.constructor !== Date) {
    date = new Date(date.replace(/-/g, '/'))
  }

  var month = date.getMonth() + 1
  var day = date.getDate()
  var hours = date.getHours()
  var minutes = date.getMinutes()
  var seconds = date.getSeconds()

  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }
  if (hours < 10) {
    hours = '0' + hours
  }
  if (minutes < 10) {
    minutes = '0' + minutes
  }
  if (seconds < 10) {
    seconds = '0' + seconds
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }
  const reDate = date.getFullYear() + separator + month + separator + day + ' ' + hours + ':' + minutes + ':' + seconds

  return reDate
}

function getToday () {
  return getStrDate(new Date())
}

function getTodayTime () {
  return getStrYMDHMSS(new Date())
}

function getFirstAndEndDay (mm, separator) {
  const nowdays = new Date()
  var year = nowdays.getFullYear()
  var month = nowdays.getMonth() + 1

  if (month <= mm) {
    year = year - 1
    month = month - mm + 12
  } else {
    month = month - mm
  }

  if (month < 10) {
    month = '0' + month
  }

  if (separator === null || separator === undefined) {
    separator = '-'
  }

  const startYmd = year + separator + month + separator + '01'

  const myDate = new Date(year, month, 0)
  const endYmd = year + separator + month + separator + myDate.getDate()

  return { startYmd: startYmd, endYmd: endYmd }
}

function getSixMonths () {
  const sixMonths = []
  for (var index = 0; index < 6; index++) {
    const nowDate = new Date()
    const newDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - index, 1)
    sixMonths.push(newDate.getFullYear() + '년 ' + (newDate.getMonth() + 1) + '월')
  }
  return sixMonths
}

function isYearEndDay () {
  const date = new Date()
  if (date.getMonth() === 11 && date.getDate() === 31) {
    return true
  } else {
    return false
  }
}

function getJanuary5 () {
  const date = new Date()
  return (date.getFullYear() + 1) + '-01-05 23:59:59'
}

function getEndDayForYear () {
  const date = new Date()
  return date.getFullYear() + '-12-31 23:59:59'
}

function getStrMDW (date) {
  const weeks = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  return (date.getMonth() + 1) + '.' + date.getDate() + ' ' + weeks[date.getDay()]
}

function isOverDay (date) {
  const ONE_DAY = 1000 * 60 * 60 * 24
  const d = new Date(date.replace(/-/g, '/') + ' GMT+9') - new Date().getTime()
  return d > 0 && d <= ONE_DAY
}

function within30Days (date) {
  const ONE_DAY = 1000 * 60 * 60 * 24 * 30
  const d = new Date(date.replace(/-/g, '/') + ' GMT+9') - new Date().getTime()
  return d > 0 && d <= ONE_DAY
}

function getDateFormat (date) {
  if (date) {
    var slaDate = new Date(date.replace(/-/g, '/'))

    var y = slaDate.getFullYear()
    var m = slaDate.getMonth() + 1
    m = m < 10 ? '0' + m : m
    var d = slaDate.getDate()
    d = d < 10 ? ('0' + d) : d
    return y + '년 ' + m + '월 ' + d + '일'
  }
}

function getDateFormatMD (date) {
  if (date) {
    var slaDate = new Date(date.replace(/-/g, '/'))
    var m = slaDate.getMonth() + 1
    var d = slaDate.getDate()
    return m + '월 ' + d + '일 ' + ' 오픈예정'
  }
}

function getDateFormatYMDHM (date) {
  if (date) {
    var slaDate = new Date(date.replace(/-/g, '/'))

    var y = slaDate.getFullYear()
    var m = slaDate.getMonth() + 1
    m = m < 10 ? '0' + m : m
    var d = slaDate.getDate()
    d = d < 10 ? ('0' + d) : d
    var hours = slaDate.getHours()
    var minutes = slaDate.getMinutes()
    minutes = minutes < 10 ? ('0' + minutes) : minutes
    return y + '년 ' + m + '월 ' + d + '일' + (hours < 12 ? ' 오전 ' : ' 오후 ') + (hours < 12 ? hours : hours - 12) + ':' + minutes
  }
}

function getDateFormatMDHM (date) {
  if (date) {
    var slaDate = new Date(date.replace(/-/g, '/'))
    var m = slaDate.getMonth() + 1
    var d = slaDate.getDate()
    var hours = slaDate.getHours()
    var minutes = slaDate.getMinutes()
    minutes = minutes < 10 ? ('0' + minutes) : minutes
    return m + '월 ' + d + '일' + (hours < 12 ? ' 오전 ' : ' 오후 ') + (hours < 12 ? hours : hours - 12) + ':' + minutes + ' 오픈예정'
  }
}

function includeNow (start, end) {
  const nowDateTime = new Date().getTime()
  const startDateTime = new Date(start.replace(/-/g, '/') + ' GMT+9').getTime()
  const endDateTime = new Date(end.replace(/-/g, '/') + ' GMT+9').getTime()
  return nowDateTime >= startDateTime && nowDateTime <= endDateTime
}
