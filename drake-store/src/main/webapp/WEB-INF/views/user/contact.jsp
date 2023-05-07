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
<link rel="stylesheet" href="${base }/user/css/contact.css">
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
			<p>Contact</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Contact</span>
		</div>
	</div>
	<div class="contact">
		<c:if test="${not empty msg}">
			<div class="alert alert-success" role="alert"
				style="text-align: center; width: 87%; margin: 30px auto">${msg}</div>
		</c:if>
		<div class="contact1">
			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59587.97785448576!2d105.80194415873746!3d21.022736016299344!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab9bd9861ca1%3A0xe7887f7b72ca17a9!2zSMOgIE7hu5lpLCBIb8OgbiBLaeG6v20sIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1670293365510!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
<%--			<iframe--%>
<%--				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14893.86583272624!2d105.63169957721563!3d21.05402400105402!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313456e29b6daa29%3A0x67a5060f49f33a19!2zTGnDqm4gSGnhu4dwLCBQaMO6YyBUaOG7jSwgSMOgIE7hu5lpLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1631498160185!5m2!1svi!2s"--%>
<%--				style="border: 0;" allowfullscreen="" loading="lazy"></iframe>--%>
			<div class="contact11">
				<p id="p-title" style="font-weight: bolder">Looking Forward to
					Hear From You</p>
				<p id="content_contact">Contact sit amet, consectetur adipiscing
					elit, sed do eiusmod tempor incididunt ut labore et dolore magna
					aliqua.</p>
				<div class="contact111">
					<i class="fas fa-map-marker-alt"></i>
					<div class="contact1111">
						<p class="element">Address</p>
						<p class="element1">Hanoi, Vietnam</p>
					</div>
				</div>
				<div class="contact111">
					<i class="fas fa-phone-alt"></i>
					<div class="contact1111">
						<p class="element">Phone</p>
						<p class="element1">
							<a href="tel:+84981982267">0981982267</a>
						</p>
					</div>
				</div>
				<div class="contact111">
					<i class="fas fa-envelope"></i>
					<div class="contact1111">
						<p class="element">Email</p>
						<p class="element1">
							<a href="#">dung.ntt992001@gmail.com</a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="contact_form">
			<p id="form-title" style="font-weight: bolder; text-align: center;">Send
				Us A Mesage</p>
			<br>
			<p id="al" class="alert alert-success" role="alert"
				style="text-align: center"></p>
			<br>
			<sf:form method="POST" action="${base }/contact"
				modelAttribute="newContact" onsubmit="return send()">

				<sf:input class="form-control" id="contact-name" path="full_name"
					type="text" required="required" placeholder="Your Full name *"
					onkeyup="checkName()" />
				<br>
				<p id="demo-name"></p>
				<br>
				<sf:input class="form-control" id="contact-email" path="email"
					type="email" required="required" placeholder="Your Email *"
					onkeyup="checkEmRegister()"></sf:input>
				<br>
				<p id="demo-email"></p>
				<br>
				<sf:input class="form-control" id="contact-phone"
					path="phone_number" type="number" required="required" min="0"
					placeholder="Your Phone Number *" onkeyup="checkSDT()"></sf:input>
				<br>
				<p id="demo-phone"></p>
				<br>
				<sf:textarea class="form-control" id="contact-message"
					path="message" required="required" placeholder="Message *"
					onkeyup="checkMessage()"></sf:textarea>
				<br>
				<p id="demo-message"></p>
				<br>
				<p style="text-align: center">
					<button type="button" class="btn btn-primary"
						onclick="checkName(),checkEmRegister(),checkSDT(),checkMessage(),send(),saveContact()">Send</button>
				</p>
				<!-- 			<p style="text-align: center"><button type="submit" class="btn btn-primary">Send</button></p>
 -->

			</sf:form>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>

	<script src="${base }/user/js/blogs.js">
		
	</script>
	<script type="text/javascript">
		function checkEmRegister() {
			/* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
			var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
			var g = document.getElementById("contact-email").value;
			if (y3.test(g)) {
				document.getElementById("demo-email").innerHTML = "";
				document.getElementById("contact-email").style.border = "1px solid gray";
				return true;
			} else {
				document.getElementById("contact-email").style.border = "1px solid red";
				document.getElementById("demo-email").innerHTML = "Note: Lưu ý định dạng email.";
				return false;
			}
		}
		function checkName() {

			var g = document.getElementById("contact-name").value;

			if (g == null || g == "") {
				document.getElementById("contact-name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
				document.getElementById("contact-name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được chứa kí tự đặc biệt!";
				return false;
			} else {
				document.getElementById("demo-name").innerHTML = "";
				document.getElementById("contact-name").style.border = "1px solid gray";
				return true;
			}
		}
		function checkSDT() {

			var g = document.getElementById("contact-phone").value;
			var vnf_regex = /((09|03|07|08|05)+([0-9]{8})\b)/g;
			if (g == null || g == "") {
				document.getElementById("contact-phone").style.border = "1px solid red";
				document.getElementById("demo-phone").innerHTML = "Note: Không được để trống trường này";
				return false;

			}

			if (g != null && g != "") {
				if (vnf_regex.test(g)) {
					document.getElementById("demo-phone").innerHTML = "";
					document.getElementById("contact-phone").style.border = "1px solid gray";
					return true;
				} else {
					document.getElementById("contact-phone").style.border = "1px solid red";
					document.getElementById("demo-phone").innerHTML = "Note: Số điện thoại không hợp lệ";
					return false;
				}
			}
		}
		function checkMessage() {

			var g = document.getElementById("contact-message").value;

			if (g == null || g == "") {
				document.getElementById("contact-message").style.border = "1px solid red";
				document.getElementById("demo-message").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else {
				document.getElementById("demo-message").innerHTML = "";
				document.getElementById("contact-message").style.border = "1px solid gray";
				return true;
			}
		}
		function send() {

			if (checkEmRegister() == true && checkName() == true
					&& checkSDT() == true && checkMessage() == true) {
				return true;

			} else {
				//alert("Bạn nhập sai định dạng . Vui lòng nhập lại !");
				return false;
			}
		}
		function saveContact() {
			if (send() == true) {
				document.getElementById("al").innerHTML = "Cảm ơn bạn đã gửi liên hệ cho chúng tôi!";
				document.getElementById("al").style.display = "block";

				setTimeout(function() {
					$("#al").slideUp(500);
				}, 2000)
				// javascript object.
				// data la du lieu ma day len action cua controller
				let data = {
					full_name : jQuery("#contact-name").val(), // lay theo id 
					email : jQuery("#contact-email").val(),
					phone_number : jQuery("#contact-phone").val(),
					message : jQuery("#contact-message").val(),

				};
				$("#contact-name").val("");
				$("#contact-email").val("");
				$("#contact-phone").val("");
				$("#contact-message").val("");
				// file java đâu ô, chạy thử lại đi ô
				/* var form_data = new FormData();
				form_data.append('file',$('#input_file')[0].files[0]);
				form_data.append('id',$("#a1").val());
				f orm_data.append('full_name',$("#full_name").val());*/
				// để 2 id kìa ô
				// $ === jQuery
				// json == javascript object
				jQuery.ajax({
					url : "/contact",
					type : "post",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(data),
					// prevent jQuery from automatically transforming the data into a query string

					dataType : "json", // kieu du lieu tra ve tu controller la json

					success : function(jsonResult) {
						/* document.getElementById("al").innerHTML = "Cảm ơn bạn đã gửi liên hệ cho chúng tôi!";
						document.getElementById("al").style.display = "block"; */
					},
					error : function(jqXhr, textStatus, errorMessage) { // error callback 

					}
				});
			} else {
				alert("Bạn nhập sai định dạng . Vui lòng nhập lại !");
			}

		}
	</script>
</body>
</html>
