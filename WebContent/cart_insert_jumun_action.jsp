<%@page import="thebestkitchen.exception.ExistedCartException"%>
<%@page import="thebestkitchen.cart.Cart"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	
	String[] cart_item = request.getParameterValues("cart_item");
	if(cart_item == null ){
		out.println("<script>");
		out.println("alert('장바구니에 담긴 상품이 없습니다');");
		out.println("location.href='cart_form.jsp';");
		out.println("</script>");
		return;
	}
	try{
		for (String tmp : cart_item) {
			String[] tmpStr = tmp.split("-");
			String p_name = tmpStr[0];
			String m_id = tmpStr[1];
			int c_qty = Integer.parseInt(tmpStr[2]);
			int c_totprice = Integer.parseInt(tmpStr[3]);
			int p_no = Integer.parseInt(tmpStr[4]);
			CartService cartService = new CartService();
			cartService.addJumun(p_name, m_id, c_qty, c_totprice, c_totprice, p_no);
		}
		response.sendRedirect("jumun_main.jsp");
	}
	catch (ExistedCartException e){
		request.setAttribute("msg1", e.getMessage());
		String msg = e.getMessage();
		System.out.println(msg+"안맛소금");
		RequestDispatcher rd = request.getRequestDispatcher("cart_form.jsp");
		rd.forward(request,response);
		return;

	}
%>


%>
