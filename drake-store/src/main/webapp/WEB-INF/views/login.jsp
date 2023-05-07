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
<link rel="stylesheet" href="${base }/user/css/login.css">
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
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Login</span>
		</div>
	</div>
	<div class="login">
		<!-- của password  -->
		<c:if test="${not empty message }">
			<div id="hideDiv1" class="alert alert-success" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${message}</div>
		</c:if>
		<c:if test="${not empty message1 }">
			<div id="hideDiv2" class="alert alert-success" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${message1}</div>
		</c:if>
		<c:if test="${not empty msg1 }">
			<div id="hideDiv6" class="alert alert-danger" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${msg1}</div>
		</c:if>
		<!-- của register  -->
		<c:if test="${not empty success }">
			<div id="hideDiv3" class="alert alert-success" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${success}</div>
		</c:if>
		<c:if test="${not empty success1 }">
			<div id="hideDiv4" class="alert alert-danger" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${success1}</div>
		</c:if>
		<c:if test="${not empty error }">
			<div id="hideDiv5" class="alert alert-danger" role="alert"
				style="text-align: center; width: 87%; margin: 0 auto">${error}</div>
		</c:if>


		<br>
		<div class="login1">
			<div class="login11">
				<p class="title">Login</p>
				<div style="border: 1px solid black;">
					<!-- nếu login lỗi thì thông báo  -->
					<c:if test="${not empty param.login_error }">
						<%-- <p  class="alert alert-success">${msg }</p> --%>
						<div id="hideDiv" style="margin: 20px"
							class="alert alert-danger text-center" role="alert">
							<c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
							<!-- nếu có ngoại lệ xảy ra trong quá trình đăng nhập thì biến
							SPRING_SECURITY_LAST_EXCEPTION.message in ra message của các
							ngoại lệ đó -->
						</div>
					</c:if>
					<div class="social-login">
						<i class="fab fa-facebook-f"></i> <a
							href="${base }/oauth2/authorization/facebook"><p>Sign in
								with Facebook</p></a>
					</div>
					<div class="social-login1">
						<i class="fab fa-google"></i> <a
							href="${base }/oauth2/authorization/google"><p>Sign in
								with GOOGLE</p></a>
					</div>
					<p id="or">OR</p>
					<form method="POST" action="/account/perform-login" id="lg-form">
						<br> <input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }"> <label style="width: 100%;">
							<p>Username *</p> <input type="text" name="username"
							id="input-usn" value="" required="required"> <!-- <p id="demo1"></p> -->
						</label> <label style="width: 100%;">
							<p>Passwords *</p>
							<div style="display: flex;">
								<input type="password" name="password" id="input-pw" value=""
									required="required">
								<div class="show">
									<p class="pw-bt">
										<i onclick="hide()" class="fas fa-eye"></i>
									</p>
								</div>
							</div> <!--  <p id="demo2"></p> -->
						</label> <input type="checkbox" name="remember-me" id="remember"><span
							style="margin-left: 5px;">Remember me</span><br>

						<button type="submit" class="submit">LOG IN</button>
						<br>
					</form>
					<a href="${base }/forgot_password"><p>Lost your password ?</p></a>
				</div>
			</div>
			<div class="register">
				<p class="title">Register</p>
				<div style="border: 1px solid black;">
					<sf:form method="POST" action="${base }/account/login" id="lg-form"
						modelAttribute="newUser" onsubmit="return register()"
						enctype="multipart/form-data">
						<sf:hidden path="id" />
						<label style="width: 100%;">
							<p>Fullname*</p> <sf:input path="full_name" type="text" name="fn"
								id="input-fn1" value="" onchange="checkNameRegister()"
								required="required"></sf:input>
							<p id="demo-name"></p>
						</label>
						<label style="width: 100%;">
							<p>Username*</p> <sf:input type="text" path="username" name="usn"
								id="input-usn1" value="" required="required"
								onkeyup="checkUsnRegister()"></sf:input>
							<p id="demo3"></p>
						</label>
						<label style="width: 100%;">
							<p>Email *</p> <sf:input path="email" type="email" name="em"
								id="input-em1" value="" required="required"
								onkeyup="checkEmRegister()"></sf:input>
							<p id="demo4"></p>
						</label>
						<label style="width: 100%;">
							<p>Passwords *</p>
							<div style="display: flex;">
								<sf:input path="password" type="password" name="pw"
									id="input-pw1" value="" required="required"
									onkeyup="checkPwRegister()"></sf:input>
								<div class="show">
									<p class="pw-bt">
										<i onclick="hide1()" class="fas fa-eye"></i>
									</p>
								</div>
							</div>
							<p id="demo5"></p>
						</label>

						<label style="width: 100%;">
							<p>Avatar</p>
							<div style="display: flex;">
								<input type="file" name="userAvatar" accept="image/*">
							</div>
						</label>

						<button type="submit" class="submit">REGISTER</button>
						<br>
					</sf:form>

				</div>
			</div>
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
				$("#hideDiv3").slideUp(500);
				$("#hideDiv4").slideUp(500);
				$("#hideDiv5").slideUp(500);
				$("#hideDiv6").slideUp(500);
			}, 2000)

		})
	</script>
</body>
</html>