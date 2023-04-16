<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>${projectTitle }</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="${base }/manager/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
table tr td img {
	width: 120px;
	height: auto;
}
</style>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base} /admin/list-saleorders" method="get">
		<div class="input-group">
			<input name="keyword" class="form-control" type="text"
				placeholder="Search for..." aria-label="Search for..."
				aria-describedby="btnNavbarSearch" />
			<button class="btn btn-primary" id="btnNavbarSearch" type="submit">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
	<jsp:include page="/WEB-INF/views/manager/layout/navigation1.jsp"></jsp:include>

	<!-- menu -->
	<jsp:include page="/WEB-INF/views/manager/layout/menu.jsp"></jsp:include>

	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<!-- <h1 class="mt-4">Sale Order</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Detail Sale Order</li>
                        </ol> -->
				<br> <a href="${base }/admin/list-saleorders"
					class="btn btn-secondary active" role="button" aria-pressed="true">Back
					to List</a>
				<%--                        	<a href="${base }/pdf/${saleorder.id}" target="_blank" class="btn btn-secondary active" role="button" aria-pressed="true">Export</a> --%>
				<a href="${base }/admin/pdf-report/${saleorder.id}" target="_blank"
					class="btn btn-success active" role="button" aria-pressed="true">Export</a>

			</div>


			<div class="container-fluid"
				style="margin: 50px auto; border: 2px solid black; width: 70%; border-radius: 10px">

				<h1 class="text-center">Drake Store</h1>
				<h5 class="text-center">Địa chỉ : Tân Lập - Đan Phượng - Hà Nội</h5>
				<!-- <h4>Địa chỉ : Liên Hiệp - Phúc Thọ - Hà Nội</h4> -->
				<h3 class=" text-center">Hóa Đơn Bán Lẻ</h3>
				<p class="text-left">
					<span style="font-weight: bolder">Ngày :</span>
					<fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
						value="${saleorder.created_date}" />
				</p>
				<p class="text-left">
					<span style="font-weight: bolder">Số HĐ :</span> ${saleorder.code }
				</p>
				<p class="text-left">
					<span style="font-weight: bolder">Tên Khách Hàng :</span>
					${saleorder.customer_name }
				</p>
				<p class="text-left">
					<span style="font-weight: bolder">SĐT :</span>
					${saleorder.customer_phone }
				</p>
				<p class="text-left">
					<span style="font-weight: bolder">Email :</span>
					${saleorder.customer_email }
				</p>
				<p class="text-left">
					<span style="font-weight: bolder">Địa chỉ :</span>
					${saleorder.customer_address }
				</p>
				<div class="table-responsive">
					<table class="table table-hover table-bordered table-condensed">
						<%-- <p> ${product.title}</p> --%>
						<tr>
							<!-- <th>ID</th> -->
							<th>Tên SP</th>
							<th>Size</th>
							<th>SL</th>
							<th>Đơn giá</th>
							<th>Thành tiền</th>

						</tr>
						<c:forEach var="saleOrderProduct" items="${saleOderProducts }">
							<tr>
								<%-- <c:forEach var="product" items="${products }">
		                    			<c:if test="${product.id==saleOrderProduct.products1.id}">
			                    			<td>${product.title}</td>
			                    			<td>${saleOrderProduct.size}</td>
			                    			<td>${saleOrderProduct.quantity}</td>
			                    			<td><fmt:formatNumber value="${saleOrderProduct.price_at_buy}" type="number" groupingUsed="true" /> VND</td>
			                    			<td><fmt:formatNumber value="${saleOrderProduct.quantity*saleOrderProduct.price_at_buy}" type="number" groupingUsed="true" /> VND</td> 
			                    			
		                    			</c:if>
	                    			</c:forEach> --%>
								<td>${saleOrderProduct.product_name }</td>
								<td>${saleOrderProduct.size }</td>
								<td>${saleOrderProduct.quantity }</td>
								<td><fmt:formatNumber
										value="${saleOrderProduct.price_at_buy}" type="number"
										groupingUsed="true" /> VND</td>
								<td><fmt:formatNumber
										value="${saleOrderProduct.quantity*saleOrderProduct.price_at_buy}"
										type="number" groupingUsed="true" /> VND</td>
							</tr>
						</c:forEach>
					</table>

				</div>
				<h3 style="text-align: right">
					Tổng tiền:
					<fmt:formatNumber value="${saleorder.total}" type="number"
						groupingUsed="true" />
					VND
				</h3>
			</div>



		</main>

		<!--footer  -->
		<jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="${base }/manager/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('.confirmation')
									.on(
											'click',
											function() {
												return confirm('Bạn có chắc chắn muốn xóa blog này khỏi database?');
											});
						});
	</script>
</body>
</html>
