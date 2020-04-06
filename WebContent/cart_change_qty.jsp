<%@page import="thebestkitchen.cart.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/member_login_check.jspf"%>
<%	
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	int c_qty = Integer.parseInt(request.getParameter("c_qty"));
	CartService cartService = new CartService();
	cartService.update(p_no, c_qty,sMemberId);
	response.sendRedirect("cart_form.jsp");
%>