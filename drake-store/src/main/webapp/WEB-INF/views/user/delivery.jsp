<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

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
          href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.js"></script>
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.css"
            rel="stylesheet"/>

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
        <p>Delivery</p>
        <a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Delivery</span>
    </div>
</div>
<div class="giao-hang">
    <p class="hd-title">Chính sách vận chuyển</p>
    <p>
        <span>1.Giao hàng và thanh toán tiền mặt tại nhà. </span><br> -
        Giao hàng COD Toàn quốc trong vòng 2 – 4 Ngày làm việc<br> - Phí
        vận chuyển sẽ được thông báo trước cho khách hàng<br> - Quý
        Khách được kiểm tra sản phẩm trước khi thanh toán <br> - Quý
        Khách được thử sản phẩm.
    </p>
    <p>
        <span>2.Thông báo đơn hàng</span><br> - Đặt hàng thành công<br>
        - Xác nhận đơn hàng (Chờ xác nhận qua điện thoại hoặc Email)<br>
        - Thông báo tiền và thời gian nhận hàng.
    </p>
    <p>
        <span>3.Thanh toán </span><br> - Quý khách có thể thanh toan
        giao hàng với 2 hình thức sau: <br> <span class="span1">+
				Thanh toán khi nhận hàng [COD]</span><br> <span class="span1">+
				Thanh toán Thông qua số Tài Khoản:</span><br> <span class="stk">
				Số TK: xxxxxxxxxxxxx<br> Chủ TK: Nguyen The Tien Dung<br> Ngân
				hàng : BIDV
			</span> <br> * Lưu ý: Khi chuyển khoản quý khách vui lòng điền thông
        tin trong phần nội dung chuyển khoản.<br> <span>Cảm ơn
				Quý Khách hàng đã tin tưởng và cho Drake Store cơ hội được phục
				vụ Quý Khách!</span>
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
