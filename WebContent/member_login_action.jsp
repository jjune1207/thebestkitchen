<%@page import="thebestkitchen.exception.MemberRetireException"%>
<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@page import="thebestkitchen.exception.PasswordMismatchException"%>
<%@page import="thebestkitchen.exception.MemberNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equalsIgnoreCase("GET")){
		response.sendRedirect("member_login_form.jsp");
		return;
	}
	try{
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("password");
		
		MemberService memberService = MemberService.getInstance();	
		Member loginMember = memberService.login(memberId, memberPw);
		
		session.setAttribute("sMemberId", memberId);
		session.setAttribute("sMemberPw", memberPw);
		session.setAttribute("sMember", loginMember);
		
		response.sendRedirect("main.jsp");
		
	}catch(MemberNotFoundException e){
		request.setAttribute("msg1", e.getMessage());
		RequestDispatcher rd = request.getRequestDispatcher("member_login_form.jsp");
		rd.forward(request,response);
		return;
	}catch(PasswordMismatchException e){
		request.setAttribute("msg2", e.getMessage());
		RequestDispatcher rd = request.getRequestDispatcher("member_login_form.jsp");
		rd.forward(request,response);
		return;
	}catch(MemberRetireException e){
		request.setAttribute("msg3", e.getMessage());
		RequestDispatcher rd = request.getRequestDispatcher("member_login_form.jsp");
		rd.forward(request,response);
		return;
	}catch(Exception e){
		e.printStackTrace();
		RequestDispatcher rd = request.getRequestDispatcher("member_login_form.jsp");
		rd.forward(request,response);
		return;
	}
%>