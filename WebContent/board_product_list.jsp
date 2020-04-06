<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.board.util.BoardListPageDto"%>
<%@page import="thebestkitchen.board.util.PageInputDto"%>
<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!public String getTitleString(Board board) {
		StringBuilder title = new StringBuilder(128);
		String t = board.getB_title();
		if (t.length() > 15) {
			//t = t.substring(0,15);
			//t = t+"...";
			t = String.format("%s...", t.substring(0, 15));
		}
		//답글공백삽입
				for (int i = 0; i < board.getB_depth(); i++) {
					title.append("&nbsp;&nbsp;");
				}
				if (board.getB_depth() > 0) {
					title.append("<img border='0' src='image/re.gif'/>");
				}
				
				title.append(t.replace(" ", "&nbsp;"));
				
		return title.toString();
	}
	%>

<%
//1.요청페이지번호	
String pageno=request.getParameter("pageno");
if(pageno==null||pageno.equals("")){
	pageno="1";
}	
//2.한페이지에표시할 게시물수 
int rowCountPerPage = 10;
//3.한페이지에보여줄 페이지번호갯수(<< 1 2 3 4 5 6 7 8 9 10>>)
int pageCountPerPage = 10;
//페이징(계산)을위한DTO,VO
PageInputDto pageInputDto=
		new PageInputDto(rowCountPerPage,pageCountPerPage,pageno,"","");

//게시물조회

BoardListPageDto boardListPage 
	=BoardService.getInstance().findBoardQnaList(pageInputDto);


	
//관리자확인
MemberService memberService=new MemberService();
boolean adCheck=memberService.adminCheck((String)session.getAttribute("sMemberId"));


//String adminCheck=(String)session.getAttribute("adminCheck");
//if(adminCheck==null)adminCheck="noAdmin";

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>공지사항</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel=stylesheet href="css/stylesboard.css" type="text/css">
<link rel=stylesheet href="css/board.css" type="text/css">
<script type="text/javascript">
	function boardCreate() {
		location.href = "board_notice_write_form.jsp";
	}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0
	marginwidth=0 marginheight=0>
		<!-- header start -->
		<div id="header" >
			<!-- include_common_top.jsp start-->
			<jsp:include page="include_common_top.jsp" />
			<!-- include_common_top.jsp end-->
		</div>
		<!-- header end -->
		

			<!-- content start -->
			<!-- include_content.jsp start-->

			<div id="content">
				<table border=0 cellpadding=0 cellspacing=0>
					<tr>
						<td><br />
							<table style= border=0 cellpadding=0
								cellspacing=0>
								<tr>
									<td bgcolor="f4f4f4" align=center>&nbsp;&nbsp; <b>관리자</b>
									<tr>
										<td><a href="board_notice_list.jsp">공지사항</a>
										<a href="board_product_list.jsp">상품문의</a>
										<a href="board_review_list.jsp">상품후기</a>
									</td>
								</tr>
								<tr bgcolor="#FFFFFF">
									<td  height="20" class="t1" align="right" valign="bottom">♠
										총 <font color="#FF0000"><%=boardListPage.getTotalRecordCount()%></font>
										건 | 현재페이지( <font color="#FF0000"><%=boardListPage.getSelectPageNo()%></font>
										/ <font color="#0000FF"><%=boardListPage.getTotalPageCount()%></font>
										)
									</td>
								</tr>
							</table> <br /> <!-- list -->
							<form name="f" method="post" action="">
								<table border="0" cellpadding="0" cellspacing="1" width="800"
									bgcolor="BBBBBB">

									<tr>
										<td width=80 align=center bgcolor="E6ECDE">글쓴이</td>
										<td width=80 align=center bgcolor="E6ECDE">제목</td>
										<td width=120 align=center bgcolor="E6ECDE">글쓴날</td>
										<td width=70 align=center bgcolor="E6ECDE">조회수</td>
									</tr>
									<%
										for (Board board : boardListPage.getList()) {
									%>
									
									<tr>
										<td width=260 bgcolor="ffffff" style="padding-left: 10px" align="center"><%=board.getM_id() %></td>
										<td width=260 bgcolor="ffffff" style="padding-left: 10px" align="center">
										<a href='board_product_view.jsp?boardno=<%=board.getB_no()%>&pageno=<%=boardListPage.getSelectPageNo()%>'><%=getTitleString(board)%></a>
										</td>
										<td width=120 bgcolor="ffffff" style="padding-left: 10"><%=board.getB_date() %>
										</td>
										<td width=70 align=center bgcolor="ffffff" ><%=board.getB_count() %></td>
									</tr>
									 
									<%
										}
									%>
								</table>
								<!-- /list -->
							</form> <br>
							<table border="0" cellpadding="0" cellspacing="1" width="590">
								<tr>
									<td align="center">
										<%if (boardListPage.isShowFirst()) {%> 
											<a href="./board_product_list.jsp?pageno=1">◀◀</a>&nbsp; 
										<%}%> 
										<%if (boardListPage.isShowPreviousGroup()) {%>
											<a href="./board_product_list.jsp?pageno=<%=boardListPage.getPreviousGroupStartPageNo()%>">◀</a>&nbsp;&nbsp;
										<%}%>
										<%
										 	for (int i = boardListPage.getStartPageNo(); i <= boardListPage
										 			.getEndPageNo(); i++) {
										 	if (boardListPage.getSelectPageNo() == i) {
										%>
										 <font color='red'><strong><%=i%></strong></font>&nbsp;
										<%} else {%>
										<a href="./board_product_list.jsp?pageno=<%=i%>"><strong><%=i%></strong></a>&nbsp;
										<%
										   }
										  }%>
										   <%
 	if (boardListPage.isShowNextGroup()) {
 %> <a
										href="./board_product_list.jsp?pageno=<%=boardListPage.getNextGroupStartPageNo()%>">▶&nbsp;</a>
										<%
											}
										%> <%
 	if (boardListPage.isShowLast()) {
 %> <a
										href="./board_product_list.jsp?pageno=<%=boardListPage.getTotalPageCount()%>">▶▶</a>&nbsp;
										<%
											}
										%>
									</td>
								</tr>
							</table>
					</tr>
				</table>
			</div>
			<!-- include_content.jsp end-->
			<!-- content end -->
		<div id="footer">
			<!-- include_common_bottom.jsp start-->
			<jsp:include page="include_common_bottom.jsp" />
			<!-- include_common_bottom.jsp end-->
		</div>
</body>
</html>