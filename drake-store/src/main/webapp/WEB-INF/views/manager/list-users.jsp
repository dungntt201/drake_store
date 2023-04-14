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
<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
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
	width: 50px;
	height: 50px;
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
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/account/list-accounts" method="get">
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
				<h1 class="mt-4">Accounts</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">Accounts</li>
				</ol>

				<c:if test="${not empty msg1 }">
					<p id="hideDiv" class="alert alert-success">${msg1 }</p>
				</c:if>
				<c:if test="${not empty msg }">
					<p id="hideDiv1" class="alert alert-danger">${msg }</p>
				</c:if>

				<a href="${base }/admin/account/add-account"
					class="btn btn-secondary active" role="button" aria-pressed="true">Add
					New Account</a> <br> <br>
				<sf:form action="${base }/admin/account/list-accounts" method="GET"
					modelAttribute="productSearch" enctype="multipart/form-data">

					<span
						style="font-size: 20px; font-weight: bolder; margin-right: 30px;">Sort:
					</span>
					<sf:select path="sort" name="sort" id="sort" style="outline: none">
						<option value="default" ${sort == 'default' ? 'selected' : ''}>Default</option>
						<option value="latest" ${sort == 'latest' ? 'selected' : ''}>Latest
							Created</option>
						<option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Oldest
							Created</option>
						<option value="name:asc" ${sort == 'name:asc' ? 'selected' : ''}>A
							to Z</option>
						<option value="name:desc" ${sort == 'name:desc' ? 'selected' : ''}>Z
							to A</option>
					</sf:select>
					<br>
					<br>

					<span
						style="font-size: 20px; font-weight: bolder; margin-right: 20px;">Filter:
					</span>
					<sf:input path="keyword" type="hidden" value="${keyword }"
						name="keyword"></sf:input>

					<sf:select path="filter" name="filter" id="filter"
						style="outline: none;">
						<option value="all" ${filter == 'all' ? 'selected' : ''}>Tất
							cả</option>
						<option value="active" ${filter == 'active' ? 'selected' : ''}>Active</option>
						<option value="inactive" ${filter == 'inactive' ? 'selected' : ''}>InActive</option>
					</sf:select>
					<button type="submit">FILTER</button>

				</sf:form>
				<br>
				<c:if test="${totalUsers==0 }">
					<div style="background-color: black">
						<p style="color: white; font-size: 20px; padding: 10px">Không
							có kết quả hiển thị</p>
					</div>
				</c:if>
				<c:if test="${totalUsers>0 }">
					<div style="background-color: black">
						<p id="show" style="color: white; font-size: 20px; padding: 10px">Showing:
							${curPage*sizeOfPage+1}-${curPage*sizeOfPage+totalDisplay} of
							Total: ${totalUsers } kết quả</p>
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
						<th>Username</th>
						<th>Email</th>
						<th>Full name</th>
						<th>Avatar</th>
						<th>Provider</th>
						<th>Status</th>
						<th>Update</th>
					</tr>

					<c:forEach var="user" items="${users }" varStatus="loop">

						<tr>
							<td id="ID">${sizeOfPage * curPage + loop.count}</td>
							<td>${user.username}</td>
							<td>${user.email}</td>
							<td>${user.full_name}</td>
							<c:choose>
								<c:when test="${user.avatar!=null }">
									<td><img alt="" src="${base }/upload/${user.avatar}"></td>
								</c:when>
								<c:otherwise>
									<td></td>
								</c:otherwise>
							</c:choose>

							<td>${user.provider}</td>
							<c:choose>
								<c:when test="${user.status==true}">
									<td>Active</td>
								</c:when>
								<c:otherwise>
									<td>InActive</td>
								</c:otherwise>
							</c:choose>
							<td><a
								href="${base}/admin/account/edit-account/${user.username}"
								style="text-decoration: none; color: blue; font-weight: bolder"><i
									class="fas fa-edit"></i></a><br>
								<p class="confirmation1"
									style="text-decoration: underline; color: red; cursor: pointer; font-weight: bolder">
									<i class="fas fa-trash"></i>
								</p></td>

						</tr>
					</c:forEach>
				</table>
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
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
				$("#hideDiv1").slideUp(500);
			}, 2000)

		})
		function function2() {
			return confirm('Bạn có chắc chắn muốn ẩn account này?');
		}
		$(document).on("click", ".confirmation", function() {
			if (function2()) {
				var id = $(this).parents("tr").children("#ID").text();
				var filter = $("#filter").val();
				var data = {
					id : id,
				};

				jQuery.ajax({
					url : "/admin/account/delete",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json", // kieu du lieu tra ve tu controller la json
					success : function(jsonResult) {
						alert("Đã ẩn account " + jsonResult.accountName);
						window.location.reload();
					},
					error : function(jqXhr, textStatus, errorMessage) { // error callback 

					}
				});

				$(this).parents("tr").remove();

			}

		});

		function function3() {
			return confirm('Bạn có chắc chắn muốn xóa account này khỏi Database?');
		}
		$(document).on(
				"click",
				".confirmation1",
				function() {
					if (function3()) {
						var id = $(this).parents("tr").children("#ID").text();
						var filter = $("#filter").val();
						var data = {
							id : id,
						};

						jQuery.ajax({
							url : "/admin/account/removeFromDB",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {
								alert(jsonResult.msg);
								window.history.pushState(null, null,
										"/admin/account/list-accounts");
								window.location.reload();
							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});

						//$(this).parents("tr").remove();

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
										;
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
									$("#pagee11").css("display", "none");
									$("#pagee1").css("display", "none");
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

							window.history.pushState(null, null,
									"/admin/account/list-accounts?page="
											+ (page + 1) + "&keyword="
											+ $("#keyWord").val() + "&sort="
											+ $("#sort").val() + "&filter="
											+ $("#filter").val());
							var data = {
								page : page,
								keyword : keyword,
								sort : sort,
								filter : filter,

							};

							jQuery
									.ajax({
										url : "/admin/account/list-accounts",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);

											if (jsonResult.totalAccounts >= 1) {
												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalAccounts
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

							window.history.pushState(null, null,
									"/admin/list-accounts?page=" + (page + 1)
											+ "&keyword=" + $("#keyWord").val()
											+ "&sort=" + $("#sort").val()
											+ "&filter=" + $("#filter").val());
							var data = {
								page : page,
								keyword : keyword,
								sort : sort,
								filter : filter,

							};

							jQuery
									.ajax({
										url : "/admin/account/list-accounts",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);
											if (jsonResult.totalAccounts >= 1) {
												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalAccounts
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
