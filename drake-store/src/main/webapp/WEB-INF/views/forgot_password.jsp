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
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<!-- Auto detecting language -->
<link rel="stylesheet" href="${base }/user/css/forgot_password.css">
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
			<p>My Account</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Forgot
				Password</span>
		</div>
	</div>
	<div class="login">

		<div class="forgot">
			<!-- của @PostMapping("/forgot_password") -->
			<c:if test="${not empty error }">
				<div id="hideDiv" class="alert alert-danger" role="alert"
					style="text-align: center;">${error }</div>
			</c:if>
			<c:if test="${not empty message }">
				<div id="hideDiv1" class="alert alert-success" role="alert"
					style="text-align: center;">${message}</div>
			</c:if>
			
			<!-- của @GetMapping("/reset_password")  -->
			<c:if test="${not empty message1 }">
				<div id="hideDiv2" class="alert alert-danger text-center" role="alert">${message1}</div>
			</c:if>
			
			
			<p>Vui lòng nhập địa chỉ email liên kết với tài khoản của bạn!</p>
			<br>
			<form action="${base }/forgot_password" method="post">
				<input type="email" class="form-control" name="email"
					placeholder="Enter your email" required="required" style="font-size: 15px;height: 40px" /> <br> <br>
				<p class="text-center">
					<button type="submit" value="Send" class="btn btn-primary" />
					Send
					</button>
				</p>
			</form>
		</div>

	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>
	<script src="${base }/user/js/login.js">
		
	</script>
	
	<script type="text/javascript">
	$(function() {
		setTimeout(function() {
			$("#hideDiv").slideUp(500);
			$("#hideDiv1").slideUp(500);
			$("#hideDiv2").slideUp(500);
		}, 2000)

	})
	</script>
</body>
</html>