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
//페이징(계산)을 위한 DTO,VO
PageInputDto pageInputDto=
		new PageInputDto(rowCountPerPage,pageCountPerPage,pageno,"","");

//게시물조회

BoardListPageDto boardListPage 
	=BoardService.getInstance().findBoardList(pageInputDto);


	
//관리자확인
MemberService memberService=new MemberService();
boolean adCheck=memberService.adminCheck((String)session.getAttribute("sMemberId"));



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>공지사항</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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

			
<div class="container">
	<div class="row">
        <div class="col-md-3">
            <form action="#" method="get">
                <div class="input-group">
                </div>
            </form>
        </div>
		<div class="col-md-9">
    	 <table class="table table-list-search" align=right>
                    <thead>
	                    <tr>
							<%if(adCheck==true){ %> 
							<td bgcolor="f4f4f4" align=center>&nbsp;&nbsp; <b>관리자</b>
							<tr>
							<%} %>
							<td bgcolor="f4f4f4" align=center>&nbsp;&nbsp; <b>공지사항</b>
						</td>
						</tr>
			
									<td  height="20" class="t1" align="right" valign="bottom">♠
										총 <font color="#FF0000"><%=boardListPage.getTotalRecordCount()%></font>
										건 | 현재페이지( <font color="#FF0000"><%=boardListPage.getSelectPageNo()%></font>
										/ <font color="#0000FF"><%=boardListPage.getTotalPageCount()%></font>
										)
									</td>
						
                        <tr>
                            <th>글쓴이</th>
                            <th>제목</th>
                            <th>글쓴날</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <%
							for (Board board : boardListPage.getList()) {
						%>
                        <tr>
                            <td><%=board.getM_id() %></td>
                            <td><a href='board_notice_view.jsp?boardno=<%=board.getB_no()%>&pageno=<%=boardListPage.getSelectPageNo()%>'><%=getTitleString(board)%></a></td>
                            <td><%=board.getB_date() %></td>
                            <td><%=board.getB_count() %></td>
                        </tr>
                        <%
							}
						%>
                    </tbody>
                </table>   
                </form> <br>
                <table border="0" cellpadding="0" cellspacing="1" width="590">
								<tr>
									<td align="center">
										<%if (boardListPage.isShowFirst()) {%> 
											<a href="./board_notice_list.jsp?pageno=1">◀◀</a>&nbsp; 
										<%}%> 
										<%if (boardListPage.isShowPreviousGroup()) {%>
											<a href="./board_notice_list.jsp?pageno=<%=boardListPage.getPreviousGroupStartPageNo()%>">◀</a>&nbsp;&nbsp;
										<%}%>
										<%
										 	for (int i = boardListPage.getStartPageNo(); i <= boardListPage
										 			.getEndPageNo(); i++) {
										 	if (boardListPage.getSelectPageNo() == i) {
										%>
										 <font color='red'><strong><%=i%></strong></font>&nbsp;
										<%} else {%>
										<a href="./board_notice_list.jsp?pageno=<%=i%>"><strong><%=i%></strong></a>&nbsp;
										<%
										   }
										  }%>
										   <%
 	if (boardListPage.isShowNextGroup()) {
 %> <a
										href="./board_notice_list.jsp?pageno=<%=boardListPage.getNextGroupStartPageNo()%>">▶&nbsp;</a>
										<%
											}
										%> <%
 	if (boardListPage.isShowLast()) {
 %> <a
										href="./board_notice_list.jsp?pageno=<%=boardListPage.getTotalPageCount()%>">▶▶</a>&nbsp;
										<%
											}
										%>
									</td>
								</tr>
							</table> <!-- button -->
							<%if(adCheck==true){ %> 
							<table border="0" cellpadding="0" cellspacing="1" width="590">
								<tr>
									<td align="right"><input type="button" value="글쓰기"
										onclick="boardCreate();" /></td>
								</tr>
							</table></td>
							<% } %>
					</tr>
				</table>
                
		</div>
	</div>
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