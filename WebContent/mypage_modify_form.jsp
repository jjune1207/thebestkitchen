<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%
	MemberService memberService = new MemberService();
	Member member = memberService.findMember(sMemberId);
	int count = memberService.getjumuncount(sMemberId);
	
	String phone = (String)member.getM_phone();
	String address = (String)member.getMd_address();
	String birth = (String)member.getMd_birth();
	String daddress = (String)member.getMd_daddress();
	String postcode = (String)member.getMd_postcode();
	
	if(phone == null || phone.equals("")){
		member.setM_phone("");
	}
	
	if(address == null || address.equals("")){
		member.setMd_address("");
	}
	
	if(birth == null || birth.equals("")){
		member.setMd_birth("");
	}
	
	if(daddress == null || daddress.equals("")){
		member.setMd_daddress("");
	}
	if(postcode == null || postcode.equals("")){
		member.setMd_postcode("");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
	function update() {
		if (document.f.m_pw.value != f.m_repw.value) {
			alert("비밀번호와 비밀번호 확인은 일치해야합니다.");
			document.f.m_repw.select();
			document.f.m_repw.focus();
			return false;
		}
		
		document.f.action = "mypage_modify_action.jsp";
		document.f.method = 'POST';
		document.f.submit();
	}
	
	function SetNum(obj) {
		 
		/* 숫자만 되도록 */
		if ((event.keyCode <= 27) || (event.keyCode >= 33 && event.keyCode <= 46) || (event.keyCode >= 91 && event.keyCode <= 93) || (event.keyCode >= 112 && event.keyCode <= 145)) {
		  return false;
		}
	 
		val=obj.value;
		re=/[^0-9]/gi;
		obj.value=val.replace(re,"");
	 
		/*전화번호 '-'대쉬추가*/
		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";
		 
		if(number.length < 4) {
			return number;
		} else if(number.length < 7) {
			phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3);
		} else if(number.length < 11) {
		    phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3, 3);
		    phone += "-";
		    phone += number.substr(6);
		} else {
		    phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3, 4);
		    phone += "-";
		    phone += number.substr(7);
		}
		obj.value = phone;
	}
	
	function SetNum2(obj) {
		 
		/* 숫자만 되도록 */
		if ((event.keyCode <= 27) || (event.keyCode >= 33 && event.keyCode <= 46) || (event.keyCode >= 91 && event.keyCode <= 93) || (event.keyCode >= 112 && event.keyCode <= 145)) {
		  return false;
		}
	 
		val=obj.value;
		re=/[^0-9]/gi;
		obj.value=val.replace(re,"");
	 
		var number = obj.value.replace(/[^0-9]/g, "");
		var birth = "";
		 
		if(number.length < 4) {
			return number;
		} else if(number.length < 7) {
			birth += number.substr(0, 3);
			birth += number.substr(3);
		} else if(number.length < 11) {
			birth += number.substr(0, 3);
			birth += number.substr(3, 3);
			birth += number.substr(6);
		} else {
			birth += number.substr(0, 3);
			birth += number.substr(3, 4);
			birth += number.substr(7);
		}
		obj.value = birth;
	}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
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
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

</head>
  <link rel=stylesheet href="css/mypage.css" type="text/css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<body class="home">
 <jsp:include page="include_common_top.jsp"></jsp:include>
    <div class=" display-table" style="margin-left:15%; width:70%;">
        <div class="row display-table-row">
            <div class="col-md-2 col-sm-1 hidden-xs display-table-cell v-align box" id="navigation" style="height: 94%;">
                <div class="navi">
                    <ul>
                       <li><a href="mypage_main.jsp"><i class="fa fa-home" aria-hidden="true"></i><span class="hidden-xs hidden-sm">주문내역 <%=count%>건</span></a></li>
                        <li><a href="cart_form.jsp"><i class="fa fa-cog" aria-hidden="true"></i><span class="hidden-xs hidden-sm">장바구니</span></a></li>
                        <li><a href="mypage_inquiry_form.jsp"><i class="fa fa-tasks" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품문의</span></a></li>
                        <li><a href="mypage_hugi_form.jsp"><i class="fa fa-bar-chart" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품후기</span></a></li>
                        <li class="active"><a href="mypage_modify_form.jsp"><i class="fa fa-user" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원정보 변경</span></a></li>
                        <li><a href="mypage_remove_form.jsp"><i class="fa fa-calendar" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원탈퇴</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="user-dashboard" style="width:100%;">
                    
                    <div class="row" style="width:70%;margin: 0 0 3% 26%;">
                        <div class="col-md-5 col-sm-5 col-xs-12 gutter"style="width:91%;">

                            <div class="sales">
                                <h2 class="my_title">회원정보 변경</h2>
                                <form name="f" method="POST">
                                <table border="2px;"style="margin-bottom:20px;">
									<tr>
										<td width="300" height="40" style="font-size:15px;">&nbsp;&nbsp;아이디</td>
										<td width="450">&nbsp;&nbsp;<%=member.getM_id()%></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;이름</td>
										<td>&nbsp;&nbsp;<input type="text" name="m_name" value="<%=member.getM_name()%>" style="width:425px"></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;신규 비밀번호</td>
										<td>&nbsp;&nbsp;<input type="password" name="m_pw" style="width:425px"></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;신규 비밀번호 확인</td>
										<td>&nbsp;&nbsp;<input type="password" name="m_repw" style="width:425px"></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;주소</td>
										<td>&nbsp;&nbsp;<input type="text" id="sample6_postcode" name="md_postcode" placeholder="우편번호" value="<%=member.getMd_postcode()%>" style="width:200px" readonly>
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="width:220px"></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;"></td>
										<td>&nbsp;&nbsp;<input type="text" id="sample6_address" name="md_address" value="<%=member.getMd_address()%>" style="width:425px" placeholder="주소" readonly><br></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;"></td>
										<td>&nbsp;&nbsp;<input type="text" id="sample6_detailAddress" name="md_daddress" value="<%=member.getMd_daddress() %>" placeholder="상세주소" style="width:425px"><br></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;생일</td>
										<td>&nbsp;&nbsp;<input type="text" name="md_birth" maxlength="6" value="<%=member.getMd_birth()%>" onKeyup="SetNum2(this);" style="width:425px" placeholder="(6자리로 입력해주세요)"></td>
									</tr>
									<tr>
										<td height="40" style="font-size:15px;">&nbsp;&nbsp;전화번호</td>
										<td>&nbsp;&nbsp;<input type="text" name="m_phone" maxlength="13" value="<%=member.getM_phone()%>" onKeyup="SetNum(this);" style="width:425px" placeholder="(-을 빼고 입력해주세요)"></td>
									</tr>
								</table>
								<input type="button"  class="btn black common-1" value="변경" style="width:150px;height:40px; margin-left:485px;"onclick="update()">
								<input type="reset"  class="btn black common-1" value="취소" style="width:150px;height:40px ">
								
			
							
								</form> 

                                
                            </div>
                        </div>
                    </div>
                </div>
        </div>        
     </div>
     
           
</body>

</html>