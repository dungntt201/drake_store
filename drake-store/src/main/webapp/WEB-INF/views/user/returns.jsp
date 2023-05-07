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

<link rel="stylesheet" href="${base }/user/css/returns.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
	<link rel="stylesheet" href="${base}/user/css/header-f.css">
	<link rel="stylesheet" href="${base}/user/css/header-f.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>

	<div class="banner">
		<div class="banner-content">
			<p>Returns</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Returns</span>
		</div>
	</div>
	<div class="doi-tra">
		<p class="hd-title">Chính sách đổi trả</p>
		<p>
			<span>Đối với khách hàng Hà Nội hoặc mua hàng trực tiếp tại
				của hàng Drake Store: </span><br> - Trong vòng 7 ngày kể từ ngày
			mua hàng (Theo thời gian ghi trong hoá đơn), quý khách được phép đổi
			size, đổi mẫu hoặc trả hàng và nhận lại tiền.<br> - Khi đến đổi,
			quý khách vui lòng mang theo sản phẩm trong tình trạng chưa qua sử
			dụng.
		</p>
		<p>
			<span>Đối với khách hàng ở các tỉnh ngoài Hà Nội khi đặt hàng
				của Drake Store:</span><br> - Trong vòng 7 ngày kể từ ngày nhận
			hàng (Theo thời gian ghi trong hoá đơn, hoặc mã đơn hàng), quý khách
			được phép đổi size, đổi mẫu hoặc trả lại hàng và nhận lại tiền.<br>
			- Quý khách vui lòng thông báo trước về tình trạng sản phẩm, nguyên
			do đổi hàng qua inbox Fanpgage: http://facebook.com/drakestoreshoes.vn
			hoặc Hotline: 09xx.xxx.xxx. Sau đó sẽ nhận được hướng dẫn từ đội ngũ
			hỗ trợ của Drake Store.<br> - Trường hợp Sản phẩm lỗi do nhà
			sản xuất hoặc bên phía cửa hàng gửi nhầm Sản phẩm của Quý khách.
			Drake Store xin chịu hoàn toàn Phí Vận Chuyển để đảm bảo quý khách
			có một Sản phẩm tốt nhất.
		</p>
		<p>
			<span>Lưu ý : </span><br> - Những sản phẩm đã qua sử dụng thì sẽ
			không áp dụng đổi trả.<br> - Các sản phẩm trong chương trình
			khuyến mãi, giảm giá tùy theo sự kiện mà Drake Store công bố.<br>
			- Điều kiện: Sản phẩm còn mới 100% <br> <span>Cảm ơn Quý
				Khách hàng đã tin tưởng và cho Drake Store cơ hội được phục vụ
				Quý Khách!</span>

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