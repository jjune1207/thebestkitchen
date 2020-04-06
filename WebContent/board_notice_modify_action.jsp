<%@page import="thebestkitchen.board.BoardService"%>
<%@page import="thebestkitchen.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
 //post 요청인 경우 요청 데이터에 한글 문자셋으로 설정
if (request.getMethod().toLowerCase().equals("post")) {
	 
}

//1. Board 객체를 만들고 사용자가 입력한 데이터를 저장
Board board = new Board();
board.setB_no(
	Integer.parseInt(request.getParameter("boardno")));
board.setB_title(request.getParameter("title"));
board.setB_content(request.getParameter("content"));

//2. 데이터베이스에 변경된 내용 적용
BoardService.getInstance().update(board);
String pageno = "1";
if (request.getParameter("pageno") != null) {
	pageno = request.getParameter("pageno");
}

//3. 수정된 게시글로 이동
response.sendRedirect(
	String.format("board_notice_view.jsp?boardno=%d&pageno=%s",
	board.getB_no(), pageno));
%>
