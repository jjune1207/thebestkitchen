<%@page import="thebestkitchen.board.Board"%>
<%@page import="thebestkitchen.product.Product"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/member_login_check.jspf"%>

<%

	Board board=new Board();
	board.setP_no(Integer.parseInt(request.getParameter("p_no")));
	
	
	MemberService memberService=new MemberService();
	boolean adCheck=memberService.adminCheck((String)session.getAttribute("sMemberId"));

	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel=stylesheet href="css/stylesboard.css" type="text/css">
<link rel=stylesheet href="css/board.css" type="text/css">
<script type="text/javascript">
	function boardCreate() {
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

		f.action = "board_review_write_action.jsp";
		f.method="POST";
		f.submit();
	}
	function goBack(){
		history.back();
	}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0
	marginwidth=0 marginheight=0>
	<!-- container start-->
	<div id="container">
		<!-- header start -->
		<div id="header">
		</div>
		<!-- header end -->
		<!-- wrapper start -->
			<!-- include_common_top.jsp start-->
			<jsp:include page="include_common_top.jsp" />
			<!-- include_common_top.jsp end-->
			<!-- content start -->
			<!-- include_content.jsp start-->
			<div id="content">
				<table border=0 cellpadding=0 cellspacing=0>
					<tr>
						<td><br />
							<table style="padding-left: 10px" border=0 cellpadding=0
								cellspacing=0>
								
								<tr>
									
								</tr>
							</table> <br> <!-- write Form  -->
							<form name="f" method="post">
								
								<table border="0" cellpadding="0" cellspacing="1" width="590"
									bgcolor="BBBBBB">
									<td bgcolor="f4f4f4" height="22">&nbsp;&nbsp;<b>게시판 작성</b></td>
											<td><font size="2">게시판 종류</font></th>
											<td width="100"><select name="board" size="1">
													<%if(adCheck==true){ %> 
														<option value="N"><font size="2">공지사항</font></option>
													<%} %>
													<option value="R"><font size="2">구매후기</font></option>
													<option value="Q"><font size="2">상품문의</font></option>
											</select></td>
									<tr>
										<td width=100 align=center bgcolor="E6ECDE" height="22">제목</td>
										<td width=490 bgcolor="ffffff" style="padding-left: 10px"
											align="left"><input type="text" style="width: 150px"
											name="title"></td>
									</tr>
									<tr>
										<td width=100 align=center bgcolor="E6ECDE">내용</td>
										<td width=490 bgcolor="ffffff" style="padding-left: 10px"
											align="left"><textarea name="content" class="textarea"
												style="width: 350px" rows="14"></textarea></td>
									<td><input type="hidden" value="<%=board.getP_no()%>" name="p_no"></td>
								</table>
									</tr>
								<tr>
									<td align=center><input type="button" value="쓰기"
										name="p_no" value="<%=board.getP_no() %>"
										onClick="boardCreate()"> &nbsp; <input type="button"
										value="취소" onClick="goBack()"></td>
								</tr>
							</form> <br>
							<table width=590 border=0 cellpadding=0 cellspacing=0>
							</table></td>
					</tr>
				</table>
			</div>
			<!-- include_content.jsp end-->
			<!-- content end -->
		</div>
		<!--wrapper end-->
		<div id="footer">
			<!-- include_common_bottom.jsp start-->
			<jsp:include page="include_common_bottom.jsp" />
			<!-- include_common_bottom.jsp end-->
		</div>
	<!--container end-->
</body>
</html>