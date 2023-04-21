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
<link rel="stylesheet" href="${base }/user/css/order.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="banner">
		<div class="banner-content">
			<p>Order</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Order</span>
		</div>
	</div>
	<div class="cart-view">
		<c:if test="${not empty msg }">
			<p id="hideDiv" style="font-weight: normal"
				class="alert alert-success">${msg }</p>
		</c:if>
		<c:choose>
			<c:when test="${not empty msg1 }">
				<div class="message">
					<p>${msg1 }</p>
					<a href="${base }/shop">Tiếp tục mua hàng</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="order-view">
					<div class="customer-info">
						<div class="customer-info1">
							<div class="customer">
								<p>Thông tin nhận hàng</p>
								<c:if test="${!isLogined }">
									<a href="${base }/account/login"><i
										class="fas fa-user-circle"></i> Đăng nhập</a>
								</c:if>

							</div>
						</div>
						<br>
						<c:choose>
							<c:when test="${isLogined }">
								<form action="${base }/order/finish" method="post"
									onsubmit="return send1()">

									<input type="text" name="customerName" id="customerName"
										class="form-control" placeholder="Họ tên (required)"
										required="required" disabled="disabled"
										value="${userLogined.full_name }"> <br> <input
										type="text" name="customerAddress" id="customerAddress"
										placeholder="Địa chỉ (required)" class="form-control"
										required="required" onkeyup="checkAddress()"> <br>
									<p id="demo-address"></p>
									<input type="number" min="0" name="customerPhone"
										id="customerphone" placeholder="Số điện thoại (required)"
										class="form-control" required="required" onkeyup="checkSDT()"><br>
									<p id="demo-phone"></p>

									<input type="email" name="customerEmail" id="customerEmail"
										placeholder="Email (required)" class="form-control"
										disabled="disabled" value="${userLogined.email }"> <br>
									<textarea style="width: 100%; height: 100px" name="message"
										class="form-control" placeholder="Mesage"></textarea>
									<br>
									<<input type="radio" name="ship" value="1" checked="checked" id="ship">
									<label for="ship"> Giao hàng tận nơi (Free)</label> <br> <br>
									<input type="radio" name="ship-code" checked="checked" value="cod" id="ship_code">
									<label for="ship_code"> Thanh toán khi nhận hàng (COD)</label> <br>
									<input type="radio" name="ship-code" value="atm" id="ship_atm">
									<label for="ship_atm"> Thanh toán trực tuyến</label> <br> <br>
									<small
										style="background-color: red; color: white; padding: 5px">We
										will never share your email with anyone else</small><br> <br>
									<br> <a style="font-size: 16px" href="${base }/shop"
										class="btn btn-primary">Tiếp tục mua hàng</a>
									<button style="font-size: 16px" type="submit" id="tinh1"
										class="btn btn-danger">Đặt hàng</button>
								</form>

							</c:when>
							<c:otherwise>
								<form action="${base }/order/finish" method="post"
									onsubmit="return send()">

									<input type="text" name="customerName" id="customerName"
										placeholder="Họ tên (required)" class="form-control"
										required="required" onkeyup="checkName()"> <br>
									<p id="demo-name"></p>
									<input type="text" name="customerAddress" id="customerAddress"
										placeholder="Địa chỉ (required)" class="form-control"
										required="required" onkeyup="checkAddress()"> <br>
									<p id="demo-address"></p>
									<input type="number" min="0" name="customerPhone"
										id="customerphone" placeholder="Số điện thoại (required)"
										class="form-control" required="required" onkeyup="checkSDT()"><br>
									<p id="demo-phone"></p>

									<input type="email" name="customerEmail" id="customerEmail"
										placeholder="Email (required)" class="form-control"
										required="required" onkeyup="checkEmRegister()"><br>
									<p id="demo-email"></p>

									<textarea style="width: 100%; height: 100px" name="message"
										class="form-control" placeholder="Message"></textarea>
									<br>
									<input type="radio" name="ship" value="1" checked="checked" id="ship">
									<label for="ship"> Giao hàng tận nơi (Free)</label> <br> <br>
									<input type="radio" name="ship-code" checked="checked" value="cod" id="ship_code">
									<label for="ship_code"> Thanh toán khi nhận hàng (COD)</label> <br>
									<input type="radio" name="ship-code" value="atm" id="ship_atm">
									<label for="ship_atm"> Thanh toán trực tuyến</label> <br> <br>
									<small
										style="background-color: red; color: white; padding: 5px">We
										will never share your email with anyone else</small><br> <br>
									<br> <a style="font-size: 16px" href="${base }/shop"
										class="btn btn-primary">Tiếp tục mua hàng</a>
									<button style="font-size: 16px" type="submit" id="tinh1"
										class="btn btn-danger">Đặt hàng</button>
								</form>

							</c:otherwise>
						</c:choose>
					</div>

					<div class="cart-order">
						<p class="order-title">Đơn hàng (${totalItems} sản phẩm)</p>
						<c:forEach var="cartItem" items="${cart.cartItems }">
							<div class="sp-order">
								<c:forEach var="product" items="${products }">
									<c:if test="${product.id==cartItem.productId }">
										<td><img alt="" src="${base }/upload/${product.avatar}"></td>
									</c:if>
								</c:forEach>
								<div class="sp-order1">
									<p style="font-weight: bolder">${cartItem.productName }</p>
									<div>
										<p style="float: left; color: gray">${cartItem.size }x
											${cartItem.quanlity }</p>
										<p style="float: right; color: gray">
											<fmt:formatNumber
												value="${cartItem.quanlity*cartItem.priceUnit }"
												type="number" groupingUsed="true" />
											VND
										</p>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="ship">
							<p style="float: left; color: black; font-weight: bolder">Phí
								vận chuyển:</p>
							<p style="float: right; color: gray">Miễn phí</p>
						</div>
						<br> <br>
						<div class="ship">
							<p style="float: left; color: black; font-weight: bolder">Tổng
								tiền:</p>
							<p style="float: right; color: gray">
								<fmt:formatNumber value="${totalPrice }" type="number"
									groupingUsed="true" />
								VND
							</p>
						</div>
					</div>
				</div>

			</c:otherwise>

		</c:choose>
	</div>
	<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
	<button onclick="topFunction()" id="myBtn" title="Go to top">
		<i class="fas fa-angle-double-up"></i>
	</button>

	<script src="${base }/user/js/blogs.js">
		
	</script>
	<script type="text/javascript">
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
			}, 2000)

		})
		function checkAddress() {

			var g = document.getElementById("customerAddress").value;

			if (g == null || g == "") {
				document.getElementById("customerAddress").style.border = "1px solid red";
				document.getElementById("demo-address").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else {
				document.getElementById("demo-address").innerHTML = "";
				document.getElementById("customerAddress").style.border = "1px solid gray";
				return true;
			}
		}
		function checkName() {

			var g = document.getElementById("customerName").value;

			if (g == null || g == "") {
				document.getElementById("customerName").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
				document.getElementById("customerName").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được chứa kí tự đặc biệt!";
				return false;
			} else {
				document.getElementById("demo-name").innerHTML = "";
				document.getElementById("customerName").style.border = "1px solid gray";
				return true;
			}
		}

		function checkEmRegister() {
			/* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
			var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
			var g = document.getElementById("customerEmail").value;
			if (y3.test(g)) {
				document.getElementById("demo-email").innerHTML = "";
				document.getElementById("customerEmail").style.border = "1px solid gray";
				return true;
			} else {
				document.getElementById("customerEmail").style.border = "1px solid red";
				document.getElementById("demo-email").innerHTML = "Note: Lưu ý định dạng email.";
				return false;
			}
		}
		function checkSDT() {

			var g = document.getElementById("customerphone").value;
			var vnf_regex = /((09|03|07|08|05)+([0-9]{8})\b)/g;
			if (g == null || g == "") {
				document.getElementById("customerphone").style.border = "1px solid red";
				document.getElementById("demo-phone").innerHTML = "Note: Không được để trống trường này";
				return false;

			}

			if (g != null && g != "") {
				if (vnf_regex.test(g)) {
					document.getElementById("demo-phone").innerHTML = "";
					document.getElementById("customerphone").style.border = "1px solid gray";
					return true;
				} else {
					document.getElementById("customerphone").style.border = "1px solid red";
					document.getElementById("demo-phone").innerHTML = "Note: Số điện thoại không hợp lệ";
					return false;
				}
			}
		}
		function send() {

			if (checkEmRegister() == true && checkSDT() == true
					&& checkName() == true && checkAddress() == true) {
				return true;
			} else {
				alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
				return false;
			}
		}
		function send1() {

			if (checkSDT() == true && checkAddress() == true) {
					
				return true;
			} else {
				alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
				return false;
			}
		}
		$(document)
				.ready(
						function() {
							$('.inputsl').change(
									function() {
										var sl = parseFloat($(this).val());
										var price = parseFloat($(this).parents(
												"tr").children("td").children(
												".price").text());
										var total = sl * price;
										$(this).parents("tr").children("td")
												.children(".totalMoney").text(
														total.toFixed(2));
									});
							$('.del').click(function() {
								$(this).parents("tr").remove();
							});
							$("#tinh1")
									.click(
											function() {
												//$("#totalCartItemId").text(0);
												//$(".tongtien").text(0.toFixed(2));
												return confirm('Bạn có chắc chắn muốn đặt hàng không?');
											});
						});
		function deleteItem(productId, size) {
			// javascript object.
			// data la du lieu ma day len action cua controller
			let data = {
				productId : productId,
				size : size,
			};

			// $ === jQuery
			// json == javascript object
			jQuery.ajax({
				url : "/cart/delete",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", // kieu du lieu tra ve tu controller la json
				success : function(jsonResult) {
					//alert("Đã lưu yêu cầu của " + " thành công !");
					let totalItems = jsonResult.totalItems;
					let totalPrice = jsonResult.totalPrice;
					$("#money").text("$" + totalPrice + ".00");
					$("#addcart").text(totalItems);
					$(".tongtien").text("$" + totalPrice + ".00");
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 

				}
			});
		}

		function editQuanlity(productId, quanlity, size) {
			// javascript object.
			// data la du lieu ma day len action cua controller
			let data = {
				productId : productId,
				quanlity : quanlity,
				size : size,
			};

			// $ === jQuery
			// json == javascript object
			jQuery.ajax({
				url : "/cart/editQuanlity",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", // kieu du lieu tra ve tu controller la json
				success : function(jsonResult) {
					//alert("Đã lưu yêu cầu của " + " thành công !");
					if (jsonResult.message == null) {
						let totalItems = jsonResult.totalItems;
						let totalPrice = jsonResult.totalPrice;
						$("#money").text("$" + totalPrice + ".00");
						$("#addcart").text(totalItems);
						$(".tongtien").text("$" + totalPrice + ".00");

					} else {
						alert("vượt quá số lượng có của sản phẩm!");

					}
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 

				}
			});
		}

		let rspCode = "${rspCode}"
		if(rspCode !== "") {
			console.log(1)
		}
		else {
			console.log(2)
		}
		console.log("rspCode: " + rspCode)
	</script>
</body>
</html>