
<%@page import="thebestkitchen.exception.MemberNotFoundException"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equalsIgnoreCase("GET")){
		response.sendRedirect("member_find_pw_form.jsp");
		return;
	}
	try{
		String memberId = request.getParameter("memberId");
		String name = request.getParameter("name");
		
		MemberService memberService = MemberService.getInstance();	
		String result = memberService.findMemberPw(memberId, name);
		
		out.println("<script>");
		out.println("alert('임시 비밀번호는 "+result+"입니다.');");
		out.println("location.href = 'member_login_form.jsp';");
		out.println("</script>");
		
	}catch(MemberNotFoundException e){
		e.printStackTrace();
		request.setAttribute("msg", e.getMessage());
		RequestDispatcher rd = request.getRequestDispatcher("member_find_pw_form.jsp");
		rd.forward(request,response);
		return;
	}catch(Exception e){
		e.printStackTrace();
		RequestDispatcher rd = request.getRequestDispatcher("member_find_pw_form.jsp");
		rd.forward(request,response);
		return;
	}
%>