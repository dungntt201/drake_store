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

<!-- add  summernote editor  -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<link href="${base }/manager/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-saleorders" method="get">
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
					<li class="breadcrumb-item active">Edit Sale Order</li>
				</ol> -->
				<div class="container-fluid">


					<sf:form id="form1" method="post"
						action="${base }/admin/edit-saleorder" modelAttribute="saleorder"
						enctype="multipart/form-data">

						<sf:hidden path="id" id="idSO" />


						<br>
						<label for="code">Code (required)</label>
						<sf:input path="code" type="text" class="form-control" id="code"
							placeholder="Code" required="required" disabled="true" />

						<br>

						<label for="total">Tổng tiền (required)</label>
						<sf:input disabled="true" path="total" type="number"
							class="form-control" id="total" placeholder="Tổng tiền"
							required="required" />



						<label style="display: none" for="created_date">Ngày tạo </label>
						<sf:input style="display: none" path="created_date" type="date"
							class="form-control" id="created_date" placeholder="Ngày Tạo"
							disabled="true" />


						<label style="display: none" for="created_date">Ngày
							update </label>
						<sf:input style="display: none" path="updated_date" type="date"
							class="form-control" id="updated_date" placeholder="Ngày Update"
							disabled="true" />


						<label style="display: none" for="updated_by">Updated by:</label>
						<sf:input style="display: none" path="updated_by" type="text"
							class="form-control" id="updated_by" placeholder="Updated by"
							disabled="true" />


						<label style="display: none" for="user_id">User ID:</label>
						<sf:input style="display: none" path="user.id" type="text"
							class="form-control" id="user_id" placeholder="User ID"
							disabled="true" />

						<br>
						<label for="name">Tên khách hàng (required)</label>
						<sf:input path="customer_name" type="text" class="form-control"
							id="name" placeholder="Email khách hàng" required="required" />

						<br>
						<label for="email">Email khách hàng (required)</label>
						<sf:input path="customer_email" type="email" class="form-control"
							id="email" placeholder="Email khách hàng" required="required" />

						<br>
						<label for="phone_number">SDT khách hàng (required)</label>
						<sf:input path="customer_phone" type="number" class="form-control"
							id="phone_number" min="0" placeholder="Số điện thoại"
							required="required" />

						<br>

						<label for="address">Địa chỉ khách hàng (required)</label>
						<sf:input path="customer_address" type="text" class="form-control"
							id="address" placeholder="Địa chỉ" required="required" />


						<br>
						<label for="message">Message </label>
						<sf:textarea path="message" autocomplete="off"
							class="form-control" id="message" placeholder="Message" />


						<br>
						<c:choose>
							<c:when test="${saleorder.cancel }">
								<p class="alert alert-danger">Tình trạng : Đã hủy</p>
							</c:when>
							<c:when test="${!saleorder.confirm&&!saleorder.cancel}">
								<p class="alert alert-danger">Tình trạng : ${saleorder.is_pay ? 'Đã thanh toán và ' : ''}  Chờ xác nhận</p>
							</c:when>
							<c:when test="${saleorder.confirm&&!saleorder.is_delivery}">
								<p class="alert alert-danger">Tình trạng : Đang giao hàng</p>
							</c:when>
							<c:otherwise>
								<p class="alert alert-success">Tình trạng : Giao hàng thành
									công</p>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${!saleorder.cancel }">
								<c:choose>
									<c:when test="${saleorder.confirm }">
										<sf:hidden path="confirm" />
										<c:choose>
											<c:when test="${saleorder.is_delivery }">
												<sf:hidden path="is_delivery" />
											</c:when>
											<c:otherwise>
												<sf:checkbox id="delivery" path="is_delivery" />
												<label for="delivery">Đơn hàng đã giao thành công ?</label>
												<br>
												<sf:checkbox id="cancel" path="cancel" />
												<label for="cancel">Hủy đơn hàng ?</label>
												<br>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<sf:checkbox id="confirm" path="confirm" />
										<label for="confirm">Xác nhận đơn hàng ?</label>
										<sf:hidden path="is_delivery" />
										<br>
										<sf:checkbox id="cancel" path="cancel" />
										<label for="cancel">Hủy đơn hàng ?</label>
										<br>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<sf:hidden path="cancel" />
							</c:otherwise>
						</c:choose>

						<sf:checkbox id="status" path="status" />
						<label for="status">Is Active Sale Order ?</label>

						<br>
						<br>
						<a href="${base }/admin/list-saleorders"
							class="btn btn-secondary active" role="button"
							aria-pressed="true">Back to List</a>
						<button type="submit" class="btn btn-primary">Save Sale
							Order</button>
					</sf:form>

				</div>
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
	<script type="text/javascript">
		if('${saleorder.ipn_return}' !== '') {
			document.getElementById("cancel").disabled = true;
		}

	</script>
</body>
</html>
