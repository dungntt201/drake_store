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

<link rel="stylesheet" href="${base }/user/css/delivery.css">
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
			<p>Privacy</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Privacy</span>
		</div>
	</div>
	<div class="giao-hang">
		<p class="hd-title">Chính sách bảo mật thông tin</p>
		<p>
			<span>1.Mục đích và phạm vi thu thập </span><br> Cảm ơn Quý
			khách đã truy cập vào website của chúng tôi, để sử dụng dịch vụ tại
			website, Quý khách có thể được yêu cầu đăng ký thông tin cá nhân với
			chúng tôi như:<br> - Họ và tên, địa chỉ liên lạc<br> -
			Email, số điện thoại di động<br> Chúng tôi cũng có thể thu thập
			thông tin về số lần ghé thăm website của chúng tôi bao gồm số trang
			Quý khách xem, số links Quý khách click vào các thông tin khác liên
			quan đến việc kết nối đến địa chỉ chỉ drakestore.vn
		<p>
			<span>2.Phạm vi sử dụng thông tin</span><br> drakestore.vn
			thu thập và sử dụng thông tin cá nhân với mục đích phù hợp và hoàn
			toàn tuân thủ “chính sách bảo mật” này. Chúng tôi chỉ sử dụng thông
			tin của Quý khách trong nội bộ công ty hoặc có thể công bố cho bên
			thứ 3 như các đại lý, các nhà cung cấp dịch vụ khác nhằm cung cấp
			dịch vụ tốt nhất, tối ưu nhất cho Quý khách.<br> Khi cần thiết
			chúng tôi có thể sử dụng những thông tin này để liên hệ trực tiếp với
			Quý khách như gửi thư ngỏ, đơn đặt hàng, thư cảm ơn, thông tin về kỹ
			thuật và bảo mật, thông tin về khuyến mại, thông tin về sản phẩm dịch
			vụ mới….
		</p>
		<p>
			<span>3.Thời gian lưu trữ thông tin </span><br> Các thông tin
			của Quý khách hàng sẽ được lưu trữ trong hệ thống nội bộ của công ty
			chúng tôi cho đến khi Quý khách có yêu cầu hủy bỏ các thông tin đã
			cung cấp.
		</p>
		<p>
			<span>4.Địa chỉ của đơn vị thu thập và quản lý thông tin cá
				nhân </span><br> HO KINH DOANH DRAKE STORE<br> Địa chỉ : Tân
			Lập - Đan Phượng - Hà Nội<br> Số điện thoại : 0981.982.267
		</p>
		<p>
			<span>5.Phương tiện và công cụ để người dùng tiếp cận và chỉnh
				sửa dữ liệu cá nhân </span><br> Quý khách muốn chỉnh sửa thông tin cá
			nhân của mình vui lòng liên hệ tổng đài chăm sóc khách hàng của chúng
			tôi qua số điện thoại: 0981.982.267 hoặc qua địa chỉ email:
			hotro@drakestore.vn
		</p>
		<p>
			<span>6.cam kết bảo mật thông tin cá nhân khác hàng</span><br>
			Chúng tôi cam kết bảo mật thông tin của Quý khách hàng bằng mọi hình
			thức có thể theo chính bảo vệ thông tin cá nhân của chúng tôi.<br>
			Chúng tôi tuyệt đối không chia sẻ thông tin của Quý khách cho bất cứ
			công ty hay bên thứ 3 nào khác ngoại trừ các đại lý và các nhà cung
			cấp liên quan đến việc cung cấp dịch vụ cho Quý khách hàng.
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