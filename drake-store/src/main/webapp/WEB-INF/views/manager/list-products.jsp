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

select {
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

input[type=checkbox] {
	margin-right: 10px;
}

label {
	margin-right: 20px;
	font-weight: bolder;
}

form .middle {
	position: relative;
	width: 40%;
	margin-top: 30px;
	margin-left: 80px;
}

form .middle .slider {
	position: relative;
	z-index: 1;
	height: 10px;
}

form .middle .slider>.track {
	position: absolute;
	z-index: 1;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	border-radius: 5px;
	background-color: rgb(216, 214, 218);
}

form .middle .slider>.range {
	position: absolute;
	z-index: 2;
	left: 25%;
	right: 25%;
	top: 0;
	bottom: 0;
	border-radius: 5px;
	background-color: rgb(0, 0, 0);
}

form .middle .slider>.thumb {
	position: absolute;
	z-index: 3;
	width: 30px;
	height: 30px;
	background-color: gray;
	border-radius: 50%;
	opacity: 1;
}

form .middle .slider>.thumb.left {
	left: 25%;
	transform: translate(-15px, -10px);
}

form .middle .slider>.thumb.right {
	right: 25%;
	transform: translate(15px, -10px);
}

form .middle input[type=range] {
	position: absolute;
	z-index: 2;
	width: 100%;
	height: 10px;
	-webkit-appearance: none;
	pointer-events: none;
	opacity: 0;
	cursor: e-resize;
}

form .middle input[type=range]::-webkit-slider-thumb {
	pointer-events: all;
	-webkit-appearance: none;
	width: 30px;
	height: 30px;
	border-radius: 0;
	border: 0 none;
	background-color: red;
}

form .middle .slider .thumb i {
	color: white;
	text-align: center;
	position: absolute;
	left: 32%;
	top: 32%;
	font-size: 10px;
}
</style>
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
				<h1 class="mt-4">Products</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">Products</li>
				</ol>

				<c:if test="${not empty msg }">
					<p id="hideDiv" class="alert alert-success">${msg }</p>
				</c:if>
				
				<c:if test="${not empty msg1 }">
					<p id="hideDiv1" class="alert alert-danger">${msg1}</p>
				</c:if>

				<a href="${base }/admin/add-products"
					class="btn btn-secondary active" role="button" aria-pressed="true">Add
					New Product</a> <br> <br>

				<sf:form action="${base }/admin/list-products" method="GET"
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
						<option value="lowtohigh" ${sort == 'lowtohigh' ? 'selected' : ''}>Price:
							low to high</option>
						<option value="hightolow" ${sort == 'hightolow' ? 'selected' : ''}>Price:
							high to low</option>
					</sf:select>
					<br>
					<br>

					<span
						style="font-size: 20px; font-weight: bolder; margin-right: 20px;">Filter:
					</span>
					<sf:input path="keyword" type="hidden" value="${keyword }"
						name="keyword"></sf:input>

					<span style="font-weight: bolder; margin-right: 20px;">Size:</span>
					<sf:checkboxes items="${listSizes }" path="sizes" />


					<br>
					<br>
					<span
						style="font-weight: bolder; margin-right: 20px; margin-left: 80px">Price:
						$<span id="span1">0 VND</span> - $<span id="span2">25.000.000
							VND</span>
					</span>
					<div class="middle">
						<div class="multi-range-slider">
							<c:choose>
								<c:when test="${minPrice!=null&&maxPrice!=null }">
									<sf:input path="minPrice" type="range" min="0" max="25000000"
										value="${minPrice }" id="input-left" name="min-price"></sf:input>
									<sf:input path="maxPrice" type="range" min="0" max="25000000"
										value="${maxPrice }" id="input-right" name="max-price"></sf:input>
								</c:when>
								<c:otherwise>
									<sf:input path="minPrice" type="range" min="0" max="25000000"
										value="0" id="input-left" name="min-price"></sf:input>
									<sf:input path="maxPrice" type="range" min="0" max="25000000"
										value="25000000" id="input-right" name="max-price"></sf:input>
								</c:otherwise>
							</c:choose>
							<div class="slider">
								<div class="track"></div>
								<div class="range"></div>
								<div class="thumb left">
									<i class="fas fa-circle"></i>
								</div>
								<div class="thumb right">
									<i class="fas fa-circle"></i>
								</div>
							</div>
						</div>
					</div>


					<br>
					<c:choose>
						<c:when test="${category_id!=0 }">
							<div style="margin-left: 95px">
								<input type="checkbox" id="haspid" class="form-check-input"
									checked="checked" /> <label class="form-check-lable"
									for="haspid"
									style="margin-left: 10px; color: red; font-weight: bolder">Click
									if you want to filter by category?</label>
							</div>

							<br>
							<sf:select disabled="false" path="category_id" name="category_id"
								id="category_id" style="outline: none;margin-left:80px;">
								<sf:options items="${categories }" itemValue="id"
									itemLabel="name" />
							</sf:select>
						</c:when>
						<c:otherwise>
							<div style="margin-left: 95px">
								<input type="checkbox" id="haspid" class="form-check-input" />
								<label class="form-check-lable" for="haspid"
									style="margin-left: 10px; color: red; font-weight: bolder">Click
									if you want to filter by category?</label>
							</div>

							<br>
							<sf:select disabled="true" path="category_id" name="category_id"
								id="category_id" style="outline: none;margin-left:80px;">
								<sf:options items="${categories }" itemValue="id"
									itemLabel="name" />
							</sf:select>
						</c:otherwise>
					</c:choose>


					<sf:select path="filter" name="filter" id="filter"
						style="outline: none;">
						<option value="all" ${filter == 'all' ? 'selected' : ''}>Tất
							cả</option>
						<option value="hot" ${filter == 'hot' ? 'selected' : ''}>HOT</option>
	                    <option value="sale" ${filter == 'sale' ? 'selected' : ''}>SALE</option>
						<option value="active" ${filter == 'active' ? 'selected' : ''}>Active</option>
						<option value="inactive" ${filter == 'inactive' ? 'selected' : ''}>InActive</option>
					</sf:select>
					<button type="submit" onclick="f1()">FILTER</button>

				</sf:form>

				<br>
				<c:if test="${totalProducts==0 }">
					<div style="background-color: black">
						<p style="color: white; font-size: 20px; padding: 10px">Không
							có kết quả hiển thị</p>
					</div>
				</c:if>
				<c:if test="${totalProducts>0 }">
					<div style="background-color: black">
						<p id="show" style="color: white; font-size: 20px; padding: 10px">Showing:
							${curPage*sizeOfPage+1}-${curPage*sizeOfPage+totalDisplay} of
							Total: ${totalProducts } kết quả</p>
					</div>
				</c:if>

			</div>



			<div class="table-responsive container-fluid px-4"
				style="width: 100%">
				<input type="hidden" value="${totalPage }" id="totalPage"> <input
					type="hidden" value="${curPage }" id="curPage"> <input
					type="hidden" value="${keyword }" id="keyWord"> <input
					type="hidden" value="${filter }" id="filter"> <input
					type="hidden" value="${minPrice }" id="minPrice"> <input
					type="hidden" value="${maxPrice }" id="maxPrice">
				<%-- <input type="hidden" value="${sort }" id="Sort"> --%>
				<input type="hidden" value="${category_id }" id="cate_ID">
				<c:forEach items="${sizes }" var="size">
					<input type="hidden" class="sizes" value="${size }">
				</c:forEach>

				<table class="table table-hover table-bordered table-condensed">
					<tr>
						<th>ID</th>
						<th>Title</th>
						<th>Price</th>
						<th>Price Sale</th>
						<!-- <th>Details Des</th> -->
						<th>Avatar</th>
						<th>Category</th>
						<!-- <th>Created date</th>
                    			<th>Updated date</th>
                    			<th>Created By</th>
                    			<th>Updated By</th> -->
						<!-- <th>Status</th> -->
						<th>Sold</th>
						<th>Is hot Product</th>
						<th>Update</th>
					</tr>

					<c:forEach var="product" items="${products }" varStatus="loop">

						<tr>
							<td id="ID">${sizeOfPage * curPage + loop.count}</td>
							<td>${product.title}</td>
							<td><fmt:formatNumber value="${product.price}" type="number"
									groupingUsed="true" /> VND</td>
							<td><fmt:formatNumber value="${product.price_sale}"
									type="number" groupingUsed="true" /> VND</td>
							<%-- <td>${product.details}</td> --%>
							<td><img alt="" src="${base }/upload/${product.avatar}">
							</td>
							<td>${product.categories.name}</td>
							<%-- <td>${product.created_date}</td>
	                    			<td>${product.updated_date}</td>
	                    			<td>${product.created_by}</td>
	                    			<td>${product.updated_by}</td> --%>
							<%-- <td>${product.status}</td> --%>
							<c:choose>
								<c:when test="${product.sold==null || product.sold==0}">
									<td>0</td>
								</c:when>
								<c:otherwise>
									<td>${product.sold}</td>
								</c:otherwise>
							</c:choose>
							<td>${product.is_hot}</td>
							<td><a href="${base}/admin/edit-product/${product.seo}"
								style="text-decoration: none; color: blue; font-weight: bolder">
									<i class="fas fa-edit"></i>
							</a><br> <%-- <c:if test="${filter!='deleted' }">
									<p class="confirmation"
										style="text-decoration: none; color: red; cursor: pointer; font-weight: bolder">Ẩn</p>
								</c:if> --%>
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
	<script src="${base }/manager/js/managerproducts.js"></script>

	<script type="text/javascript">
		$(function() {
			setTimeout(function() {
				$("#hideDiv1").slideUp(500);
				$("#hideDiv").slideUp(500);
			}, 2000)

		})
		$(document).ready(function() {

			$('#haspid').click(function() {
				if ($(this).is(':checked')) {
					// khi thẻ đc disabled thì path sẽ k link đễn thuộc tính của entity
					$("#category_id").prop('disabled', false);
				} else {
					$("#category_id").prop('disabled', true);
				}
			});
		});

		function function2() {
			return confirm('Bạn có chắc chắn muốn ẩn product này?');
		}
		$(document).on("click", ".confirmation", function() {
			if (function2()) {
				var id = $(this).parents("tr").children("#ID").text();
				var filter = $("#filter").val();
				var data = {
					id : id,
				};

				jQuery.ajax({
					url : "/admin/product/delete",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json", // kieu du lieu tra ve tu controller la json
					success : function(jsonResult) {
						alert("Đã ẩn product có tên " + jsonResult.proName);
						window.location.reload();
					},
					error : function(jqXhr, textStatus, errorMessage) { // error callback 

					}
				});

				$(this).parents("tr").remove();

			}

		});

		function function3() {
			return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi Database?');
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
							url : "/admin/product/removeFromDB",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {
								alert(jsonResult.msg);
								window.history.pushState(null, null,
										"/admin/list-products");
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
							var minPrice = $("#minPrice").val();
							var maxPrice = $("#maxPrice").val();
							var category_id = $("#cate_ID").val();
							var a1 = $(".sizes");
							const sizes = [];
							for (var i = 0; i < a1.length; i++) {

								sizes[i] = $(a1[i]).val();

							}

							if ((minPrice != "") && (minPrice != "")) {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&min-price="
														+ minPrice
														+ "&max-price="
														+ maxPrice
														+ "&category_id="
														+ $("#cate_ID").val()
														+ "&filter="
														+ $("#filter").val());

										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											//sizes:sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&min-price="
														+ minPrice
														+ "&max-price="
														+ maxPrice + "&filter="
														+ $("#filter").val());

										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											//sizes:sizes,
											//category_id:category_id,
											filter : filter,
										};
									}
								} else {
									if (category_id != 0) {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&min-price=" + minPrice
												+ "&max-price=" + maxPrice
												+ "&category_id="
												+ $("#cate_ID").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}

										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&min-price=" + minPrice
												+ "&max-price=" + maxPrice
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}

										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}
								}
							} else {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&category_id="
														+ $("#cate_ID").val()
														+ "&filter="
														+ $("#filter").val());
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&filter="
														+ $("#filter").val());
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}

								} else {
									if (category_id != 0) {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&category_id="
												+ $("#cate_ID").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}
										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}
										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}

								}
							}

							jQuery
									.ajax({
										url : "/admin/list-products",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);

											if (jsonResult.totalProducts >= 1) {
												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalProducts
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

							var sort = $("#sort").val();
							var keyword = $("#keyWord").val();
							var filter = $("#filter").val();
							var minPrice = $("#minPrice").val();
							var maxPrice = $("#maxPrice").val();
							var category_id = $("#cate_ID").val();
							var a1 = $(".sizes");
							const sizes = [];
							for (var i = 0; i < a1.length; i++) {

								sizes[i] = $(a1[i]).val();

							}

							if ((minPrice != "") && (minPrice != "")) {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&min-price="
														+ minPrice
														+ "&max-price="
														+ maxPrice
														+ "&category_id="
														+ $("#cate_ID").val()
														+ "&filter="
														+ $("#filter").val());

										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											//sizes:sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&min-price="
														+ minPrice
														+ "&max-price="
														+ maxPrice + "&filter="
														+ $("#filter").val());

										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											//sizes:sizes,
											//category_id:category_id,
											filter : filter,
										};
									}
								} else {
									if (category_id != 0) {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&min-price=" + minPrice
												+ "&max-price=" + maxPrice
												+ "&category_id="
												+ $("#cate_ID").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}

										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&min-price=" + minPrice
												+ "&max-price=" + maxPrice
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}

										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											minPrice : minPrice,
											maxPrice : maxPrice,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}
								}
							} else {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&category_id="
														+ $("#cate_ID").val()
														+ "&filter="
														+ $("#filter").val());
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										window.history.pushState(null, null,
												"/admin/list-products?page="
														+ (page + 1)
														+ "&keyword="
														+ $("#keyWord").val()
														+ "&sort="
														+ $("#sort").val()
														+ "&filter="
														+ $("#filter").val());
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}

								} else {
									if (category_id != 0) {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&category_id="
												+ $("#cate_ID").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}
										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											category_id : category_id,
											filter : filter,
										};
									} else {
										var a = "/admin/list-products?page="
												+ (page + 1) + "&keyword="
												+ $("#keyWord").val()
												+ "&sort=" + $("#sort").val()
												+ "&filter="
												+ $("#filter").val();
										for (var i = 0; i < sizes.length; i++) {
											a += "&sizes=" + sizes[i];
										}
										window.history.pushState(null, null, a);
										var data = {
											page : page,
											keyword : keyword,
											sort : sort,
											sizes : sizes,
											//category_id:category_id,
											filter : filter,
										};
									}

								}
							}

							jQuery
									.ajax({
										url : "/admin/list-products",
										type : "post",
										contentType : "application/json",
										data : JSON.stringify(data),
										dataType : "json", // kieu du lieu tra ve tu controller la json
										success : function(jsonResult) {
											$(".table").html(jsonResult.html);

											if (jsonResult.totalProducts >= 1) {
												$("#show")
														.text(
																"Showing: "
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + 1)
																		+ "-"
																		+ (jsonResult.curPage
																				* jsonResult.sizeOfPage + jsonResult.totalDisplay)
																		+ " of Total: "
																		+ jsonResult.totalProducts
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
