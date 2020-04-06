function makeOrderProductOptionName (orderProductOption) {
  if (orderProductOption.brandName) {
    orderProductOption.showBrandName = '[' + orderProductOption.brandName + ']';
  }
  orderProductOption.showProductName = orderProductOption.productName;

  // 옵션선택정보
  orderProductOption.showOptions = [];
  orderProductOption.showAddPrice = '';
  orderProductOption.showOrderCnt = '';

  if (orderProductOption.optionUsed) {
    if (orderProductOption.optionType !== 'PRODUCT_ONLY') {
      const optionNames = orderProductOption.optionName.split('|');
      const optionValues = orderProductOption.optionValue.split('|');
      for (var i = 0; i < optionNames.length; i++) {
        tempName = optionNames[i];
        orderProductOption.showOptions.push(tempName + ':' + optionValues[i]);
      }
    }

    if (orderProductOption.inputs !== null) {
      orderProductOption.optionInputs = orderProductOption.inputs.filter(function (input) {
        return input.inputMatchingType === 'OPTION';
      });

      // 구매자 작성형 옵션
      if (orderProductOption.optionInputs && orderProductOption.optionInputs.length > 0) {
        for (var i = 0; i < orderProductOption.optionInputs.length; i++) {
          optionInput = orderProductOption.optionInputs[i];
          rderProductOption.showOptions.push(optionInput.inputLabel + ':' + optionInput.inputValue);
        }
      } else if (orderProductOption.inputs && orderProductOption.inputs.length > 0) {
        for (var i = 0; i < orderProductOption.inputs.length; i++) {
          optionInput = orderProductOption.inputs[i];
          orderProductOption.showOptions.push(optionInput.inputLabel + ':' + optionInput.inputValue);
        }
      }
    }
    // 옵션추가금액
    if (orderProductOption.price.addPrice !== 0) {
      var showAddPrice = orderProductOption.price.addPrice > 0 ? '(' + formatCurrency(orderProductOption.price.addPrice) + '원)' : '(' + formatCurrency(orderProductOption.price.addPrice) + '원)';
      orderProductOption.showAddPrice = showAddPrice;
    }

    if (orderProductOption.orderCnt !== 0) {
      //orderProductOption.showOrderCnt = '/ ' + orderProductOption.orderCnt + '개';
    }
  } else {
    if (orderProductOption.orderCnt !== 0) {
      //orderProductOption.showOrderCnt = orderProductOption.orderCnt + '개';
    }
  }

  orderProductOption.productOption = '';
  if (orderProductOption.showOptions.length != 0) {
    for (var i = 0; i < orderProductOption.showOptions.length; i++) {
      var showOption = orderProductOption.showOptions[i];
      if (i === 0) {
        orderProductOption.productOption += showOption;
      } else {
        orderProductOption.productOption += ' / ' + showOption;
      }
    }
  }

  if (orderProductOption.showAddPrice) {
    orderProductOption.productOption += orderProductOption.showAddPrice;
  }

  if (orderProductOption.showOrderCnt) {
    orderProductOption.productOption += orderProductOption.showOrderCnt;
  }
}

function renderReasonsOption (types) {
  var html = "";
  var aOpt = "<option value='" + 'DEFAULT_TIPS' + "'";
  aOpt += ">";
  aOpt += '선택하세요.';
  aOpt += "</option>";
  html += aOpt;

  for (var i = 0; i < types.length; i++) {
    var item = types[i];
    aOpt = "<option value='" + item.claimReasonType + "'";
    aOpt += ">";
    aOpt += item.label;
    aOpt += "</option>";
    html += aOpt;
  }
  $('#selectReasons').html(html);
}

function renderQuantitiesOption (cnt) {
  var html = "";
  for (var i = 1; i <= cnt; i++) {
    var aOpt = "<option value='" + i + "'";
    aOpt += ">";
    aOpt += i;
    aOpt += "</option>";
    html += aOpt;
  }
  $('#selectQuantities').html(html);
}

