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
<title>${projectTitle}</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.css"
	rel="stylesheet" />

<link rel="stylesheet" href="${base}/user/css/home.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<link rel="stylesheet" href="${base}/user/css/header-f.css">
<script type="text/javascript" src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner1">
			<div class="menu-banner">
				<a id="a1" href="#" style="display: flex;"><i id="mnbn"
					class="fas fa-bars"></i><i id="x" class="fas fa-times"></i>
				<p>CATEGORIES</p></a>
				<div id="myDropdown" class="dropdown-content">
					<ul class="submenu-banner1 list-unstyled">
						<c:forEach var="parent" items="${parentCategories }">
							<li class="sb1">
								<p>
									<a href="${base }/shop/${parent.seo }">${parent.name }</a> <i
										class="fas fa-minus closemn"></i><i class="fas fa-plus openmn"></i>
								</p>

								<ul class="list-unstyled sub11">
									<c:forEach var="children" items="${childrenCategories }">
										<c:if test="${children.children.id==parent.id }">
											<li><a href="${base }/category/${children.seo }">${children.name }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="search-bar">
				<form action="${base }/shop" method="get">
					<input type="text" placeholder="Search Products Here"
						name="keyword">
					<button id="bt1" type="submit">
						<i class="fas fa-search"></i>
					</button>
				</form>

			</div>
		</div>
		<div class="banner2">
			<div class="banner21">
				<ul class="submenu-banner list-unstyled">
					<c:forEach var="parent" items="${parentCategories }">

						<li class="lii"><a href="${base }/category/${parent.seo }">
								${parent.name } <i class="fas fa-chevron-right"></i>
						</a>
							<ul class="list-unstyled sub1">
								<c:forEach var="children" items="${childrenCategories }">
									<c:if test="${children.children.id==parent.id }">
										<li><a href="${base }/category/${children.seo }">${children.name }</a></li>
									</c:if>
								</c:forEach>

							</ul></li>
					</c:forEach>
				</ul>
			</div>
			<div class="container">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
						<li data-target="#myCarousel" data-slide-to="3"></li>
						<li data-target="#myCarousel" data-slide-to="4"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">

						<div class="item active">
							<img src="${base}/user/Images/IMAGE2/slide1.jpg"
								alt="Los Angeles" style="width: 100%;">
							<div class="carousel-caption">
								<p class="animate__animated animate__fadeInUp">New 2023
									Collection</p>
								<h3 class="animate__animated animate__fadeInUp">CONVERSE
									1970s</h3>
								<!--                             <p class="animate__animated animate__fadeInUp" id="pp1">Lorem ipsum dolor sit amet consectetur adipisicing elited do veniam.</p>
 -->
								<div class="a11">
									<a href="${base }/category/converse"><p
											class="animate__animated animate__fadeInUp" id="pp2">
											SHOP NOW
											<!-- <i class="fas fa-chevron-right"></i> -->
										</p></a>
								</div>


							</div>
						</div>

						<div class="item">
							<img src="${base}/user/Images/IMAGE2/slide2.jpg" alt="Chicago"
								style="width: 100%;">
							<div class="carousel-caption">
								<p class="animate__animated animate__fadeInUp">New 2023
									Collection</p>
								<h3 class="animate__animated animate__fadeInUp">VANS
									OLDSKOOL</h3>
								<!--                             <p class="animate__animated animate__fadeInUp" id="pp1">Lorem ipsum dolor sit amet consectetur adipisicing elited do veniam.</p>
 -->
								<div class="a11">
									<a href="${base }/category/vans"><p
											class="animate__animated animate__fadeInUp" id="pp2">
											SHOP NOW
											<!-- <i class="fas fa-chevron-right"></i> -->
										</p></a>
								</div>
							</div>
						</div>

						<div class="item">
							<img src="${base}/user/Images/IMAGE2/slide3.jpg" alt="New York"
								style="width: 100%;">
							<div class="carousel-caption">
								<p class="animate__animated animate__fadeInUp">New 2023
									Collection</p>
								<h3 class="animate__animated animate__fadeInUp">NIKE JUST
									DO IT</h3>
								<!--                             <p class="animate__animated animate__fadeInUp" id="pp1">Lorem ipsum dolor sit amet consectetur adipisicing elited do veniam.</p>
 -->
								<div class="a11">
									<a href="${base }/category/nike"><p
											class="animate__animated animate__fadeInUp" id="pp2">
											SHOP NOW
											<!-- <i class="fas fa-chevron-right"></i> -->
										</p></a>
								</div>
							</div>
						</div>
						<div class="item">
							<img src="${base}/user/Images/IMAGE2/slide4.jpg" alt="New York"
								style="width: 100%;">
							<div class="carousel-caption">
								<p class="animate__animated animate__fadeInUp">New 2023
									Collection</p>
								<h3 class="animate__animated animate__fadeInUp">VAN SLIP-ON</h3>
								<!--                             <p class="animate__animated animate__fadeInUp" id="pp1">Lorem ipsum dolor sit amet consectetur adipisicing elited do veniam.</p>
 -->
								<div class="a11">
									<a href="${base }/category/vans"><p
											class="animate__animated animate__fadeInUp" id="pp2">
											SHOP NOW
											<!-- <i class="fas fa-chevron-right"></i> -->
										</p></a>
								</div>
							</div>
						</div>
						<div class="item">
							<img src="${base}/user/Images/IMAGE2/slide5.jpg" alt="New York"
								style="width: 100%;">
							<div class="carousel-caption">
								<p class="animate__animated animate__fadeInUp">New 2023
									Collection</p>
								<h3 class="animate__animated animate__fadeInUp">ADIDAS
									ULTRABOOST</h3>
								<!--                             <p class="animate__animated animate__fadeInUp" id="pp1">Lorem ipsum dolor sit amet consectetur adipisicing elited do veniam.</p>
 -->
								<div class="a11">
									<a href="${base }/category/adidas"><p
											class="animate__animated animate__fadeInUp" id="pp2">
											SHOP NOW
											<!-- <i class="fas fa-chevron-right"></i> -->
										</p></a>
								</div>
							</div>
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <!-- <span class="sr-only">Previous</span> -->
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <!-- <span class="sr-only">Next</span> -->
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="part3">
		<div class="part31">
			<p id="pp00">
				<i class="fas fa-shipping-fast"></i>
			</p>
			<div class="part311">
				<p id="pp11">FREE SHIPPING</p>
				<p id="pp12">On All Orders</p>
			</div>
		</div>
		<div class="part31">
			<p id="pp00">
				<i class="fas fa-headset"></i>
			</p>
			<div class="part311">
				<p id="pp11">24/7 SUPPORT</p>
				<p id="pp12">Get Help When You Need</p>
			</div>
		</div>
		<div class="part31" style="margin-right: 0;">
			<p id="pp00">
				<i class="fas fa-hand-peace"></i>
			</p>
			<div class="part311">
				<p id="pp11">100% RETURN</p>
				<p id="pp12">Within 30 Days</p>
			</div>
		</div>
	</div>
	<div class="part4">
		<div class="part">
			<div class="part41">
				<a href="${base }/category/nike">
					<div class="part411">
						<p class="pp3">NIKE</p>
						<p class="pp4">Collection 2023</p>
					</div>
					<div class="img">
						<img
							src="${base}/user/Images/IMAGE2/air-force-1-07-shoe-NMmm1B.png">
					</div>
				</a>
			</div>
		</div>

		<div class="part42">
			<div class="part421">
				<div class="part4211">
					<a href="${base }/category/adidas">
						<div class="part42111">
							<p class="pp3">ADIDAS</p>
							<p class="pp4">Collection 2023</p>
						</div>
						<div class="img">
							<img
								src="${base}/user/Images/IMAGE2/Giay_Chay_Bo_UltraBoost_21_Tokyo_trang_S23840_41_detail.png">
						</div>
					</a>
				</div>
				<div class="part4212">
					<a href="${base }/category/vans">
						<div class="part42111">
							<p class="pp3">VANS</p>
							<p class="pp4">Collection 2023</p>
						</div>
						<div class="img">
							<img
								src="${base}/user/Images/IMAGE2/vans-old-skool-black-white-ship-us1.png">
						</div>
					</a>
				</div>
			</div>
			<div class="part421">
				<div class="part4221">
					<a href="${base }/category/converse">
						<div class="part42111">
							<p class="pp3">CONVERSE</p>
							<p class="pp4">2023 Trend</p>
						</div>
						<div class="img">
							<img src="${base}/user/Images/IMAGE2/converse-preview.png">
						</div>
					</a>
				</div>
				<div class="part4222">
					<a href="${base }/category/palladium">
						<div class="part42111">
							<p class="pp3">PALLADIUM</p>
							<p class="pp4">Collection</p>
						</div>
						<div class="img">
							<img
								src="${base}/user/Images/IMAGE2/pala-preview.png">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="slide-product1">
		<div class="view" style="display: flex;">
			<p id="pv">Hot Products</p>
			<div class="view1">
				<a id="av" href="${base }/san-pham-hot"><p>
						View all <i class="fas fa-chevron-right"></i>
					</p></a>
			</div>

		</div>
		<div class="slide-pro">
			<div class="container">

				<div id="owl-demo" class="owl-carousel owl-theme">
					<c:forEach var="hotProduct" items="${hotProducts }">
						<div class="item">
							<div class="item1">

								<c:if test="${hotProduct.price_sale<hotProduct.price }">
									<div class="sale-price">
										<p>Sale</p>
									</div>
								</c:if>
								<c:if test="${hotProduct.is_hot==true }">
									<div class="sale-price1">
										<p>HOT</p>
									</div>
								</c:if>
								<a href="${base }/shop/${hotProduct.seo}"><img
									src="${base }/upload/${hotProduct.avatar}"
									alt="${hotProduct.title }"></a> <a
									href="${base }/shop/${hotProduct.seo}"><p class="pi1">${hotProduct.title }</p></a>
								<%-- <p class="pi2">${newProduct.price }</p> --%>
								<c:if test="${hotProduct.price_sale<hotProduct.price }">

									<p class="line-price">
										<fmt:formatNumber value="${hotProduct.price}" type="number"
											groupingUsed="true" />
										VND
									</p>
									<p class="pi2">
										<fmt:formatNumber value="${hotProduct.price_sale}"
											type="number" groupingUsed="true" />
										VND
									</p>
								</c:if>
								<c:if
									test="${hotProduct.price_sale==null ||hotProduct.price_sale==hotProduct.price  }">
									<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
									<!-- $${product.price } -->
									<p class="pi2">
										<fmt:formatNumber value="${hotProduct.price}" type="number"
											groupingUsed="true" />
										VND
									</p>
								</c:if>



							</div>
						</div>

					</c:forEach>
				</div>

				<div class="customNavigation">
					<a class="btn prev">Previous</a> <a class="btn next">Next</a>
					<!-- <a class="btn play">Autoplay</a>
				        <a class="btn stop">Stop</a> -->
				</div>
			</div>
		</div>
	</div>
	<div class="slide-product1">
		<div class="view" style="display: flex;">
			<p id="pv">Sale Products</p>
			<div class="view1">
				<a id="av" href="${base }/san-pham-sale"><p>
						View all <i class="fas fa-chevron-right"></i>
					</p></a>
			</div>
		</div>
		<div class="slide-pro">
			<div class="container">
				<div id="owl-demo1" class="owl-carousel owl-theme">
					<c:forEach var="saleProduct" items="${saleProducts }">
						<div class="item">
							<div class="item1">
								<c:if test="${saleProduct.price_sale<saleProduct.price }">
									<div class="sale-price">
										<p>Sale</p>
									</div>
								</c:if>
								<c:if test="${saleProduct.is_hot==true }">
									<div class="sale-price1">
										<p>HOT</p>
									</div>
								</c:if>
								<a href="${base }/shop/${saleProduct.seo}"><img
									src="${base }/upload/${saleProduct.avatar}"
									alt="${saleProduct.title }"></a> <a
									href="${base }/shop/${saleProduct.seo}"><p class="pi1">${saleProduct.title }</p></a>
								<%-- <p class="pi2">${newProduct.price }</p> --%>
								<c:if test="${saleProduct.price_sale<saleProduct.price }">
									<p class="line-price">
										<fmt:formatNumber value="${saleProduct.price}" type="number"
											groupingUsed="true" />
										VND
									</p>
									<p class="pi2">
										<fmt:formatNumber value="${saleProduct.price_sale}"
											type="number" groupingUsed="true" />
										VND
									</p>

								</c:if>
								<c:if
									test="${saleProduct.price_sale==null ||saleProduct.price_sale==saleProduct.price  }">
									<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
									<!-- $${product.price } -->
									<p class="pi2">
										<fmt:formatNumber value="${saleProduct.price}" type="number"
											groupingUsed="true" />
										VND
									</p>

								</c:if>
							</div>
						</div>

					</c:forEach>

				</div>

				<div class="customNavigation">
					<a class="btn prev1">Previous</a> <a class="btn next1">Next</a>
					<!-- <a class="btn play">Autoplay</a>
			        <a class="btn stop">Stop</a> -->
				</div>
			</div>
		</div>
	</div>
	<div class="poster">
		<div class="sale">
			<img src="${base}/user/Images/IMAGE2/banner1.png"> <a
				href="${base }/san-pham-sale"><p>
					BUY NOW <i class="fas fa-chevron-right"></i>
				</p></a>
		</div>
		<div class="img-sale">
			<img src="${base}/user/Images/IMAGE2/pst.jpg">
		</div>
	</div>
	<div class="top-pro">
		<div class="BS">
			<p id="bs1">Best Seller</p>
			<c:forEach var="bestSeller" items="${bestSellers }">
				<div class="BSpp">
					<div class="BSp1">
						<img src="${base}/upload/${bestSeller.avatar }" alt="imageproduct"
							class="image"> <a href="${base}/shop/${bestSeller.seo}">
							<div class="overlay">
								<div class="text">
									<i class="fas fa-plus"></i>
								</div>
							</div>
						</a>
					</div>
					<div class="titlep">
						<a href="${base}/shop/${bestSeller.seo}"><p>${bestSeller.title }</p></a>
						<p id="tt1">${bestSeller.categories.name }</p>
						<%-- <p id="tt2">${bestSeller.price } VND</p> --%>
						<c:if test="${bestSeller.price_sale<bestSeller.price }">
							<p class="line-price">
								<fmt:formatNumber value="${bestSeller.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
							<p id="tt2">
								<fmt:formatNumber value="${bestSeller.price_sale }"
									type="number" groupingUsed="true" />
								VND
							</p>
						</c:if>
						<c:if
							test="${bestSeller.price_sale==null ||bestSeller.price_sale==bestSeller.price  }">
							<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
							<!-- $${product.price } -->
							<p id="tt2">
								<fmt:formatNumber value="${bestSeller.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
						</c:if>
					</div>
				</div>
			</c:forEach>


		</div>
		<div class="BS">
			<p id="bs1">On Sale</p>
			<c:forEach var="saleProducts" items="${saleProducts1 }">
				<div class="BSpp">
					<div class="BSp1">
						<img src="${base}/upload/${saleProducts.avatar }"
							alt="imageproduct" class="image"> <a
							href="${base}/shop/${saleProducts.seo}">
							<div class="overlay">
								<div class="text">
									<i class="fas fa-plus"></i>
								</div>
							</div>
						</a>
					</div>
					<div class="titlep">
						<a href="${base}/shop/${saleProducts.seo}"><p>${saleProducts.title }</p></a>
						<p id="tt1">${saleProducts.categories.name }</p>
						<c:if test="${saleProducts.price_sale<saleProducts.price }">
							<p class="line-price">
								<fmt:formatNumber value="${saleProducts.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
							<p id="tt2">
								<fmt:formatNumber value="${saleProducts.price_sale }"
									type="number" groupingUsed="true" />
								VND
							</p>
						</c:if>
						<c:if
							test="${saleProducts.price_sale==null ||saleProducts.price_sale==saleProducts.price  }">
							<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
							<!-- $${product.price } -->
							<p id="tt2">
								<fmt:formatNumber value="${saleProducts.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="BS">
			<p id="bs1">Top Rated</p>
			<c:forEach var="hotProduct" items="${hotProduct1 }">
				<div class="BSpp">
					<div class="BSp1">
						<img src="${base}/upload/${hotProduct.avatar }" alt="imageproduct"
							class="image"> <a href="${base}/shop/${hotProduct.seo}">
							<div class="overlay">
								<div class="text">
									<i class="fas fa-plus"></i>
								</div>
							</div>
						</a>
					</div>
					<div class="titlep">
						<a href="${base}/shop/${hotProduct.seo}"><p>${hotProduct.title }</p></a>
						<p id="tt1">${hotProduct.categories.name }</p>
						<c:if test="${hotProduct.price_sale<hotProduct.price }">
							<p class="line-price">
								<fmt:formatNumber value="${hotProduct.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
							<p id="tt2">
								<fmt:formatNumber value="${hotProduct.price_sale }"
									type="number" groupingUsed="true" />
								VND
							</p>
						</c:if>
						<c:if
							test="${hotProduct.price_sale==null ||hotProduct.price_sale==hotProduct.price  }">
							<!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
							<!-- $${product.price } -->
							<p id="tt2">
								<fmt:formatNumber value="${hotProduct.price }" type="number"
									groupingUsed="true" />
								VND
							</p>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="mypost">
		<div class="mypost1">
			<div class="post">
				<div class="view" style="display: flex;">
					<p id="pv">Newest Posts</p>
					<div class="view1">
						<a id="av" href="${base }/blogs"><p>
								View all <i class="fas fa-chevron-right"></i>
							</p></a>
					</div>
				</div>
				<div class="post1">
					<c:forEach var="blog" items="${blogs }">
						<div class="post11">
							<div class="container1">
								<img src="${base}/upload/${blog.avatar}" alt="blogimage"
									class="image">
								<div class="overlay1"></div>
								<div class="overlay2"></div>
							</div>
							<div class="post12">
								<p class="ptt1"><fmt:formatDate pattern = "dd-MM-yyyy HH:mm:ss" 
         						value = "${blog.created_date }" /></p>
								<a class="ptt2" href="${base }/blogs/${blog.seo}">${blog.title }</a>
								<%-- <c:forEach var="user" items="${users }">
									<c:if test="${user.id==blog.created_by }"> --%>
										<p class="ptt3">
											Posted by <a href="#">${blog.author }</a>
										</p>
									<%-- </c:if>
								</c:forEach> --%>

							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div class="slide-brand">
		<div id="owl-demo2" class="owl-carousel owl-theme">

			<div class="item">
				<img src="${base}/user/Images/IMAGE2/nike.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/adidas.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/vans.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/converse1.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/mcqueen.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/gucci.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/mlb.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/newbalance.png">
			</div>
			<div class="item">
				<img src="${base}/user/Images/IMAGE2/balenciaga.png">
			</div>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>
	<script src="${base}/user/js/home.js">
		
	</script>
	<script>
		$(document).ready(function() {

			var owl = $("#owl-demo");

			owl.owlCarousel({
				items : 4, //10 items above 1000px browser width
				itemsDesktop : [ 1000, 4 ], //5 items between 1000px and 901px
				itemsDesktopSmall : [ 900, 3 ], // betweem 900px and 601px
				itemsTablet : [ 600, 2 ], //2 items between 600 and 0
				itemsMobile : [ 400, 1 ],// itemsMobile disabled - inherit from itemsTablet option
				autoPlay : 3000,
				loop : true,
				nav : false,
			});

			// Custom Navigation Events
			$(".next").click(function() {
				owl.trigger('owl.next');
			})
			$(".prev").click(function() {
				owl.trigger('owl.prev');
			})
			$(".play").click(function() {
				owl.trigger('owl.play', 1000); //owl.play event accept autoPlay speed as second parameter
			})
			$(".stop").click(function() {
				owl.trigger('owl.stop');
			})

			var owl1 = $("#owl-demo1");

			owl1.owlCarousel({
				items : 4, //10 items above 1000px browser width
				itemsDesktop : [ 1000, 4 ], //5 items between 1000px and 901px
				itemsDesktopSmall : [ 900, 3 ], // betweem 900px and 601px
				itemsTablet : [ 600, 2 ], //2 items between 600 and 0
				itemsMobile : [ 400, 1 ],// itemsMobile disabled - inherit from itemsTablet option
				autoPlay : 4000,
			});

			$(".next1").click(function() {
				owl1.trigger('owl.next');
			})
			$(".prev1").click(function() {
				owl1.trigger('owl.prev');
			})

			var owl2 = $("#owl-demo2");

			owl2.owlCarousel({
				items : 4, //10 items above 1000px browser width
				itemsDesktop : [ 1000, 4 ], //5 items between 1000px and 901px
				itemsDesktopSmall : [ 900, 3 ], // betweem 900px and 601px
				itemsTablet : [ 600, 2 ], //2 items between 600 and 0
				itemsMobile : false,// itemsMobile disabled - inherit from itemsTablet option
				autoPlay : 5000,
			});
		});
	</script>
</body>
</html>