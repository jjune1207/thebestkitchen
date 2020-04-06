<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String sMemberId = (String) session.getAttribute("sMemberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel=stylesheet href="css/import.css" type="text/css">
<link rel=stylesheet href="css/search.css" type="text/css">
</head>
<body class="template large-width">
	<div id="wrapper">
		<div id="header">
			<!-- Global site tag (gtag.js) - Google Analytics -->

			<style>
header .editor-canvas {
	display: block;
}

header .mobile {
	display: none;
}

#header_mobile {
	display: none;
}

@media screen and (max-width: 1023px) {
	header .editor-canvas {
		display: none;
	}
	#header_mobile {
		display: block;
	}
	#header_mobile .editor-canvas {
		display: block;
	}
	header .mobile {
		display: none;
	}
}
</style>

			<header id="header"
				style="font-family: &amp; amp; amp; amp; amp; amp; amp; quot; Nanum Gothic&amp;amp; amp; amp; amp; amp; amp; quot; , NanumGothic , ng, 돋움, Dotum, &amp;amp; amp; amp; amp; amp; amp; quot; Apple SD Gothic Neo&amp;amp; amp; amp; amp; amp; amp; quot; , sans-serif; background-color: rgb(255, 255, 255);">
				<div class="editor-canvas" style="min-height: 271px;"
					data-rate="0.19357142857142856" data-rate1="0.3528645833333333"
					data-rate2="0.5634095634095634" data-standard-width="1400"
					data-column-set="1">
					<div class="bg-editor-canvas" style="width: 100%; min-height: 0px;">
						<div class="bg-view-pc"
							style="background-size: 100% 100%; background-position: center center;"></div>
						<div class="bg-view-mobile"
							style="background-size: 1920px 271px; background-position: center center;"></div>
					</div>
					<div class="wrap">
						<div class="columnArea column-1">
							<div data-mobileoptimize="true" class="column"
								style="min-height: 271px;">
								<div class="element-wrapper"
									style="top: 76.75%; left: 4.64%; width: auto; height: 22px; z-index: 100;"
									data-ori-style="top: 76.75%; left: 4.64%; width: auto; height: 22px; z-index: 100;"
									data-top-style="76.75%">
									<ul class="element-cover header-menus type2">
										<li class="header-menus-item"><span
											style="color: #000000">/</span><a href="good_company.jsp"
											style="color: #000000">Good Company</a></li>
										<li class="header-menus-item"><span
											style="color: #000000">/</span><a href="good_health.jsp"
											style="color: #000000">Good Health</a></li>
										<li class="header-menus-item"><span
											style="color: #000000">/</span><a href="product_form.jsp"
											style="color: #000000">Shop</a></li>
									</ul>
								</div>
								<div>
								</div>
								
								<div class="element-wrapper"
									style="top: 72%; left: 84%; width: 300px; height: 26px; z-index: 101;"
									data-ori-style="top: 80.44%; left: 85.93%; width: auto; height: 26px; z-index: 101;"
									data-top-style="80.44%">
									<ul>
										<li style="width: 15%; float: left;"><a
											href="board_notice_list.jsp"><img
												src="./image/alram2.png"></a></li>
										<%
											if (sMemberId != null) {
										%>
										<li style="width: 15%; float: left;"><a
											href="member_logout_action.jsp"><img
												src="./image/logout.png"></a></li>
										<li style="width: 15%; float: left;"><a
											href="mypage_main.jsp"><img src="./image/mypage3.png"></a>
										</li>
										<li style="width: 15%; float: left;"><a
											href="jumun_main.jsp"><img src="./image/jumun.png"></a>
										</li>
										<%
											} else {
										%>
										<li style="width: 15%; float: left;"><a
											href="member_login_form.jsp"><img src="./image/login.png"></a></li>
										<li style="width: 15%; float: left;"><a
											href="member_write_form.jsp"><img src="./image/join.png"></a>
										</li>
										<%
											}
										%>
										<li style="width: 15%; float: left;"><a
											href="cart_form.jsp"><img src="./image/cart3.png"></a>
										</li>
									</ul>
								</div>
								<div class="element-wrapper"
									style="top: 17.34%; left: 4.17%; width: 94.59%; height: 44.65%; z-index: 102;"
									data-range1-style="top: 17.34%;left: 21.35%;width: 59.12%;height: 44.65%;z-index: 102;"
									data-range2-style="top: 17.34%;left: 4.17%;width: 94.59%;height: 44.65%;z-index: 102;"
									data-original-width-px="454.02"
									data-ori-style="top: 17.34%; left: 34.29%; width: 32.43%; height: 44.65%; z-index: 102;"
									data-top-style="17.34%">
									<div class="element-cover element-image2 no-bg"
										style="width: 454px; height: 121px; margin: 0 auto; padding: 0;">
										<a href="main.jsp" target="_self"><img
											src="./더테스트키친_files/로고.png"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</header>
			<script type="js/search.js"></script>
</body>
</html>