function makeOptionButton (option) {
  option.buttons = [];
  if (option.claimStatusType) {
    if (option.claimStatusType === 'CANCEL_REQUEST' || option.claimStatusType === 'CANCEL_PROC_REQUEST_REFUND' || option.claimStatusType === 'CANCEL_PROC_WAITING_REFUND') {
      option.statusLabel = '취소처리중'
      option.buttonCount = 0
      option.nextActions.forEach(function(nextAction) {
        if (nextAction.nextActionType === 'VIEW_CLAIM') {
          option.buttonCount += 1
          option.buttons.push('CANCEL_VIEW_CLAIM_ING')
        } else if (nextAction.nextActionType === 'WITHDRAW_CANCEL') {
          option.buttonCount += 1
          option.buttons.push('WITHDRAW_CANCEL')
        }
      })
    } else if (option.claimStatusType === 'CANCEL_NO_REFUND' || option.claimStatusType === 'CANCEL_DONE') {
      option.statusLabel = '취소완료'
      option.buttonCount = 1
      option.buttons.push('CANCEL_VIEW_CLAIM')
    } else if (option.claimStatusType === 'RETURN_REQUEST' || option.claimStatusType === 'RETURN_REJECT_REQUEST' || option.claimStatusType === 'RETURN_PROC_BEFORE_RECEIVE' || option.claimStatusType === 'RETURN_PROC_REQUEST_REFUND' || option.claimStatusType === 'RETURN_PROC_WAITING_REFUND') {
      option.statusLabel = '반품처리중'
      option.buttonCount = 0
      option.nextActions.forEach(function(nextAction) {
        if (nextAction.nextActionType === 'VIEW_CLAIM') {
          option.buttonCount += 1
          option.buttons.push('RETURN_VIEW_CLAIM_ING')
        } else if (nextAction.nextActionType === 'WITHDRAW_RETURN') {
          option.buttonCount += 1
          option.buttons.push('WITHDRAW_RETURN')
        }
      })
    } else if (option.claimStatusType === 'RETURN_DONE') {
      option.statusLabel = '반품완료'
      option.buttonCount = 1
      option.buttons.push('RETURN_VIEW_CLAIM')
    }
  } else {
    if (option.orderStatusType === 'PAY_DONE') {
      option.statusLabel = '결제완료'
        option.buttonCount = 0
        option.nextActions.forEach(function (nextAction) {
            if (nextAction.nextActionType === 'CANCEL') {
                option.buttonCount += 1
                option.buttons.push('CANCEL')
            }
        })
    } else if (option.orderStatusType === 'PRODUCT_PREPARE') {
      option.statusLabel = '상품준비중'
        option.buttonCount = 0
        option.nextActions.forEach(function (nextAction) {
            if (nextAction.nextActionType === 'CANCEL') {
                option.buttonCount += 1
                option.buttons.push('CANCEL')
            }
        })
    } else if (option.orderStatusType === 'DELIVERY_PREPARE') {
      option.statusLabel = '배송준비중'
        option.buttonCount = 0
        option.nextActions.forEach(function (nextAction) {
            if (nextAction.nextActionType === 'CANCEL') {
                option.buttonCount += 1
                option.buttons.push('CANCEL')
            }
        })
    } else if (option.orderStatusType === 'DELIVERY_ING') {
      option.statusLabel = '배송중'
      option.buttonCount = 0
      option.nextActions.forEach(function(nextAction) {
        if (nextAction.nextActionType === 'VIEW_DELIVERY') {
          option.buttonCount += 1
          option.buttons.push('VIEW_DELIVERY')
        } else if (nextAction.nextActionType === 'WRITE_REVIEW') {
          option.buttonCount += 1
          option.buttons.push('WRITE_REVIEW')
        } else if (nextAction.nextActionType === 'RETURN') {
          if (option.deliverable && option.refundable) {
            option.buttonCount += 1
            option.buttons.push('RETURN')
          }
        } else if (nextAction.nextActionType === 'CONFIRM_ORDER') {
            if (option.deliverable && option.refundable) {
                option.buttonCount += 1
                option.buttons.push('CONFIRM_ORDER')
            }
        }
      })
      if (option.deliverable && !option.refundable) {
        option.buttonCount += 1
        option.buttons.push('NOT_REFUNDABLE')
      }
    } else if (option.orderStatusType === 'DELIVERY_DONE') {
      option.statusLabel = '배송완료'
      option.buttonCount = 0
      option.nextActions.forEach(function(nextAction) {
        if (nextAction.nextActionType === 'VIEW_DELIVERY') {
          //option.buttonCount += 1
          //option.buttons.push('VIEW_DELIVERY')
        } else if (nextAction.nextActionType === 'WRITE_REVIEW') {
          option.buttonCount += 1
          option.buttons.push('WRITE_REVIEW')
        } else if (nextAction.nextActionType === 'RETURN') {
          if (option.deliverable && option.refundable) {
            option.buttonCount += 1
            option.buttons.push('RETURN')
          }
        } else if (nextAction.nextActionType === 'CONFIRM_ORDER') {
            if (option.deliverable && option.refundable) {
                option.buttonCount += 1
                option.buttons.push('CONFIRM_ORDER')
            }
        }
      })
      if (option.deliverable && !option.refundable) {
        option.buttonCount += 1
        option.buttons.push('NOT_REFUNDABLE')
      }
    } else if (option.orderStatusType === 'BUY_CONFIRM') {
      option.statusLabel = '구매확정'
      option.buttonCount = 1
      if (option.nextActions.length === 1) {
        option.buttons.push('WRITE_REVIEW')
      }
    }
  }
}

