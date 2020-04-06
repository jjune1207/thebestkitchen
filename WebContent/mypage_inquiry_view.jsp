<%@page import="thebestkitchen.board.Board"%>
<%@page import="thebestkitchen.mypage.inquiryutil.InquiryPageInputDto"%>
<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.mypage.ProductInquiry"%>
<%@page import="thebestkitchen.mypage.mypageService"%>
<%@page import="thebestkitchen.mypage.inquiryutil.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%	
	mypageService mypageService = new mypageService();
	MemberService memberService = new MemberService();
	int count = memberService.getjumuncount(sMemberId);
	
	Integer boardno=null;
	int pageno=1;
	try{
		boardno=Integer.parseInt(request.getParameter("boardno"));
		pageno=Integer.parseInt(request.getParameter("pageno"));
	}catch(Exception e){
		
	}
	if(boardno==null){
		//목록으로이동
		response.sendRedirect("board_notice_list.jsp?pageno="+pageno);
		return;
	}
	Board board=BoardService.getInstance().findBoard(boardno);
	if(board==null){
		response.sendRedirect("board_notice_list.jsp?pageno="+pageno);
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
<script language="JavaScript">
function boardUpdate() {
	document.f.action = "mypage_inquiry_modify_form.jsp";
	document.f.submit();
}
function boardRemove() {
	if (confirm("정말 삭제하시겠습니까?")) {
		document.f.action = "board_notice_remove_action.jsp";
		document.f.submit();
	}
}
function goBack(){
	history.back();
}
</script>
<style>
table {
width: 590px; 
}
td {
height: 25px;
}
</style>
</head>
  <link rel=stylesheet href="css/mypage.css" type="text/css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<body class="home">
 <jsp:include page="include_common_top.jsp"></jsp:include>
    <div class="container-fluid display-table">
        <div class="row display-table-row">
            <div class="col-md-2 col-sm-1 hidden-xs display-table-cell v-align box" id="navigation">
                <div class="navi">
                    <ul>
                        <li class="active"><a href="mypage_main.jsp"><i class="fa fa-home" aria-hidden="true"></i><span class="hidden-xs hidden-sm">주문내역 <%=count%>건</span></a></li>
                        <li><a href="cart_form.jsp"><i class="fa fa-cog" aria-hidden="true"></i><span class="hidden-xs hidden-sm">장바구니</span></a></li>
                        <li><a href="mypage_inquiry_form.jsp"><i class="fa fa-tasks" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품문의</span></a></li>
                        <li><a href="mypage_hugi_form.jsp"><i class="fa fa-bar-chart" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품후기</span></a></li>
                        <li><a href="mypage_modify_form.jsp"><i class="fa fa-user" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원정보 변경</span></a></li>
                        <li><a href="mypage_remove_form.jsp"><i class="fa fa-calendar" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원탈퇴</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="user-dashboard">
                    
                    <div class="row">
                        <div class="col-md-5 col-sm-5 col-xs-12 gutter">

                            <div class="sales">
                                <h2>상품문의</h2>
								<div id="content">
				<table border=0 cellpadding=0 cellspacing=0>
					<tr>
						<td><br />
							<form name="f" method="post">
								<input type="hidden" name="boardno" value="<%=board.getB_no()%>">
								<input type="hidden" name="pageno" value="<%=pageno%>">
								<table border="0" cellpadding="0" cellspacing="1" width="590"
									bgcolor="BBBBBB">

									<tr>
										<td width=100 align=center bgcolor="E6ECDE" height="22">제목</td>
										<td width=490 bgcolor="ffffff" style="padding-left: 10px"
											align="left"><%=board.getB_title()%></td>
									</tr>
									<tr>
										<td width=100 align=center bgcolor="E6ECDE" height="22">내용</td>
										<td width=490 bgcolor="ffffff" height="180px"
											style="padding-left: 10px" align="left"><%=board.getB_content().replace("\n","<br/>")%><br />

										</td>
									</tr>

								</table>

							</form> <br>
							<table width=590 border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td align=center><input
										type="button" value="수정" onClick="boardUpdate()">
										&nbsp; <input type="button" value="삭제" onClick="boardRemove()"> 
										&nbsp; <input type="button" value="목록" onClick="goBack()"></td>
								</tr>
							</table></td>
					</tr>
				</table>
			</div>
			<!-- include_content.jsp end-->
			<!-- content end -->
		</div>
		<!--wrapper end-->
								

                                
                            </div>
                        </div>
                    </div>
                </div>
        </div>        
     </div>
     
           
</body>

</html>