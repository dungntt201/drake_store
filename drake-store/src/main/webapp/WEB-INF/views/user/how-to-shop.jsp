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
<link rel="stylesheet" href="${base }/user/css/how-to-shop.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner-content">
			<p>How To Shop</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>How
				to shop</span>
		</div>
	</div>
	<div class="huong-dan">
		<p class="hd-title">Hướng dẫn</p>
		<p>
			<span>Bước 1: </span>Truy cập website và lựa chọn sản phẩm cần mua để
			mua hàng
		</p>
		<p>
			<span>Bước 2: </span>Click vào sản phẩm muốn mua,chọn size và click
			nút ADD TO CART, màn hình hiển thị ra pop up với các lựa chọn sau<br>
			Nếu bạn muốn tiếp tục mua hàng: Bấm vào dấu x để tắt popup và tiếp
			tục tìm kiếm sản phẩm phù hợp<br> Nếu bạn muốn xem giỏ hàng để
			cập nhật sản phẩm: Bấm vào nút View cart</br> Nếu bạn muốn đặt hàng và
			thanh toán cho sản phẩm này vui lòng bấm vào nút Checkout
		</p>
		<p>
			<span>Bước 3: </span>Lựa chọn thông tin tài khoản thanh toán<br>
			Nếu bạn đã có tài khoản vui lòng nhập thông tin tên đăng nhập là
			email và mật khẩu vào mục đã có tài khoản trên hệ thống<br> Nếu
			bạn chưa có tài khoản và muốn đăng ký tài khoản vui lòng điền các
			thông tin cá nhân để tiếp tục đăng ký tài khoản. Khi có tài khoản bạn
			sẽ dễ dàng theo dõi được đơn hàng của mình<br> Nếu bạn muốn mua
			hàng mà không cần tài khoản vui lòng nhấp chuột vào mục đặt hàng
			không cần tài khoản
		</p>
		<p>
			<span>Bước 4: </span> Điền các thông tin của bạn để nhận đơn hàng,
			lựa chọn hình thức thanh toán và vận chuyển cho đơn hàng của mình
		</p>
		<p>
			<span>Bước 5: </span>Xem lại thông tin đặt hàng, điền chú thích và
			gửi đơn hàng<br> Sau khi nhận được đơn hàng bạn gửi chúng tôi sẽ
			liên hệ bằng cách gọi điện lại để xác nhận lại đơn hàng và địa chỉ
			của bạn.<br> Trân trọng cảm ơn.
		</p>
	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>

	<script src="${base }/user/js/blogs.js">
		
	</script>
</body>
</html>