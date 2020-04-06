<%@page import="thebestkitchen.product.Product"%>
<%@page import="thebestkitchen.product.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String p_no = request.getParameter("p_no");
	String p_name = request.getParameter("p_name");
	String p_price = request.getParameter("p_price");
	String p_desc = request.getParameter("p_desc");
	String p_image = request.getParameter("p_image");
	String p_count = request.getParameter("p_count");
	String p_qty = request.getParameter("p_qty");

	ProductService productService = new ProductService();
	Product findProduct = productService.findByP_no(Integer.parseInt(p_no));
	boolean updateResult = productService.productUpdate(
				new Product(findProduct.getP_no(), p_name, Integer.parseInt(p_price), 
						p_desc, Integer.parseInt(p_qty)));
	if (updateResult) {
		response.sendRedirect("product_form.jsp");
	}
%>