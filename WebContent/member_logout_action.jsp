<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%
	//세션 무효화
	session.invalidate();
	//로그아웃 완료
	response.sendRedirect("main.jsp");
%>