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
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-product-sizes" method="get">
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
				<!-- <h1 class="mt-4">Product Sizes</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Add Product Sizes</li>
                        </ol> -->


				<div class="container-fluid">
					<br>
					<br>
					<c:if test="${not empty msg }">
						<p id="hideDiv" class="alert alert-success">${msg }</p>
					</c:if>
					<c:if test="${not empty err }">
						<p id="hideDiv" class="alert alert-danger">${err }</p>
					</c:if>

					<sf:form method="post" action="${base }/admin/add-product-sizes"
						modelAttribute="productSize" enctype="multipart/form-data">

						<sf:hidden path="id" />




						<label for="category">Product ID</label>
						<sf:select path="products2.id" id="parentID" class="form-control"
							disabled="false">
							<sf:options items="${products }" itemValue="id" itemLabel="title" />
						</sf:select>

						<br>
						<label for="size">Size (required)</label>
						<br>

						<input type="checkbox" id="haspid" name="haspid"
							class="form-check-input" style="margin-left: 0px" />
						<label class="form-check-lable" for="haspid"
							style="margin-left: 25px; color: red; font-weight: bolder">Click
							if you want to add available sizes ?</label>
						<br>
						<sf:select path="size" class="form-control" disabled="true"
							id="sizes">
							<sf:options items="${sizes }" />
						</sf:select>
						<br>

						<sf:input disabled="false" path="size" type="text"
							class="form-control" id="size" placeholder="Size"
							required="required" />

						<br>
						<label for="remaining">Remaining (required)</label>
						<sf:input path="remaining" type="number" class="form-control"
							id="remaining" placeholder="Remaining" required="required" />

						<br>

						<%-- 	<label for="created_Date">Created Date</label>
						<sf:input disabled="true" path="created_date" autocomplete="off"
							type="date" class="form-control" id="created_Date" />

						<br>
						<label for="updated_Date">Updated Date</label>
						<sf:input disabled="true" path="updated_date" autocomplete="off"
							type="date" class="form-control" id="updated_Date" />

						<br>
						<label for="created_By">Created By</label>
						<sf:input disabled="true" path="created_by" autocomplete="off"
							type="number" class="form-control" id="created_By"
							placeholder="Created By" />

						<br>
						<label for="updated_By">Updated By</label>
						<sf:input disabled="true" path="updated_by" autocomplete="off"
							type="number" class="form-control" id="updated_By"
							placeholder="Updated By" /> --%>

						<c:choose>
							<c:when test="${product.id==null}">
								<sf:checkbox checked="checked" id="status" path="status" />
								<label for="status">Is Active Product Size (Status) ?</label>
							</c:when>
							<c:otherwise>
								<sf:checkbox id="status" path="status" />
								<label for="status">Is Active Product Size (Status) ?</label>
							</c:otherwise>
						</c:choose>

						<br>
						<br>
						<a href="${base }/admin/list-product-sizes"
							class="btn btn-secondary active" role="button"
							aria-pressed="true">Back to List</a>
						<button type="submit" class="btn btn-primary">Save
							Product Sizes</button>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
	<script type="text/javascript">
		$(function() {
			setTimeout(function() {
				$("#hideDiv").slideUp(500);
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
					$("#sizes").prop('disabled', false);
					$("#size").prop('disabled', true);
				} else {
					$("#sizes").prop('disabled', true);
					$("#size").prop('disabled', false);
				}
			});
		});
	</script>
</body>
</html>
