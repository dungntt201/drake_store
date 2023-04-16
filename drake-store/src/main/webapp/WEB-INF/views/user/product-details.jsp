<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${projectTitle }</title>
    <script src="https://kit.fontawesome.com/e9a6ecd83d.js"
            crossorigin="anonymous"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">

    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="https://kit.fontawesome.com/e9a6ecd83d.js"
            crossorigin="anonymous"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <script
            src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.js"></script>
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.css"
            rel="stylesheet"/>

    <link rel="stylesheet" href="${base}/user/css/productdetails.css">
    <link rel="stylesheet" href="${base}/user/css/styles.css">

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
        <p>Shop</p>
        <a href="${base }/">Home </a><i class="fas fa-chevron-right"></i><a
            href="${base }/shop">Products </a> <i class="fas fa-chevron-right"></i><span>${product.title }</span>
    </div>
</div>
<div class="pro-details">
    <div class="img-details">
        <div class="img-zoom-container">
            <img id="myimage" src="${base}/upload/${product.avatar}"
                 width="100%" alt="${product.title }">
        </div>
        <div class="select-img">
            <div id="owl-demo" class="owl-carousel owl-theme">
                <c:forEach var="productImg" items="${productImgs }">
                    <c:if test="${productImg.products.id==product.id }">
                        <div class="item">
                            <button>
                                <img src="${base }/upload/${productImg.path}" alt="Owl Image">
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="info_img_details">
        <div class="info">
            <p id="pro_name">${product.title }</p>
            <c:choose>
                <c:when test="${product.price>product.price_sale }">
                    <p class="price1">
                        <span class="drake-price">Drake Price:</span>
                        <fmt:formatNumber value="${product.price_sale}" type="number"
                                          groupingUsed="true"/>
                        VND
                    </p>
                    <p class="price">
                        <span class="retail-price">Retail Price:</span>
                        <span style="text-decoration: line-through !important; font-weight: 400 !important;">
								<fmt:formatNumber value="${product.price}" type="number"
                                                  groupingUsed="true"/> VND
							</span>
                    </p>

                </c:when>
                <c:otherwise>
                    <p class="price1">
                        <span class="drake-price">Drake Price:</span>
                        <fmt:formatNumber value="${product.price_sale}" type="number"
                                          groupingUsed="true"/>
                        VND
                    </p>
                </c:otherwise>
            </c:choose>
            <c:forEach var="fullcate" items="${fullCate }">

                <c:if test="${fullcate.id==product.categories.id }">
                    <p id="carte">
                        Categories: <span><a
                            href="${base }/category/${fullcate.seo }">${fullcate.name }</a></span>
                    </p>
                </c:if>

            </c:forEach>

            <p id="share">
                Share: <a href="#" style="margin-left: 10px"><i class="fab fa-facebook-f"></i></a><a href="#"><i
                    class="fab fa-twitter"> </i></a><a href="#"><i
                    class="fab fa-linkedin-in"></i></a><a href="#"><i
                    class="fab fa-pinterest"></i></a><a href="#"><i
                    class="fab fa-reddit"></i></a>
            </p>
        </div>
        <div class="select_item">
            <p id="desc">${product.details }</p>
            <br>
            <div class="size">
                <p>Size</p>
                <select id="size-product">
                    <option value="">---SIZE---</option>
                    <c:forEach var="productSize" items="${productSizes}">
                        <c:if test="${productSize.products2.id == product.id}">
                            <c:choose>
                                <c:when
                                        test="${productSize.remaining>=1 && productSize.status==true }">
                                    <option value="${productSize.size }">${productSize.size }</option>
                                </c:when>
                                <c:otherwise>
                                    <option disabled="disabled"
                                            value="${productSize.size }">${productSize.size }</option>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </select>
                <!-- <p id="demo" class="alert alert-danger"></p> -->
            </div>
            <%--				<p id="size-error-msg">Vui lòng chọn size</p>--%>
            <div class="buy">
                <div class="buy1">
                    <input type="number" value="1" min="1" id="number">
                    <button id="add" onclick="addToCart(${product.id},b(),a())">ADD
                        TO CART
                    </button>
                    <%-- addToCart(${product.id},1,a()) --%>
                </div>
                <div class="buy1">
                    <button id="like" onclick="addToWishlist(${product.id},a())">
                        <i class="fa fa-heart-o"></i>
                    </button>
                </div>

            </div>
        </div>
    </div>

