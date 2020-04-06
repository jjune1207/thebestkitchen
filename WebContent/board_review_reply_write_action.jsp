	<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Board객체를 생성하고 입력된데이타를 읽어서 객체에저장
	Board board=new Board();
	/*
	원글boardno
	*/
	board.setB_no(
			Integer.parseInt(request.getParameter("boardno")));
	/*
	답글 데이타
	*/
	board.setB_title(request.getParameter("title"));
	board.setM_id(request.getParameter("writer"));
	board.setB_content(request.getParameter("content"));
	board.setB_type(request.getParameter("typeR"));		

	board.setP_no(Integer.parseInt(request.getParameter("p_no")));
	
	BoardService.getInstance().createReplay(board);
	
	String pageno = "1";
	if(request.getParameter("pageno")!=null){
		pageno=request.getParameter("pageno");
	}
	response.sendRedirect(
			String.format("board_review_list.jsp?pageno=%s",pageno));
	
%>