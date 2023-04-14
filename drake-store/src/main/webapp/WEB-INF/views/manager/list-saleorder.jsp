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
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="${base }/manager/css/styles.css" rel="stylesheet" />
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script> -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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

table th, td {
	text-align: center;
}

td p {
	margin: 0;
}

#pagee, #pagee111 {
	display: none;
}

select, input {
	width: 200px;
	height: 37px;
}

button {
	height: 37px;
	outline: none;
	background-color: black;
	color: white;
	border: none;
	padding: 0 10px;
	border-radius: 5px;
	font-weight: bolder;
}
</style>
<script type="text/javascript">
	function checkEndDate() {
		var g = document.getElementById("endDate").value;
		var checkout = Date.parse(g);

		var g1 = document.getElementById("startDate").value;
		var checkin = Date.parse(g1);

		if (g1 != null) {
			if (checkin > checkout) {
				alert("Warning: End date phải >= Start date!")
				document.getElementById("endDate").value = null;
				return false;
			} else {
				return true;
			}
		} else {
			return true;
		}

	}
	function checkStartDate() {
		var g = document.getElementById("endDate").value;
		var checkout = Date.parse(g);

		var g1 = document.getElementById("startDate").value;
		var checkin = Date.parse(g1);

		if (g != null) {
			if (checkin > checkout) {
				alert("Warning: Start date phải <= End date!")
				document.getElementById("startDate").value = null;
				return false;
			} else {
				return true;
			}
		} else {
			return true;
		}

	}

	function checkDate() {
		if (checkStartDate() && checkEndDate()) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-saleorders" method="get">
		<div class="input-group">
			<input value="${keyword }" name="keyword" class="form-control"
				type="text" placeholder="Search for..." aria-label="Search for..."
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
				<h1 class="mt-4">Sale Orders</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">Sale Orders</li>
				</ol>


				<c:if test="${not empty msg }">
					<p id="hideDiv" class="alert alert-success">${msg }</p>
				</c:if>
				<c:if test="${not empty msg1 }">
					<p id="hideDiv" class="alert alert-danger">${msg1 }</p>
				</c:if>
				<sf:form action="${base }/admin/list-saleorders" method="GET"
					modelAttribute="productSearch" enctype="multipart/form-data"
					onsubmit="return checkDate()">

					<span
						style="font-size: 20px; font-weight: bolder; margin-right: 30px;">Sort:
					</span>
					<sf:select path="sort" name="sort" id="sort" style="outline: none">
						<option value="default" ${sort == 'default' ? 'selected' : ''}>Default</option>
						<option value="latest" ${sort == 'latest' ? 'selected' : ''}>Latest
							Created</option>
						<option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Oldest
							Created</option>
						<option value="lowtohigh" ${sort == 'lowtohigh' ? 'selected' : ''}>Total:
							low to high</option>
						<option value="hightolow" ${sort == 'hightolow' ? 'selected' : ''}>Total:
							high to low</option>
					</sf:select>
					<br>
					<br>
					<span
						style="font-size: 20px; font-weight: bolder; margin-right: 20px;">Filter:
					</span>
					<sf:input path="keyword" type="hidden" value="${keyword }"
						name="keyword"></sf:input>


					<span style="font-weight: bolder; margin-left: 0px;">Start
						Date: </span>
					<sf:input onchange="checkStartDate()" path="startDate"
						id="startDate" name="startDate" type="date"
						style="margin-left:20px;" />
					<br>
					<br>

					<span style="font-weight: bolder; margin-left: 80px;">End
						Date: </span>
					<sf:input onchange="checkEndDate()" path="endDate" id="endDate"
						name="endDate" type="date" style="margin-left:28px;" />
					<br>
					<br>

					<span style="font-weight: bolder; margin-left: 80px;">Trạng
						thái: </span>
					<sf:select path="filter" name="filter" id="filter"
						style="outline: none;margin-left:20px;">
						<option value="all" ${filter == 'all' ? 'selected' : ''}>Tất
							cả</option>
						<option value="unconfirm"
							${filter == 'unconfirm' ? 'selected' : ''}>Chờ xác nhận</option>
						<option value="delivering"
							${filter == 'delivering' ? 'selected' : ''}>Đang giao
							hàng</option>
						<option value="delivered"
							${filter == 'delivered' ? 'selected' : ''}>Đã giao hàng</option>
						<option value="cancel" ${filter == 'cancel' ? 'selected' : ''}>Đã
							hủy</option>
						<option value="active" ${filter == 'active' ? 'selected' : ''}>Active</option>
						<option value="inactive" ${filter == 'inactive' ? 'selected' : ''}>InActive</option>
					</sf:select>
					<button type="submit">FILTER</button>

				</sf:form>
				<br>
				<c:if test="${totalSaleOrders==0 }">
					<div style="background-color: black">
						<p style="color: white; font-size: 20px; padding: 10px">Không
							có kết quả hiển thị</p>
					</div>
				</c:if>
				<c:if test="${totalSaleOrders>0 }">
					<div style="background-color: black">
						<p id="show" style="color: white; font-size: 20px; padding: 10px">Showing:
							${curPage*sizeOfPage+1}-${curPage*sizeOfPage+totalDisplay} of
							Total: ${totalSaleOrders } kết quả</p>
					</div>
				</c:if>
			</div>




			<div class="table-responsive container-fluid px-4"
				style="width: 100%">
				<input type="hidden" value="${totalPage }" id="totalPage"> <input
					type="hidden" value="${curPage }" id="curPage"> <input
					type="hidden" value="${keyword }" id="keyWord"> <input
					type="hidden" value="${filter }" id="filter">
				<table class="table table-hover table-bordered table-condensed">
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
						<c:if test="${filter!='deleted' }">
							<th>Hủy</th>
						</c:if>
						<th>Update</th>
					</tr>

					<c:forEach var="saleOrder" items="${saleOrders}" varStatus="loop">

						<tr>
<%--							<td>${saleOrder.id}</td>--%>
							<td>${sizeOfPage * curPage + loop.count}</td>
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
							<c:if test="${filter!='deleted' }">
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
							</c:if>
							<td><a
								href="${base }/admin/edit-saleorder/${saleOrder.code}"
								style="text-decoration: none; color: blue; font-weight: bolder"><i
									class="fas fa-edit"></i></a> <%--	                    				
									<c:if test="${filter!='deleted' }">--%> <%--<p class="confirmation1" style="text-decoration:none;color:red;font-weight: bolder;cursor: pointer;"><i class="fas fa-eye-slash"></i></p>--%>
								<%--</c:if>--%> <%--tạm thời bỏ nút ẩn--%>

								<p class="confirmation2"
									style="text-decoration: underline; color: red; cursor: pointer; font-weight: bolder">
									<i class="fas fa-trash"></i>
								</p></td>

						</tr>
					</c:forEach>
				</table>

			</div>
			<!--
                    	phân trang 
                    	trang 1 trở đi là đã phân<=> curPage=0 trở lên
                    	trang 0 là trang lấy full bản ghi <=> curPage=-1
                      -->
			<c:if test="${totalPage>1 }">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center	">
						<!--của ajax  -->
						<li id="pagee" class="page-item"><a class="page-link"
							href="#"><i class="fas fa-angle-double-left"></i></a></li>

						<!--của controller  -->
						<c:if test="${curPage>0 }">
							<li id="pagee11" class="page-item"><a class="page-link"
								href="#"><i class="fas fa-angle-double-left"></i></a></li>
						</c:if>
						<%-- <c:if test="${totalPage>1 }">
										 <li class="page-item"><a class="page-link" href="${base }/shop?keyword=${keyword }&page=1">First</a></li>	 
									</c:if> --%>

						<c:forEach var="i" begin="1" end="${totalPage }">
							<c:if test="${i==curPage+1 }">
								<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
							</c:if>
							<c:if test="${i!=curPage+1 }">
								<li class="page-item"><a class="page-link" href="#">${i}</a></li>
							</c:if>
						</c:forEach>

						<%-- <c:if test="${totalPage>1 }">							 
										<li class="page-item"><a class="page-link" href="${base }/shop?keyword=${keyword }&page=${totalPage}">Last</a></li>
									 </c:if> --%>

						<c:if test="${curPage<totalPage-1 }">
							<li id="pagee1" class="page-item"><a class="page-link"
								href="#"><i class="fas fa-angle-double-right"></i></a></li>
						</c:if>
						<!--của ajax  -->
						<li id="pagee111" class="page-item"><a class="page-link"
							href="#"><i class="fas fa-angle-double-right"></i></a></li>

					</ul>
				</nav>
			</c:if>
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
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
			}, 2000)

		})
		function function1() {
			return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');
		}
		$(document).on(
				"click",
				".confirmation",
				function() {
					if (function1()) {
						var code = $(this).parents("tr").children("#code")
								.text();
						var filter = $("#filter").val();
						var data = {
							code : code,
						};

						jQuery.ajax({
							url : "/admin/saleorder/cancel",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {
								alert(jsonResult.msg);
								window.history.pushState(null, null,
										"/admin/list-saleorders");
								window.location.reload();
							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});
						/* if(filter=="all"){
							
							$(this).parents("tr").children("#confirm").text("Đã hủy");
							$(this).parents("tr").children("#cancel").html("<p style=\"text-decoration:none;color:red;font-weight: bolder\">Không thể hủy</p>");
								
						}else{
							
							$(this).parents("tr").remove();
							   		
						} */

					}

				});

		function function2() {
			return confirm('Bạn có chắc chắn muốn ẩn đơn hàng này?');
		}
		$(document).on(
				"click",
				".confirmation1",
				function() {
					if (function2()) {
						var code = $(this).parents("tr").children("#code")
								.text();
						var filter = $("#filter").val();
						var data = {
							code : code,
						};

						jQuery.ajax({
							url : "/admin/saleorder/delete",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {
								alert("Đã ẩn đơn hàng có code "
										+ jsonResult.codeSaleOrder);
								window.location.reload();
							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});

						$(this).parents("tr").remove();

					}

				});

		function function3() {
			return confirm('Bạn có chắc chắn muốn xóa đơn hàng này khỏi Database?');
		}
		$(document).on(
				"click",
				".confirmation2",
				function() {
					if (function3()) {
						var code = $(this).parents("tr").children("#code")
								.text();
						var filter = $("#filter").val();
						var data = {
							code : code,
						};

						jQuery.ajax({
							url : "/admin/saleorder/removeFromDB",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {
								alert(jsonResult.msg);
								window.history.pushState(null, null,
										"/admin/list-saleorders");
								window.location.reload();
							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});

						/* $(this).parents("tr").remove();
							xóa dòng chứa đơn hàng   		
						 */

					}

				});

		$(document)
				.on(
						"click",
						".page-item",
						function() {

							var pageItem = document
									.getElementsByClassName("page-item");
							var page;

							//set page để chuyển về db
							//TH nút next
							if ($(this).text() == null || $(this).text() == "") {
								if ($(this).children(".page-link")
										.children("i").hasClass(
												"fas fa-angle-double-right")) {
									//alert("abc");
									//nếu chưa đc phân lần nào thì lấy giá trị của id curPage đc đẩy từ controller xuống
									if ($("#curpage").val() == null) {
										page = parseInt($("#curPage").val()) + 1;
									}
									//đc phân rồi thì lấy của id curpage trong html đc đẩy từ controller ajax xuống
									else {
										page = parseInt($("#curpage").val()) + 1;
									}

								}
								//TH nút previuos
								else {
									//nếu chưa đc phân lần nào thì lấy giá trị của id curPage đc đẩy từ controller xuống
									if ($("#curpage").val() == null) {
										page = parseInt($("#curPage").val()) - 1;
									}
									//đc phân rồi thì lấy của id curpage trong html đc đẩy từ controller ajax xuống
									else {
										page = parseInt($("#curpage").val()) - 1;
									}
								}
							}
							//TH còn lại lấy giá trị text của nút
							else {
								page = $(this).text() - 1;
							}

							//chỉnh sửa hiện thị các nút phân trang

							//nếu nút bấm là số trang <=1 thì tất cả các nút điều hướng sẽ ẩn trừ nút next ajax
							if ($(this).text() <= 1) {
								$("#pagee").css("display", "none");
								$("#pagee111").css("display", "block");
								$("#pagee1").css("display", "none");
								$("#pagee11").css("display", "none");
								$(".page-item").removeClass("active");
								$(this).addClass("active");
							}

							//nếu nút bấm là số trang >1 và < nút số cuối
							if ($(this).text() > 1
									&& $(this).text() < parseInt($("#totalPage")
											.val())) {
								//alert("Nguyen");
								//nếu load lại trang thì sẽ hiển thị 2 nút của controller và ẩn 2 nút ajax

								//TH nút previous controller hiển thị thì ẩn các nút controller hiện nút ajax
								if ($("#pagee11").css("display") != "none") {
									$("#pagee11").css("display", "none");
									$("#pagee1").css("display", "none");
									$("#pagee").css("display", "block");
									$("#pagee111").css("display", "block");
									$(".page-item").removeClass("active");
									$(this).addClass("active");
								} else if ($("#pagee1").css("display") != "none") {
									$("#pagee1").css("display", "none");
									$("#pagee11").css("display", "none");
									$("#pagee").css("display", "block");
									$("#pagee111").css("display", "block");
									$(".page-item").removeClass("active");
									$(this).addClass("active");
								}
								//TH k hiện nút controller
								else {
									$("#pagee").css("display", "block");
									$("#pagee111").css("display", "block");
									$(".page-item").removeClass("active");
									$(this).addClass("active");
								}
							}

							//trưởng hợp là nút số cuối cùng
							if ($(this).text() == parseInt($("#totalPage")
									.val())) {
								$("#pagee1").css("display", "none");
								$("#pagee11").css("display", "none");
								$("#pagee111").css("display", "none");
								$("#pagee").css("display", "block");
								$(".page-item").removeClass("active");
								$(this).addClass("active");
							}

							//TH là 2 nút chuyển hướng
							//ẩn các nứt controller hiện các nút ajax vs điều hiện tưởng ứng
							//add class active cho các nút số tương ứng
							if ($(this).text() == null || $(this).text() == "") {
								if ($(this).children(".page-link")
										.children("i").hasClass(
												"fas fa-angle-double-right")) {
									for (var i = 0; i < pageItem.length; i++) {
										if (pageItem[i].textContent == page + 1) {
											$(".page-item").removeClass(
													"active");
											pageItem[i].classList.add("active");
											$("#pagee1").css("display", "none");
											$("#pagee11")
													.css("display", "none");
											if (page > 0) {
												$("#pagee").css("display",
														"block");
												$("#pagee111").css("display",
														"block")
											} else {
												$("#pagee").css("display",
														"none");
											}

											if (page == parseInt($("#totalPage")
													.val()) - 1) {
												$("#pagee111").css("display",
														"none");
											}
										}

									}
								} else {
									for (var i = 0; i < pageItem.length; i++) {
										if (pageItem[i].textContent == page + 1) {
											$(".page-item").removeClass(
													"active");
											pageItem[i].classList.add("active");
											$("#pagee1").css("display", "none");
											$("#pagee11")
													.css("display", "none");
											if (page <= 0) {
												$("#pagee").css("display",
														"none");
											} else if (page > 0
													&& page < parseInt($(
															"#totalPage").val())) {
												$("#pagee").css("display",
														"block");
												$("#pagee111").css("display",
														"block");
											} else {
												$("#pagee111").css("display",
														"none")
											}
										}

									}
								}
							}
							var sort = $("#sort").val();
							var keyword = $("#keyWord").val();
							var filter = $("#filter").val();
							var startDate = $("#startDate").val();
							var endDate = $("#endDate").val();
							window.history
									.pushState(null, null,
											"/admin/list-saleorders?page="
													+ (page + 1) + "&keyword="
													+ $("#keyWord").val()
													+ "&sort="
													+ $("#sort").val()
													+ "&filter="
													+ $("#filter").val()
													+ "&startDate="
													+ $("#startDate").val()
													+ "&endDate="
													+ $("#endDate").val());
							var data = {
								page : page,
								keyword : keyword,
								sort : sort,
								filter : filter,
								endDate : endDate,
								startDate : startDate,
							};

							jQuery
									.ajax({
										url : "/admin/list-saleorders",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);

											if (jsonResult.totalSaleOrders >= 1) {

												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalSaleOrders
																		+ " kết quả");
											} else {
												$("#show")
														.text(
																"Không có kết quả hiển thị");

											}
										},
										error : function(jqXhr, textStatus,
												errorMessage) { // error callback 

										}
									});

						});

		$(document)
				.on(
						"change",
						"#sort",
						function() {

							var pageItem = document
									.getElementsByClassName("page-item");
							var page = 0;

							for (var i = 0; i < pageItem.length; i++) {
								if (pageItem[i].textContent == page + 1) {
									$(".page-item").removeClass("active");
									pageItem[i].classList.add("active");
									$("#pagee1").css("display", "none");
									$("#pagee").css("display", "none");
									$("#pagee11").css("display", "none");
									$("#pagee111").css("display", "block");
								}

							}

							var keyword = $("#keyWord").val();
							var sort = $("#sort").val();
							var filter = $("#filter").val();
							var startDate = $("#startDate").val();
							var endDate = $("#endDate").val();

							window.history
									.pushState(null, null,
											"/admin/list-saleorders?page="
													+ (page + 1) + "&keyword="
													+ $("#keyWord").val()
													+ "&sort="
													+ $("#sort").val()
													+ "&filter="
													+ $("#filter").val()
													+ "&startDate="
													+ $("#startDate").val()
													+ "&endDate="
													+ $("#endDate").val());
							var data = {
								page : page,
								keyword : keyword,
								sort : sort,
								filter : filter,
								endDate : endDate,
								startDate : startDate,
							};

							jQuery
									.ajax({
										url : "/admin/list-saleorders",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);
											if (jsonResult.totalSaleOrders >= 1) {

												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalSaleOrders
																		+ " kết quả");
											} else {
												$("#show")
														.text(
																"Không có kết quả hiển thị");

											}
										},
										error : function(jqXhr, textStatus,
												errorMessage) { // error callback 

										}
									});

						});
	</script>

</body>
</html>
