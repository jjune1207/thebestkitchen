<%@page import="thebestkitchen.jumun.JumunService"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String m_id = request.getParameter("member");
	System.out.println(m_id);
	/*
	String[] cart_item_received_array = request.getParameterValues("cart_tot_order");
	String j_no = request.getParameter("j_no");
	String p_no = request.getParameter("p_no");
	String m_id = request.getParameter("m_id");
	String j_desc = request.getParameter("j_desc");
	String j_date = request.getParameter("j_date");
	String j_qty = request.getParameter("j_qty");
	String j_price = request.getParameter("j_price");
	String j_dprice = request.getParameter("j_dprice");
	String j_address = request.getParameter("j_address");
	String j_phone = request.getParameter("j_phone");
	Jumun newOrder = null;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String[] cart_item_received_array = request.getParameterValues(CartService);
	
	try {
		JumunService jumunService = JumunService.getInstance();
		newOrder = new Jumun(Integer.parseInt(j_no),
				Integer.parseInt(p_no),
				m_id,
				j_desc,
				sdf.parse(j_date),
				Integer.parseInt(j_qty),
				Integer.parseInt(j_price),
				Integer.parseInt(j_dprice),
				j_address,
				j_phone);
		int insertRowCount = JumunService.insertOrder(newOrder);
		
		response.sendRedirect("test_order_submit_form.jsp");
		
	} catch (Exception e) {
		e.printStackTrace();
		RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
		rd.forward(request, response);
		return;
	}
	*/


%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Order Action</title>
</head>
<body>
	<%
		// SQL Jumun TABLE
		JumunService jumunService = new JumunService();
		jumunService.modifyPayment(m_id);
		// 장바구니 삭제
		
		CartService cartService = new CartService();
		cartService.deleteCart(m_id);

		response.sendRedirect("mypage_main.jsp");
	%>
</body>
</html>