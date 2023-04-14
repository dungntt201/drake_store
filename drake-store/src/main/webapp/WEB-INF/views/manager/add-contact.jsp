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
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>${projectTitle }</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />

<!-- add  summernote editor  -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<link href="${base }/manager/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<style type="text/css">
#demo-phone,#demo-name,#demo-email {
	color: red;
}
</style>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-contact" method="get">
		<div class="input-group">
			<input name="keyword" class="form-control" type="text"
				placeholder="Search for..." aria-label="Search for..."
				aria-describedby="btnNavbarSearch" />
			<button class="btn btn-primary" id="btnNavbarSearch" type="submit">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
	<jsp:include page="/WEB-INF/views/manager/layout/navigation1.jsp"></jsp:include>

	<!-- menu -->
	<jsp:include page="/WEB-INF/views/manager/layout/menu.jsp"></jsp:include>

	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<!-- <h1 class="mt-4">Contacts</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Add contact</li>
                        </ol> -->
				<div class="container-fluid">
					<br>
					<c:if test="${not empty msg }">
						<p id="hideDiv" class="alert alert-success">${msg }</p>
					</c:if>
					<sf:form onsubmit="return send()" method="post"
						action="${base }/admin/add-contact" modelAttribute="contact"
						enctype="multipart/form-data">

						<sf:hidden path="id" />


						<br>
						<label for="full_name">Full name (required)</label>
						<sf:input path="full_name" type="text" class="form-control"
							id="full_name" placeholder="Full name" required="required" onkeyup="checkName()"/>

						<p style="margin: 0 0 20px 0" id="demo-name"></p>
						<label for="email">Email (required)</label>
						<sf:input path="email" type="email" class="form-control"
							id="email" placeholder="Email" required="required" onkeyup="checkEmRegister()" />

						<p style="margin: 0 0 20px 0" id="demo-email"></p>
						<label for="phone_number">Phone number (required)</label>
						<sf:input onkeyup="checkSDT()" path="phone_number" type="number"
							class="form-control" id="phone_number" min="0"
							placeholder="Phone number" required="required" />

						<p style="margin: 0 0 20px 0" id="demo-phone"></p>


						<label for="message">Message (required)</label>
						<sf:textarea path="message" autocomplete="off"
							class="form-control" id="message" placeholder="Message"
							required="required" />

						<%-- <br>
						<label for="created_Date">Created Date</label>
						<sf:input path="created_date" autocomplete="off" type="date"
							class="form-control" id="created_Date" disabled="true" />

						<br>
						<label for="updated_Date">Updated Date</label>
						<sf:input path="updated_date" autocomplete="off" type="date"
							class="form-control" id="updated_Date" disabled="true" />

						<br>
						<label for="created_By">Created By</label>
						<sf:input path="created_by" autocomplete="off" type="number"
							class="form-control" id="created_By" placeholder="Created By"
							disabled="true" />

						<br>
						<label for="updated_By">Updated By</label>
						<sf:input path="updated_by" autocomplete="off" type="number"
							class="form-control" id="updated_By" placeholder="Updated By"
							disabled="true" />

						--%>
						<br>
						<c:choose>
							<c:when test="${contact.id==null}">
								<sf:checkbox checked="checked" id="status" path="status" />
								<label for="status">Is Active Contact (Status) ?</label>
							</c:when>
							<c:otherwise>
								<sf:checkbox id="status" path="status" />
								<label for="status">Is Active Contact (Status) ?</label>
							</c:otherwise>
						</c:choose>



						<br>
						<br>
						<a href="${base }/admin/list-contact"
							class="btn btn-secondary active" role="button"
							aria-pressed="true">Back to List</a>
						<button type="submit" class="btn btn-primary">Save
							Contact</button>
					</sf:form>

				</div>
			</div>
		</main>

		<!--footer  -->
		<jsp:include page="/WEB-INF/views/manager/layout/footer.jsp"></jsp:include>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="${base }/manager/js/scripts.js"></script>

	<script type="text/javascript">
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
			}, 2000)

		})
		//set cho summernote editor
		$(document).ready(function() {
			$('#short_content').summernote({
				placeholder : 'Short content',
				tabsize : 2,
				height : 100
			});
			$('#content').summernote({
				placeholder : 'Content',
				tabsize : 2,
				height : 100
			});
			$('#haspid').click(function() {
				if ($(this).is(':checked')) {
					// khi thẻ đc disabled thì path sẽ k link đễn thuộc tính của entity
					$("#parentID").prop('disabled', false);
				} else {
					$("#parentID").prop('disabled', true);
				}
			});
		});
		
		function checkName() {

			var g = document.getElementById("full_name").value;

			if (g == null || g == "") {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được để trống trường này";
				return false;

			} else if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?0-9]+/.test(g)) {
				document.getElementById("full_name").style.border = "1px solid red";
				document.getElementById("demo-name").innerHTML = "Note: Không được chứa kí tự đặc biệt!";
				return false;
			} else {
				document.getElementById("demo-name").innerHTML = "";
				document.getElementById("full_name").style.border = "1px solid gray";
				return true;
			}
		}
		function checkSDT() {

			var g = document.getElementById("phone_number").value;
			var vnf_regex = /((09|03|07|08|05)+([0-9]{8})\b)/g;
			if (g == null || g == "") {
				document.getElementById("phone_number").style.border = "1px solid red";
				document.getElementById("demo-phone").innerHTML = "Note: Không được để trống trường này";
				return false;

			}

			if (g != null && g != "") {
				if (vnf_regex.test(g)) {
					document.getElementById("demo-phone").innerHTML = "";
					document.getElementById("phone_number").style.border = "1px solid gray";
					return true;
				} else {
					document.getElementById("phone_number").style.border = "1px solid red";
					document.getElementById("demo-phone").innerHTML = "Note: Số điện thoại không hợp lệ";
					return false;
				}
			}
		}
		function checkEmRegister() {
			/* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
			var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
			var g = document.getElementById("email").value;
			if (g == null || g == "") {
				document.getElementById("email").style.border = "1px solid red";
				document.getElementById("demo-email").innerHTML = "Note: Không được để trống trường này";
				return false;

			}
			if (g != null && g != "") {
				if (y3.test(g)) {
				document.getElementById("demo-email").innerHTML = "";
					document.getElementById("email").style.border = "1px solid gray";
					return true;
				} else {
					document.getElementById("email").style.border = "1px solid red";
					document.getElementById("demo-email").innerHTML = "Note: Lưu ý định dạng email.";
					return false;
				}
			}
			
		}
		function send() {

			if (checkSDT() == true && checkName() == true && checkEmRegister()) {
				return true;

			} else {
				alert("Bạn nhập sai định dạng . Vui lòng nhập lại !");
				return false;
			}
		}
	</script>
</body>
</html>