function makeOptionStatusLabel (option) {
  if (option.claimStatusType) {
    if (option.claimStatusType === 'CANCEL_REQUEST' || option.claimStatusType === 'CANCEL_PROC_REQUEST_REFUND' || option.claimStatusType === 'CANCEL_PROC_WAITING_REFUND') {
      option.statusLabel = '취소처리중'
    } else if (option.claimStatusType === 'CANCEL_NO_REFUND' || option.claimStatusType === 'CANCEL_DONE') {
      option.statusLabel = '취소완료'
    } else if (option.claimStatusType === 'RETURN_REQUEST' || option.claimStatusType === 'RETURN_REJECT_REQUEST' || option.claimStatusType === 'RETURN_PROC_BEFORE_RECEIVE' || option.claimStatusType === 'RETURN_PROC_REQUEST_REFUND' || option.claimStatusType === 'RETURN_PROC_WAITING_REFUND') {
      option.statusLabel = '반품처리중'
    } else if (option.claimStatusType === 'RETURN_DONE') {
      option.statusLabel = '반품완료'
    }
  } else {
    if (option.orderStatusType === 'PAY_DONE') {
      option.statusLabel = '결제완료'
    } else if (option.orderStatusType === 'PRODUCT_PREPARE') {
      option.statusLabel = '상품준비중'
    } else if (option.orderStatusType === 'DELIVERY_PREPARE') {
      option.statusLabel = '배송준비중'
    } else if (option.orderStatusType === 'DELIVERY_ING') {
      option.statusLabel = '배송중'
    } else if (option.orderStatusType === 'DELIVERY_DONE') {
      option.statusLabel = '배송완료'
    } else if (option.orderStatusType === 'BUY_CONFIRM') {
      option.statusLabel = '구매확정'
    }
  }
}

function withdrawClaim (orderOptionNo, orderNo) {
  if (!shop.isLogin()) {
    shop.ajax({
      url: deployInfo.apiUrl + '/guest/order-options/' + orderOptionNo + '/claim/withdraw',
      type: 'PUT',
      data: null,
      success: $.proxy(function (res) {
        alert('반품 신청이 취소되었습니다.');
        window.location.href = './orderview.html?orderNo=' + orderNo;
      }, this)
    })
  } else {
    shop.ajax({
      url: deployInfo.apiUrl + '/profile/order-options/' + orderOptionNo + '/claim/result',
      type: 'GET',
      data: null,
      success: $.proxy(function (res) {

        if ((res && res.claimedOption.claimStatusType !== 'RETURN_REQUEST') && (res && res.claimedOption.claimStatusType !== 'CANCEL_REQUEST')) {
          alert('주문상품의 상태가 변경되었습니다. 확인 후 다시 시도해 주세요.');
          history.back();
        } else {
          shop.ajax({
            url: deployInfo.apiUrl + '/profile/order-options/' + orderOptionNo + '/claim/withdraw',
            type: 'PUT',
            data: null,
            success: $.proxy(function (res) {
              alert('반품 신청이 취소되었습니다.');
              window.location.href = './orders.html';
            }, this)
          })
        }
      }, this)
    })
  }
}

