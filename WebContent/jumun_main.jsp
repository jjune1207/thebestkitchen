<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.jumun.Jumun"%>
<%@page import="thebestkitchen.jumun.JumunService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf"%>
<%
   JumunService jumunService = new JumunService();
   ArrayList<Jumun> m_idJumunList = jumunService.m_idJumunList(sMemberId);
   MemberService memberService = new MemberService();
   Member member = memberService.findMember(sMemberId);
%>

<!DOCTYPE html>
<html>
<link rel=stylesheet href="css/import.css" type="text/css">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
   content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="../style/css/import.css">
<script type="text/javascript" async=""
   src="https://www.google-analytics.com/analytics.js"></script>
<script src="../js/jquery-1.7.2.js"></script>
<title>더베스트키친</title>
<script src="../js/lib/handlebars/handlebars-v3.1.0.js"></script>
<script src="../js/lib/jquery/jquery-handlebars.js"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>
<script src="../js/jquery.mask.js"></script>
<script src="../js/module/common.js"></script>
<script src="../js/utils/StringUtils.js"></script>
<script src="../js/module/appinfo.js"></script>
<script src="https://www.thetestkitchen.co.kr/config/deploy.js"></script>
<link rel="shortcut icon"
   href="https://api-storage.cloud.toast.com/v1/AUTH_69db659103894b00aa9f8b28aa62fe8e/shopby-favicon/1576743376241_투명파비콘1.ico">
<script src="https://www.thetestkitchen.co.kr/config/readyshop.js"></script>
<script src="https://www.thetestkitchen.co.kr/js/module/naverInflow.js"></script>
<script src="../js/module/metaTagBinder.js"></script>
<script src="../js/module/order.js"></script>
<script type="text/javascript"
   src="https://pay.kcp.co.kr/plugin/payplus_web.jsp"></script>
<style type="text/css">
.kcpTransDiv {
   filter: alpha(opacity = 10);
   -khtml-opacity: 0.1;
   -moz-opacity: 0.1;
   opacity: 0.1;
   top: 0px;
   left: 0;
   background-color: #000000;
   width: 100%;
   height: 100%;
   position: absolute;
   z-index: 10000;
}
</style>

<script type="text/javascript">
   function jumun() {
      var member = cart_and_order.member.value;
      cart_and_order.action = "jumun_action.jsp";
      cart_and_order.method = 'GET';
      cart_and_order.submit();
   }
   function delChecked(){
		order_remove_all.action = "jumun_remove_all_action.jsp";
		order_remove_all.method = 'POST';
		order_remove_all.submit();
	}
</script>
<script
   src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
   function sample6_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var addr = ''; // 주소 변수
                  var extraAddr = ''; // 참고항목 변수

                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                     addr = data.roadAddress;
                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                     addr = data.jibunAddress;
                  }

                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                  if (data.userSelectedType === 'R') {
                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                     if (data.bname !== ''
                           && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                     }
                     // 건물명이 있고, 공동주택일 경우 추가한다.
                     if (data.buildingName !== ''
                           && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', '
                              + data.buildingName : data.buildingName);
                     }
                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                     if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                     }
                     // 조합된 참고항목을 해당 필드에 넣는다.
                     // document.getElementById("sample6_extraAddress").value = extraAddr;

                  } else {
                     //document.getElementById("sample6_extraAddress").value = '';
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('sample6_postcode').value = data.zonecode;
                  document.getElementById("sample6_address").value = addr;

                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("sample6_detailAddress")
                        .focus();
               }
            }).open();
   }
   function update() {
      document.f.action = "jumun_address_update_aciton.jsp";
      document.f.method = 'POST';
      document.f.submit();
   }
</script>

</head>

