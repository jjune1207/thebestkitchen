
<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.mypage.ProductHugi"%>
<%@page import="thebestkitchen.mypage.mypageService"%>
<%@page import="thebestkitchen.mypage.hugiutil.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%!public String getTitleString(ProductHugi producthugi) {
		StringBuilder title = new StringBuilder(128);
		String t = producthugi.getB_title();
		if (t.length() > 20) {
			t = String.format("%s...", t.substring(0, 20));
		}
		title.append(t.replace(" ", "&nbsp;"));
		
		return title.toString();
	}
%>
<%
	mypageService mypageService = new mypageService();
	MemberService memberService = new MemberService();
	int count = memberService.getjumuncount(sMemberId);
%>

<%
	//1.요청페이지번호	
	String pageno = request.getParameter("pageno");
	if(pageno == null || pageno.equals("")){
		pageno = "1";
	}	
	//2.한페이지에보여줄 페이지번호갯수(<< 1 2 3 4 5 6 7 8 9 10>>)
	int pageCountPerPage = 10;
	//3.한페이지에표시할 게시물수 
	int rowCountPerPage = 15;
	//페이징(계산)을위한DTO,VO
	HugiPageInputDto HugipageInputDto=
			new HugiPageInputDto(rowCountPerPage, pageCountPerPage, pageno, "", "");
	
	//게시물조회	
	HugiListPageDto hugiListPage 
		= BoardService.getInstance().findHugiList(HugipageInputDto, sMemberId);
	
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
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
    <div class=" display-table" style="margin-left:15%; width:70%;">
        <div class="row display-table-row">
            <div class="col-md-2 col-sm-1 hidden-xs display-table-cell v-align box" id="navigation"style="height: 94%;">
                <div class="navi">
                    <ul>
                        <li><a href="mypage_main.jsp"><i class="fa fa-home" aria-hidden="true"></i><span class="hidden-xs hidden-sm">주문내역 <%=count%>건</span></a></li>
                        <li><a href="cart_form.jsp"><i class="fa fa-cog" aria-hidden="true"></i><span class="hidden-xs hidden-sm">장바구니</span></a></li>
                        <li><a href="mypage_inquiry_form.jsp"><i class="fa fa-tasks" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품문의</span></a></li>
                        <li class="active"><a href="mypage_hugi_form.jsp"><i class="fa fa-bar-chart" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품후기</span></a></li>
                        <li><a href="mypage_modify_form.jsp"><i class="fa fa-user" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원정보 변경</span></a></li>
                        <li><a href="mypage_remove_form.jsp"><i class="fa fa-calendar" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원탈퇴</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="user-dashboard" style="width:100%;">
                    
                    <div class="row" style="width:70%;margin: 0 0 3% 26%;">
                        <div class="col-md-5 col-sm-5 col-xs-12 gutter"style="width:91%;">

                            <div class="sales">
                                <h2 class="my_title">상품후기</h2>
                                <form name="f" method="post">
			
							<table border="1">
								<tr>
									<td width=300 align=center bgcolor="0E1A35" height="25" style="color:white; font-size:17px">상품정보</td>
									<td width=300 align=center bgcolor="0E1A35" style="color:white; font-size:17px">후기내용</td>
									<td width=100 align=center bgcolor="0E1A35" style="color:white; font-size:17px">작성자</td>
									<td width=150 align=center bgcolor="0E1A35" style="color:white; font-size:17px">등록일</td>
								</tr>
								<!-- loop start -->
								<%for(ProductHugi hugi: hugiListPage.getList()){
								System.out.println(hugi.getM_id());%>
								<tr>
									
									<td width=300 align=center bgcolor="ffffff" style="padding-left: 10">
										<a href="product_detail_form.jsp?p_no=<%=hugi.getP_no()%>" class="user">
										<%=hugi.getP_name()%></a>
									<td width=300 align=center bgcolor="ffffff" style="padding-left: 10">
										<a href="mypage_hugi_view.jsp?boardno=<%=hugi.getB_no()%>" class="user">
										<%=getTitleString(hugi)%></a>
									<td width=150 align=center bgcolor="ffffff"><%=hugi.getM_id()%></td>
									<td width=150 align=center bgcolor="ffffff"><%=hugi.getB_date()%></td>
								</tr>
								<%} %>
								<!--loop end  -->
								
								
								
							</table>
							</form> 
							<table>							
								<tr>
									<td align="center">
										<%if (hugiListPage.isShowFirst()) {%> 
											<a href="mypage_hugi_form.jsp?pageno=1">◀◀</a>&nbsp; 
										<%}%> 
										<%if (hugiListPage.isShowPreviousGroup()) {%>
											<a href=".mypage_hugi_form.jsp?pageno=<%=hugiListPage.getPreviousGroupStartPageNo()%>">◀</a>&nbsp;&nbsp;
										<%}%>
										<%
										 	for (int i = hugiListPage.getStartPageNo(); i <= hugiListPage
										 			.getEndPageNo(); i++) {
										 	if (hugiListPage.getSelectPageNo() == i) {
										%>
										 <font color='red'><strong><%=i%></strong></font>&nbsp;
										<%} else {%>
										<a href="mypage_hugi_form.jsp?pageno=<%=i%>"><strong><%=i%></strong></a>&nbsp;
										<%
										   }
										  }%>
										<%if (hugiListPage.isShowNextGroup()) {%> 
											<a href="mypage_hugi_form.jsp?pageno=<%=hugiListPage.getNextGroupStartPageNo()%>">▶&nbsp;</a>
										<%}%> 
										<%if (hugiListPage.isShowLast()) {%> 
											<a href="mypage_hugi_form.jsp?pageno=<%=hugiListPage.getTotalPageCount()%>">▶▶</a>&nbsp;
										<%}%>
									</td>
								</tr>
							</table>

                                
                            </div>
                        </div>
                    </div>
                </div>
        </div>        
     </div>
     
           
</body>

</html>