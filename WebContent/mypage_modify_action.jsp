<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<%
	String pw = request.getParameter("m_pw");
	String name = request.getParameter("m_name");
	String phone = request.getParameter("m_phone");
	String address = request.getParameter("md_address");
	String birth = request.getParameter("md_birth");
	String daddress = request.getParameter("md_daddress");
	String postcode = request.getParameter("md_postcode");
		
	MemberService memberService = new MemberService();
	if(pw == null || pw.equals("")) {
		memberService.update(new Member(sMemberId, sMemberPw, name, phone, "F", "F", address, birth, daddress, postcode));		
	}
	else {
		memberService.update(new Member(sMemberId, pw, name, phone, "F", "F", address, birth, daddress, postcode));		
	}

	out.println("<script>alert('회원정보가 변경되었습니다.'); location.href='mypage_main.jsp';</script>");
	
	
%>
