<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	Board board=new Board();
	board.setM_id((String)session.getAttribute("sMemberId"));
	board.setB_title(request.getParameter("title"));
	board.setB_content(request.getParameter("content"));
	board.setB_type(request.getParameter("board"));
	board.setP_no(Integer.parseInt(request.getParameter("p_no")));
	BoardService.getInstance().createBoard(board);
	response.sendRedirect("mypage_inquiry_form.jsp");
	
%>