<body>
   <jsp:include page="include_common_top.jsp" />
   <main id="main">
      <div class="wrap">

         <!-- ▼▼▼▼ order-wrap ▼▼▼▼ -->
         <div class="order-wrap">
            <!-- ▼▼▼▼ productsInf ▼▼▼▼ -->
            <div class="productsInf">
               <h1>주문결제</h1>
               <!-- ▼▼▼▼ products ▼▼▼▼ -->
               <div class="products">
                  <table>
                     <thead>
                        <tr>
                           <th class="line2">상품정보</th>
                           <th class="line3">수량</th>
                           <th class="line4">총가격</th>
                           <th class="line5">배송비</th>
                        </tr>
                     </thead>
                     <%
                        DecimalFormat df = new DecimalFormat("#,##0");
                        int tot = 0;
                        for (Jumun jumun : m_idJumunList) {
                           tot += (jumun.getJ_price());
                     %>
                     <tbody id="tb">
                        <tr>
                           <td class="line2">
                              <ul>
                                 <li>
                                    <p>
                                       <img src="main_image/main_image<%=jumun.getP_no()%>.jpg">
                                    </p>
                                 </li>
                                 <li>
                                    <dl>
                                       <dt><%=jumun.getJ_desc()%></dt>
                                    </dl>
                                 </li>
                              </ul>
                           </td>
                           <td class="line3"><%=jumun.getJ_qty()%></td>
                           <td class="line4">
                              <ul>
                                 <li><strong><%=df.format(jumun.getJ_price())%>
                                       원</strong></li>
                              </ul>
                           </td>
                           <td class="line5" rowspan="">
                               <ul>
                                 <%
                                    if (jumun.getJ_qty() * jumun.getJ_price() > 50000) {
                                 %>
                                 <li><strong>배송비 무료</strong></li>
                                 <%
                                    } else {
                                 %>
                                 <li><strong>3,000 원</strong></li>
                                 <%
                                    }
                                 %>
                              </ul>
                           </td>
                        </tr>
                     </tbody>
                     <%
                        }
                     %>
                  </table>
					<form id="order_remove" name="order_remove_all">
						<input name="member" type="hidden" value="<%=sMemberId%>">
						<li class="goDelete">
						<p>
							<button type="button" class="btn btn-outline-light btn-sm"
							onclick="delChecked()">목록비우기</button>
						</p>
						</li>
					</form>
               </div>
               <!-- ▲▲▲▲ products ▲▲▲▲ -->
               <!-- ▼▼▼▼ payment ▼▼▼▼ -->
               <div class="payment cf">
                  <h1>배송정보</h1>
                  <div class="infroArea cf">
                     <!-- ▼▼▼▼ part1 ▼▼▼▼ -->
                     <div class="part1 cf">
                        <!-- ▼▼▼▼ columnrleft ▼▼▼▼ -->
                        <div class="sales">
                           <form name="f" method="POST">
                              <table border="1">
                                 <tr>
                                    <td width="50" height="40" style="font-size: 15px;">&nbsp;&nbsp;아이디</td>
                                    <td width="300">&nbsp;&nbsp;<%=member.getM_id()%></td>
                                 </tr>
                                 <tr>
                                    <td height="40" style="font-size: 15px;">&nbsp;&nbsp;이름</td>
                                    <td>&nbsp;&nbsp;<input type="text" name="m_name"
                                       value="<%=member.getM_name()%>" style="width: 425px"></td>
                                 </tr>
                                 <tr>
                                    <td height="40" style="font-size: 15px;">&nbsp;&nbsp;우편번호</td>
                                    <td>&nbsp;&nbsp;<input type="text"
                                       id="sample6_postcode" name="md_postcode" placeholder="우편번호"
                                       value="<%=member.getMd_postcode()%>" style="width: 200px"
                                       readonly> <input type="button"
                                       onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
                                       style="width: 220px"></td>
                                 </tr>
                                 <tr>
                                    <td height="40" style="font-size: 15px;">&nbsp;&nbsp;주소</td>
                                    <td>&nbsp;&nbsp;<input type="text" id="sample6_address"
                                       name="md_address" value="<%=member.getMd_address()%>"
                                       style="width: 425px" placeholder="주소" readonly><br></td>
                                 </tr>
                                 <tr>
                                    <td height="40" style="font-size: 15px;">&nbsp;&nbsp;상세주소</td>
                                    <td>&nbsp;&nbsp;<input type="text"
                                       id="sample6_detailAddress" name="md_daddress"
                                       value="<%=member.getMd_daddress()%>" placeholder="상세주소"
                                       style="width: 425px"><br></td>
                                 </tr>
                                 <tr>
                                    <td height="40" style="font-size: 15px;">&nbsp;&nbsp;전화번호</td>
                                    <td>&nbsp;&nbsp;<input type="text" name="m_phone"
                                       maxlength="13" value="<%=member.getM_phone()%>"
                                       onKeyup="SetNum(this);" style="width: 425px"
                                       placeholder="(-을 빼고 입력해주세요)"></td>
                                 </tr>
                              </table>
                              <div align="center">
                              <input type="button" value="배송지변경"
                                 style="width: 200px; height: 40px" onclick="update()">
                              <input type="reset" value="취소"
                                 style="width: 200px; height: 40px">
                              </div>



                           </form>


                        </div>
                        <!-- ▲▲▲▲ columnleft ▲▲▲▲ -->
                        <button class="delivery_more js-more-hide on"
                           style="display: none;">
                           <span>배송지 정보 닫기</span>
                        </button>
                     </div>
                     <!-- ▲▲▲▲ part1 ▲▲▲▲ -->
                     <!-- ▼▼▼▼ part2 ▼▼▼▼ -->
                     <div class="part2" id="agree" style="">
                     </div>
                     <!-- ▲▲▲▲ part2 ▲▲▲▲ -->
                  </div>
               </div>
               <!-- ▲▲▲▲ products ▲▲▲▲ -->
               <!-- ▼▼▼▼ totalPrice ▼▼▼▼ -->
               <div class="totalPrice">
                  <div class="priceDetail" id="totalPrice" style="">
                     <h2>최종 결제금액</h2>
                     <ul>
                        <li>
                           <p>상품금액</p> <span><%=df.format(tot)%> 원</span>
                        </li>
                        <li>
                           <p>배송비</p> 
                           <%
                              if(tot == 0) {
                           %>
                              <span>(+) 0 원</span>               
                           <%
                              } else if (tot > 50000) {
                            %> <span>(+) 배송비 무료</span> <%
                               } else {
                            %> <span>(+) 3,000 원</span> <%
                               }
                            %>
                        </li>
                        <li class="totalMoney">
                           <p>총 결제금액</p> 
                           <%
                              if(tot == 0) {                           
                           %>
                              <span> 0 원</span>   
                           <%
                              } else if (tot < 50000) {
                           %> <span class="sum"><%=df.format((tot + 3000))%> 원</span> <%
                               } else {
                            %> <span class="sum"><%=df.format(tot)%> 원</span> <%
                               }
                            %>
                        </li>
                        <li>
                           <form id="cart_and_order_f" name="cart_and_order">
                              <input name="member" type="hidden" value="<%=sMemberId%>">
                              <button type="button" class="btn black style-2-2" id="payBtn"
                                 value="결제" onclick="jumun();">결제하기</button>

                           </form>
                        </li>
                     </ul>

                  </div>
               </div>
               <!-- ▲▲▲▲ payment ▲▲▲▲ -->
            </div>
            <!-- ▲▲▲▲ productsInf ▲▲▲▲ -->
         </div>
         <!-- ▲▲▲▲ order-wrap ▲▲▲▲ -->
      </div>
      <!-- 
         <input name="p_no" type="hidden" value="">
          -->
   </main>
   <jsp:include page="include_common_bottom.jsp" />
</body>
</html>