function cancelOrder (orderOptionNo) {
  if (!shop.isLogin()) {
    window.location.href = './ordercancel.html?orderOptionNo=' + orderOptionNo;
  } else {
    window.location.href = './ordercancel.html?orderOptionNo=' + orderOptionNo;
  }
}

function requestReturn (orderOptionNo) {
  if (!shop.isLogin()) {
    window.location.href = './orderreturn.html?orderOptionNo=' + orderOptionNo;
  } else {
    window.location.href = './orderreturn.html?orderOptionNo=' + orderOptionNo;
  }
}

function getPayType (payType) {
  var showPayType = '';

  switch (payType) {
    case 'PAYCO':
      showPayType = 'PAYCO';
      break
    case 'CREDIT_CARD':
      showPayType = '신용카드';
      break
    case 'ACCOUNT':
    case 'ESCROW_REALTIME_ACCOUNT_TRANSFER':
    case 'REALTIME_ACCOUNT_TRANSFER':
    case 'ESCROW_VIRTUAL_ACCOUNT':
    case 'VIRTUAL_ACCOUNT':
      showPayType = '현금환불'
      break
  }
  return showPayType
}


shop.malls = {
  fetchMallsInfo: function () {
    shop.ajax({
      url: deployInfo.apiUrl + '/malls',
      type: 'GET',
      success: $.proxy(function (res) {
        cookieUtil.set('Malls', JSON.stringify(res.claimReasonType), setCookieDate(7));
      }, this)
    });
  }
}

function openOrderClaimDetailPopup (orderOptionNo, isGuest) {
  var url = '/profile/order-options/' + orderOptionNo + '/claim/result';
  if (isGuest) {
    url = '/guest/order-options/' + orderOptionNo + '/claim/result';
  }
  shop.ajax({
    url: deployInfo.apiUrl + url,
    type: 'GET',
    success: $.proxy(function (detailInfo) {
      if (detailInfo.claimType === 'CANCEL') {
        detailInfo.title = '취소상세정보'
        detailInfo.titleInfo = '취소상세정보'
        detailInfo.titleReason = '취소사유'
        detailInfo.reasonType = '취소사유구분'
        detailInfo.reasonDetail = '취소상세사유'
      } else if (detailInfo.claimType === 'RETURN') {
        detailInfo.title = '반품상세정보'
        detailInfo.titleInfo = '반품상세정보'
        detailInfo.titleReason = '반품사유'
        detailInfo.reasonType = '반품사유구분'
        detailInfo.reasonDetail = '반품상세사유'

        $('#detailReason').show();
      }
      makeOrderProductOptionName(detailInfo.claimedOption);
      makeOptionStatusLabel(detailInfo.claimedOption);
      $('#claimDetailPopup').render({ "info": detailInfo });

      showRefundProductAmt(detailInfo.claimPriceInfo.productAmtInfo.totalAmt);
      showRefundDeliveryAmt(detailInfo.claimPriceInfo.deliveryAmtInfo.totalAmt);
      showRefundSubtractionAmt(detailInfo.claimPriceInfo.subtractionAmtInfo.totalAmt);
      showRefundPayAmt(detailInfo.claimPriceInfo.refundPayAmt);
      $('#payMethod').text(getPayType(detailInfo.claimPriceInfo.refundPayType));
      showClaimReasonTypeLabel(detailInfo.claimReasonType);

    }, this)
  })
}

function showRefundProductAmt (totalAmt) {
  $('#productAmt').text(formatCurrency(totalAmt) + ' 원');

};

function showRefundDeliveryAmt (deliveryTotalAmt) {
  if (deliveryTotalAmt < 0) {
    $('#deliveryAmt').text('(-)' + formatCurrency(Math.abs(deliveryTotalAmt)) + ' 원');
  } else {
    $('#deliveryAmt').text(formatCurrency(Math.abs(deliveryTotalAmt)) + ' 원');
  }

};

function showRefundSubtractionAmt (subtractionAmt) {
  $('#subtractionAmt').text('(-)' + formatCurrency(subtractionAmt) + ' 원');
};

