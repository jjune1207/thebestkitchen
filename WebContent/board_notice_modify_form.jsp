<%@page import="javafx.scene.layout.Border"%>
<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%



	
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
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

	function boardList() {
		f.action = "board_notice_list.jsp";
		f.submit();
	}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0
	marginwidth=0 marginheight=0>
		<!-- header start -->
		<div id="header">
		</div>
		<!-- header end -->
			<!-- include_common_top.jsp start-->
			<jsp:include page="include_common_top.jsp" />
			<!-- include_common_top.jsp end-->
			<!-- content start -->
			<!-- include_content.jsp start-->
			<div class="container">
	<div class="row">
	    
	    <div class="col-md-8 col-md-offset-2">
	        
    		
    		<form name="f" method="post">
    		    <input type="hidden" name="pageno" value="<%=pageno%>" /> <input
									type="hidden" name="boardno" value="<%=board.getB_no()%>" />
								<input type="hidden" name="b_type" value="<%=board.getB_type() %>" />
								<table border="0" cellpadding="0" cellspacing="1" width="590"
									bgcolor="BBBBBB">
    		    <div class="form-group">
    		        <label for="title">제목 <span class="require">*</span></label>
    		        <input type="text" class="form-control" name="title"
    		        value="<%=board.getB_title()%>" />
    		    </div>
    		    
    		    <div class="form-group">
    		        <label for="description">내용</label>
    		        <textarea rows="5" class="form-control" name="content" ><%=board.getB_content().replace("\n", ">>").trim()%></textarea>
    		    </div>
							</form>  
							  <br>

							<table width=590 border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td align=center><input type="button" value="수정"
										onClick="boardUpdate()"> &nbsp; <input type="button"
										value="취소" onClick="boardList()"></td>
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