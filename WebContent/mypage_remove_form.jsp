<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%
	MemberService memberService = new MemberService();
	Member member = memberService.findMember(sMemberId);
	int count = memberService.getjumuncount(sMemberId);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
	function remove() {		
		document.f.action = "mypage_remove_action.jsp";
		document.f.submit();
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
                        <li><a href="mypage_modify_form.jsp"><i class="fa fa-user" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원정보 변경</span></a></li>
                        <li class="active"><a href="mypage_remove_form.jsp"><i class="fa fa-calendar" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원탈퇴</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="user-dashboard" style="width:100%;">
                    
                    <div class="row" style="width:70%;margin: 0 0 3% 26%;">
                        <div class="col-md-5 col-sm-5 col-xs-12 gutter"style="width:91%;">
                       

                            <div class="sales">
                                <h2 class="my_title">회원탈퇴</h2>
                                <div style="font-size:20px;margin:50px 0;">회원탈퇴 시, 회원정보는 1개월간 보존됩니다.<br>
								정말 탈퇴하시겠습니까?<br>
								</div>
                                <form name="f" method="post" style="margin-left:450px; margin-top:240px;">
                                <input type='hidden' name='m_id' value='<%=member.getM_id() %>'>
                                <input type="submit" class="btn black common-1" value="탈퇴" style="width:150px;height:40px " onclick="remove()">
								<input type="button" class="btn gray common-1" value="취소" style="width:150px;height:40px" onclick="location.href='mypage_main.jsp'">
			
							
								</form> 

                                
                            </div>
                        </div>
                    </div>
                </div>
        </div>        
     </div>
     
           
</body>

</html>