function showRefundPayAmt (refundPayAmt) {
  $('#PayAmt').text(formatCurrency(refundPayAmt) + ' 원');
};

function showClaimReasonTypeLabel (claimReasonType) {
  var mallClaims = JSON.parse(cookieUtil.get('Malls'));
  if (typeof (mallClaims) !== 'undefined' || mallClaims !== null) {
    for (var i = 0; i < mallClaims.length; i++) {
      if (mallClaims[i].value == claimReasonType) {
        $('#claimReasonLabel').text(mallClaims[i].label);
        break;
      }
    }
  }
}

Handlebars.registerHelper("ifContain", function (a, b, options) {
  for (var i = 0; i < a.length; i++) {
    if (a[i] == b)
      return options.fn(this);
  }
  return options.inverse(this);
});

var closePopup = function (popup) {
  $('body').removeClass('no_scroll');
  $('#' + popup).hide();
}

function onItemCancel (orderOptionNo, orderNo) {
  window.location.href = './ordercancel.html?orderOptionNo=' + orderOptionNo + '&' + 'orderNo=' + orderNo;
}

function onItemReturn (orderOptionNo, orderNo) {
  window.location.href = './orderreturn.html?orderOptionNo=' + orderOptionNo + '&' + 'orderNo=' + orderNo;
}

function diffProcMemberGuest () {
  if (shop.isLogin()) {
    $(".leftMenu").load("./leftmenu.html").show();
    $("#orderCouponInfo").load("./ordercouponinfo.html").show();
    $('#pageTitle').show();
    $('#naviHome').show();
    diffApiMemberGuest = '/profile';
    $(".rightCon").removeClass('noMember');
  } else {
    diffApiMemberGuest = '/guest';
    $(".rightCon").addClass('noMember');
  }
}

function succeedCancleReturnProc (orderOptionNo, orderNo) {
  /*
  if (shop.isLogin()) {
      window.location.href = './orderview.html?orderNo=' + orderNo;
  } else {
    window.location.href = './ordercancelreturndetail.html?orderOptionNo=' + orderOptionNo + '&' + 'orderNo=' + orderNo;
  }
  */
  window.location.href = './orderview.html?orderNo=' + orderNo;
}

function getProductStatus (claimStatusType, orderStatusType) {
    var statusLabel;
    if (claimStatusType) {
        if (claimStatusType === 'CANCEL_REQUEST' || claimStatusType === 'CANCEL_PROC_REQUEST_REFUND' || claimStatusType === 'CANCEL_PROC_WAITING_REFUND') {
            statusLabel = '취소처리중'
        } else if (claimStatusType === 'CANCEL_NO_REFUND' || claimStatusType === 'CANCEL_DONE') {
            statusLabel = '취소완료'
        } else if (claimStatusType === 'RETURN_REQUEST' || claimStatusType === 'RETURN_REJECT_REQUEST' || claimStatusType === 'RETURN_PROC_BEFORE_RECEIVE' || claimStatusType === 'RETURN_PROC_REQUEST_REFUND' || claimStatusType === 'RETURN_PROC_WAITING_REFUND') {
            statusLabel = '반품처리중'
        } else if (claimStatusType === 'RETURN_DONE') {
            statusLabel = '반품완료'
        }
    } else {
        if (orderStatusType === 'PAY_DONE') {
            statusLabel = '결제완료'
        } else if (orderStatusType === 'PRODUCT_PREPARE') {
            statusLabel = '상품준비중'
        } else if (orderStatusType === 'DELIVERY_PREPARE') {
            statusLabel = '배송준비중'
        } else if (orderStatusType === 'DELIVERY_ING') {
            statusLabel = '배송중'
        } else if (orderStatusType === 'DELIVERY_DONE') {
            statusLabel = '배송완료'
        } else if (orderStatusType === 'BUY_CONFIRM') {
            statusLabel = '구매확정'
        } else if (orderStatusType === 'DEPOSIT_WAIT') {
            statusLabel = '입금대기'
        }
    }

    return statusLabel;
}
function cashReceiptOpenLayer() {
    $('#cashReceiptLayer').show();
}
function cashReceiptCloseLayer() {
    $('#cashReceiptLayer').hide();
}

