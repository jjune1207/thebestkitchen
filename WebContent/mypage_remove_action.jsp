<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%
	String id = request.getParameter("m_id");
	MemberService memberService = new MemberService();
	memberService.retire(id);
	session.invalidate();
	out.println("<script>alert('탈퇴가 정상적으로 이루어졌습니다.'); location.href='main.jsp';</script>");
	
%>