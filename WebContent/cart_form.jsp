<%@page import="java.util.Iterator"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="thebestkitchen.cart.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@page import="thebestkitchen.cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/member_login_check.jspf"%>
<!DOCTYPE html>
<%
	String msg1 = (String) request.getAttribute("msg1");
	if (msg1 != null) {
		out.println("<script>");
		out.println("alert('" + msg1 + "')");
		out.println("</script>");
	}
	CartService cartService = new CartService();
	ArrayList<Cart> cartList = cartService.getCartItemList(sMemberId);
%>
<jsp:include page="include_common_top.jsp"></jsp:include>

<html>
<head>
<meta charset="UTF-8">
<title><%="test"%> 님 장바구니</title>
</head>
<link rel=stylesheet href="css/cart.css" type="text/css">
<script type="text/javascript">
	function jumun() {
		var cart_jumun_form_f=document.getElementById('cart_jumun_form_f');
		cart_jumun_form_f.action = "cart_insert_jumun_action.jsp";
		cart_jumun_form_f.method = 'POST';
		cart_jumun_form_f.submit();
	}
	function deleteOne(p_no) {
		var cartF=document.getElementById('cart_form_'+p_no);
		cartF.action = "cart_remove_action.jsp";
		cartF.method = 'POST';
		cartF.submit();
	}
	function changeQty(c_qty,p_no){
		var cartF=document.getElementById('cart_form_'+p_no);
		console.log(cartF+"mtmt	");
		cartF.method = 'GET';
		cartF.action = "cart_change_qty.jsp"
		cartF.submit();
	}
	function delChecked(){
		cart_remove_all.action = "cart_remove_all_action.jsp";
		cart_remove_all.method = 'POST';
		cart_remove_all.submit();
	}
</script>
<body>
	<h1 align="center">
		<a href="mypage_main.jsp"> <b><font
				size="15"><%=sMemberId%></font> </b></a> 님 장바구니
		<br>
		<br>
		<br>
		<br>
	</h1>
	<div class="shopping-cart">
		<div class="column-labels">
			<label class="product-image">Image</label> 
			<label class="product-details">상품정보</label> 
			<label class="product-price">상품별합계가격</label>
			<label class="product-quantity">수량</label> 
			<label class="product-line-price">배송비</label> 
			<label class="product-removal">삭제</label>
		</div>
		<!-- ▼▼▼▼▼ 장바구니 출력시작▼▼▼▼▼  -->
		<%
			DecimalFormat df = new DecimalFormat("#,##0");
			int tot = 0;
			for (Cart cart : cartList) {
				tot += cart.getC_totprice();
		%>
		<form id="cart_form_<%=cart.getP_no()%>" name="f<%=cart.getP_no()%>">
			<div class="product">
				<div class="product-image">
					<a href="product_detail_form.jsp?p_no=<%=cart.getP_no()%>"> <img
						src="main_image/main_image<%=cart.getP_no()%>.jpg"></a>
				</div>
				<div class="product-details">
					<a href="product_detail_form.jsp?p_no=<%=cart.getP_no()%>">
						<div class="product-title"><%=cart.getP_name()%></div>
						<p class="product-description"><%=cart.getP_desc()%></p>
					</a>
				</div>
				<div class="product-price"><%=df.format(cart.getC_totprice())%>원
				</div>
				<div class="product-quantity">
					<input type="number" name="c_qty" value="<%=cart.getC_qty()%>"
						min="1">
					<button type="submit" name="change_qty" value="수정"
						onClick="changeQty('<%=cart.getC_qty()%>','<%=cart.getP_no()%>')">수량변경</button>
				</div>
				<div class="product-line-price">3000</div>
				<div class="product-removal">
					<button type="submit" class="remove-product"
						onClick="deleteOne(<%=cart.getP_no()%>)">삭제</button>
				</div>
				<input name="p_no" type="hidden" value="<%=cart.getP_no()%>">
			</div>
		</form>
		<%
			}
		%>
		<!--  ▲▲▲▲▲장바구니 출력종료▲▲▲▲▲  -->
		<form id="cart_remove" name="cart_remove_all">
			<input name="member" type="hidden" value="<%=sMemberId%>">
		</form>
		<li class="goDelete">
			<p>
				<button type="button" class="btn white-2 common-2"
					onclick="delChecked()">장바구니비우기</button>
			</p>
		</li>
		<!--  ▼▼▼▼▼합계 출력시작▼▼▼▼▼  -->
		<div class="totalPrice">
			<div class="priceDetail" id="totalPrice" style="">
				<ul>
					<li>
						<p>상품금액</p> <span><%=df.format(tot)%> 원</span>
					</li>
					<li>
						<p>배송비</p> <%
 				if (tot == 0) {
				 	%> <span>(+) 0원</span> <%
 				} else if( tot > 50000){
				 	%> <span>(+) 배송비 무료</span> <%
 				} else {
 					%> <span>(+) 3,000 원</span> <%
 				}
 				%>
					</li>
					<li class="totalMoney">
						<p>총 결제금액</p> <%
 				if (tot == 0) {
				%> <span class="sum">0 원</span> <%
			 	} else if (tot < 50000) {
				%> <span class="sum"><%=df.format((tot + 3000))%> 원</span> <%
 				} else{
 				%> <span class="sum"><%=df.format(tot)%> 원</span> <%
 				}
				%>
		<!--  ▲▲▲▲▲합계 출력종료▲▲▲▲▲  -->
				</li>
				<li>
						<form id="cart_and_order_f" name="cart_and_order">
							<input name="member" type="hidden" value="<%=sMemberId%>">
							<div class="cart_button_box">
								<button type="button" class="btn style-7"
									onclick="location.href='product_form.jsp' ">쇼핑 계속하기</button>
								<button type="button" class="btn black style-7"
									onclick="jumun()">구매하기</button>
							</div>

						</form>
					</li>
				</ul>
			</div>
		</div>
		<!--  ▼▼▼▼▼주문하기 데이터 보내기▼▼▼▼▼  -->
		<form id="cart_jumun_form_f" name="cart_jumun_form"
			action="cart_insert_jumum_action.jsp">
			<%
				for (Cart cart : cartList) {
			%>
			<input type="hidden" id="cart_jumun_item<%=cart.getP_no()%>"
				name="cart_item"
				value="<%=cart.getP_name()%>-<%=cart.getM_id()%>-<%=cart.getC_qty()%>-<%=cart.getC_totprice()%>-<%=cart.getP_no()%>">

			<%
				}
			%>
		</form>
	</div>
<jsp:include page="include_common_bottom.jsp"></jsp:include>
</body>
</html>