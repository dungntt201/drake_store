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

<link rel="stylesheet" href="${base }/user/css/about-us.css">
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
			<p>About us</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>About
				us</span>
		</div>
	</div>
	<div class="who-we-are">
		<div class="who-we-are1">
			<p id="wwa-title">Who We Are ?</p>
			<p>Dorem ipsum dolor sit amet, consectetur adipiscing elit. Ut
				blandit nisi a dictum tristique. Nullam urna metus, vestibulum ac
				sodales eSed ut perspiciatis unde omnis iste natus error sit
				voluptatem accusantium doloremque laudantium totam remrutrumDorem
				ipsum dolor sit amet, consectetur adipiscing elit. Sed ut
				perspiciatis.Dorem ipsum dolor sit amet, consectetur adipiscing
				elit. Ut blandit nisi a dictum tristique.</p>

			<p>Dorem ipsum dolor sit amet, consectetur adipiscing elit. Ut
				blandit nisi a dictum tristique. Nullam urna metus, vestibulum ac
				sodales eSed ut perspiciatis unde omnis iste natus error sit
				voluptatem accusantium doloremque laudantium totam remrutrumDorem
				ipsum dolor sit amet, consectetur adipiscing elit. Sed ut
				perspiciatis.Doremque laudantium totam remrutrumDorem ipsum dolor.</p>
		</div>
		<div class="who-we-are2">
			<img alt="" src="${base }/user/Images/IMAGE2/about-us-pictures.jpg"
				width="100%">
		</div>
	</div>



	<div class="part3">
		<p id="p3-title">Why shop From Us</p>
		<div class="partt">
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
	</div>
	<div class="contact-au">
		<div class="contact-au1">
			<p id="ca-title">We Deliver Genuine Products</p>
			<p>Lorem Ipsum has been the industrys standard dummy text ever
				since printer took a galley. Rimply dummy text of the printing and
				typesetting industry</p>
			<p>
				<a href="${base }/contact">CONTACT US</a>
			</p>
		</div>
	</div>
	<div class="slide-brand">
		<div id="owl-demo2" class="owl-carousel owl-theme">

			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/nike.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/adidas.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/vans.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/converse1.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/mcqueen.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/gucci.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/mlb.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/newbalance.png">
				</p>
			</div>
			<div class="item">
				<p style="text-align: center">
					<img src="${base}/user/Images/IMAGE2/balenciaga.png">
				</p>
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
		$(document).ready(function() {
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