function cashReceiptSubmit() {
    var cashReceiptIssuePurposeType = $("input[name='cashReceiptIssuePurposeType']:checked").val();
    var cashReceiptKey = $('#cashReceiptKey').val();

    if(cashReceiptKey == ''){
        if(cashReceiptIssuePurposeType == 'INCOME_TAX_DEDUCTION'){
            alert('휴대폰번호를 입력해주세요');
        }else{
            alert('사업자번호를 입력해주세요');
        }
        return false;
    }

    if (shop.isLogin()) {
        diffApiMemberGuest = 'profile';
    } else {
        diffApiMemberGuest = 'guest';
    }

    shop.ajax({
        url: deployInfo.apiUrl + '/' + diffApiMemberGuest + '/orders/' + shop.getUrlParam('orderNo') + '/cashReceipt',
        type: 'POST',
        data: {
            "cashReceiptIssuePurposeType": cashReceiptIssuePurposeType,
            "cashReceiptKey": cashReceiptKey
        },
        success: $.proxy(function (res) {
            if(res.resultType == 'ISSUE'){
                alert('현금영수증이 발급 되었습니다.');
            }else if (res.resultType == 'REQUEST_ONLY'){
                alert('현금영수증 발급신청 되었습니다.');
            }else{
                alert('현금영수증 발급을 실패하였습니다. 다시 한번 요청해주세요.');
            }
            location.reload();
        }, this),
        error: $.proxy(function (res) {
            var result = JSON.parse(res.responseText);
            console.log(result);
            alert('현금영수증 발급을 실패하였습니다. 다시 한번 요청해주세요.');
            location.reload();
        }, this)
    })
}
function cashReceiptSerchLayer(url){
    var win = popup({
        url: url
        , target: 'cashReceiptPopup'
        , width: 400
        , height: 560
        , resizable: 'no'
        , scrollbars: 'no'
    });
    win.focus();
    return win;
}

function getMalls () {
    var malls = cookieUtil.get('Malls');
    if (typeof (malls) === 'undefined' || malls === null) {
        shop.malls.fetchMallsInfo();
    }
}

function orderConfirm(orderOptionNo){

    if (confirm('구매확정 이후에는 반품이 불가합니다.\n반드시 상품을 받으신 후 진행해주세요.\n구매확정 처리 하시겠습니까? \n')) {
        if(pgInfo.escrow == true && pgInfo.pgType == 'LG_U_PLUS'){
            alert('에스크로로 결제한 주문의 구매확정은 결제 대행(PG)사에서 발송된 이메일에서만 가능합니다.\n 자세한 문의는 고객센터로 해주세요.');
        } else {
            confirmExec(orderOptionNo);
        }
    }
}


function confirmExec(orderOptionNo) {
    if (shop.isLogin()) {
        diffApiMemberGuest = 'profile';
    } else {
        diffApiMemberGuest = 'guest';
    }

    shop.ajax({
        url: deployInfo.apiUrl + '/' + diffApiMemberGuest + '/order-options/' + orderOptionNo + '/confirm',
        type: 'PUT',
        success: $.proxy(function (res) {
            alert('구매확정 처리가 성공 하였습니다.');
            location.reload();
        }, this),
        error: $.proxy(function (res) {
            var result = JSON.parse(res.responseText);
            console.log(result);
            alert('구매확정 처리가 실패 하였습니다.');
            location.reload();
        }, this)
    })
}

//-------------cache orderinfo Start-------------------
function setOrderInfoInStorage (products, fromUrl) {
  deleteOrderInfoInStorage()
  var orderInfo = {
    option: products,
    fromUrl: fromUrl
  }
  window.localStorage.orderInfo = JSON.stringify(orderInfo)
}

function deleteOrderInfoInStorage () {
  delete window.localStorage.orderInfo
}

function setPrevOrderInfoInStoreage (ordersheetno) {
  var temp = window.localStorage.preOrderInfos ? JSON.parse(window.localStorage.preOrderInfos) : []
  temp.push({ ordersheetno: ordersheetno, orderInfo: window.localStorage.orderInfo })
  window.localStorage.preOrderInfos = JSON.stringify(temp)
}
//-------------cache orderinfo End-------------------
