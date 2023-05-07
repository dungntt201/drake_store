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
<script src='https://www.google.com/recaptcha/api.js'></script>
<link rel="stylesheet" href="${base }/user/css/account-info.css">
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
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>My
				Account and Order</span>
		</div>
	</div>
	<div class="account_user">
		<!-- của password -->
		<c:if test="${not empty msg1 }">
			<p id="hideDiv1" style="font-size: 15px; padding: 10px"
				class="alert alert-danger text-center">${msg1 }</p>
		</c:if>
		<c:if test="${not empty msg }">
			<p id="hideDiv" style="font-size: 15px; padding: 10px"
				class="alert alert-success text-center">${msg }</p>
		</c:if>



		<p>THÔNG TIN TÀI KHOẢN</p>

		<div class="account_user1">
			<div class="info">
				<!-- <p id="myacc">Tài khoản của tôi</p> -->
				<sf:form method="post" action="${base }/account/info"
					modelAttribute="user" enctype="multipart/form-data"
					onsubmit="return checkAll()">

					<sf:hidden path="id" id="a1" />

					<br>
					<label for="full_name">HỌ VÀ TÊN:*</label>
					<sf:input path="full_name" autocomplete="off" type="text"
						class="form-control" id="full_name" placeholder="Full name"
						required="required" onchange="checkName()" />
					<p style="color: red; font-weight: normal; font-size: 15px"
						id="demo-name"></p>
					<!-- <br> -->

					<label for="username">USER NAME:*</label>
					<sf:input path="username" autocomplete="off" class="form-control"
						id="username" placeholder="Username" required="required"
						disabled="true" />

					<br>
					<label for="email">EMAIL:*</label>
					<sf:input path="email" autocomplete="off" class="form-control"
						id="email" placeholder="Email" required="required" disabled="true" />

					<br>
					<label for="created_date">NGÀY TẠO:*</label>
					<sf:input path="created_date" autocomplete="off" type="date"
						class="form-control" id="created_date" placeholder="Created Date"
						disabled="true" />

					<br>
					<label for="provider">PROVIDER:</label>
					<sf:input path="provider" autocomplete="off" class="form-control"
						id="provider" placeholder="PROVIDER" disabled="true" />

					<br>

					<label for="input_file">Avatar</label>
					<input name="userAvatar" id="input_file" accept="image/*"
						type="file" class="form-control-file">
					<br>
					<a href="${base }/logout" class="btn btn-danger" role="button"
						aria-pressed="true">LOG OUT</a>
					<button type="submit" class="btn btn-primary">UPDATE</button>

					<c:if test="${checkLocal==true }">
						<p style="margin-top: 10px">
							<a href="${base }/change_password" class="btn btn-danger"
								role="button" aria-pressed="true">CHANGE PASSWORD</a>
						</p>
					</c:if>

				</sf:form>
			</div>
			<div class="order">
				<c:choose>
					<c:when test="${totalSaleOrders<=0 }">
						<p style="font-size: 15px; padding: 10px"
							class="alert alert-danger text-center">Bạn chưa có đơn hàng
							nào!</p>
					</c:when>
					<c:otherwise>
						<div class="table-responsive" style="width: 100%">
							<table class="table table-hover table-bordered table-condensed">
								<tr>
									<th>Đơn hàng</th>
									<th>Ngày tạo</th>
									<th>Địa chỉ</th>
									<th>Giá trị đơn hàng</th>
									<!-- <th>Tình trạng thanh toán</th> -->
									<th>Trạng thái</th>
									<th>Hủy</th>
								</tr>

								<c:forEach var="saleOrder" items="${saleOrders }">

									<tr>
										<td id="code">${saleOrder.code}</td>
										<td><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss"
												value="${saleOrder.created_date}" /></td>
										<td>${saleOrder.customer_address}</td>
										<td><fmt:formatNumber value="${saleOrder.total}"
												type="number" groupingUsed="true" /> VND</td>
										<c:choose>
											<c:when test="${saleOrder.cancel }">
												<td>Đã hủy</td>
											</c:when>
											<c:when test="${!saleOrder.confirm&&!saleOrder.cancel }">
												<td id="confirm">Chờ xác nhận</td>
											</c:when>
											<c:when test="${saleOrder.confirm&&!saleOrder.is_delivery }">
												<td>Đang giao hàng</td>
											</c:when>
											<c:otherwise>
												<td>Đã giao hàng thành công</td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${saleOrder.confirm }">
												<td style="color: red; font-weight: bolder">Không thể
													hủy</td>
											</c:when>
											<c:when test="${saleOrder.cancel }">
												<td style="color: red; font-weight: bolder">Không thể
													hủy</td>
											</c:when>
											<c:otherwise>
												<td id="cancel">
													<p class="confirmation" id="after_cancel" style="text-decoration: none; color: red; font-weight: bolder; cursor: pointer">Hủy đơn</p>
												</td>
											</c:otherwise>
										</c:choose>


									</tr>
								</c:forEach>
							</table>
						</div>
					</c:otherwise>
				</c:choose>

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
			}, 2000)

		});

		function checkName() {

			var g = document.getElementById("full_name").value;

			if (g == null || g == "") {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được chứa kí tự đặc biệt và số!";
				return false;
			} else {
				document.getElementById("demo-name").innerHTML = "";
				document.getElementById("full_name").style.border = "1px solid #ced4da";

				return true;
			}
		}

		function checkAll() {
			if (checkName()) {
				alert("Update thông tin của bạn thành công");
				return true;
			} else {
				alert("Update thông tin của bạn không thành công. Vui lòng nhập đúng định dạng");
				return false;
			}
		}
		/* function saveRequest() {
			// javascript object.
			// data la du lieu ma day len action cua controller
			  let data = {
				id: jQuery("#a1").val(), // lay theo id
				full_name: jQuery("#full_name").val(), // lay theo id
				file: $('#input_file').prop('files'),

			};
			// file java đâu ô, chạy thử lại đi ô
			var form_data = new FormData();
			form_data.append('file', $('#input_file')[0].files[0]);
			form_data.append('id', $("#a1").val());
			form_data.append('full_name', $("#full_name").val());
			// để 2 id kìa ô
			// $ === jQuery
			// json == javascript object
			jQuery.ajax({
				url : "/request-ajax",
				type : "post",
				processData : false,
				contentType : false,
				data : form_data,
				// prevent jQuery from automatically transforming the data into a query string

				dataType : "json", // kieu du lieu tra ve tu controller la json
				success : function(jsonResult) {
					alert("Đã lưu yêu cầu của thành công !");
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback

				}
			});
		} */
	</script>
	<script type="text/javascript">
		function function1() {
			return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');
		}
		$(document).on("click", ".confirmation", function() {
			if (function1()) {
				var code = $(this).parents("tr").children("#code").text();

				var data = {
					code : code,
				};

				jQuery.ajax({
					url : "/cancel",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json", // kieu du lieu tra ve tu controller la json
					success : function(jsonResult) {
						alert(jsonResult.msg);
						window.location.reload();
					},
					error : function(jqXhr, textStatus, errorMessage) { // error callback

					}
				});
				/* $(this).parents("tr").children("#confirm").text(
						"Đã hủy");
				$(this).parents("tr").children("#cancel").children(
						"#after_cancel").text("Không thể hủy");
				$(this).parents("tr").children("#cancel").children(
						"#after_cancel").removeClass("confirmation"); */
			}

		});
	</script>
</body>
</html>