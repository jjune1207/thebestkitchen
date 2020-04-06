<%@page import="java.text.DecimalFormat"%>
<%@page import="thebestkitchen.product.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.product.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ProductService productService = new ProductService();
	ArrayList<Product> productList = productService.productList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel=stylesheet href="css/import.css" type="text/css">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function jumun(){
		p.method="POST";
		p.action="product_to_jumun_insert_action.jsp";
		p.submit();
	}
	
	function cart(){
		p.method="POST";
		p.action="product_to_cart_insert_action.jsp";
		p.submit();
	}
</script>
<body>
	<jsp:include page="include_common_top.jsp" />
	<div data-mobileoptimize="true" class="column"
		style="min-height: 230px;">
		<div class="element-wrapper"
			style="top: 37.39%; left: 35%; width: 30%; height: 25.22%; z-index: 100;"
			data-range1-style="top: 37.39%;left: 22.66%;width: 54.69%;height: 25.22%;z-index: 100;"
			data-range2-style="top: 37.39%;left: 6.25%;width: 87.5%;height: 25.22%;z-index: 100;"
			data-original-width-px="420"
			data-ori-style="top: 37.39%; left: 35%; width: 30%; height: 25.22%; z-index: 100;"
			data-top-style="37.39%">
			<div class="element-cover element-txt mid align-center"
				style="width: 100%; height: 100%; background-color: rgb(255, 255, 255);">
				<p
					style="width: 100%; word-break: break-all; white-space: normal; font-size: 2.1052631578947367rem; letter-spacing: 0em; line-height: 1.0; font-family: Poppins Light; font-weight: normal; text-decoration: none; color: #000">Shop</p>
			</div>
		</div>
	</div>
	<div class="editor-canvas" style="min-height: 1318px;"
		data-rate="0.9414285714285714" data-rate1="1.7161458333333333"
		data-rate2="2.74012474012474" data-standard-width="1400"
		data-column-set="1">
		<div class="bg-editor-canvas">
			<div class="bg-view-pc"
				style="background-size: 100% 100%; background-position: center center;"></div>
			<div class="bg-view-mobile"
				style="background-size: 1920px 1318px; background-position: center center;"></div>
		</div>
		<div class="wrap">
			<div class="columnArea column-1">
				<div data-mobileoptimize="true" class="column"
					style="min-height: 1318px;">
					<div class="element-exhibition type3"
						style="left: 0%; top: 0%; width: 100%; height: 100%; z-index: 100;">
						<ul id="productList_1">
							<%
								DecimalFormat df = new DecimalFormat("#,##0");
								for (Product product : productList) {	
							%>
							<li>
								<div>
									<a href="product_detail_form.jsp?p_no=<%=product.getP_no()%>"art='ddd'>
										<div class="exhibition_vis">
										
											<div class="exhibition_vis_line">
												<img src="main_image/main_image<%=product.getP_no()%>.jpg"
													alt="">
											</div>
										</div>
									</a>
									<div class="exhibition_infor">
										<p class="exhibition_tit"><%=product.getP_name()%></p>
										<p class="exhibition_price">
											<strong>판매가격 <%=df.format(product.getP_price())%> 원
											</strong>
										</p>
										<div class="cart_button_box">
											<form method="post" action="product_to_jumun_insert_action.jsp">
														<input type="hidden" name="p_no" value="<%=product.getP_no() %>">
														<input type="hidden" name="p_price" value="<%=product.getP_price() %>">
														<input type="hidden" name="p_desc" value="<%=product.getP_desc() %>">
														<input type="submit" value="구매하기" class="btn black style-2-1" onclick="jumun()" >
											</form>												
											<form method="post" action="product_to_cart_insert_action.jsp">
														<input type="hidden" name="p_no" value="<%=product.getP_no() %>">
														<input type="hidden" name="p_price" value="<%=product.getP_price() %>">
														<input type="submit" value="장바구니담기" class="btn white-2 style-2-1" onclick="cart()">
											</form>
											</div>
										</div>
									</div>
							</li>
							<%
								}
							%>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="table-bot-cont">
		<div class="paging" id="productList_paging_1">
			<a href="javascript:;" class="btn-prev"><img
				src="style/img/common/btn-list-prev.png"></a> <a
				href="javascript:;" class="btn-page on" data-page="1">1</a> <a
				href="javascript:;" class="btn-next"><img
				src="style/img/common/btn-list-next.png"></a>
		</div>
	</div>

	<jsp:include page="include_common_bottom.jsp" />
</body>
</html>