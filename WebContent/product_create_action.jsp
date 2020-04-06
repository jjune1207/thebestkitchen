<%@page import="thebestkitchen.product.ProductService"%>
<%@page import="thebestkitchen.product.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String p_name = request.getParameter("p_name");
	String p_price = request.getParameter("p_price");
	String p_desc =  request.getParameter("p_desc");
	String p_image = request.getParameter("p_image");
	Product newProduct = null;
	
	ProductService productService = new ProductService();
	newProduct = new Product(-999, p_name, Integer.parseInt(p_price), 
							p_desc, -999);
	productService.registerProduct(newProduct);
	response.sendRedirect("product_form.jsp");
%>