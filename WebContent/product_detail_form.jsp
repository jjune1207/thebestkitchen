<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="thebestkitchen.cart.CartService"%>
<%@page import="thebestkitchen.product.Product"%>
<%@page import="thebestkitchen.product.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <% 
    String msg = (String)request.getAttribute("msg");
	if (msg != null) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.println("</script>");
	response.sendRedirect("product_detail_form.jsp");	
	}
	String p_no = request.getParameter("p_no");
	if (p_no == null) {
		response.sendRedirect("product_form.jsp");
		return;
	}
	ProductService productService = new ProductService();
	Product product = productService.findByP_no(Integer.parseInt(p_no));
	%>
<!DOCTYPE html>
<div id="container">
	<!-- header start -->
	<div id="header">
		<!-- include_common_top.jsp -->
		<jsp:include page="include_common_top.jsp"></jsp:include>
	</div>
	<!-- header end -->
	<html>
<head>
<link rel="stylesheet" type="text/css" href="css/import.css">
<link rel="stylesheet" type="text/css" href="css/slick.css">
<script	src="js/product.js"></script>
<title>맛있는 <%=product.getP_name()%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script type="text/javascript">
	var p_price;
	var p_qty;
	function buy() {
		if (<%=session.getAttribute("sMemberId") == null%>) {
			alert('회원만 구매 가능합니다. 로그인 하세요');
			location.href = 'member_login_form.jsp';
		} else {
			location.href = 'jumun_main.jsp';
		}
	}
	function admin(){
		if(<%=session.getAttribute("sMemberId")!= "sAdminId"%>){
			alert('접근 권한이 없습니다. 관리자로 로그인하세요');
			location.href = 'product_detail_form.jsp';
		} else{
			location.href = 'main.jsp';
		}
	}
	function jumun(){
		purchase.method="POST";
		purchase.action="product_detail_to_add_jumun.jsp";
		purchase.submit();
	}
	
	function cart(){
		purchase.method="POST";
		purchase.action="product_detail_to_add_cart.jsp";
		purchase.submit();
	}
	
	function init () {
		hm = document.purchase.p_qty.value;
		pm = document.purchase.parseInt(p_price).value;
		document.purchase.sum.value = parseInt(p_price);
		change();
	}
	
	function add() {
	      hm = document.purchase.p_qty;
	      sum = document.purchase.sum.value;
	      console.log(sum+"priceprice");
	      hm.value ++ ;
	      sum.value = parseInt(hm.value)*parseInt(p_price);
	   }
	
	function del() {
		sum = document.purchase.sum.value;
		hm = document.purchase.p_qty.value;
		if (hm.value > 1) {
				hm.value -- ;
				sum.value = parseInt(hm.value)*parseInt(p_price);
			}
	}
	function change() {
		hm = document.purchase.p_qty.value;
		sum = document.purchase.sum.value;
		console.log(hm,sum);
			if (hm.value < 0) {
				hm.value = 0;
			}
		sum.value = parseInt(hm.value)*parseInt(p_price);
	}  

