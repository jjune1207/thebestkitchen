<%@page import="thebestkitchen.cart.CartDao"%>
<%@page import="thebestkitchen.cart.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="member_login_check.jspf" %>      
   
    <%
  	String p_no = request.getParameter("p_no");
	String p_qty = request.getParameter("p_qty");
	String p_price = request.getParameter("p_price");
	
    CartService cartService = new CartService();
	  
	int i = cartService.insert(Integer.parseInt(p_no), sMemberId,
    							Integer.parseInt(p_qty), Integer.parseInt(p_price)*Integer.parseInt(p_qty), 
    							Integer.parseInt(p_price));   
    response.sendRedirect("cart_form.jsp");
    
   // 카트 추가 성공 여부 확인
    System.out.println("-----------------------------------------------------------");
  	System.out.println("테스트: Cart_main 으로 넣으려는 제품 정보는 아래와 같다");
  	System.out.println("아이디: "+sMemberId);
  	System.out.println("제품번호: "+Integer.parseInt(p_no));
    System.out.println("제품수량: "+Integer.parseInt(p_qty));
    System.out.println("제품가격: "+Integer.parseInt(p_price));
    System.out.println("총 구매가격: "+Integer.parseInt(p_price)*Integer.parseInt(p_qty));
    System.out.println("-----------------------------------------------------------");
    System.out.println(i+" 의 뜻은 cart_main으로 새로운 상품에 대한 파라메타 던지는거시 성공했다는거시야");
    System.out.println("-----------------------------------------------------------");
   
    /*
    int k = cartService.update(Integer.parseInt(p_no), Integer.parseInt(p_qty), sMemberId);
    System.out.println(k+" 의 뜻은 카트에 담겨있는 상품에 수량 추가가 성공했다는 뜻이야");
    response.sendRedirect("cart_form.jsp");
    */
	%>
