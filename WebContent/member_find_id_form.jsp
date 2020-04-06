<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	String msg = (String)request.getAttribute("msg");
	if(msg==null)msg="";
	
	String fName = request.getParameter("name");
	if(fName==null)fName="";	
	String fPhone = request.getParameter("phone");
	if(fPhone==null)fPhone="";
	
%>
<!DOCTYPE html>

<html lang="ko">

<head>
  <title>아이디찾기</title>
  <meta charset="utf-8">
    	<script type="text/javascript">
		function findId() {
			if (f.name.value == "") {
				alert("이름을 입력하세요");
				f.name.focus();
				return false;
			}
			if (f.phone.value == "") {
				alert("휴대폰번호를 입력하세요");
				f.phone.focus();
				return false;
			}
	
			f.action = "member_find_id_action.jsp";
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
            <h1>아이디 찾기</h1>
            <form name="f" method="post">
              <ul class="login-form find-email">
                <li>
                  <input class="input-large" type="text" name="name" value="" placeholder="이름">
                </li>
                <li>
				  <input class="input-large" type="text" name="phone" value="" placeholder="휴대폰번호">
                </li>
                <li>
	            	<div>
	            		&nbsp;&nbsp;<font color="red" ><%=msg%></font>
	            	</div>
	            </li>
              </ul>
          	</form>
              <ul class="login-btn find-email">
              <li style="height: 61px">
				<button type="submit" id="findemail-btn" class="btn black common-1" onclick="findId();">확인</button>
              </li>
              </ul>
				<ul class="login-etc type2 cf">
				  <li><a href="./member_login_form.jsp">로그인</a></li>
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