</div>
<div class="related">
    <p id="rlt">Related Products</p>
    <div class="row justify-content-center" id="sanpham" style="margin: 0">
        <c:forEach var="relatedProduct" items="${relatedProducts }">
            <div
                    class=" row col-xl-3 col-lg-3 col-md-4 col-sm-6 col-xs-12 tinh justify-content-center">
                <div class="tinh1" style="position: relative;">
                    <!-- Hot badge-->
                    <c:if test="${relatedProduct.is_hot }">
                        <div class="badge bg-danger text-white position-absolute"
                             style="top: 10px; left: 10px; font-size: 15px">Hot
                        </div>
                    </c:if>
                    <!-- Product image-->
                    <a href="${base }/shop/${relatedProduct.seo}"> <img
                            class="card-img-top"
                            src="${base }/upload/${relatedProduct.avatar}"
                            alt="${relatedProduct.title }" width="100%" height="300px"/>
                    </a>

                    <!-- Product details-->
                    <div class="text-center">
                        <!-- Product name-->
                        <a href="${base }/shop/${relatedProduct.seo}"
                           style="text-decoration: none" class="text-black">
                            <p style="font-size: 18px; margin-top: 20px" class="fw-bolder">${relatedProduct.title }</p>
                        </a>
                        <!-- Product price-->
                        <c:if test="${relatedProduct.price_sale<relatedProduct.price }">
                        <!-- Sale badge-->
                        <div class="badge bg-dark text-white position-absolute"
                             style="top: 10px; right: 10px; font-size: 15px">Sale
                        </div>
                        <span style="font-size: 16px"
                              class="text-muted text-decoration-line-through"><fmt:formatNumber
                                value="${relatedProduct.price}" type="number"
                                groupingUsed="true"/> VND</span>
                        <br>
                        <span style="font-size: 16px" class="fw-bolder"><fmt:formatNumber
                                value="${relatedProduct.price_sale}" type="number"
                                groupingUsed="true"/> VND<span>
							</c:if>
							<c:if
                                    test="${relatedProduct.price_sale==null ||relatedProduct.price_sale==relatedProduct.price  }">
                            <!-- <span class="text-muted text-decoration-line-through">$${product.price }</span> -->
								<span class="fw-bolder" style="font-size: 16px"><fmt:formatNumber
                                        value="${relatedProduct.price}" type="number"
                                        groupingUsed="true"/> VND</span>
							</c:if>

                    </div>
                    <br> <br>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include>
<button onclick="topFunction()" id="myBtn" title="Go to top">
    <i class="fas fa-angle-double-up"></i>
</button>

