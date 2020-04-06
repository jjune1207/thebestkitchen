<%@page import="thebestkitchen.board.Board"%>
<%@page import="thebestkitchen.product.Product"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/member_login_check.jspf"%>

<%

	Board board=new Board();
	board.setP_no(Integer.parseInt(request.getParameter("p_no")));
	
	//관리자확인
	MemberService memberService=new MemberService();
	boolean adCheck=memberService.adminCheck((String)session.getAttribute("sMemberId"));

	
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
	
		f.action = "board_product_write_action.jsp";
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
			<div class="container">
	<div class="row">
	    
	    <div class="col-md-8 col-md-offset-2">
	        
    		
    		<form name="f" method="post">
											<td width="100"><select name="board" size="1">
													<option value="Q"><font size="2">상품문의</font></option>
													<option value="R"><font size="2">구매후기</font></option>
											</select>
    		    <td><input type="hidden" value="<%=board.getP_no()%>" name="p_no"></td>
    		    <div class="form-group">
    		        <label for="title">제목 <span class="require">*</span></label>
    		        <input type="text" class="form-control" name="title" />
    		    </div>
    		    
    		    <div class="form-group">
    		        <label for="description">내용</label>
    		        <textarea rows="5" class="form-control" name="content" ></textarea>
    		    </div>
    		    
    		    <table width=590 border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td align=center><input type="button" value="쓰기"
										onClick="boardCreate()"> &nbsp; <input type="button"
										value="취소" onClick="goBack()"></td>
								</tr>
							</table>
    		    </div>
    		    
    		</form>
		</div>
		
	</div>
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