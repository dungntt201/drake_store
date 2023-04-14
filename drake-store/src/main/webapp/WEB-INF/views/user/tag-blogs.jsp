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
<link rel="stylesheet" href="${base }/user/css/blogs.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner-content">
			<p>Tag: ${tag }</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i> <a
				href="${base }/blogs">Blog </a><i class="fas fa-chevron-right">
			</i><span>${tag }</span>
		</div>
	</div>
	<div class="blogs">
		<div class="blogs1">
			<div class="List-blogs">
				<div class="L-b-1">
					<div class="L-b-11">
						<c:choose>
							<c:when test="${totalBlogs>0 }">
								<p id="show">Showing:
									${curPage*sizeOfPage+1}-${curPage*sizeOfPage+totalDisplay} of
									Total: ${totalBlogs } kết quả</p>
							</c:when>
							<c:otherwise>
								<!-- fix -->
								<p id="show">Không có kết quả hiển thị</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<input type="hidden" value="${totalPage }" id="totalPage"> <input
					type="hidden" value="${curPage }" id="curPage"> <input
					type="hidden" value="${tag }" id="tag">
				<div class="all-blogs" id="all-blogs">
					<c:forEach var="blog" items="${blogs }">
						<div class="all-blogs1">
							<a href="${base }/blogs/${blog.seo}"> <img alt="img-blog"
								src="${base }/upload/${blog.avatar}">
							</a>
							<p class="date">
								<fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
									value="${blog.created_date }" />
							</p>
							<a href="${base }/blogs/${blog.tag}" class="tag">${blog.tag}</a>
							<br>
							<p class="title">
								<a href="${base }/blogs/${blog.seo}">${blog.title}</a>
							</p>
							<div class="author">
								<div class="author1">
									<%-- <c:forEach  var="user1" items="${user }">
										<c:if test="${user1.id==blog.created_by }"> --%>
									<p>
										<i class="fas fa-user"></i> <a href="#">${blog.author}</a>
									</p>
									<%-- </c:if>
									</c:forEach> --%>
								</div>
								<div class="comments">
									<c:if test="${blog.comments==null||blog.comments==0 }">
										<p>
											<i class="fas fa-comments"></i><span>0 Comments</span>
										</p>
									</c:if>
									<c:if test="${blog.comments>0 }">
										<p>
											<i class="fas fa-comments"></i><span>${blog.comments }
												Comments</span>
										</p>
									</c:if>
								</div>
							</div>
							<p class="short-content">${blog.short_content}</p>
							<p class="btnn">
								<a href="${base }/blogs/${blog.seo}">Đọc thêm <i
									class="fas fa-arrow-right"></i></a>
							</p>
						</div>
					</c:forEach>
				</div>
				<!--phân trang 
              	trang 1 trở đi là đã phân<=> curPage=0 trở lên
              	trang 0 là trang lấy full bản ghi <=> curPage=-1
                -->
				<c:if test="${totalPage>1 }">
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
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
			<div class="Toc-blog">
				<p id="t1">Categories</p>
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

				<p id="t2">Tags</p>
				<div class="tagg">
					<c:forEach var="tag" items="${totalTags }">
						<a class="tag-item" href="${base }/blogs/tag/${tag}">${tag}</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>

	<script src="${base }/user/js/blogs.js">
		
	</script>

	<script type="text/javascript">
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
								if ($("#curpage").val() == null) {
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
								if ($("#curpage").val() == null) {
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

							var tag = $("#tag").val();
							window.history.pushState(null, null, "/blogs/tag/"
									+ tag + "?page=" + (page + 1));

							var data = {
								page : page,
								tag : tag,
							};

							jQuery.ajax({
								url : "/blogs",
								type : "post",
								contentType : "application/json",
								data : JSON.stringify(data),
								dataType : "json", // kieu du lieu tra ve tu controller la json
								success : function(jsonResult) {
									$("#all-blogs").html(jsonResult.html);

									$("#show").text(
											"Showing: "
													+ (jsonResult.curPage + 1)
													+ "/"
													+ jsonResult.totalPage
													+ " of Total: "
													+ jsonResult.totalBlogs
													+ " blogs");
								},
								error : function(jqXhr, textStatus,
										errorMessage) { // error callback 

								}
							});

						});
	</script>
</body>
</html>