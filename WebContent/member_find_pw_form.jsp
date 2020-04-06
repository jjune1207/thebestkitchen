<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String msg = (String)request.getAttribute("msg");
	if(msg==null)msg="";
	
	String fMemberId = request.getParameter("memberId");
	if(fMemberId==null)fMemberId="";
	String fName = request.getParameter("name");
	if(fName==null)fName="";	
	
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <title>비밀번호찾기</title>
  	<script type="text/javascript">
		function findPw() {
			if (f.memberId.value == "") {
				alert("아이디를 입력하세요");
				f.memberId.focus();
				return false;
			}
			if (f.name.value == "") {
				alert("이름을 입력하세요");
				f.name.focus();
				return false;
			}
	
			f.action = "member_find_pw_action.jsp";
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
            <div id="password_find_form">
              <h1>비밀번호 찾기</h1>
              <form name="f" method="post">
	              <p class="login-sub-tit">임시비밀번호가 발급됩니다.</p>
	              <ul class="login-form">
	                <li>
	                  <input class="input-large" type="text" name="memberId" value="" placeholder="아이디">
	                </li>
	                <li>
	                <input class="input-large" type="text" name="name" value="" placeholder="이름">
	                </li>
	                <li>
	            	<div>
	            		&nbsp;&nbsp;<font color="red" ><%=msg%></font>
	            	</div>
	            	</li>
	              </ul>
              </form>
              <ul class="login-btn">
                <li style="height: 61px">
                  <button type="submit" id="submit-auth-btn" class="btn black common-1" onclick="findPw();">다음</button>
                </li>
              </ul>
            </div>
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