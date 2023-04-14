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
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${projectTitle }</title>
<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
	crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" href="${base}/user/css/products.css">
<link rel="stylesheet" href="${base}/user/css/styles.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<button id="btn-filter">
		<i class="fas fa-filter"></i>
	</button>
	<div class="banner">
		<div class="banner-content">
			<p>Sale Products</p>
			<a href="#">Home </a><i class="fas fa-chevron-right"></i><span>Sale
				Products</span>
		</div>
	</div>
	<div class="products">
		<div class="products1">
			<div class="List-products">
				<div class="L-p-1">
					<div class="L-p-11">
						<c:choose>
							<c:when test="${totalProducts>0 }">
								<p id="show">Showing:
									${curPage*sizeOfPage+1}-${curPage*sizeOfPage+totalDisplay} of
									Total: ${totalProducts } kết quả</p>
							</c:when>
							<c:otherwise>
								<!-- fix -->
								<p id="show">Không có kết quả hiển thị</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="L-p-12">
						<!-- <form action="#"> -->
						<select name="sort" id="sort">
							<option value="default" ${sort == 'default' ? 'selected' : ''}>Default</option>
							<option value="latest" ${sort == 'latest' ? 'selected' : ''}>Latest
								Created</option>
							<option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Oldest
								Created</option>
							<option value="name:asc" ${sort == 'name:asc' ? 'selected' : ''}>A
								to Z</option>
							<option value="name:desc"
								${sort == 'name:desc' ? 'selected' : ''}>Z to A</option>
							<option value="lowtohigh"
								${sort == 'lowtohigh' ? 'selected' : ''}>Price: low to
								high</option>
							<option value="hightolow"
								${sort == 'hightolow' ? 'selected' : ''}>Price: high to
								low</option>
						</select>
						<!-- </form> -->
						<!-- <ul class="nav nav-tabs">
                            <li class="active active1"><a data-toggle="tab" href="#gird"><i class="fas fa-th"></i></a></li>
                            <li><a data-toggle="tab" href="#inline"><i class="fas fa-th-list"></i></a></li>
                          </ul> -->
					</div>
				</div>
				<div class="list-product11">
					<input type="hidden" value="${totalPage }" id="totalPage">
					<input type="hidden" value="${curPage }" id="curPage"> <input
						type="hidden" value="${keyword }" id="keyWord"> <input
						type="hidden" value="${filter }" id="filter"> <input
						type="hidden" value="${minPrice }" id="minPrice"> <input
						type="hidden" value="${maxPrice }" id="maxPrice">
					<%-- <input type="hidden" value="${sort }" id="Sort"> --%>
					<input type="hidden" value="${category_id }" id="cate_ID">
					<c:forEach items="${sizes }" var="size">
						<input type="hidden" class="sizes" value="${size }">
					</c:forEach>
					<input type="hidden" value="${is_hot }" id="HOT"> <input
						type="hidden" value="${sale }" id="SALE">



					<div class="row" id="sanpham">
						<c:forEach var="product" items="${products }">
							<div
								class=" row col-xl-4 col-lg-4 col-md-4 col-sm-6 col-xs-12 tinh justify-content-left">
								<div class="tinh1" style="position: relative;">
									<!-- Hot badge-->
									<c:if test="${product.is_hot }">
										<div class="badge bg-danger text-white position-absolute"
											style="top: 10px; left: 10px; font-size: 15px">Hot</div>
									</c:if>
									<!-- Product image-->
									<a href="${base }/shop/${product.seo}"> <img
										class="card-img-top" src="${base }/upload/${product.avatar}"
										alt="${product.title }" width="100%" height="250px" />
									</a>
									<!-- Product details-->
									<div class="text-center">
										<!-- Product name-->
										<a href="${base }/shop/${product.seo}"
											style="text-decoration: none" class="text-black">
											<p style="font-size: 17px; margin: 20px 10px 0 10px"
												class="fw-bolder">${product.title }</p>
										</a>
										<!-- Product price-->
										<c:if test="${product.price_sale<product.price }">
											<!-- Sale badge-->
											<div class="badge bg-dark text-white position-absolute"
												style="top: 10px; right: 10px; font-size: 15px">Sale</div>
											<span style="font-size: 16px"
												class="text-muted text-decoration-line-through"><fmt:formatNumber
													value="${product.price}" type="number" groupingUsed="true" />
												VND</span>
											<br>
											<span style="font-size: 16px" class="fw-bolder"><fmt:formatNumber
													value="${product.price_sale}" type="number"
													groupingUsed="true" /> VND<span>
										</c:if>
										<c:if
											test="${product.price_sale==null ||product.price_sale==product.price  }">
											<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
											<span class="fw-bolder" style="font-size: 16px"><fmt:formatNumber
													value="${product.price}" type="number" groupingUsed="true" />
												VND</span>
										</c:if>
									</div>
									<br>
									<br>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<!--phân trang 
              	trang 1 trở đi là đã phân<=> curPage=0 trở lên
              	trang 0 là trang lấy full bản ghi <=> curPage=-1
                -->
				<c:if test="${totalPage>1 }">
					<nav aria-label="Page navigation example" style="margin-top: 50px">
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
			<!-- table of contents -->
			<div class="Toc-product" id="toc">
				<button id="close-filter">
					<i class="fas fa-times"></i>
				</button>
				<p class="t3">Categories</p>
				<ul class="all-category list-unstyled">
					<c:forEach var="parentCategory" items="${parentCategories }">
						<li class="category1"><p>
								<a href="${base }/category/${parentCategory.seo }">${parentCategory.name }</a>
								<i class="fas fa-chevron-down"></i><i class="fas fa-chevron-up"></i>
							</p>
							<ul class="category2 list-unstyled">
								<c:forEach var="childrenCategory" items="${childrenCategories }">
									<c:if
										test="${childrenCategory.children.id==parentCategory.id }">
										<li class="sub-category"><p>
												<a href="${base }/category/${childrenCategory.seo }">${childrenCategory.name }</a>
											</p></li>
									</c:if>
								</c:forEach>

							</ul></li>
					</c:forEach>
				</ul>


				<sf:form action="${base }/san-pham-sale" method="GET"
					modelAttribute="productSearch">
					<p class="t3">Size :</p>
					<div class="size">

						<sf:input type="hidden" value="${keyword }" name="keyword"
							path="keyword"></sf:input>


						<%-- <sf:checkboxes items="${listSizes }" path="sizes"  style="display:gird"/> --%>
						<sf:checkbox path="sizes" value="37" id="sizes1" />
						<label for="sizes1">37</label>
						<sf:checkbox path="sizes" value="38" id="sizes2" />
						<label for="sizes2">38</label>
						<sf:checkbox path="sizes" value="39" id="sizes3" />
						<label for="sizes3">39</label><br>
						<sf:checkbox path="sizes" value="40" id="sizes4" />
						<label for="sizes4">40</label>
						<sf:checkbox path="sizes" value="41" id="sizes5" />
						<label for="sizes5">41</label>
						<sf:checkbox path="sizes" value="42" id="sizes6" />
						<label for="sizes6">42</label><br>
						<sf:checkbox path="sizes" value="43" id="sizes7" />
						<label for="sizes7">43</label>
						<sf:checkbox path="sizes" value="44" id="sizes8" />
						<label for="sizes8">44</label>
						<sf:checkbox path="sizes" value="XS" id="sizes9" />
						<label for="sizes9">XS</label><br>
						<sf:checkbox path="sizes" value="S" id="sizes10" />
						<label for="sizes10">S</label>
						<sf:checkbox path="sizes" value="M" id="sizes11" />
						<label for="sizes11">M</label>
						<sf:checkbox path="sizes" value="L" id="sizes12" />
						<label for="sizes12">L</label><br>
						<sf:checkbox path="sizes" value="XL" id="sizes13" />
						<label for="sizes13">XL</label>

					</div>
					<br>
					<p class="t3">Category :</p>
					<c:choose>
						<c:when test="${category_id!=0 }">
							<sf:select disabled="false" path="category_id" name="category_id"
								id="category_id">
								<sf:options items="${fullCate }" itemValue="id" itemLabel="name" />
							</sf:select>
							<br>
							<br>
							<div style="display: flex;">
								<input type="checkbox" id="haspid" checked="checked"
									style="margin-top: 5px" /> <label for="haspid"
									style="color: red; font-weight: bolder; font-size: 15px">Click
									if you want to filter by category?</label>
							</div>
						</c:when>
						<c:otherwise>
							<sf:select disabled="true" path="category_id" name="category_id"
								id="category_id">
								<sf:options items="${fullCate }" itemValue="id" itemLabel="name" />
							</sf:select>
							<br>
							<br>
							<div style="display: flex;">
								<input type="checkbox" id="haspid" style="margin-top: 5px" /> <label
									for="haspid"
									style="color: red; font-weight: bolder; font-size: 15px">Click
									if you want to filter by category?</label>
							</div>
						</c:otherwise>
					</c:choose>

					<br>
					<p class="t3">Filter :</p>
					<sf:select path="filter" name="filter" id="filter"
						style="outline: none;width:100%;height:40px;font-size:18px">
						<option value="all" ${filter == 'all' ? 'selected' : ''}>Tất
							cả</option>
						<option value="hot" ${filter == 'hot' ? 'selected' : ''}>HOT</option>
						<%--  <option value="sale" ${filter == 'sale' ? 'selected' : ''}>SALE</option> --%>

					</sf:select>

					<br>
					<br>
					<p class="t3">Price :</p>
					<div class="middle">
						<div class="multi-range-slider">
							<c:choose>
								<c:when test="${minPrice!=null&&maxPrice!=null }">
									<sf:input type="range" min="0" max="25000000"
										value="${minPrice }" id="input-left" name="min-price"
										path="minPrice"></sf:input>
									<sf:input type="range" min="0" max="25000000"
										value="${maxPrice }" id="input-right" name="max-price"
										path="maxPrice"></sf:input>
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
					<div class="filter">
						<p id="t5">
							Price: $<span id="span1">0</span> - $<span id="span2">25.000.000</span>
						</p>
						<br> <br> <br>
						<button type="submit">
							<p>Filter</p>
						</button>
						<br>
						<br>
					</div>
				</sf:form>


			</div>
		</div>

	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>

	<script src="${base}/user/js/products.js">
		
	</script>

	<script type="text/javascript">
		$('#haspid').click(function() {
			if ($(this).is(':checked')) {
				// khi thẻ đc disabled thì path sẽ k link đễn thuộc tính của entity
				$("#category_id").prop('disabled', false);
			} else {
				$("#category_id").prop('disabled', true);
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
							if ($(this).children(".page-link").children("i")
									.hasClass("fas fa-angle-double-right")) {
								//nếu chưa đc phân lần nào thì lấy giá trị của id curPage đc đẩy từ controller xuống
								if ($("#curpage").val() == null
										&& $("#curPage").val() != null) {
									page = parseInt($("#curPage").val()) + 1;
								}
								//đc phân rồi thì lấy của id curpage trong html đc đẩy từ controller ajax xuống
								else {
									page = parseInt($("#curpage").val()) + 1;
								}

							}
							//TH nút previuos
							else if ($(this).children(".page-link").children(
									"i").hasClass("fas fa-angle-double-left")) {
								//nếu chưa đc phân lần nào thì lấy giá trị của id curPage đc đẩy từ controller xuống
								if ($("#curpage").val() == null
										&& $("#curPage").val() != null) {
									page = parseInt($("#curPage").val()) - 1;
									;
								}
								//đc phân rồi thì lấy của id curpage trong html đc đẩy từ controller ajax xuống
								else {
									page = parseInt($("#curpage").val()) - 1;
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
								if ($("#pagee11").css("display") == "block") {
									$("#pagee11").css("display", "none");
									$("#pagee1").css("display", "none");
									$("#pagee").css("display", "block");
									$("#pagee111").css("display", "block");
									$(".page-item").removeClass("active");
									$(this).addClass("active");
								} else if ($("#pagee1").css("display") == "block") {
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
							if ($(this).text() == parseInt($("#totalpage")
									.val())
									|| $(this).text() == parseInt($(
											"#totalPage").val())) {
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

											if (page == parseInt($("#totalpage")
													.val()) - 1
													|| page == parseInt($(
															"#totalPage").val()) - 1) {
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

							var is_sale = $("#SALE").val();

							//alert(is_hot);
							if ((minPrice != "") && (minPrice != "")) {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									}
								} else {
									if (category_id != 0) {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									}
								}
							} else {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									}

								} else {
									if (category_id != 0) {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									}

								}
							}

							jQuery.ajax({
								url : "/shop",
								type : "post",
								contentType : "application/json",
								data : JSON.stringify(data),
								dataType : "json", // kieu du lieu tra ve tu controller la json
								success : function(jsonResult) {
									$("#sanpham").html(jsonResult.html);

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
							var is_sale = $("#SALE").val();
							//alert(is_hot);
							if ((minPrice != "") && (minPrice != "")) {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									}
								} else {
									if (category_id != 0) {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									}
								}
							} else {
								if (sizes.length == 0) {
									if (category_id != 0) {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										window.history.pushState(null, null,
												"/san-pham-sale?page="
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
											sale : is_sale,
										};
									}

								} else {
									if (category_id != 0) {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									} else {
										var a = "/san-pham-sale?page="
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
											sale : is_sale,
										};
									}

								}
							}

							jQuery.ajax({
								url : "/shop",
								type : "post",
								contentType : "application/json",
								data : JSON.stringify(data),
								dataType : "json", // kieu du lieu tra ve tu controller la json
								success : function(jsonResult) {
									$("#sanpham").html(jsonResult.html);

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