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
	//공지사항이므로 상품번호 임의 값 입력
	board.setP_no(3);
	BoardService.getInstance().createBoard(board);
	response.sendRedirect("board_notice_list.jsp");
	
%>