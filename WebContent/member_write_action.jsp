<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.exception.ExistedMemberException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equalsIgnoreCase("GET")){
		response.sendRedirect("member_write_form.jsp");
		return;
	}

	String memberId = request.getParameter("memberId");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	
	Member newMember = null;
	
	try{
		MemberService memberService = new MemberService();
		newMember = new Member(memberId,password,name,phone);
		memberService.create(newMember);
		response.sendRedirect("member_login_form.jsp");
		
	}catch(ExistedMemberException e){
		request.setAttribute("msg", e.getMessage());
		request.setAttribute("fmember", newMember);
		//정보유지
		RequestDispatcher rd = request.getRequestDispatcher("member_write_form.jsp");
		rd.forward(request, response);
		return;
	}catch(Exception e){
		e.printStackTrace();
		return;
	}
%>