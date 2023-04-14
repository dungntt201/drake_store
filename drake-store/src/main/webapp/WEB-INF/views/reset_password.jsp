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
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner-content">
			<p>My Account</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Reset
				Password</span>
		</div>
	</div>
	<div class="login">

		<div class="forgot">
			<c:if test="${not empty message1 }">
				<div id="hideDiv" class="alert alert-danger text-center"
					role="alert">${message1}</div>
			</c:if>
			<p>Reset your password</p>
			
			<form action="${base }/reset_password" method="post"
				onsubmit="return resetpass()">
				<p style="text-align: right;">
					<button onclick="hide3()" type="button" class="btn btn-danger">
						<i class="fas fa-eye"></i>
					</button>
				</p>
				<p>
					<input type="hidden" name="token" value="${token}" /> <input
						onkeyup="checkPassword()" autocomplete="off" type="password"
						class="form-control" id="reset_pass" name="password"
						placeholder="Enter your new password" required="required"
						style="font-size: 15px; height: 40px; font-weight: normal;" />
				</p>
				<p
					style="padding: 5px 10px; margin: 10px 0 10px 0; font-weight: normal;"
					class="alert alert-danger font-weight-normal" role="alert"
					id="demox"></p>
				<p>
					<input onkeyup="checkConfirmPass()" autocomplete="off"
						type="password" class="form-control" id="confirm"
						placeholder="Enter your new password" required="required"
						style="font-size: 15px; height: 40px; font-weight: normal;" />
				</p>
				<p
					style="padding: 5px 10px; margin: 10px 0 10px 0; font-weight: normal;"
					class="alert alert-danger font-weight-normal" role="alert"
					id="demoy"></p>
				<br>
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
			}, 2000)

		})

		//ẩn hiện password login
		var x = true;
		function hide3() {
			if (x) {
				//document.getElementById("old-pass").type = "text";
				document.getElementById("reset_pass").type = "text";
				document.getElementById("confirm").type = "text";
				x = false;
			} else {
				//document.getElementById("old-pass").type = "password";
				document.getElementById("reset_pass").type = "password";
				document.getElementById("confirm").type = "password";
				x = true;
			}
		}
	</script>
</body>
</html>