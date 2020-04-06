<%@page import="thebestkitchen.jumun.JumunService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/member_login_check.jspf"%>  

<!DOCTYPE html>
<%
	JumunService jumunService = new JumunService();
	jumunService.deleteOrder(sMemberId);
	out.println("<script>alert('주문 전 목록을 비우셨습니다.'); location.href='jumun_main.jsp';</script>");
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>order deleted</title>
</head>
<body>

</body>
</html>
