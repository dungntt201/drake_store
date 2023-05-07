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
<link rel="stylesheet" href="${base }/user/css/detail-blog.css">
<%-- <link rel="stylesheet" href="${base}/user/css/styles.css"> --%>
<link rel="stylesheet" href="${base}/user/css/call_button.css">
	<link rel="stylesheet" href="${base}/user/css/header-f.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner-content">
			<p>${blog.title}</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i> <a
				href="${base }/blogs">Blog </a><i class="fas fa-chevron-right"></i>
			<a href="${base }/blogs/tag/${blog.tag }">${blog.tag } </a><i
				class="fas fa-chevron-right"> </i><span>${blog.title }</span>
		</div>
	</div>
	<div class="blogs">
		<c:if test="${not empty msg }">
			<p id="hideDiv" class="alert alert-success">${msg }</p>
		</c:if>
		<div class="blogs1">

			<div class="List-blogs">
				<div class="all-blogs">
					<img alt="img-blog" src="${base }/upload/${blog.avatar}">

					<div class="author">
						<div class="date">
							<p>
								<i class="far fa-calendar-alt"></i><span><fmt:formatDate
										pattern="dd-MM-yyyy HH:mm:ss" value="${blog.created_date }" /></span>
							</p>
						</div>
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
						<div class="tag">
							<p>
								<i class="fas fa-tags"></i> <a href="#">${blog.tag}</a>
							</p>
						</div>
						<div></div>
					</div>
					<div class="content">${blog.content }</div>

					<input type="hidden" value="${totalPage }" id="totalPage">
					<input type="hidden" value="${curPage }" id="curPage"> <input
						type="hidden" value="${blogSeo }" id="blog_Seo">
					<div class="user-comments">
						<p class="title">Comments:</p>
						<c:choose>
							<c:when test="${blog.comments==null || blog.comments==0 }">
								<p id="no-cmt" style="font-size: 16px; color: gray">Bài viết
									chưa có bình luận nào</p>
							</c:when>
							<c:otherwise>
								<%-- 								<p id="cmtss" style="font-size: 18px;color: gray">Showing ${curPage+1 }/${totalPage } of ${totalCmts } comments</p>
 --%>
							</c:otherwise>
						</c:choose>

						<div class="total-cmt" id="total_cmt">
							<c:forEach var="cmt" items="${cmts }">
								<c:choose>
									<c:when test="${cmt.users!=null }">
										<div class="comments1">
											<div class="avatar">
												<c:forEach var="user2" items="${user }">
													<c:if test="${user2.id==cmt.users.id }">
														<c:choose>
															<c:when test="${user2.avatar!=null }">
																<img alt="" src="${base }/upload/${user2.avatar}">
															</c:when>
															<c:otherwise>
																<img alt="" src="${base }/user/Images/IMAGE2/avatar.jpg">
															</c:otherwise>
														</c:choose>

													</c:if>
												</c:forEach>
											</div>

											<div class="comments11">
												<p class="fullname">${cmt.full_name }</p>
												<p class="date-cmt">
													<fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
														value="${cmt.created_date }" />
												</p>
												<p class="cmt">${cmt.comment }</p>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="comments1">
											<div class="avatar">
												<img alt="" src="${base }/${cmt.avatar}">
											</div>
											<div class="comments11">
												<p class="fullname">${cmt.full_name }</p>
												<p class="date-cmt">
													<fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
														value="${cmt.created_date }" />
												</p>
												<p class="cmt">${cmt.comment }</p>
											</div>
										</div>

									</c:otherwise>
								</c:choose>

							</c:forEach>
						</div>

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
										<li class="page-item active"><a class="page-link"
											href="#">${i}</a></li>
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
					<div class="write-cmt">
						<p class="title">Write your comment:</p>

						<c:if test="${isLogined }">
							<sf:form action="/save-comment" method="POST"
								modelAttribute="cmt" onsubmit="return send1()">
								<div style="width: 100%">
									<sf:hidden id="blog_id" path="blogs.id" />
									<input type="text" class="form-control" id="full_name"
										placeholder="Your Full name (*)"
										value="${userLogined.full_name }" disabled="true" /><br>
									<input type="email" class="form-control" id="email"
										placeholder="Your email (*)" value="${userLogined.email }"
										disabled="true" />
								</div>
								<sf:textarea path="comment"
									style="margin-top: 25px;height: 100px;" id="cmt1"
									autocomplete="off" class="form-control"
									placeholder="Your comment (*)" onkeyup="checkMessage()" />
								<p style="margin: 0" id="demo-message"></p>
								<button type="submit" class="btn btn-primary"
									style="float: right; margin-top: 30px">SEND</button>


							</sf:form>
						</c:if>
						<c:if test="${!isLogined }">
							<sf:form action="/save-comment" method="POST"
								modelAttribute="cmt" onsubmit="return send()">
								<div style="width: 100%">
									<sf:hidden id="blog_id" path="blogs.id" />
									<sf:input path="full_name" type="text" class="form-control"
										id="full_name" onkeyup="checkName()"
										placeholder="Your Full name (*)" />
									<p style="margin: 0" id="demo-name"></p>
									<br>
									<sf:input path="email" type="email" class="form-control"
										id="email" onkeyup="checkEmRegister()"
										placeholder="Your email (*)" />
									<p style="margin: 0" id="demo-email"></p>
								</div>
								<sf:textarea path="comment"
									style="margin-top: 25px;height: 100px;" id="cmt1"
									autocomplete="off" class="form-control"
									placeholder="Your comment (*)" onkeyup="checkMessage()" />
								<p style="margin: 0" id="demo-message"></p>
								<button type="submit" class="btn btn-primary"
									style="float: right; margin-top: 30px">SEND</button>
							</sf:form>
						</c:if>
						<!--form ajax  -->
						<%-- <form action="/save-comment" method="POST">
							<div style="width: 100%">
								<input type="hidden" id="blog_id" name="blog_id" value="${cmt.blogs.id }">
								<c:if test="${isLogined }">
									<input style="width: 100%; margin-right: 6%" type="text" class="form-control" id="full_name" placeholder="Your Full name (*)" required="required" value="${userLogined.full_name }" disabled="true"/><br>
									<input style="width: 100%"  type="email" class="form-control" id="email" placeholder="Your email (*)" required="required" value="${userLogined.email }" disabled="true"/><br>
								</c:if>
								<c:if test="${!isLogined }">
									<input style="width: 100%; margin-right: 6%"  type="text" class="form-control" id="full_name" placeholder="Your Full name (*)" required="required" onkeyup="checkName()"/><br>
									<p id="demo-name"></p>
									<input style="width: 100%" type="email" class="form-control" id="email" placeholder="Your email (*)" required="required" onkeyup="checkEmRegister()"/><br>
									<p id="demo-email"></p>
								</c:if>
			
							</div>
		              		<textarea style="height: 100px;" autocomplete="off" class="form-control" id="cmt" placeholder="Your comment (*)" required="required" onkeyup="checkMessage()"/></textarea>
	                   		<br><p id="demo-message"></p>
	                   		
	                   		<c:if test="${isLogined }">
	                   			<p style="text-align: center;"><button type="button" class="send1 btn btn-primary" onclick="checkMessage(),send()">SEND</button></p>
							</c:if>
							<c:if test="${!isLogined }">
							
								<p style="text-align: center;"><button type="button" class="send btn btn-primary" onclick="checkName(),checkEmRegister(),checkMessage(),send()">SEND</button></p>

							</c:if>
							
						</form> --%>
					</div>

				</div>

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
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
			}, 2000)

		})
		function checkEmRegister() {
			/* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
			var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
			var g = document.getElementById("email").value;
			if (y3.test(g)) {
				document.getElementById("demo-email").innerHTML = "";
				document.getElementById("email").style.border = "1px solid gray";
				return true;
			} else {
				document.getElementById("email").style.border = "1px solid red";
				document.getElementById("demo-email").innerHTML = "Note: Lưu ý định dạng email.";
				return false;
			}
		}
		function checkName() {

			var g = document.getElementById("full_name").value;

			if (g == null || g == "") {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được chứa kí tự đặc biệt!";
				return false;
			} else {
				document.getElementById("demo-name").innerHTML = "";
				document.getElementById("full_name").style.border = "1px solid gray";
				return true;
			}
		}
		function checkMessage() {

			var g = document.getElementById("cmt1").value;
			//alert(g);
			if (g == null || g == "" || g == undefined) {
				//alert("true");
				document.getElementById("cmt1").style.border = "1px solid red";
				document.getElementById("demo-message").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else {
				document.getElementById("demo-message").innerHTML = "";
				document.getElementById("cmt1").style.border = "1px solid gray";
				return true;
			}
		}
		function send() {
			if (checkName() == true && checkEmRegister() == true
					&& checkMessage() == true) {
				return true;

			} else {

				alert("Vui lòng nhập đúng định dạng!");
				return false;
			}
		}
		function send1() {

			if (checkMessage() == true) {
				return true;

			} else {
				alert("Vui lòng nhập đúng định dạng!");
				return false;
			}
		}
		$(document).on(
				"click",
				".send",
				function() {
					if (send() == true) {
						var id_ajax = $("#blog_id").val();
						var full_name = $("#full_name").val();
						var email = $("#email").val();
						var cmt = $("#cmt").val();
						//alert(email);
						var data = {
							id_ajax : id_ajax,
							full_name : full_name,
							email : email,
							comment : cmt,
						};

						jQuery.ajax({
							url : "/save-comment",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {

								alert("Cảm ơn bạn " + jsonResult.full_name
										+ " đã bình luận về bài viết này");
								$(".total-cmt").prepend(jsonResult.html);
								if ($("#no-cmt").text() != null
										|| $("#no-cmt").text() != null) {
									$("#no-cmt").text("");
								}
								if (jsonResult.is_login) {
									$("#cmt").val("");
								} else {
									$("#cmt").val("");
									$("#full_name").val("");
									$("#email").val("");
								}

							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});
					} else {
						alert("Bạn nhập sai định dạng . Vui lòng nhập lại !");
					}

				});

		$(document).on(
				"click",
				".send1",
				function() {
					if (send1() == true) {
						var id_ajax = $("#blog_id").val();
						var full_name = $("#full_name").val();
						var email = $("#email").val();
						var cmt = $("#cmt").val();
						//alert(email);
						var data = {
							id_ajax : id_ajax,
							full_name : full_name,
							email : email,
							comment : cmt,
						};

						jQuery.ajax({
							url : "/save-comment",
							type : "post",
							contentType : "application/json",
							data : JSON.stringify(data),
							dataType : "json", // kieu du lieu tra ve tu controller la json
							success : function(jsonResult) {

								alert("Cảm ơn bạn " + jsonResult.full_name
										+ " đã bình luận về bài viết này");
								$(".total-cmt").prepend(jsonResult.html);
								if ($("#no-cmt").text() != null
										|| $("#no-cmt").text() != null) {
									$("#no-cmt").text("");
								}
								if (jsonResult.is_login) {
									$("#cmt").val("");
								} else {
									$("#cmt").val("");
									$("#full_name").val("");
									$("#email").val("");
								}

							},
							error : function(jqXhr, textStatus, errorMessage) { // error callback 

							}
						});
					} else {
						alert("Bạn nhập sai định dạng . Vui lòng nhập lại !");
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

							var blog_id = $("#blog_id").val();
							var seo = $("#blog_Seo").val();
							window.history.pushState(null, null, "/blogs/"
									+ seo + "?page=" + (page + 1));

							var data = {
								page : page,
								blog_id : blog_id,
							};

							jQuery.ajax({
								url : "/PhanTrangCmts",
								type : "post",
								contentType : "application/json",
								data : JSON.stringify(data),
								dataType : "json", // kieu du lieu tra ve tu controller la json
								success : function(jsonResult) {
									$("#total_cmt").html(jsonResult.html);

									$("#no-cmt").text(
											"Showing: "
													+ (jsonResult.curPage + 1)
													+ "/"
													+ jsonResult.totalPage
													+ " of Total: "
													+ jsonResult.totalCmts
													+ " comments");
								},
								error : function(jqXhr, textStatus,
										errorMessage) { // error callback 

								}
							});

						});
	</script>
</body>
</html>