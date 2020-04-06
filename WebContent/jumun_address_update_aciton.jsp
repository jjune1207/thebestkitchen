<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf" %>
<!DOCTYPE html>
<%
	String address = request.getParameter("md_address");
	String daddress = request.getParameter("md_daddress");
	String postcode = request.getParameter("md_postcode");
	MemberService memberService = new MemberService();
	memberService.updateAddress(address, postcode, daddress, sMemberId);
	out.println("<script>alert('주문정보가 변경되었습니다.'); location.href='jumun_main.jsp';</script>");
	
	
%>