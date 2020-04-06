<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.mypage.jumunutil.JumunListPageDto"%>
<%@page import="thebestkitchen.mypage.jumunutil.JumunPageInputDto"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.mypage.JumunList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.mypage.mypageService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
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
	JumunPageInputDto JumunpageInputDto=
			new JumunPageInputDto(rowCountPerPage, pageCountPerPage, pageno, "", "");
	
	//게시물조회	
	JumunListPageDto jumunListPage 
		= BoardService.getInstance().findJumunList(JumunpageInputDto, sMemberId);
	
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
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
                        <li class="active"><a href="mypage_main.jsp"><i class="fa fa-home" aria-hidden="true"></i><span class="hidden-xs hidden-sm">주문내역 <%=count%>건</span></a></li>
                        <li><a href="cart_form.jsp"><i class="fa fa-cog" aria-hidden="true"></i><span class="hidden-xs hidden-sm">장바구니</span></a></li>
                        <li><a href="mypage_inquiry_form.jsp"><i class="fa fa-tasks" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품문의</span></a></li>
                        <li><a href="mypage_hugi_form.jsp"><i class="fa fa-bar-chart" aria-hidden="true"></i><span class="hidden-xs hidden-sm">상품후기</span></a></li>
                        <li><a href="mypage_modify_form.jsp"><i class="fa fa-user" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원정보 변경</span></a></li>
                        <li><a href="mypage_remove_form.jsp"><i class="fa fa-calendar" aria-hidden="true"></i><span class="hidden-xs hidden-sm">회원탈퇴</span></a></li>
                    </ul>
                </div>
            </div>
            <div class="user-dashboard" style="width:100%;">
                    
                    <div class="row" style="width:70%;margin: 0 0 3% 26%;">
                        <div class="col-md-5 col-sm-5 col-xs-12 gutter" style="width:91%;">

                            <div class="sales">
                                <h2 class="my_title">주문내역</h2>
                                <form name="f" method="post">
			
							<table border="1">
								<tr>
									<td width=150 align=center bgcolor="0E1A35" height="25" style="color:white; font-size:17px">주문번호</td>
									<td width=300 align=center bgcolor="0E1A35" style="color:white; font-size:17px">상품정보</td>
									<td width=100 align=center bgcolor="0E1A35" style="color:white; font-size:17px">수량</td>
									<td width=200 align=center bgcolor="0E1A35" style="color:white; font-size:17px">가격</td>
									<td width=100 align=center bgcolor="0E1A35" style="color:white; font-size:17px">결제 여부</td>
								</tr>
								<!-- loop start -->
								<%for(JumunList jumun: jumunListPage.getList()){ %>
								<tr>
									<td width=50 align=center bgcolor="ffffff" height="25" ><%=jumun.getJ_no()%></td>
									<td width=300 align=center bgcolor="ffffff" >
										<a href="product_detail_form.jsp?p_no=<%=jumun.getP_no()%>" class="user">
										<%=jumun.getP_name()%></a>
									<td width=120 align=center bgcolor="ffffff" ><%=jumun.getJ_qty()%></td>
									<td width=120 align=center bgcolor="ffffff" ><%=jumun.getJ_price()%></td>
									<%if(jumun.getJ_payment().equals("N")) { %>
                             		 <td width=120 align=center bgcolor="ffffff" >결제 중</td>
		                           <%}
		                           else {%>                           
		                              <td width=120 align=center bgcolor="ffffff" >결제 완료</td>
		                           <%} %>
								</tr>
								<%} %>
								<!--loop end  -->
								
								
								
							</table>
							</form>
							<table>							
								<tr>
									<td align="center">
										<%if (jumunListPage.isShowFirst()) {%> 
											<a href="mypage_main.jsp?pageno=1">◀◀</a>&nbsp; 
										<%}%> 
										<%if (jumunListPage.isShowPreviousGroup()) {%>
											<a href=".mypage_main.jsp?pageno=<%=jumunListPage.getPreviousGroupStartPageNo()%>">◀</a>&nbsp;&nbsp;
										<%}%>
										<%
										 	for (int i = jumunListPage.getStartPageNo(); i <= jumunListPage
										 			.getEndPageNo(); i++) {
										 	if (jumunListPage.getSelectPageNo() == i) {
										%>
										 <font color='red'><strong><%=i%></strong></font>&nbsp;
										<%} else {%>
										<a href="mypage_main.jsp?pageno=<%=i%>"><strong><%=i%></strong></a>&nbsp;
										<%
										   }
										  }%>
										<%if (jumunListPage.isShowNextGroup()) {%> 
											<a href="mypage_main.jsp?pageno=<%=jumunListPage.getNextGroupStartPageNo()%>">▶&nbsp;</a>
										<%}%> 
										<%if (jumunListPage.isShowLast()) {%> 
											<a href="mypage_main.jsp?pageno=<%=jumunListPage.getTotalPageCount()%>">▶▶</a>&nbsp;
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