<%@page import="thebestkitchen.cart.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%	//session 발생시 session id 받아오기 ;
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	int c_qty = Integer.parseInt(request.getParameter("c_qty"));
	System.out.println(p_no+"랑"+c_qty);
	CartService cartService = new CartService();
	cartService.deleteCartItem(p_no);
	response.sendRedirect("cart_form.jsp");	
%>
