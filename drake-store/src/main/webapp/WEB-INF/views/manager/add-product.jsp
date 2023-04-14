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
<script type="text/javascript">
	function checkPriceSale() {
		var g = document.getElementById("priceSale").value;
		var g1 = document.getElementById("price").value;
		if (g != null && g1 != null) {
			if (parseFloat(g) > parseFloat(g1)) {
				alert("Warning: Price Sale phải <= Price!");
				//document.getElementById("priceSale").value = null;
				document.getElementById("priceSale").focus();
				return false;
			} else {
				return true;
			}
		}
	}

	/* function checkDescription() {
		var g = $($('#details_description').summernote('code')).text();
		if (g != null && g != '' && g != undefined && g.length > 0) {
			//alert(g.length);
			return true;
		} else {
			alert("Warning: Không được để trống Details Description!");
			$('#details_description').summernote({
				focus : true
			});
			return false;
		}
	} */ //tạm thời k dùng summer note nữa && checkDescription()

	function checkAll() {
		if (checkPriceSale()) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body class="sb-nav-fixed">
	<!-- navigation  -->
	<jsp:include page="/WEB-INF/views/manager/layout/navigation.jsp"></jsp:include>
	<form
		class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
		action="${base }/admin/list-products" method="get">
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
				<!--  <h1 class="mt-4">Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Add product</li>
                        </ol> -->
				<div class="container-fluid">
					<br>
					<c:if test="${not empty msg }">
						<p id="hideDiv" class="alert alert-success">${msg }</p>
					</c:if>
					<sf:form method="post" action="${base }/admin/add-products"
						modelAttribute="product" enctype="multipart/form-data"
						onsubmit="return checkAll()">

						<sf:hidden path="id" />

						<c:choose>
							<c:when test="${product.categories!=null }">
								<br>
								<input type="checkbox" id="haspid" name="haspid"
									class="form-check-input" style="margin-left: 0px" />
								<label class="form-check-lable" for="haspid"
									style="margin-left: 25px; color: red; font-weight: bolder">Click
									if your product is not in a categories</label>
								<br>

								<label for="category">Category</label>
								<sf:select path="categories.id" id="parentID"
									class="form-control" disabled="false">
									<sf:options items="${categories }" itemValue="id"
										itemLabel="name" />
								</sf:select>

								<br>
							</c:when>
							<c:otherwise>
								<br>
								<input type="checkbox" checked="checked" id="haspid"
									name="haspid" class="form-check-input" style="margin-left: 0px" />
								<label class="form-check-lable" for="haspid"
									style="margin-left: 25px; color: red; font-weight: bolder">Click
									if your product is not in a categories</label>
								<br>

								<label for="category">Category</label>
								<sf:select path="categories.id" id="parentID"
									class="form-control" disabled="true">
									<sf:options items="${categories }" itemValue="id"
										itemLabel="name" />
								</sf:select>

								<br>
							</c:otherwise>
						</c:choose>


						<label for="title">Title (required)</label>
						<sf:input path="title" autocomplete="off" type="text"
							class="form-control" id="title" placeholder="Title"
							required="required" />

						<br>
						<label for="price">Price (required)</label>
						<sf:input path="price" autocomplete="off" type="number"
							class="form-control" id="price" placeholder="Price"
							required="required" min="0" />

						<br>
						<label for="priceSale">Price Sale </label>
						<sf:input path="price_sale" autocomplete="off" type="number"
							class="form-control" id="priceSale" placeholder="Price Sale"
							min="0" onchange="checkPriceSale()" />

						<%-- <br>
                   		<label for="short_description">Short Description (required)</label>
                   		<sf:textarea path="short_description" autocomplete="off" class="form-control" id="short_description" placeholder="Short_description" required="required"/>
                   		 --%>
						<br>
						<label for="details_description">Details Description
							(required)</label>
						<sf:textarea path="details" autocomplete="off"
							class="form-control" id="details_description"
							placeholder="Description" required="required" />
						<%-- 
                   		<br>
                   		<label for="seo">Seo</label>
                   		<sf:textarea path="seo" autocomplete="off" class="form-control" id="seo" placeholder="Seo" disabled="true" />
                   		
                   		<br>
                   		<label for="created_Date">Created Date</label>
                   		<sf:input path="created_date" autocomplete="off" type="date" class="form-control" id="created_Date" disabled="true" />
                   	 	
                   	 	<br>
                   		<label for="updated_Date">Updated Date</label>
                   		<sf:input path="updated_date" autocomplete="off" type="date" class="form-control" id="updated_Date"  disabled="true"/>
                   	 	
                   	 	<br>
                   		<label for="created_By">Created By</label>
                   		<sf:input path="created_by" autocomplete="off" type="number" class="form-control" id="created_By" placeholder="Created By" disabled="true"/>
                   	 	
                   	 	<br>
                   		<label for="updated_By">Updated By</label>
                   		<sf:input path="updated_by" autocomplete="off" type="number" class="form-control" id="updated_By" placeholder="Updated By" disabled="true"/>
                   	 	 --%>
						<br>
						<sf:checkbox id="isHot" path="is_hot" />
						<label for="isHot">Is hot Product ?</label>

						<br>
						<c:choose>
							<c:when test="${product.id==null}">
								<sf:checkbox checked="checked" id="status" path="status" />
								<label for="status">Is Active Product (Status) ?</label>
							</c:when>
							<c:otherwise>
								<sf:checkbox id="status" path="status" />
								<label for="status">Is Active Product (Status) ?</label>
							</c:otherwise>
						</c:choose>
						<br>
						<c:choose>
							<c:when test="${product.id!=null }">
								<br>
								<label for="fileProductAvatar">Avatar</label>
								<input accept="image/*" id="fileProductAvavtar"
									name="productAvatar" type="file" class="form-control-file">
							</c:when>
							<c:otherwise>
								<br>
								<label for="fileProductAvatar">Avatar (required)</label>
								<input accept="image/*" id="fileProductAvavtar"
									name="productAvatar" type="file" class="form-control-file"
									required="required">
							</c:otherwise>
						</c:choose>


						<br>
						<label for="fileProductPictures">Picture (Multiple)</label>
						<input accept="image/*" id="fileProductPictures"
							name="productPictures" type="file" class="form-control-file"
							multiple="multiple">

						<br>
						<br>
						<a href="${base }/admin/list-products"
							class="btn btn-secondary active" role="button"
							aria-pressed="true">Back to List</a>
						<button type="submit" class="btn btn-primary">Save
							Product</button>
					</sf:form>
					<!-- onclick="checkDescription()" -->

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
			/* $('#details_description').summernote({
				placeholder : 'Details Description',
				tabsize : 2,
				height : 100
			}); */
			$('#haspid').click(function() {
				if ($(this).is(':checked')) {
					// khi thẻ đc disabled thì path sẽ k link đễn thuộc tính của entity
					$("#parentID").prop('disabled', true);
				} else {
					$("#parentID").prop('disabled', false);
				}
			});
		});
	</script>
</body>
</html>
