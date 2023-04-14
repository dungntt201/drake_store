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
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-products" method="get">
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
				<input class="money" type="hidden" id="t1" value="${thang1 }">
				<input class="money" type="hidden" id="t2" value="${thang2 }">
				<input class="money" type="hidden" id="t3" value="${thang3 }">
				<input class="money" type="hidden" id="t4" value="${thang4 }">
				<input class="money" type="hidden" id="t5" value="${thang5 }">
				<input class="money" type="hidden" id="t6" value="${thang6 }">
				<input class="money" type="hidden" id="t7" value="${thang7 }">
				<input class="money" type="hidden" id="t8" value="${thang8 }">
				<input class="money" type="hidden" id="t9" value="${thang9 }">
				<input class="money" type="hidden" id="t10" value="${thang10 }">
				<input class="money" type="hidden" id="t11" value="${thang11 }">
				<input class="money" type="hidden" id="t12" value="${thang12 }">
				<input type="hidden" id="totalMoney" value="${total }">
				<h1 class="mt-4">Dashboard</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">Dashboard</li>
				</ol>
				<div class="row">
					<div class="col-xl-3 col-md-6">
						<div class="card bg-primary text-white mb-4">
							<div class="card-body">
								<p>Tổng đơn hàng: ${all }</p>
								<p>Active: ${allActive }</p>
								<p>InActive: ${allInActive }</p>
								<p>Số đơn hàng chờ xác nhận: ${confirm }</p>
								<p>Số đơn hàng đang giao: ${delivery }</p>
								<p>Số đơn hàng đã giao: ${delivered }</p>
								<p>Số đơn hàng đã hủy: ${cancel }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/list-saleorders">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-warning text-white mb-4">
							<div class="card-body">
								<p>Tổng số danh mục: ${category }</p>
								<p>Active: ${categoryActive }</p>
								<p>InActive: ${categoryInActive }</p>
								<p>Số danh mục cha: ${parentCategory }</p>
								<p>Số danh mục con: ${childrenCategory }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/list-categories">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-success text-white mb-4">
							<div class="card-body">
								<p>Tổng số sản phẩm: ${product }</p>
								<p>Active: ${productActive }</p>
								<p>InActive: ${productInActive }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/list-products">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-danger text-white mb-4">
							<div class="card-body">
								<p>Tổng số tài khoản: ${user }</p>
								<p>Active: ${userActive }</p>
								<p>InActive: ${userInActive }</p>
								<p>Local: ${local }</p>
								<p>Social: ${social }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/account/list-accounts">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-success text-white mb-4">
							<div class="card-body">
								<p>Tổng số bài viết: ${blog }</p>
								<p>Active: ${blogActive }</p>
								<p>InActive: ${blogInActive }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/list-blogs">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card bg-danger text-white mb-4">
							<div class="card-body">
								<p>Tổng số liên hệ: ${contact }</p>
								<p>Active: ${contactActive }</p>
								<p>InActive: ${contactInActive }</p>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-between">
								<a class="small text-white stretched-link"
									href="${base }/admin/list-contact">View Details</a>
								<div class="small text-white">
									<i class="fas fa-angle-right"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card mb-4">
					<div class="card-header"
						style="background-color: red; color: white;">
						<i class="fas fa-table me-1"></i> Đơn hàng chưa xác nhận:
						${confirm }
					</div>
					<div class="card-body">
						<table id="datatablesSimple">
							<thead>
								<tr>
									<th>ID</th>
									<th>Code</th>
									<th>Ngày tạo</th>
									<!-- <th>Ngày Update</th> -->
									<th>Người mua</th>
									<th>Địa chỉ</th>
									<th>Giá trị đơn hàng</th>
									<!-- <th>Thanh toán</th> -->
									<th>Trạng thái</th>
									<th>Xem chi tiết</th>
									<%-- <c:if test="${filter!='deleted' }">
										<th>Hủy</th>
									</c:if> --%>
									<th>Update</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>ID</th>
									<th>Code</th>
									<th>Ngày tạo</th>
									<!-- <th>Ngày Update</th> -->
									<th>Người mua</th>
									<th>Địa chỉ</th>
									<th>Giá trị đơn hàng</th>
									<!-- <th>Thanh toán</th> -->
									<th>Trạng thái</th>
									<th>Xem chi tiết</th>
									<%-- <c:if test="${filter!='deleted' }">
										<th>Hủy</th>
									</c:if> --%>
									<th>Update</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach var="saleOrder" items="${confirmList }">

									<tr>
										<td>${saleOrder.id}</td>
										<td id="code">${saleOrder.code}</td>
										<td><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
												value="${saleOrder.created_date}" /></td>
										<%-- <td>${saleOrder.updated_date}</td> --%>
										<td>${saleOrder.customer_name}</td>
										<td>${saleOrder.customer_address}</td>
										<td><fmt:formatNumber value="${saleOrder.total}"
												type="number" groupingUsed="true" /> VND</td>
										<%-- <c:choose>
			               				<c:when test="${saleOrder.confirm&&saleOrder.is_delivery }">
			               					<td>Đã thanh toán</td>
			               				</c:when>
			               				<c:otherwise>
			               					<td>Chưa thanh toán</td>
			               				</c:otherwise>
			               			</c:choose> --%>
										<c:choose>
											<c:when test="${saleOrder.cancel&&saleOrder.status }">
												<td>Đã hủy</td>
											</c:when>
											<c:when
												test="${!saleOrder.confirm&&!saleOrder.cancel&&saleOrder.status}">
												<td id="confirm">Chờ xác nhận</td>
											</c:when>
											<c:when
												test="${saleOrder.confirm&&!saleOrder.is_delivery&&saleOrder.status }">
												<td>Đang giao hàng</td>
											</c:when>
											<c:when test="${!saleOrder.status }">
												<td>Đã ẩn</td>
											</c:when>
											<c:otherwise>
												<td>Đã giao hàng thành công</td>
											</c:otherwise>
										</c:choose>
										<td><a
											href="${base }/admin/detail-saleorder/${saleOrder.code}"
											style="text-decoration: none; color: blue"><i
												class="far fa-eye"></i></a><br></td>
										<%-- <c:if test="${filter!='deleted' }">
											<c:choose>
												<c:when test="${saleOrder.confirm }">
													<td><p
															style="text-decoration: none; color: red; font-weight: bolder">Không
															thể hủy</p></td>
												</c:when>
												<c:when test="${saleOrder.cancel }">
													<td><p
															style="text-decoration: none; color: red; font-weight: bolder">Không
															thể hủy</p></td>
												</c:when>
												<c:otherwise>
													<td id="cancel"><p class="confirmation"
															style="text-decoration: none; color: red; font-weight: bolder; cursor: pointer;">Hủy
															đơn</p></td>

												</c:otherwise>
											</c:choose>
										</c:if> --%>
										<td><a
											href="${base }/admin/edit-saleorder/${saleOrder.code}"
											style="text-decoration: none; color: blue; font-weight: bolder"><i
												class="fas fa-edit"></i></a> <%--	                    				
									<c:if test="${filter!='deleted' }">--%> <%--<p class="confirmation1" style="text-decoration:none;color:red;font-weight: bolder;cursor: pointer;"><i class="fas fa-eye-slash"></i></p>--%>
											<%--</c:if>--%> <%--tạm thời bỏ nút ẩn--%> <!-- <p class="confirmation2"
												style="text-decoration: underline; color: red; cursor: pointer; font-weight: bolder">
												<i class="fas fa-trash"></i>
											</p> --></td>

									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-12">
						<div class="card mb-4">
							<div class="card-header"
								style="background-color: red; color: white;">
								<i class="fas fa-chart-bar me-1"></i> Biểu đồ doanh thu các
								tháng trong năm ${year } (Tổng doanh thu hiện tại: <fmt:formatNumber value="${total}"
									type="number" groupingUsed="true" /> VND)
							</div>
							<div class="card-body">
								<canvas id="myBarChart" width="100%" height="40"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; Your Website 2021</div>
					<div>
						<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
							&amp; Conditions</a>
					</div>
				</div>
			</div>
		</footer>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="${base }/manager/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="${base }/manager/assets/demo/chart-area-demo.js"></script>
	<script src="${base }/manager/assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="${base }/manager/js/datatables-simple-demo.js"></script>
</body>
</html>
