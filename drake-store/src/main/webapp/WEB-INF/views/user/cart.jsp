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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/e9a6ecd83d.js"
	crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" href="${base }/user/css/cart.css">
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
			<p>Cart</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Cart</span>
		</div>
	</div>
	<div class="cart-view">
		<c:choose>
			<c:when test="${not empty msg1 }">
				<div class="message">
					<p>${msg1 }</p>
					<a href="${base }/shop">Tiếp tục mua hàng</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="table-responsive">
					<table class="table table-hover table-bordered table-condensed">
						<tr>
							<th>Tên sản phẩm</th>
							<th>Ảnh</th>
							<th>Size</th>
							<th>Số lượng</th>
							<th>Giá</th>
							<th>Thành tiền</th>
							<th>Xóa</th>
						</tr>
						<c:forEach var="cartItem" items="${cart.cartItems}">
							<tr class="sp">
								<td><p class="title">${cartItem.productName }</p> <input
									class="id" type="hidden" value="${cartItem.productId }">
								</td>
								<c:forEach var="product" items="${products }">
									<c:if test="${product.id==cartItem.productId }">
										<td><img alt="" src="${base }/upload/${product.avatar}"></td>
									</c:if>
								</c:forEach>
								<td><p class="size">${cartItem.size}</p></td>
								<td><input min="1" class="inputsl" type="number"
									name="quanlity" value="${cartItem.quanlity }"></td>
								<!-- onchange="editQuanlity(${cartItem.productId },this.value,${cartItem.size },${cartItem.priceUnit })"  -->
								<td><p class="price">
										<fmt:formatNumber value="${cartItem.priceUnit}" type="number"
											groupingUsed="true" />
									</p> <input type="hidden" value="${cartItem.priceUnit}"
									class="priceUnit"></td>
								<td><p class="totalMoney">
										<fmt:formatNumber
											value="${cartItem.quanlity*cartItem.priceUnit}" type="number"
											groupingUsed="true" />
									</p></td>
								<td><button class="del"
										style="color: red; border: none; outline: none"<%-- onclick="deleteItem(${cartItem.productId},${cartItem.size})" --%>>
										<i class="fas fa-trash-alt"></i>
									</button></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="cart2">
					<p
						style="font-weight: bolder; font-size: 18px; margin-bottom: 20px;">GIỎ
						HÀNG CỦA BẠN</p>
					<c:forEach var="cartItem" items="${cart.cartItems}">
						<div class="cart21">
							<c:forEach var="product" items="${products }">
								<c:if test="${product.id==cartItem.productId }">
									<td><img alt="" src="${base }/upload/${product.avatar}"></td>
								</c:if>
							</c:forEach>
							<div class="cart211">
								<p class="title">${cartItem.productName }</p>
								<p>
									Size: <span class="size">${cartItem.size }</span>
								</p>
								<input class="id" type="hidden" value="${cartItem.productId }">
								<p>
									Giá: <span class="price"><fmt:formatNumber
											value="${cartItem.priceUnit}" type="number"
											groupingUsed="true" /></span> VND
								</p>
								<input min="1" class="inputsl" type="number" name="quanlity"
									value="${cartItem.quanlity }"
									>
									<!-- onchange="editQuanlity1(${cartItem.productId },this.value,${cartItem.size },${cartItem.priceUnit })" -->
								<input type="hidden" value="${cartItem.priceUnit}"
									class="priceUnit">
								<button class="del"
									style="color: red; border: none; outline: none"<%-- onclick="deleteItem(${cartItem.productId},${cartItem.size})" --%>>
									<i class="fas fa-trash-alt"></i>
								</button>
							</div>
						</div>
					</c:forEach>
				</div>
				<p class="tien">
					Tổng tiền: <span class="tongtien"><fmt:formatNumber
							value="${totalPrice}" type="number" groupingUsed="true" /></span> VND
				</p>
				<br>
				<div class="control">
					<p style="text-align: right;">
						<a href="${base }/order/view"
							style="background-color: black; color: white;">Tiến hành đặt
							hàng</a>
					</p>
					<p class="child2" style="text-align: right;">
						<a href="${base }/shop"
							style="background-color: blue; color: white">Tiếp tục mua
							hàng</a>
					</p>
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
	
	$(document).ready(function(){
		$(".del").click(function(){
			return confirm('Bạn có chắc chắn muốn xoá sản phẩm khỏi giỏ hàng không?');
		}); 
	});
	
	//xóa sp khỏi cart trong table
	$(document).on('click', '.cart-view .table-responsive table tr td .del', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents("tr").children("td").children(".id").val();
        var size = $(this).parents("tr").children("td").children(".size").text();
         
        $(this).parents("tr").remove();
        
        // xóa ở cart mobile
        var b = $(".cart21");
		for(var i=0;i<b.length;i++){
			if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
				$(b[i]).remove();
			}
		}
		
		let data = {
				productId:productId,
				size:size,
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
				$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				$("#addcart").text(totalItems);
				$(".tongtien").text(new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				if(totalItems<=0){
					window.location.reload();
				}
				
			},
			error : function(jqXhr, textStatus, errorMessage) { // error callback 
				
			}
		});
	});
	
	//edit sl cua SP trong table
	$(document).on('change', '.cart-view .table-responsive table tr td .inputsl', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents("tr").children("td").children(".id").val();
        var size = $(this).parents("tr").children("td").children(".size").text();
        var quanlity = $(this).val();
        var priceUnit = $(this).parents("tr").children("td").children(".priceUnit").val();
        
		if(isNaN(parseInt(quanlity))||parseInt(quanlity)<=0){
			alert("Số lượng sản phẩm không hợp lệ! Vui lòng nhập lại.");
			var b = $(".cart21");
			for(var i=0;i<b.length;i++){
				if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
					$(this).val($(b[i]).children(".cart211").children(".inputsl").val());
				}
			}
			//alert($(this).text());
		}else{
			
			let data = {
					productId:productId,
					quanlity:quanlity,
					size:size,
					priceUnit:priceUnit,
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
					if(jsonResult.message==null){
						let totalItems = jsonResult.totalItems;
						let totalPrice = jsonResult.totalPrice;
						//alert(totalPrice);
						//es-ES :spainish
						$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#addcart").text(totalItems);
						$(".tongtien").text(new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						var a =$(".sp");
						//alert(a.length);
						for(var i=0;i<a.length;i++){
							if(parseInt($(a[i]).children("td").children(".id").val())==jsonResult.productId && $(a[i]).children("td").children(".size").text()==jsonResult.productSize){
								var total = parseFloat(jsonResult.productPrice) * parseFloat(jsonResult.productQuanlity);
								//alert(jsonResult.productPrice);
								//alert(jsonResult.productQuanlity);
								var a1 = new Intl.NumberFormat('es-ES', { }).format(total);
								$(a[i]).children("td").children(".totalMoney").text(a1);
							}
						}
						
						//suar cho cart2 thay doi tuong ung
						var b = $(".cart21");
						for(var i=0;i<b.length;i++){
							if(parseInt($(b[i]).children(".cart211").children(".id").val())==jsonResult.productId && $(b[i]).children(".cart211").children("p").children(".size").text()==jsonResult.productSize){
								$(b[i]).children(".cart211").children(".inputsl").val(jsonResult.productQuanlity);
							}
						}
					}
					else{
						alert(jsonResult.message);
						//sua lai sl giống ban đầu
						var b = $(".cart21");
						for(var i=0;i<b.length;i++){
							if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
								var sl = $(b[i]).children(".cart211").children(".inputsl").val();
								var a =$(".sp");
								for(var i=0;i<a.length;i++){
									if(parseInt($(a[i]).children("td").children(".id").val())==productId && $(a[i]).children("td").children(".size").text()==size){
										$(a[i]).children("td").children(".inputsl").val(sl);
									}
								}
							}
						}
					}
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 
					
				}
			});
			
				
		}
	});
	
	//xóa sp khỏi cart trong cart2
	$(document).on('click', '.cart-view .cart2 .cart21 .cart211 .del', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents(".cart211").children(".id").val();
        var size = $(this).parents(".cart211").children("p").children(".size").text();
       	
       $(this).parents(".cart21").remove();
       
    	// xóa ở cart PC
        var b = $(".sp");
		for(var i=0;i<b.length;i++){
			if(parseInt($(b[i]).children("td").children(".id").val())==productId && $(b[i]).children("td").children(".size").text()==size){
				$(b[i]).remove();
			}
		}
		
		let data = {
				productId:productId,
				size:size,
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
				$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				$("#addcart").text(totalItems);
				$(".tongtien").text(new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				if(totalItems<=0){
					window.location.reload();
				}
				
			},
			error : function(jqXhr, textStatus, errorMessage) { // error callback 
				
			}
		});
	});
	
	//edit sl cua SP trong cart2
	$(document).on('change', '.cart-view .cart2 .cart21 .cart211 .inputsl', function()  {
		
		// javascript object.
		// data la du lieu ma day len action cua controller
		
		var productId = $(this).parents(".cart211").children(".id").val();
        var size = $(this).parents(".cart211").children("p").children(".size").text();
        var quanlity = $(this).val();
        var priceUnit = $(this).parents(".cart211").children(".priceUnit").val();
        if(isNaN(parseInt(quanlity))||parseInt(quanlity)<=0){
			alert("Số lượng sản phẩm không hợp lệ! Vui lòng nhập lại.");
			var a =$(".sp");
			for(var i=0;i<a.length;i++){
				if(parseInt($(a[i]).children("td").children(".id").val())==productId && $(a[i]).children("td").children(".size").text()==size){
					$(this).val($(a[i]).children("td").children(".inputsl").val());
				}
			}
			//alert($(this).text());
		}else{
			let data = {
					productId:productId,
					quanlity:quanlity,
					size:size,
					priceUnit:priceUnit,
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
					if(jsonResult.message==null){
						let totalItems = jsonResult.totalItems;
						let totalPrice = jsonResult.totalPrice;
						//es-ES :spainish
						$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#addcart").text(totalItems);
						$(".tongtien").text(new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						
						var a =$(".sp");
						//alert(a.length);
						for(var i=0;i<a.length;i++){
							if(parseInt($(a[i]).children("td").children(".id").val())==jsonResult.productId && $(a[i]).children("td").children(".size").text()==jsonResult.productSize){
								
								$(a[i]).children("td").children(".inputsl").val(jsonResult.productQuanlity);
								var total = parseFloat(jsonResult.productPrice) * parseFloat(jsonResult.productQuanlity);
								var a1 = new Intl.NumberFormat('es-ES', { }).format(total);
								
								$(a[i]).children("td").children(".totalMoney").text(a1);
							}
						}
						
						//suar cho cart2 thay doi tuong ung
						/* var b = $(".cart21");
						for(var i=0;i<b.length;i++){
							if(parseInt($(b[i]).children(".cart211").children(".id").val())==jsonResult.productId && $(b[i]).children(".cart211").children("p").children(".size").text()==jsonResult.productSize){
								$(b[i]).children(".cart211").children(".inputsl").val(jsonResult.productQuanlity);
							}
						} */
					}
					else{
						alert(jsonResult.message);
						// sửa lại sl giống ban đầu
						var a =$(".sp");
						for(var i=0;i<a.length;i++){
							if(parseInt($(a[i]).children("td").children(".id").val())==productId && $(a[i]).children("td").children(".size").text()==size){
								var sl = $(a[i]).children("td").children(".inputsl").val();
								var b = $(".cart21");
								for(var i=0;i<b.length;i++){
									if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
										$(b[i]).children(".cart211").children(".inputsl").val(sl);
									}
								}
							}
						}
						
						
					}
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 
					
				}
			});
		}
	});
	</script>
</body>
</html>