<script src="${base}/user/js/productdetails.js">
</script>
<script>
    /* $(function() {
        setTimeout(function() {
            $("#demo").slideUp(500);
        }, 2000)

    }) */
    function a() {
        var a1 = document.getElementById("size-product").value;
        return a1;
    }

    function b() {
        var a2 = document.getElementById("number").value;
        return a2;
    }

    /* 	$(document).on('click', '.show_cart .cart-products .cart-products1 .info-pro-cart p i', function(){
    		return confirm('Bạn có chắc chắn muốn xoá sản phẩm khỏi giỏ hàng không?');
    	});
    	 */
    //add vào giỏ hàng
    function addToCart(productId, quanlity, size) {
        let sizeValue = $("#size-product option:selected").val();
        if (sizeValue === "" || sizeValue === null) {
            alert("Vui lòng chọn size!");
        }
            // javascript object.
            // data la du lieu ma day len action cua controller
        // if()
        else if (isNaN(parseInt(quanlity)) || parseInt(quanlity) <= 0) {
            alert("Số lượng sản phẩm không hợp lệ! Vui lòng nhập lại.");
            $("#number").val("1");
        } else {
            let data = {
                //txtEmail: jQuery("#txtEmail").val(), // lay theo id
                //pw: ("#input-pw").val(), // lay theo id
                size: size,
                productId: productId,
                quanlity: quanlity,
            };

            // $ === jQuery
            // json == javascript object
            jQuery.ajax({
                url: "/cart/add",
                type: "post",
                //enctype: 'multipart/form-data',
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: "json", // kieu du lieu tra ve tu controller la json
                success: function (jsonResult) {
                    if (jsonResult.message == null) {
                        let a = "";
                        //alert("thêm thành công sản phẩm vào giỏ hàng!");
                        let totalItems = jsonResult.totalItems;
                        let totalPrice = jsonResult.totalPrice;
                        $("#money").text("$" + new Intl.NumberFormat('es-ES', {maximumSignificantDigits: 3}).format(totalPrice));
                        $("#demo").html("");
                        $("#addcart").text(totalItems);
                        //alert(jsonResult.cart.length);
                        //bắt buộc suyệt từ 0
                        for (var i = 0; i < jsonResult.cart.length; i++) {

                            a += "<div class='cart-products1'>"
                                + "<input type='hidden' value=\"" + jsonResult.cart[i].productId + "\">"
                                + "<div class='img-pro-cart'>"

                                + "<img src=\"${base}/upload/" + jsonResult.cart[i].productAvatar + "\" alt=''>"
                                + "</div>"
                                + "<div class='info-pro-cart'>"
                                + "<p class='pro-name'>" + jsonResult.cart[i].productName + " (<span>" + jsonResult.cart[i].size + "</span> )</p>"
                                + "<p><span class ='sl'>" + jsonResult.cart[i].quanlity + "</span> x <span class='pro-price'>" + new Intl.NumberFormat('es-ES', {maximumSignificantDigits: 3}).format(jsonResult.cart[i].priceUnit) + "</span><i style='float:right' class='fas fa-trash-alt delete'></i></p>"
                                + "</div>"
                                //+"<i class='fas fa-trash-alt delete'></i>"
                                + "</div>";

                        }
                        $(".show_cart .cart-products").html(a);
                        $("#t-m").text("$" + new Intl.NumberFormat('es-ES', {}).format(totalPrice));
                        $("#sc").css("transform", "translateX(0%)");
                    } else {
                        alert(jsonResult.message);
                        //$("#demo").html(jsonResult.message);
                        $("#number").val("1");

                    }

                    /*  */
                    /* let totalItems = jsonResult.totalItems;
                    $("#totalCartItemId").html(totalItems); */
                },
                error: function (jqXhr, textStatus, errorMessage) { // error callback

                }
            });
        }
    }

    //xóa sản phẩm trong cart demo và cart
    $(document).on('click', '.show_cart .cart-products .cart-products1 .info-pro-cart p i', function () {
        var productId = $(this).parents(".cart-products1").children("input").val();
        var size = $(this).parents(".info-pro-cart").children(".pro-name").children("span").text();
        var quanlity = $(this).parents(".info-pro-cart").children("p").children(".sl").text();
        // javascript object.
        // data la du lieu ma day len action cua controller
        $(this).parents(".cart-products1").remove();// xoa html tren gio
        let data = {
            productId: productId,
            size: size,
        };

        // $ === jQuery
        // json == javascript object
        jQuery.ajax({
            url: "/cart/delete",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "json", // kieu du lieu tra ve tu controller la json
            success: function (jsonResult) {
                //alert("Đã lưu yêu cầu của " + " thành công !");
                let totalItems = jsonResult.totalItems;
                let totalPrice = jsonResult.totalPrice;
                $("#money").text("$" + new Intl.NumberFormat('es-ES', {}).format(totalPrice));
                $("#addcart").text(totalItems);
                $(".tongtien").text(new Intl.NumberFormat('es-ES', {}).format(totalPrice));
                $("#t-m").text("$" + new Intl.NumberFormat('es-ES', {}).format(totalPrice));

            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback

            }
        });
    });

    // thêm vào danh sách yêu thích
    function addToWishlist(productId, size) {
        // javascript object.
        // data la du lieu ma day len action cua controller
        //alert(productId +" ddd "+ size);
        let data = {
            //txtEmail: jQuery("#txtEmail").val(), // lay theo id
            //pw: ("#input-pw").val(), // lay theo id
            size: size,
            productId: productId,
            //quanlity:quanlity,
        };

        // $ === jQuery
        // json == javascript object
        jQuery.ajax({
            url: "/wishlist/add",
            type: "post",
            //enctype: 'multipart/form-data',
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "json", // kieu du lieu tra ve tu controller la json
            success: function (jsonResult) {
                if (jsonResult.message1 == null) {
                    let totalItems1 = jsonResult.totalItems1;
                    $("#demo").html("");
                    $("#love").text(totalItems1);
                } else {
                    alert(jsonResult.message1);
                    //$("#demo").html(jsonResult.message1);

                }
            },
            error: function (jqXhr, textStatus, errorMessage) { // error callback

            }
        });
    }

    $(document).ready(function () {


        $("#owl-demo").owlCarousel({

            items: 4, //10 items above 1000px browser width
            itemsDesktop: [1000, 4], //5 items between 1000px and 901px
            itemsDesktopSmall: [900, 3], // betweem 900px and 601px
            itemsTablet: [768, 4], //2 items between 600 and 0
            itemsMobile: [400, 3],// itemsMobile disabled - inherit from itemsTablet option

        });

    });

</script>
</body>
</html>