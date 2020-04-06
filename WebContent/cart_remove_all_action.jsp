<%@page import="thebestkitchen.cart.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/member_login_check.jspf"%>    
<!DOCTYPE html>
<%
	CartService cartService = new CartService();
	cartService.deleteCart(sMemberId);
	out.println("<script>alert('장바구니를 비우셨습니다.'); location.href='cart_form.jsp';</script>");
%>