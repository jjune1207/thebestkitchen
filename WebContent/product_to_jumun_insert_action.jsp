<%@page import="thebestkitchen.product.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="member_login_check.jspf" %>
<%
	String p_no = request.getParameter("p_no");
	String p_desc = request.getParameter("p_desc");
	String p_price = request.getParameter("p_price");
	
	ProductService productService = new ProductService();
	productService.jumunAdd(Integer.parseInt(p_no), sMemberId, p_desc, Integer.parseInt(p_price));
	response.sendRedirect("jumun_main.jsp");
%>