<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-1.12.4.js"
  integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 상품 등록 유효성검사
		$("#addBtn").click(function() {
			var productName = $("#productName").val();
			var productPrice = $("#productPrice").val();
			var productDesc = $("#productDesc").val();
			var productPhoto = $("#productPhoto").val();

			if (productName == "") {
				alert("상품명을 입력해주세요");
				productName.foucs();
			} else if (productPrice == "") {
				alert("상품 가격을 입력해주세요");
				productPrice.focus();
			} else if (productDesc == "") {
				alert("상품 설명을 입력해주세요");
				productDesc.focus();
			} else if (productPhoto == "") {
				alert("상품 사진을 입력해주세요");
				productPhoto.focus();
			}
			// 상품 정보 전송
			document.form1.action = "product_create_action.jsp";
			document.form1.submit();
		});
		// 상품 목록이동
		$("#listBtn").click(function() {
			location.href = 'product_form.jsp';
		});
	});
</script>
</head>
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
					style="width: 100%; word-break: break-all; white-space: normal; font-size: 2.1052631578947367rem; letter-spacing: 0em; line-height: 1.0; font-family: Poppins Light; font-weight: normal; text-decoration: none; color: #000">상품등록</p>
			</div>
		</div>
	</div>
	<form id="form1" name="form1" enctype="multipart/form-data"
		method="post">
		<table border="1">
			<tr>
				<td>상품명</td>
				<td><input type="text" name="productName" id="productName"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="productPrice" id="productPrice"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="60" name="productDesc"
						id="productDesc"></textarea></td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td><input type="file" name="productPhoto" id="productPhoto"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="등록"
					id="addBtn"> <input type="button" value="목록" id="listBtn">
				</td>
			</tr>
		</table>
	</form>
	<jsp:include page="include_common_bottom.jsp" />
</body>
</html>