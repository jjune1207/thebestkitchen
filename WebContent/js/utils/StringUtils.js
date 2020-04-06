function maskingMemberId (memberId) {
  if (!memberId) {
    return ''
  }
  var showMemberId = ''
  var endStr = ''
  if (memberId.indexOf('@') > -1) {
    endStr = memberId.substring(memberId.indexOf('@'))
    memberId = memberId.substring(0, memberId.indexOf('@'))
  }
  if (memberId.length >= 2) {
    showMemberId = memberId.substring(0, memberId.length - 2) + '**'
  } else {
    showMemberId = '**'
  }
  return showMemberId + endStr
}
function delCurrency (str) {
  if (!str) return str
  if (typeof str === 'number') return str
  var value = str.replace(',', '')
  if (isNaN(Number(value))) return str
  return Number(value)
}

function formatCurrency (num, positive) {
  if (!positive) {
    positive = ''
  }
  if (num) {
    var number = num.toString()

    if (number === '' || isNaN(number)) {
      return num
    }

    if (number.indexOf('-') > 0) {
      return num
    }

    var sign = number.indexOf('-') === 0 ? '-' : positive
    if (sign === '-') {
      number = number.substr(1)
    }

    var cents = number.indexOf('.') > 0 ? number.substr(number.indexOf('.')) : ''
    cents = cents.length > 1 ? cents : ''

    number = number.indexOf('.') > 0 ? number.substring(0, (number.indexOf('.'))) : number

    if (cents === '') {
      if (number.length > 1 && number.substr(0, 1) === '0') {
        return num
      }
    } else {
      if (number.length > 1 && number.substr(0, 1) === '0') {
        return num
      }
    }

    var tempNum = ''
    while (number.length > 3) {
      tempNum = ',' + number.slice(-3) + tempNum
      number = number.slice(0, number.length - 3)
    }
    if (number) {
      tempNum = number + tempNum
    }

    return (sign + tempNum + cents)
  } else {
    return num
  }
}

function clearRepeatNum (repeatArr) {
  const resarr = []
  repeatArr.forEach(function(arr) {
    if (resarr.indexOf(arr) === -1) {
      resarr.push(arr)
    }
  })
  return resarr
}
function compare (state) {
  // state.coupons.sort((a, b) => (a.discountPrice - b.discountPrice)
  state.coupons.sort(function(arr1, arr2) {
    var value1
    var value2
    if (arr1.discountInfo.discountAmt) {
      value1 = arr1.discountInfo.discountAmt
    } else {
      value1 = arr1.discountInfo.discountRate / 100 * state.proPrice
    }
    if (arr2.discountInfo.discountAmt) {
      value2 = arr2.discountInfo.discountAmt
    } else {
      value2 = arr2.discountInfo.discountRate / 100 * state.proPrice
    }
    return value2 - value1
  })
}

function optionFormat (optionUsed, optionType, optionName, optionValue, inputs, addPrice, orderCnt) {
  var showOption = ''

  const showOptions = []
  if (optionUsed) {
    if (optionType !== 'PRODUCT_ONLY') {
      const optionNames = optionName.split('|')
      const optionValues = optionValue.split('|')
      optionNames.forEach(function(tempName, index) {
        showOptions.push(tempName + ':' + optionValues[index])
      })
    }
    if (inputs && inputs.length > 0) {
      inputs.forEach(function(optionInput) {
        showOptions.push(optionInput.inputLabel + ':' + optionInput.inputValue)
      })
    }
  }

  if (addPrice && addPrice !== 0) {
    var last = showOptions.pop()
    var lastoption = last + ' (' + formatCurrency(addPrice, '+') + '원)'
    showOptions.push(lastoption)
  }
  if (orderCnt) {
    showOptions.push(orderCnt + '개')
  }

  showOptions.forEach(function(item, index) {
    if (index > 0) {
      showOption += ' / '
    }
    showOption += item
  })

  return showOption
}

function receiverContactFormat (receiverContact, index) {
  var retstr = ''
  if (receiverContact) {
    if (receiverContact.indexOf('-') > 0) {
      const receiverContacts = receiverContact.split('-')
      if (receiverContacts.length >= index) {
        retstr = receiverContacts[index - 1]
      }
    }
  }
  return retstr
}

function telnoFormat (telno) {
  const telnos = ['', '', '']
  if (telno) {
    if (telno.indexOf('-') > 0) {
      var temptelnos = telno.split('-')
      if (temptelnos.length > 0) {
        telnos[0] = temptelnos[0]
        telnos[1] = temptelnos[1]
        telnos[2] = temptelnos[2]
      }
    } else if (telno.indexOf('-') < 0 && telno.length > 7) {
      telnos[0] = telno.substr(0, 3)
      telnos[1] = telno.substr(3, telno.length - 7)
      telnos[2] = telno.substr(telno.length - 4, 4)
    }
  }
  return telnos
}

function appVersionGt41 (version) {
  if (version) {
    const v = version.split('.')
    if (v.length === 1) {
      if (parseInt(v[0]) > 4) {
        return true
      }
    }
    if (v.length >= 2) {
      if (parseInt(v[0]) > 4) {
        return true
      } else if (parseInt(v[0]) >= 4 && parseInt(v[1]) >= 1) {
        return true
      } else {
        return false
      }
    }
  }
  return false
}

function productPrice (salePrice, additionDiscountAmt, immediateDiscountAmt) {
  var discountAmt = additionDiscountAmt || 0
  discountAmt += immediateDiscountAmt || 0

  return {
    discountRate: Math.round((discountAmt / salePrice) * 100) || 0,
    finalSalePrice: salePrice - discountAmt
  }
}

function splitValue (value, split) {
    var valueArr = value.split(split);
    var result = '';
    $.each(valueArr, function(idx, value){
      result += (value) ? value : '';
    })
    return result;
}

function comma(num){
    var len, point, str;

    num = num + "";
    point = num.length % 3 ;
    len = num.length;

    str = num.substring(0, point);
    while (point < len) {
        if (str != "") str += ",";
        str += num.substring(point, point + 3);
        point += 3;
    }

    return str;

}

function htmlDecode(str){
    var e = document.createElement('div');
    e.innerHTML = str;
    return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
}

function encodeUrlToPunycode(url) {
  if (url.startsWith("https")) {
    return 'https://' + punycode.toASCII(url.replace('https://', ''));
  } else if(url.startsWith("http")) {
    return 'http://' + punycode.toASCII(url.replace('http://', ''));
  }
}
