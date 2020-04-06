<%@page import="thebestkitchen.exception.ExistedCartException"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@page import="thebestkitchen.product.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="member_login_check.jspf" %>
   
    <%
    try{
  	String p_no = request.getParameter("p_no");
	String p_qty = request.getParameter("p_qty");
	String p_price = request.getParameter("p_price");
	String p_name = request.getParameter("p_name");
	
    ProductService productService = new ProductService();
   	CartService cartService = new CartService();
   	
    int i = cartService.addJumun(p_name, sMemberId, Integer.parseInt(p_qty),
    		Integer.parseInt(p_price), Integer.parseInt(p_qty)*Integer.parseInt(p_price),
    		Integer.parseInt(p_no));
	  	 	System.out.println(i+"jumun_main으로 수량 추가한 파라메타 던지기 성공");
	  	 	//주문 추가 성공 여부 확인
	  	 	System.out.println("--------------------테스트------------------------");
	  	    System.out.println("jumun_main 으로 넣으려는 제품 정보는 아래와 같다");
	  	   	System.out.println("아이디 :"+sMemberId);
	  	   	System.out.println("제품이름 :"+p_name);
	  	   	System.out.println("제품번호 :"+Integer.parseInt(p_no));
	  	   	System.out.println("제품수량 :"+Integer.parseInt(p_qty));
	  	   	System.out.println("제품가격 :"+Integer.parseInt(p_price));
	  	   	System.out.println("총 구매가격 :"+Integer.parseInt(p_qty)*Integer.parseInt(p_price));
	  	   	response.sendRedirect("jumun_main.jsp");
	  	   	
    }catch(ExistedCartException e){
    	request.setAttribute("msg", e.getMessage());
    	String msg = request.getParameter(e.getMessage());
    	RequestDispatcher rd = request.getRequestDispatcher("product_detail_form.jsp");
    	rd.forward(request,response);
    	return;
    	
    }
	
   	%>
   	<%
   	
   	/*
 	if(i==1){
		response.sendRedirect("jumun_main.jsp");
	    System.out.println("jumun_main으로 수량 추가한 파라메타 던지기 성공");
	   	}
	   	else{
	    System.out.println("jumun_main으로 수량 추가한 파라메타 던지기 실패");
	    response.sendRedirect("product_detail_form.jsp");
	   	System.out.println("꺼졍 다시해방ㅋㅋ");
	   	}
	
    
	boolean toJumunAddPlusQty = 
			productService.jumunAddPlusQty(Integer.parseInt(p_no), sMemberId, "김팀장님 소주안주", 
					Integer.parseInt(p_qty), Integer.parseInt(p_qty)*Integer.parseInt(p_price), ".");
	
	주문 추가 성공 여부 확인
	System.out.println("-----------------------------------------------------------");
	System.out.println("테스트");
  	System.out.println("jumun_main 으로 넣으려는 제품 정보는 아래와 같다");
	System.out.println("아이디 :"+sMemberId);
	System.out.println("제품번호 :"+Integer.parseInt(p_no));
	System.out.println("제품수량 :"+Integer.parseInt(p_qty));
	System.out.println("제품가격 :"+Integer.parseInt(p_price));
	System.out.println("총 구매가격 :"+Integer.parseInt(p_qty)*Integer.parseInt(p_price));

	if(toJumunAddPlusQty){
		response.sendRedirect("jumun_main.jsp");
	    System.out.println("jumun_main으로 수량 추가한 파라메타 던지기 성공");
	   	}
	   	else{
	    System.out.println("jumun_main으로 수량 추가한 파라메타 던지기 실패");
	    response.sendRedirect("product_detail_form.jsp");
	   	}
	*/

	%>