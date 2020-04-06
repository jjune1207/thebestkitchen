<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String msg1 = (String)request.getAttribute("msg1");
	if(msg1==null)msg1="";
	String msg2 = (String)request.getAttribute("msg2");
	if(msg2==null)msg2="";
	String msg3 = (String)request.getAttribute("msg3");
	if(msg3==null)msg3="";
	
	String fMemberId = request.getParameter("memberId");
	if(fMemberId==null)fMemberId="";
	String fPassword = request.getParameter("password");
	if(fPassword==null)fPassword="";
	
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>로그인</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		function login() {
			if (f.memberId.value == "") {
				alert("아이디를 입력하세요");
				f.memberId.focus();
				return false;
			}
			if (f.password.value == "") {
				alert("비밀번호를 입력하세요");
				f.password.focus();
				return false;
			}
	
			f.action = "member_login_action.jsp";
			f.submit();
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
          <h1>로그인</h1>
          <form name="f" method="post">
	          <ul class="login-form">
	            <li>
	              <input class="input-large" type="email" id="memberId" name="memberId" value="" placeholder="아이디">
	            </li>
	            <li>
	              <input class="input-large" type="password" id="password" name="password" value="" placeholder="비밀번호">
	            </li>
	            <!-- 
	            <li>
	              <div class="check-text txt_l">
	                <div class="checkbox-normal">
	                  <input id="id-save" type="checkbox" name="checkbox">
	                  <label></label>
	                </div>
	              </div>
	            </li>
	            -->
	            <li>
	            	<div>
	            		&nbsp;&nbsp;<font color="red" ><%=msg1 %><%=msg2 %><%=msg3 %></font>
	            	</div>
	            </li>
	          </ul>
          </form>
          <ul class="login-btn">
            <li style="height: 61px">
              <button type="submit" id="memberLoginBtn" class="btn black common-1" onClick="login();">로그인</button>
            </li>
          </ul>
          <ul class="login-etc cf">
            <li><a href="./member_write_form.jsp" >회원가입</a></li>
            <li><a href="./member_find_id_form.jsp">아이디 찾기</a></li>
            <li><a href="./member_find_pw_form.jsp">비밀번호 찾기</a></li>
          </ul>	
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
