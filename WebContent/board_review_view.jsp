<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	Integer boardno=null;
	int pageno=1;
	try{
		boardno=Integer.parseInt(request.getParameter("boardno"));
		pageno=Integer.parseInt(request.getParameter("pageno"));
	}catch(Exception e){
		
	}
	if(boardno==null){
		//목록으로이동
		response.sendRedirect("mypage_inquiry_form.jsp?pageno="+pageno);
		return;
	}
	Board board=BoardService.getInstance().findBoard(boardno);
	if(board==null){
		response.sendRedirect("mypage_inquiry_form.jsp?pageno="+pageno);
		return;
	}
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>상품후기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel=stylesheet href="css/stylesboard.css" type="text/css">
<link rel=stylesheet href="css/board.css" type="text/css">
<script language="JavaScript">
	function boardUpdate() {
		document.f.action = "board_notice_modify_form.jsp";
		document.f.submit();
	}
	function boardRemove() {
		if (confirm("정말 삭제하시겠습니까?")) {
			document.f.action = "board_notice_remove_action.jsp";
			document.f.submit();
	}
}
	function boardReplyCreate() {
		document.f.action = "board_review_reply_write_form.jsp";
		document.f.method='POST';
		document.f.submit();
	}
	function boardList() {
		f.action = "board_review_list.jsp?pageno="+<%=pageno%>;
		f.submit();
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
		</div>
		<!-- navigation end-->
		<!-- wrapper start -->
		<div id="wrapper">
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
									<td bgcolor="f4f4f4" height="22">&nbsp;&nbsp; <b> 상품후기 </b>
									</td>
								</tr>
							</table> <br> 
							<form name="f" method="post">
								<input type="hidden" name="boardno" value="<%=board.getB_no()%>">
								<input type="hidden" name="pageno" value="<%=pageno%>">
								<input type="hidden" name="p_no" value="<%=board.getP_no() %>">
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
								
									<td align=center><input type="button" value="수정" onClick="boardUpdate()">
										&nbsp; <input type="button" value="삭제" onClick="boardRemove()"> 
										
										<input type="button" value="답글쓰기" onClick="boardReplyCreate()">
										&nbsp; <input type="button" value="목록" onClick="boardList()"></td>
								</tr>
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
	</div>
	<!--container end-->
</body>
</html>