</script>
<%	DecimalFormat df = new DecimalFormat("#,##0");%>
<body>
<body class="large-width">

	<!-- ▲▲▲▲ header ▲▲▲▲ -->
	<!-- ▼▼▼▼ main ▼▼▼▼ -->
	<main id="main">
		<div class="wrap">
			<!-- ▼▼ detail-wrap ▼▼ -->
			<div class="detail-wrap">
				<!-- ▲ header ▲ -->
				<!-- ▼ shoping ▼ -->
				<div class="shoping cf">
					<!-- exhibition -->
					<div class="exhibition">
						<!--  img-switch  -->
						<div class="img-switch">
							<section
								class="lazy slider-1 box_border_2 slick-initialized slick-slider"
								data-sizes="50vw">
								<div class="slick-list draggable">
									<div class="slick-track" style="opacity: 1; width: 1166px;">
										<div
											style="outline: none; position: relative; left: 0px; top: 0px; z-index: 999; opacity: 1; width: 583px;"
											data-slick-index="0"
											class="slick-slide slick-current slick-active"
											aria-hidden="false">
											<p>
												<span><img
													src="main_image/main_image<%=product.getP_no()%>.jpg"
													alt="" style="width: 582.4px; height: 585px;"> </span>
											</p>
											
										</div>
										<div
											style="outline: none; width: 583px; position: relative; left: -583px; top: 0px; z-index: 998; opacity: 0;"
											data-slick-index="1" class="slick-slide" aria-hidden="true">
											<p>
												<span><img
													src="main_image/main_image<%=product.getP_no()%>.jpg"
													alt=""> </span>
											</p>
											<div class="exhibition_soldout ">undefined</div>
										</div>
									</div>
								</div>
							</section>
						</div>


						<!--  /img-switch  -->
						<!--  img-loop  -->
						<div class="img-loop">
							<section class="lazy slider-2 slick-initialized slick-slider"
								data-sizes="50vw">
								<div class="slick-list draggable">
									<div class="slick-track"
										style="opacity: 1; width: 254px; transform: translate3d(0px, 0px, 0px);">

										<div style="outline: none; width: 127px;"
											onclick="onClickSlide(this)" data-slick-index="2"
											class="slick-slide slick-current slick-active"
											aria-hidden="false">
											<p>
												<span><img
													src="sub_image/subs<%=product.getP_no()*5%>.PNG" alt="서브이미지1"></span>
											</p>
										</div>
										<div style="outline: none; width: 127px;"
											onclick="onClickSlide(this)" data-slick-index="1"
											class="slick-slide slick-active" aria-hidden="false">
											<p>
												<span><img
													src="sub_image/subs<%=product.getP_no()+10%>.PNG" alt="서브이미지2"></span>
											</p>
										</div>
									</div>
								</div>
							</section>
						</div>
						<!--  /img-loop  -->
					</div>
						<!-- purchase -->
					<div id="purchaseInfo" class="purchase lazy">
						<h1 id="productName"><%=product.getP_name()%></h1>
						<p id="promotionText" class="txt-ex"></p>
						<ul class="price">
							<li class="onsale price"><strong id="totalPrice"><%=df.format(product.getP_price())%><i>원</i></strong>
							<br><br><br></li>
						</ul>
					
						<!-- 구매버튼(제품번호, 수량, 가격 product_detail_to_add_jumun.jsp로 전송 -->
						<form name="purchase" method="post"
							action="product_detail_to_add_jumun.jsp" >
							수량 선택 : 
							<input type="hidden" name='p_no' value="<%=product.getP_no()%>"> 
							<input type="hidden" name='p_name' value="<%=product.getP_name()%>"> 
							<input type="number" name='p_qty' value="1" size="5" onchange="change();"> 
							<input type="hidden" name='p_price' value="<%=product.getP_price()%>">
							<!--total price -->
						<div class="option-wrap"></div>
						<dl class="express onsale">
							<dt>배송비</dt>
							<dd id="deliveryAmt">3,000원(주문 시 합계금액에 포함)</dd>
						</dl>
							<tr>
								<td colSpan=3 height=21><hr color=#556b2f></td>
							</tr>
							<div class="cart_button_box">
							 <input type="submit" class="btn black style-2-1" onclick="jumun()" value="구매하기">
							<input type="submit" class="btn white-2 style-2-1" onclick="cart()" value="장바구니담기">
							</div>
						</form>
						
						<!-- 관리자버튼 --><!-- 
								<div class="sharing" style="cursor: pointer;">
									<input type="submit" class="btn share" onClick="admin();">
									<li><a href="admin_form.jsp">관리자</a></li>
								</div> -->
							</div>

						</div>
				
						<!-- /purchase -->
						<ul class="tab-goods js_part">
            		<li class="">
              	<a href="#" data-idx="1">상세정보</a>
           		 	</li>
        		  </ul>
				</div>
				<!-- ▲ shoping ▲ -->
				<!-- ▼ detailed ▼ -->
				
				<div class="detailed">
					<!-- tab-goods -->
					<ul class="tab-goods js_part">
						<li id="purchase-guide" style="display: none;"><a href="#"
							data-idx="2">구매안내</a></li>
					</ul>
					
					<!-- /tab-goods -->
					<!-- purchase-guide -->
					<div class="purchase-guide" style="display: none;"></div>

					<!-- /purchase-guide -->
					<!-- con-goods 이미지 뿌려주어야 함-->
					<div class="con-goods">
						<ul id="proDetailImages" class="goods-list inline_b">

							<li><p style="text-align: center;">
									<img src="sangsaeimage/1.PNG"
										width="80%" height="800px" art="상세공통이미지1"> 
									<img src="sangsaeimage/2.PNG"
										width="80%" height="800px" art="상세공통이미지2">
									<img src="sangsaeimage/3.PNG"
										width="80%" height="800px" art="상세공통이미지3">
									<img src="sangsaeimage/4.PNG"
										width="80%" height="800px" art="상세공통이미지4">
									<img src="sangsaeimage/5.PNG"
										width="80%" height="800px" art="상세공통이미지5">
									<img src="sangsaeimage/6.PNG"
										width="80%" height="800px" art="상세공통이미지6">
									<img src="sangsaeimage/7.PNG"
										width="80%" height="800px" art="상세공통이미지7">
									<img src="sub_image/subs<%=product.getP_no()*5%>.PNG"
										width="80%" height="900px" art="상세이미지1" > 
									<img src="sub_image/subs<%=product.getP_no()+10%>.PNG" 
									 	width="80%" height="900px" alt="상세이미지2">
								</p>
								<p style="text-align: center;">
						</ul>
						<div id="optionMainImages"></div>
						<div id="dutyInfoContents" class="goods-details">

							<!-- 상세페이지 하단 정보공시 -->
							<h2>
								<strong>상품정보 제공고시</strong>
							</h2>
							<table class="tbl">
								<caption class="blind">상품정보 제공고시</caption>
								<colgroup>
									<col style="width: 150px">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">식품의 유형</th>
										<td>과자</td>
									</tr>
									<tr>
										<th scope="row">생산자 및 소재지</th>
										<td>생산자 : 주)농업회사법인미스터베이커리 소재지 : 대전광역시 동구 안골로28번길 15-5</td>
									</tr>
									<tr>
										<th scope="row">제조연월일</th>
										<td>제품후면하단 참조</td>
									</tr>
									<tr>
										<th scope="row">유통기한 또는 품질유지기한</th>
										<td>제조일로부터 8개월</td>
									</tr>
									<tr>
										<th scope="row">포장단위별 용량(중량), 수량, 크기</th>
										<td>포장단위별 용량(중량) : 45g 수량 4봉</td>
									</tr>
									<tr>
										<th scope="row">원재료명 및 함량</th>
										<td>밀가루(밀:국내산),현미유(현미:국내산),볶은현미가루(현미:국내산),죽염(국내산),유자당절임(유자:국내산),녹차가루(녹차잎:국내산),대추(국내산),자색고구마가루(자색고구마:국내산),유기당설탕(브라질산)</td>
									</tr>
									<tr>
										<th scope="row">영양성분</th>
										<td>유자 나트륨6%,탄수화물11%,당류13%,지방7%(트랜스지방0%),콜레스테롤0%,단백질2% 녹차
											나트륨6%,탄수화물10%,당류10%,지방13%(트랜스지방0%),콜레스테롤0%,단백질5% 대추
											나트륨8%,탄수화물10%,당류8%,지방14%(트랜스지방0%),콜레스테롤0%,단백질5% 자색고구마
											나트륨7%,탄수화물10%,당류9%,지방8%(트랜스지방0%),콜레스테롤0%,단백질5%</td>
									</tr>
									<tr>
										<th scope="row">유전자재조합식품 유무</th>
										<td>해당없음</td>
									</tr>
									<tr>
										<th scope="row">표시광고사전심의필 유무</th>
										<td>알레르기성분 밀 함유</td>
									</tr>
									<tr>
										<th scope="row">소비자상담 관련 전화번호</th>
										<td>042-825-3600</td>
									</tr>
								</tbody>
							</table>
						</div>



					</div>
					<!-- /con-goods -->
					<form id="uploadForm" enctype="multipart/form-data" hidden="">
						<input id="fileInput" type="file" accept="image/*">
					</form>
					<!-- con-service -->
					<div class="con-service" style="display: none;">
						<div class="evaluate-text">
							<form id="formReview" action="" style="margin-bottom: 150px;"
								hidden="">
								<h2>
									<strong>구매후기</strong> <span>구매하신 상품에 대해 의견 남겨주세요. (상품과
										무관한 리뷰글은 통보 없이 삭제될 수 있습니다.)</span>
								</h2>
								<div class="text-wrap">
									<div class="textarea">
										<textarea class="textarea-noborder textarea_review"
											name="content" id="contentReview" cols="30" rows="10"
											maxlength="1000" onkeydown="updateLength('review')"
											onkeypress="updateLength('review')"
											onkeyup="updateLength('review')"
											onchange="updateLength('review')"></textarea>
										<p class="textarea-limit length_review">0자 / 1000자</p>
									</div>
									<div class="img-up">
										<ul id="reviewImageList">
											<li id="newReviewSelImg">
												<button onclick="addImage('newReviewSelImg')" type="button"
													class="btn pic">
													<span>pic</span>
												</button>
											</li>
										</ul>
									</div>
								</div>

								<p class="btn-row">
									<input type="hidden" name="optionNo"> <input
										type="hidden" name="orderOptionNo">
									<button type="submit" class="btn black style-3-1">등록하기</button>
								</p>
						</div>
						</form>
					</div>
					<div class="history">
						<div class="history_wrap">
							<div id="proReview" style="border-top: 1px solid #ababab;">
								<div id="review0">
									<div class="con-qa">
										<div class="info_top">
										</div>
									</div>
									<div id="reviewAnswer0" class="open" hidden="">
										<div colspan="5" style="overflow: hidden;">
											<div class="message">
												<p class="txt">리뷰에 대한 답글 작성</p>
												<ul class="goods-list">
													<li
														onclick="showImagePopup('https://rlyfaazj0.cdn.toastcloud.com/SERVICE/20191230/0e42c0cc-6970-406b-bb36-12030c1ad2fb.PNG')"
														style="cursor: pointer;"><img src="" class="p-img"
														alt="" style="width: 104px; height: 104px;"></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<p class="btn-row">
							<button id="btnMoreReview" type="button"
								class="btn white-2 style-3-4" style="display: none;">더보기</button>
						</p>
					</div>
				</div>


				<!-- 문의게시판 -->
				<div class="con-consultation" style="display: none;">
					<div class="consultation-text">
						<form id="formInquiry" action="">
							<h2>
								<strong>상품문의</strong> <span>상품에 관한 문의사항을 입력해주세요.</span>
							</h2>
							<div class="text-wrap">
								<div class="textarea">
									<textarea class="textarea-normal textarea_inquiriy"
										name="content" id="contentInquiry" cols="30" rows="10"
										maxlength="1000" onkeydown="updateLength('inquiriy')"
										onkeypress="updateLength('inquiriy')"
										onkeyup="updateLength('inquiriy')"
										onchange="updateLength('inquiriy')"></textarea>
									<p class="textarea-limit length_inquiriy">
										<span>0</span>자 / 1000자
									</p>
									<!-- 20190225 -->
								</div>
							</div>

							<dd></dd>
							</dl>
							<p class="btn-row">
								<button type="submit" class="btn black style-3-1">등록하기</button>
							</p>
					</div>
					</form>
				</div>
				<div class="history">
					<div class="history_wrap">
						<div id="proInquiry" style="border-top: 1px solid #ababab;">
							<div>
								<!-- 
      <tr id="inquiry0" onclick="showDetail(this)">
 -->
								<ul id="inquiry0">
									<li id="content" class="txt_wrap">
								</ul>
								<ul id="inquiryAnswer0" class="open"></ul>
								<li colspan="5">
									<div class="message">
										<!-- <p class="txt"></p> -->
										<dl class="reply">
										</dl>
									</div>
								</li>

							</div>
						</div>
					</div>
					<p class="btn-row">
						<button id="btnMoreInquiry" type="button"
							class="btn white-2 style-3-4" style="display: none;">더보기</button>
					</p>
				</div>
			</div>
			<!-- con-consultation -->
		</div>
		<!-- ▲ detailed ▲ -->
</div>
<!-- ▲▲ detail-wrap ▲▲ -->
</div>
</main>
<!-- ▲▲▲▲ main ▲▲▲▲ -->



<script src="../js/module/product.js"></script>
<!-- 상세페이지 하단 정보공시 -->
<jsp:include page="include_common_bottom.jsp"></jsp:include>
</html>