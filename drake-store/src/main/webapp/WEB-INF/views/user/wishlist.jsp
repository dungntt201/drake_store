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
<link rel="stylesheet" href="${base }/user/css/wishlist.css">
<link rel="stylesheet" href="${base}/user/css/call_button.css">
<script type="text/javascript"
	src="https://sites.google.com/site/iristipsblogger/file/hoamai-hoadao.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/user/layout/call_button.jsp"></jsp:include>
	<div class="show_cart" id="sc">
		<button type="button" id="close-button" onclick="CloseCart()">
			<i class="fas fa-times-circle"></i>
		</button>
		<p class="cart">Cart Items</p>
		<div class="cart-products">
			<%-- <div class="cart-products1">
                <div class="img-pro-cart">
                    <img src="${base}/user/Images/IMAGE2/p_2-150x150.jpg" alt="">
                </div>
                <div class="info-pro-cart">
                    <p class="pro-name">Mens Tshirts (<span>size</span> )</p>
                    <p><span class ="sl">1</span> x <span class="pro-price">$27.00</span><i style="float:right" class="fas fa-trash-alt delete"></i></p>
                </div>
                
            </div> --%>
		</div>
		<div class="total-money">
			<p>
				Subtotal: <span id="t-m">$00.00</span>
			</p>
			<div class="view-cart">
				<a href="${base }/cart/view" class="buttonn">View cart</a> <a
					href="${base }/order/view" class="buttonn">Checkout</a>
			</div>
		</div>
	</div>
	<div class="banner">
		<div class="banner-content">
			<p>Wishlist</p>
			<a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><span>Wishlist</span>
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
							<th>Tình trạng</th>
							<th>Mua</th>
							<th>Xóa</th>
						</tr>
						<c:forEach var="cartItem" items="${wishlist.cartItems}">
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
								<td><input min="1" class="inputsl" type="number" value="1"
									name="quanlity"></td>
								<td><p class="price">
										<fmt:formatNumber value="${cartItem.priceUnit}" type="number"
											groupingUsed="true" />
									</p></td>
								<c:forEach var="productSize" items="${productSizes }">
									<c:if
										test="${productSize.products2.id==cartItem.productId && productSize.size==cartItem.size }">
										<c:if test="${productSize.remaining>=1 }">
											<td><p class="remaining">Còn hàng</p></td>
											<td><button class="cart-plus"
													style="color: blue; border: none; outline: none">
													<i class="fas fa-cart-plus"></i>
												</button></td>
										</c:if>
										<c:if test="${productSize.remaining<1 }">
											<td><p class="remaining">Hết hàng</p></td>
											<td><button class="cart-plus" disabled="disabled"
													style="color: blue; border: none; outline: none">
													<i class="fas fa-cart-plus"></i>
												</button></td>
										</c:if>
									</c:if>

								</c:forEach>
								<td><button class="del"
										style="color: red; border: none; outline: none">
										<i class="fas fa-trash-alt"></i>
									</button></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="cart2">
					<p
						style="font-weight: bolder; font-size: 18px; margin-bottom: 20px;">DANH
						SÁCH SẢN PHẨM YÊU THÍCH</p>
					<c:forEach var="cartItem" items="${wishlist.cartItems}">
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
								<c:forEach var="productSize" items="${productSizes }">
									<c:if
										test="${productSize.products2.id==cartItem.productId && productSize.size==cartItem.size }">
										<c:if test="${productSize.remaining>=1 }">
											<p class="remaining">Tình trạng: Còn hàng</p>
											<button class="cart-plus"
												style="color: blue; border: none; outline: none">
												<i class="fas fa-cart-plus"></i>
											</button>
										</c:if>
										<c:if test="${productSize.remaining<1 }">
											<p class="remaining">Tình trạng: Hết hàng</p>
											<button class="cart-plus" disabled="disabled"
												style="color: blue; border: none; outline: none">
												<i class="fas fa-cart-plus"></i>
											</button>
										</c:if>
									</c:if>
								</c:forEach>
								<input min="1" class="inputsl" type="number" name="quanlity"
									value="1"
									onchange="editQuanlity1(${cartItem.productId },this.value,${cartItem.size },${cartItem.priceUnit })">
								<button class="del"
									style="color: red; border: none; outline: none"<%-- onclick="deleteItem(${cartItem.productId},${cartItem.size})" --%>>
									<i class="fas fa-trash-alt"></i>
								</button>
							</div>
						</div>
					</c:forEach>
				</div>
				<br>
				<div class="control">
					<p style="text-align: right;">
						<a href="${base }/shop"
							style="background-color: blue; color: white;">Tiếp tục mua
							hàng</a>
					</p>
					<p class="child2" style="text-align: right;">
						<a href="${base }/cart/view"
							style="background-color: black; color: white;">Chuyển đến giỏ
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
			return confirm('Bạn có chắc chắn muốn xóa sản phẩm khỏi wishlist không?');
		}); 
		
	});
	
	
	//xóa wishlist trong table
	$(document).on('click', '.cart-view .table-responsive table tr td .del', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents("tr").children("td").children(".id").val();
        var size = $(this).parents("tr").children("td").children(".size").text();
         
        $(this).parents("tr").remove();
         
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
			url : "/wishlist/delete",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json", // kieu du lieu tra ve tu controller la json
			success : function(jsonResult) {
				//alert("Đã lưu yêu cầu của " + " thành công !");
				let totalItems1 = jsonResult.totalItems1;
				$("#love").text(totalItems1);
				//window.location.reload();
				if(totalItems1<=0){
					window.location.reload();
				}
			},
			error : function(jqXhr, textStatus, errorMessage) { // error callback 
				
			}
		});
	});
	
	//add cart của wishlist tương ứng trong table
	$(document).on('click', '.cart-view .table-responsive table tr td .cart-plus', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents("tr").children("td").children(".id").val();
        var size = $(this).parents("tr").children("td").children(".size").text();
        var quanlity = $(this).parents("tr").children("td").children(".inputsl").val();
        
        if(isNaN(parseInt(quanlity))||parseInt(quanlity)<=0){
			alert("Số lượng sản phẩm không hợp lệ! Vui lòng nhập lại.");
			$(this).parents("tr").children("td").children(".inputsl").val("1");
			//alert($(this).text());
		}else{
			let data = {
				//txtEmail: jQuery("#txtEmail").val(), // lay theo id
				//pw: ("#input-pw").val(), // lay theo id
					size:size,
					productId:productId,
					quanlity:quanlity,
			};
			
			// $ === jQuery
			// json == javascript object
			jQuery.ajax({
				url : "/cart/add",
				type : "post",
				//enctype: 'multipart/form-data',
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", // kieu du lieu tra ve tu controller la json
				success : function(jsonResult) {
					if(jsonResult.message==null){
						let a ="";
						let totalItems = jsonResult.totalItems;
						let totalPrice = jsonResult.totalPrice;
						$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#addcart").text(totalItems);
						//bắt buộc suyệt từ 0
						for(var i = 0;i<jsonResult.cart.length;i++){
							
							 a+="<div class='cart-products1'>"
							 	+"<input type='hidden' value=\""+jsonResult.cart[i].productId+"\">"
				                +"<div class='img-pro-cart'>"
				                
			                    +"<img src=\"${base}/upload/" + jsonResult.cart[i].productAvatar + "\" alt=''>"
			                	+"</div>"
			                	+"<div class='info-pro-cart'>"
			                    +"<p class='pro-name'>"+jsonResult.cart[i].productName+" (<span>"+jsonResult.cart[i].size+"</span> )</p>"
			                    +"<p><span class ='sl'>"+jsonResult.cart[i].quanlity+"</span> x <span class='pro-price'>"+new Intl.NumberFormat('es-ES', { maximumSignificantDigits: 3 }).format(jsonResult.cart[i].priceUnit)+"</span><i style='float:right' class='fas fa-trash-alt delete'></i></p>"
			                	+"</div>"
			                	//+"<i class='fas fa-trash-alt delete'></i>"
			            		+"</div>";	
			            		
						}
						$(".show_cart .cart-products").html(a);
						$("#t-m").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#sc").css("transform","translateX(0%)");
						var b = $(".sp");
				 		for(var i=0;i<b.length;i++){
				 			if(parseInt($(b[i]).children("td").children(".id").val())==productId && $(b[i]).children("td").children(".size").text()==size){
				 				$(b[i]).children("td").children(".inputsl").val("1");
				 			}
				 		}
						
					}
					else{
						alert(jsonResult.message);
						var b = $(".sp");
				 		for(var i=0;i<b.length;i++){
				 			if(parseInt($(b[i]).children("td").children(".id").val())==productId && $(b[i]).children("td").children(".size").text()==size){
				 				$(b[i]).children("td").children(".inputsl").val("1");
				 			}
				 		}
					}
					
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 
					
				}
			});
		}
	});
	
	//xóa wishlist trong cart2
	$(document).on('click', '.cart-view .cart2 .cart21 .cart211 .del', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents(".cart211").children(".id").val();
        var size = $(this).parents(".cart211").children("p").children(".size").text();
         

        $(this).parents(".cart21").remove();
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
			url : "/wishlist/delete",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json", // kieu du lieu tra ve tu controller la json
			success : function(jsonResult) {
				//alert("Đã lưu yêu cầu của " + " thành công !");
				let totalItems1 = jsonResult.totalItems1;
				$("#love").text(totalItems1);
				if(totalItems1<=0){
					window.location.reload();
				}
				//window.location.reload();
			},
			error : function(jqXhr, textStatus, errorMessage) { // error callback 
				
			}
		}); 
	});
	
	//add cart của wishlist tương ứng trong cart2
	$(document).on('click', '.cart-view .cart2 .cart21 .cart211 .cart-plus', function() {
		// javascript object.
		// data la du lieu ma day len action cua controller
		var productId = $(this).parents(".cart211").children(".id").val();
        var size = $(this).parents(".cart211").children("p").children(".size").text();
        var quanlity = $(this).parents(".cart211").children(".inputsl").val();
        if(isNaN(parseInt(quanlity))||parseInt(quanlity)<=0){
			alert("Số lượng sản phẩm không hợp lệ! Vui lòng nhập lại.");
			$(this).parents(".cart211").children(".inputsl").val("1");
			//alert($(this).text());
		}else{
			let data = {
				//txtEmail: jQuery("#txtEmail").val(), // lay theo id
				//pw: ("#input-pw").val(), // lay theo id
					size:size,
					productId:productId,
					quanlity:quanlity,
			};
			
			// $ === jQuery
			// json == javascript object
			jQuery.ajax({
				url : "/cart/add",
				type : "post",
				//enctype: 'multipart/form-data',
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", // kieu du lieu tra ve tu controller la json
				success : function(jsonResult) {
					if(jsonResult.message==null){
						let a ="";
						let totalItems = jsonResult.totalItems;
						let totalPrice = jsonResult.totalPrice;
						$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#addcart").text(totalItems);
						//bắt buộc suyệt từ 0
						for(var i = 0;i<jsonResult.cart.length;i++){
							
							 a+="<div class='cart-products1'>"
							 	+"<input type='hidden' value=\""+jsonResult.cart[i].productId+"\">"
				                +"<div class='img-pro-cart'>"
				                
			                    +"<img src=\"${base}/upload/" + jsonResult.cart[i].productAvatar + "\" alt=''>"
			                	+"</div>"
			                	+"<div class='info-pro-cart'>"
			                    +"<p class='pro-name'>"+jsonResult.cart[i].productName+" (<span>"+jsonResult.cart[i].size+"</span> )</p>"
			                    +"<p><span class ='sl'>"+jsonResult.cart[i].quanlity+"</span> x <span class='pro-price'>"+new Intl.NumberFormat('es-ES', { maximumSignificantDigits: 3 }).format(jsonResult.cart[i].priceUnit)+"</span><i style='float:right' class='fas fa-trash-alt delete'></i></p>"
			                	+"</div>"
			                	//+"<i class='fas fa-trash-alt delete'></i>"
			            		+"</div>";	
			            		
						}
						$(".show_cart .cart-products").html(a);
						$("#t-m").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
						$("#sc").css("transform","translateX(0%)");
						
						var b = $(".cart21");
						for(var i=0;i<b.length;i++){
							if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
								$(b[i]).children(".cart211").children(".inputsl").val("1");
							}
						}
					}
					else{
						alert(jsonResult.message);
						var b = $(".cart21");
						for(var i=0;i<b.length;i++){
							if(parseInt($(b[i]).children(".cart211").children(".id").val())==productId && $(b[i]).children(".cart211").children("p").children(".size").text()==size){
								$(b[i]).children(".cart211").children(".inputsl").val("1");
							}
						}
					}
					
				},
				error : function(jqXhr, textStatus, errorMessage) { // error callback 
					
				}
			});
		}
	});
	
	//xóa sp trong democart
	$(document).on('click', '.show_cart .cart-products .cart-products1 .info-pro-cart p i', function(){
        var productId = $(this).parents(".cart-products1").children("input").val();
        var size = $(this).parents(".info-pro-cart").children(".pro-name").children("span").text();
        var quanlity = $(this).parents(".info-pro-cart").children("p").children(".sl").text();
     	// javascript object.
		// data la du lieu ma day len action cua controller
		$(this).parents(".cart-products1").remove();
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
				/* let totalItems = jsonResult.totalItems;
				let totalPrice = jsonResult.totalPrice;
				$("#money").text("$"+new Intl.NumberFormat('ja-JP', {  }).format(totalPrice));
				$("#addcart").text(totalItems);
				$(".tongtien").text("$"+totalPrice+".00");
				$("#t-m").text("$"+new Intl.NumberFormat('ja-JP', {  }).format(totalPrice)); */
				let totalItems = jsonResult.totalItems;
				let totalPrice = jsonResult.totalPrice;
				$("#money").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				$("#addcart").text(totalItems);
				$(".tongtien").text(new Intl.NumberFormat('es-ES', { }).format(totalPrice));
				$("#t-m").text("$"+new Intl.NumberFormat('es-ES', { }).format(totalPrice));

			},
			error : function(jqXhr, textStatus, errorMessage) { // error callback 
				
			}
		});
    });
	</script>
</body>
</html>