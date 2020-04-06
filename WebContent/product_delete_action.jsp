<%@page import="thebestkitchen.product.ProductService"%>
<%@page import="thebestkitchen.product.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String p_no = request.getParameter("p_no");
	ProductService productService = new ProductService();
	Product product = productService.findByP_no(Integer.parseInt(p_no));
	boolean deleteResult = productService.productDelete(product.getP_no());
	if(deleteResult){
		response.sendRedirect("product_form.jsp");
	}
%>