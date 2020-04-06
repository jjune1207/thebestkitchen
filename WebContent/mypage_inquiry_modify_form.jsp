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

	Integer boardno = null;
	try {
		boardno = Integer.valueOf(request.getParameter("boardno"));
	} catch (Exception ex) {
	}
	//글번호가 없다면
	if (boardno == null) {
		//목록으로 이동
		response.sendRedirect("board_notice_list.jsp");
		return;
	}
	Board board = BoardService.getInstance().findBoard(boardno);
	if (board == null) {
		response.sendRedirect("board_notice_list.jsp");
		return;
	}
	
	
	String pageno = "1";
	if (request.getParameter("pageno") != null) {
		pageno = request.getParameter("pageno");
	}	
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
<script language="JavaScript">
	function boardUpdate() {
		if (f.title.value == "") {
			alert("제목을 입력하십시요.");
			f.title.focus();
			return false;
		}
		if (f.content.value == "") {
			alert("내용을 입력하십시요.");
			f.content.focus();
			return false;
		}
	
		f.action = "board_notice_modify_action.jsp";
		f.submit();
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
                                <h2>상품문의 - 수정</h2>
								<form name="f" method="post">
								<input type="hidden" name="pageno" value="<%=pageno%>" /> <input
									type="hidden" name="boardno" value="<%=board.getB_no()%>" />
								<input type="hidden" name="b_type" value="<%=board.getB_type() %>" />
								<table border="0" cellpadding="0" cellspacing="1" width="590"
									bgcolor="BBBBBB">
									<tr>
										<td width=100 align=center bgcolor="E6ECDE" height="22">제목</td>
										<td width=490 bgcolor="ffffff" style="padding-left: 10px"
											align="left"><input type="text" style="width: 150"
											name="title" value="<%=board.getB_title()%>"></td>
									</tr>
									<tr>
										<td width=100 align=center bgcolor="E6ECDE" height="22">내용</td>
										<td width=490 bgcolor="ffffff" style="padding-left: 10px"
											align="left"><textarea name="content"
												style="width: 350px" rows="14"><%=board.getB_content().replace("\n", ">>").trim()%></textarea></td>
									</tr>


								</table>
							</form>  
							  <br>

							<table width=590 border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td align=center><input type="button" value="수정"
										onClick="boardUpdate()"> &nbsp; <input type="button"
										value="취소" onClick="goBack()"></td>
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