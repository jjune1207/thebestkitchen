<%@page import="thebestkitchen.product.Product"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@page import="thebestkitchen.cart.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="member_login_check.jspf"%>
<%
	String p_no = request.getParameter("p_no");
	String p_price = request.getParameter("p_price");
	String c_totprice = p_price;
	CartService cartService = new CartService();
	cartService.insert(Integer.parseInt(p_no), sMemberId, 1, Integer.parseInt(c_totprice),
			Integer.parseInt(p_price));
%>
<script>
if(window.confirm("장바구니에 상품이 담겼습니다. 장바구니로 이동하겠습니까?")){
	location.href = "cart_form.jsp"; 
} else {
	history.back();
}
</script>
