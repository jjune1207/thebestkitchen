<%@page import="thebestkitchen.member.Member"%>
<%@page import="thebestkitchen.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equalsIgnoreCase("GET")){
		response.sendRedirect("member_login_form.jsp");
		return;
	}
	try{
		MemberService memberService = new MemberService();
		String[] checkbox = request.getParameterValues("checkbox");
		for(int i=0;i<checkbox.length;i++){
			String memberId = request.getParameter("memberId_"+checkbox[i]);
			String password = request.getParameter("password_"+checkbox[i]);
			String name = request.getParameter("name_"+checkbox[i]);
			String phone = request.getParameter("phone_"+checkbox[i]);
			String retire = request.getParameter("retire_"+checkbox[i]);
			String admin = request.getParameter("admin_"+checkbox[i]);
			String address = request.getParameter("address_"+checkbox[i]);
			String daddress = request.getParameter("daddress_"+checkbox[i]);
			String postcode = request.getParameter("postcode_"+checkbox[i]);
			String birth = request.getParameter("birth_"+checkbox[i]);
			//memberService.update(new Member()));
			out.println("아이디:"+checkbox[i]+"<br/>");
			out.println("이름:"+name+"<br/>");
		}
			
		/*
		out.println("<script>");
		out.println("alert('회원정보가 수정되었습니다.');");
		out.println("</script>");
		*/
	}catch(Exception e){
		e.printStackTrace();
		RequestDispatcher rd = request.getRequestDispatcher("manager_member.jsp");
		rd.forward(request,response);
		return;
	}
%>