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
<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
	crossorigin="anonymous"></script>
<style type="text/css">
#form1 p {
	color: red;
}

#form1 i {
	margin-left: 10px;
	width: 4%;
	height: 38px;
	padding: 10px;
	border: 1px solid #ced4da;
	border-radius: 5px;
	text-align: center;
}
</style>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-categories" method="get">
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
				<!-- <h1 class="mt-4">Accounts</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Add Account</li>
                        </ol> -->
				<br>
				<div class="container-fluid">

					<c:if test="${not empty msg }">
						<p id="hideDiv" class="alert alert-danger">${msg }</p>
					</c:if>
					<c:if test="${not empty msg1 }">
						<p id="hideDiv1" class="alert alert-success">${msg1 }</p>
					</c:if>
					<sf:form method="post" action="${base }/admin/account/add-account"
						modelAttribute="newUser" enctype="multipart/form-data"
						onsubmit="return register()" id="form1">

						<sf:hidden path="id" id="idAcc" />
						<input type="hidden" id="checkSocial" value="${SOCIAL }">
						<c:if test="${userLogined.id!=newUser.id }">
							<!-- nếu user muốn sửa kp user đang đăng nhập thì mới cho sửa role và hiện danh sách role -->
							<c:choose>
								<c:when test="${newUser.id==null || newUser.id<=0 }">
									<label for="role">Role (required)</label>
									<c:forEach items="${roles }" var="role">
										<input onchange="f1()" required="required"
											class="role-account" style="margin-left: 20px"
											type="checkbox" name="role" value="${role.name }">
										<label style="margin-left: 5px">${role.name }</label>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${SOCIAL==true }">
											<input type="hidden" name="role">
											<span style="color: red; font-weight: bolder;">(
												Current roles: <c:forEach var="role" items="${userRoles }">
			                 			${role.name }
			                 		</c:forEach>)
											</span>
										</c:when>
										<c:otherwise>

											<label for="role">Role (required)</label>
											<c:forEach items="${roles }" var="role">
												<input onchange="f1()" required="required"
													class="role-account" style="margin-left: 20px"
													type="checkbox" name="role" value="${role.name }">
												<label style="margin-left: 5px">${role.name }</label>
											</c:forEach>
											<br>
											<span style="color: red; font-weight: bolder;">(Current
												roles: <c:forEach var="role" items="${userRoles }">
						                 			${role.name }, 
						                 		</c:forEach> )
											</span>
											<br>
										</c:otherwise>
									</c:choose>

								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${userLogined.id==newUser.id }">
							<input type="hidden" name="role">
							<span style="color: red; font-weight: bolder;">( Current
								roles: <c:forEach var="role" items="${userRoles }">
		                 			${role.name }
		                 		</c:forEach>)
							</span>
						</c:if>
						<br>
						<label for="full_name">Full name (required)</label>
						<sf:input path="full_name" type="text" class="form-control"
							id="full_name" placeholder="Full name" onkeyup="checkName()"
							required="required" />

						<p id="demo-name"></p>


						<c:if test="${SOCIAL!=true }">
							<label for="username">Username (required)</label>
							<sf:input path="username" onkeyup="checkUsnRegister()"
								type="text" class="form-control" id="username"
								placeholder="Username" required="required" />
							<p id="demo3"></p>
							<label for="password">Password (required)</label>
							<div style="display: flex">
								<sf:input path="password" onkeyup="checkPwRegister()"
									autocomplete="off" type="password" class="form-control"
									id="password" placeholder="Password" required="required" />
								<i class="fas fa-eye" onclick="hide1()"></i>
							</div>
							<p id="demo5"></p>
							<label for="email">Email (required)</label>
							<sf:input type="email" path="email" onkeyup="checkEmRegister()"
								class="form-control" id="email" placeholder="Email"
								required="required" />
							<p id="demo4"></p>
						</c:if>
						<c:if test="${SOCIAL==true }">
							<label for="username">Username (required)</label>
							<sf:input path="username" onkeyup="checkUsnRegister()"
								type="text" class="form-control" id="username"
								placeholder="Username" disabled="true" />
							<p id="demo3"></p>
							<label for="password">Password (required)</label>
							<div style="display: flex">
								<sf:input path="password" onkeyup="checkPwRegister()"
									autocomplete="off" type="password" class="form-control"
									id="password" placeholder="Password" disabled="true" />
								<i class="fas fa-eye" onclick="hide1()"></i>
							</div>
							<p id="demo5"></p>
							<label for="email">Email (required)</label>
							<sf:input type="email" path="email" onkeyup="checkEmRegister()"
								class="form-control" id="email" placeholder="Email"
								disabled="true" />
							<p id="demo4"></p>
							<sf:input type="hidden" path="username"/>
							<sf:input type="hidden" path="password"/>
							<sf:input type="hidden" path="email"/>
						</c:if>






						<c:choose>
							<c:when test="${newUser.id==null}">
								<label for="provider">Provider</label>
								<sf:input path="provider" autocomplete="off" type="text"
									class="form-control" value="LOCAL" id="provider"
									placeholder="Provider" disabled="true" />
							</c:when>
							<c:otherwise>
								<label for="provider">Provider</label>
								<sf:input path="provider" autocomplete="off" type="text"
									class="form-control" id="provider" placeholder="Provider"
									disabled="true" />
							</c:otherwise>
						</c:choose>

						<%--<br>
						<label for="created_Date">Created Date</label>
						<sf:input path="created_date" autocomplete="off" type="text"
							class="form-control" id="created_Date" placeholder="Created Date"
							disabled="true" />

						<br>
						<label for="updated_Date">Updated Date</label>
						<sf:input path="updated_date" autocomplete="off" type="date"
							class="form-control" id="updated_Date" placeholder="Updated Date"
							disabled="true" />

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





						<br>
                   	 	<sf:checkbox id="isHot" path="is_hot"/>
                   		<label for="isHot">Is hot Product ?</label> --%>

						<br>
						<c:choose>
							<c:when test="${newUser.id==null}">
								<sf:checkbox checked="checked" id="status" path="status" />
								<label for="status">Is Active Account (Status) ?</label>
							</c:when>
							<c:otherwise>
								<sf:checkbox id="status" path="status" />
								<label for="status">Is Active Account (Status) ?</label>
							</c:otherwise>
						</c:choose>

						<br>
						<label for="userAvatar">Avatar</label>
						<input id="userAvatar" name="userAvatar" type="file"
							class="form-control-file">


						<!--<br>
                   		<label for="fileProductPictures">Picture (Multiple)</label>
                   		<input id="fileProductPictures" name="productPictures" type="file" class="form-control-file" multiple="multiple">              			
                   		  -->
						<br>
						<br>
						<a href="${base }/admin/account/list-accounts"
							class="btn btn-secondary active" role="button"
							aria-pressed="true">Back to List</a>
						<button type="submit" class="btn btn-primary" onclick="f1()">Save
							Account</button>
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
	<script src="${base }/manager/js/menu.js"></script>

	<script type="text/javascript">
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
				$("#hideDiv1").slideUp(500);
			}, 2000)

		})
		//set cho summernote editor
		$(document).ready(function() {
			$('#description').summernote({
				placeholder : 'Details Description',
				tabsize : 2,
				height : 100
			});
			$('#haspid').click(function() {
				if ($(this).is(':checked')) {
					// khi thẻ đc disabled thì path sẽ k link đễn thuộc tính của entity
					$("#parentID").prop('disabled', true);
				} else {
					$("#parentID").prop('disabled', false);
				}
			});
		});

		//check required for role
		function f1() {
			var roles = $(".role-account");
			//alert(roles.length);
			/* for(var i=0;i<roles.length;i++){
				
			} */
			if (roles.is(':checked')) {
				roles.removeAttr('required');
			} else {
				roles.attr('required', 'required');
			}
		}

		//ẩn hiện password register
		var i = true;
		function hide1() {
			if (i) {
				document.getElementById("password").type = "text";
				i = false;
			} else {
				document.getElementById("password").type = "password";
				i = true;
			}
		}

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
		function checkUsnRegister() {
			var us = document.getElementById("username").value;
			var y = /[a-zA-Z0-9]$/;
			var y1 = /[a-zA-Z]$/;
			var x = 0;
			for (var i = 1; i <= us.length - 1; i++) {
				if (y.test(us.charAt(i))) {
					x += 1;
				} else {
					break;
				}
			}
			if (us.length >= 8 && x == (us.length - 1) && y1.test(us.charAt(0))
					&& (y1.test(us.charAt(0)))) {
				document.getElementById("demo3").innerHTML = "";
				document.getElementById("username").style.border = "1px solid #ced4da";
				return true;
			} else {
				document.getElementById("demo3").innerHTML = "Note:Username >=8 kí tự. Kí tự đầu phải là chữ và không được nhập kí tự đặc biệt và kí tự tiếng việt có dấu.";
				document.getElementById("username").value = us;
				document.getElementById("username").style.border = "1px solid red";
				return false;
			}

		}
		function checkEmRegister() {
			/* //var y3 = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;//chuẩn của me*/
			var y3 = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;//chuẩn w3source
			var g = document.getElementById("email").value;
			if (y3.test(g)) {
				document.getElementById("demo4").innerHTML = "";
				document.getElementById("email").style.border = "1px solid #ced4da";
				return true;
			} else {
				document.getElementById("email").style.border = "1px solid red";
				document.getElementById("demo4").innerHTML = "Note: Lưu ý định dạng email. Vui lòng nhập đúng email nếu sai bạn sẽ không nhận được email reset mật khẩu nếu bạn mất .";
				return false;
			}
		}
		function checkPwRegister() {
			var pw = document.getElementById("password").value;
			var y = /[0-9]$/;
			var y1 = /[a-z]$/;
			var y2 = /[A-Z]$/;
			var i0 = 0;
			var i1 = 0;
			var i2 = 0;
			var i3 = 0;
			// check kí tự đặc biệt
			if (/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?]+/.test(pw)) {
				i0 = 1;

			} else {
				i0 = 0;
			}
			//check ksi tự thường
			for (var i = 0; i <= pw.length - 1; i++) {
				if (y1.test(pw.charAt(i))) {
					//alert(true);
					i1 = 1;
					break;
				} else {
					i1 = 0;
				}
			}

			// check kí tự in hoa

			for (var i = 0; i <= pw.length - 1; i++) {
				if (y2.test(pw.charAt(i))) {
					//alert(true);
					i2 = 1;
					break;
				} else {
					i2 = 0;
				}
			}

			// check kí tư TV có dấu
			for (var i = 0; i <= pw.length - 1; i++) {
				if (!y2.test(pw.charAt(i))
						&& !y1.test(pw.charAt(i))
						&& !y.test(pw.charAt(i))
						&& !/[!@#$%^&*()_+\-=\[\]{};':'\\|,.<>\/?]+/.test(pw
								.charAt(i))) {
					//alert(true);
					i3 = 1;
					break;
				} else {
					i3 = 0;
				}
			}

			//alert("i0="+i0+"i1="+i1+"i2="+i2+"i3=");
			if (pw.length >= 8 && i0 == 1 && i1 == 1 && i2 == 1 && i3 == 0) {
				document.getElementById("password").style.border = "1px solid #ced4da";
				document.getElementById("demo5").innerHTML = "";
				return true;
			} else {
				document.getElementById("password").style.border = "1px solid red";
				document.getElementById("demo5").innerHTML = "Note: Mật khẩu >=8 kí tự và phải có ít nhất 1 kí tự thường, 1 kí tự in hoa, 1 kí tự đặc biệt và không chứa kí tự tiếng việt có dấu";
				return false;
			}
		}
		function register() {
			var g = document.getElementById("checkSocial").value;
			if (g == "true") {
				if (checkName() == true) {
					return true;
				} else {
					alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
					return false;
				}
			} else {
				if (checkPwRegister() == true && checkUsnRegister() == true
						&& checkEmRegister() == true && checkName() == true) {
					return true;
				} else {
					alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
					return false;
				}
			}

		}
		function checkAllSocial() {
			if (checkName() == true) {
				return true;
			} else {
				alert("Bạn nhập sai định dạng yêu cầu. Vui lòng nhập lại !");
				return false;
			}
		}
	</script>
</body>
</html>
