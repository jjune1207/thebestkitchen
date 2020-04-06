<%@page import="thebestkitchen.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member fmember = (Member)request.getAttribute("fmember");
	if(fmember==null){
		fmember = new Member("","","","");
	}
	String msg = (String)request.getAttribute("msg");
	if(msg==null) msg = "";

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원가입</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
	function memberCreate() {

		if (document.f.memberId.value == "") {
			alert("아이디를 입력하십시요.");
			f.memberId.focus();
			return false;
		}
		if (f.password.value == "") {
			alert("비밀번호를 입력하십시요.");
			f.password.focus();
			return false;
		}
		if (f.password_re.value == "") {
			alert("비밀번호확인을 입력하십시요.");
			f.password_re.focus();
			return false;
		}
		if (f.name.value == "") {
			alert("이름을 입력하십시요.");
			f.name.focus();
			return false;
		}
		if (f.phone.value == "") {
			alert("전화번호를 입력하십시요.");
			f.phone.focus();
			return false;
		}

		if (f.password.value != f.password_re.value) {
			alert("비밀번호와 비밀번호확인은 일치해야 합니다.");
			f.password.focus();
			//전체 선택
			f.password.select();
			return false;
		}

		f.action = "member_write_action.jsp";
		f.method='POST';
		f.submit();
		alert("회원가입을 축하합니다 짝짝짝!!");
		
	}
	
	// 아이디 중복체크 화면open
	function openIdChk(){
		var param="?memberId="+document.f.memberId.value;
		window.name = "parentForm";
		window.open("member_id_check_form.jsp"+param,
				"chkForm", "width=500,height=300,resizable = no,scrollbars = no");	

	}

	// 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
	// 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
	// 다시 중복체크를 하도록 한다.
	function inputIdChk(){
		document.memberInfo.idDuplication.value ="idUncheck";
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
	function formReset() {
		f.memberId.value= "";
		f.password.value= "";
		f.password_re.value= "";
		f.name.value= "";
		f.phone.value= "";
	}

	</script>
</head>

<body>

<!-- ▼▼▼▼▼▼ wrapper ▼▼▼▼▼▼ -->
<div id="wrapper">  

    <!-- ▼▼▼▼ header ▼▼▼▼ -->
    <div id="header">
   		<!-- include_common_top.jsp start-->
		<jsp:include page="include_common_top.jsp"/>
		<!-- include_common_top.jsp end-->
    </div>
    <!-- ▲▲▲▲ header ▲▲▲▲ -->

    <!-- ▼▼▼▼ main ▼▼▼▼ -->
    <main id="main">
        <div class="wrap">
            <div class="login-wrap">
                <div class="enter" id="enter">
                    <h1>회원가입</h1>
                    <div class="join-form" id="" style="">
                        <h5>회원정보 입력</h5>
                        <div class="join-infor-text">
                            * 필수 입력 사항
                        </div>
                        <!-- write Form  -->
						<form action="member_write_action.jsp" name="f" method="post">
	                        <dl>
	                            <dt><em class="must">* </em>아이디</dt>
	                            <dd>
	                                <input class="input-middle" type="text" id="memberId" name="memberId" value="<%=fmember.getM_id() %>" readonly placeholder="아이디 입력">
	                           		<input type="button" value="중복확인" class="btn black common-3" style="height: 41px; margin-left: 30px;" onclick="openIdChk();">
	                           		<input type="hidden" name="idDuplication" value="idUncheck" >
									<font color="red"><%=msg%></font>
	                            </dd>
	                        </dl>
	                        <dl>
	                            <dt><em class="must">* </em>비밀번호</dt>
	                            <dd>
	                                <input class="input-large" type="password" id="password" name="password" value="<%=fmember.getM_pw() %>" placeholder="비밀번호 입력" maxlength="20">
	                            </dd>
	                        </dl>
	                        <dl>
	                            <dt><em class="must">* </em>비밀번호  확인</dt>
	                            <dd>
	                                <input class="input-large" type="password" id="password_re" name="password_re" value="<%=fmember.getM_pw() %>" placeholder="비밀번호 한 번 더 입력" maxlength="20">
	                            </dd>
	                        </dl>
	                        <dl>
	                            <dt><em class="must">* </em>이름</dt>
	                            <dd>
	                                <input class="input-large" type="text" id="username" name="name" value="<%=fmember.getM_name() %>" placeholder="이름 입력" maxlength="30">
	                            </dd>
	                        </dl>
	                        <dl>
	                            <dt><em class="must">* </em>휴대전화</dt>
	                            <dd>
	                                <input class="input-large" type="tel" id="mobileNo" name="phone" value="<%=fmember.getM_phone() %>" placeholder="___-____-____" maxlength="13" onKeyup="SetNum(this);">
	                            </dd>
	                        </dl>
	                        </form>
	                    <p class="txt-infor">
	                        본인은 만 14세 이상이며, <span class="link_terms"> 이용약관</span>, <span class="link_terms">개인정보 수집 및 이용</span> 내용을 확인 하였으며 동의합니다.
	                    </p>
	                </div>
	                <p style="height: 60px;">
	                    <button type="button" class="btn black common-1" id="join_submit" onclick="memberCreate();">동의하고 가입하기</button>
	                </p>
	                <p style="height: 60px;">
	                    <button type="button" class="btn white-2 common-1" id="join_reset" style="margin:5% 0;" onClick="formReset();">다시 작성하기</button>
	                </p>
            	</div>
        	</div>
    	</div>
    </main>
    <!-- ▲▲▲▲ main ▲▲▲▲ -->

    <!-- ▼▼▼▼ footer ▼▼▼▼ -->
    <div id="footer" >
   		<!-- include_common_bottom.jsp start-->
		<jsp:include page="include_common_bottom.jsp"/>
		<!-- include_common_bottom.jsp end-->
    </div>
    <!-- ▲▲▲▲ footer ▲▲▲▲ -->

</div>
<!-- ▲▲▲▲▲▲ wrapper ▲▲▲▲▲▲ -->

</body>
</html>
