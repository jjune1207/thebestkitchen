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
		response.sendRedirect("board_notice_list.jsp?pageno="+pageno);
		return;
	}
	Board board=BoardService.getInstance().findBoard(boardno);
	if(board==null){
		response.sendRedirect("board_notice_list.jsp?pageno="+pageno);
		return;
	}
	
	//읽은회수증가
	BoardService.getInstance().updateHitCount(boardno);
	
	//관리자확인
	MemberService memberService=new MemberService();
	boolean adCheck=memberService.adminCheck((String)session.getAttribute("sMemberId"));
	
	//String adminCheck=(String)session.getAttribute("sMemberId");
	//if(adminCheck==null)adminCheck="noAdmin";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>공지사항</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script language="JavaScript">
function boardCreate() {
	f.action = "board_notice_write_form.jsp";
	f.submit();
}
function boardReplyCreate() {
	document.f.action = "board_reply_write_form.jsp";
	document.f.method='POST';
	document.f.submit();
}
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
function boardList() {
	f.action = "board_notice_list.jsp?pageno="+<%=pageno%>;
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
								</tr>
							</table> <br> 
							 <form name="f" method="post">
								<input type="hidden" name="boardno" value="<%=board.getB_no()%>">
								<input type="hidden" name="pageno" value="<%=pageno%>">
								<table border="0" cellpadding="0" cellspacing="1" width="590"
									bgcolor="BBBBBB">


								</table>
								
							 <div id="background-carousel">
						    <div id="myCarousel" class="carousel slide" data-ride="carousel">
						      <div class="carousel-inner">
						        <div class="item active" style="background-image:url(http://placehold.it/1600x800/)"></div>
						        <div class="item" style="background-image:url(http://placehold.it/1600x800/)"></div>
						        <div class="item" style="background-image:url(http://placehold.it/1600x800/)"></div>  
						      </div>
						    </div>
						</div>
						 
						 
						<div id="content-wrapper">
						<!-- PAGE CONTENT -->
						    <div class="container">
						        <div class="page-header"><h3><%=board.getB_title()%></h3></div>
						        <div class="well"><p><%=board.getB_content().replace("\n","<br/>")%></a></p>
						          </div><!-- End Well -->
						    </div><!-- End Container -->
						<!-- PAGE CONTENT -->
						</div>
						
						
							

							</form> <br>
							<table width=590 border=0 cellpadding=0 cellspacing=0>
								<tr>
								<td align=center>
								<% if(adCheck==true) {%>
									<input type="button" value="글쓰기"
										onClick="boardCreate()"> &nbsp; <input
										type="button" value="수정" onClick="boardUpdate()">
										&nbsp; <input type="button" value="삭제" onClick="boardRemove()"> <%} %>
										<!-- 
										<input type="button" value="답글쓰기" onClick="boardReplyCreate()"> -->
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