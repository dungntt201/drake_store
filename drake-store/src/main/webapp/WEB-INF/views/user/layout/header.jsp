<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<div id="header" class="header">
       <div class="header1">
            <div class="logo">
                <a href="${base }/"><img src="${base}/user/Images/IMAGE2/drake_logo.png" alt="LOGO"></a>
            </div>
            <div class="main-menu">
                <ul class="menu list-unstyled">
                    <li class="li1"><a href="${base}/">Home</a>
                    </li>
                    <li class="li1"><a href="${base }/shop">Shop<i class="fas fa-chevron-down" style="font-size: 10px;margin-left: 5px"></i></a>
                    	<ul class="submenu list-unstyled">
                            <ul class="submenu1 list-unstyled">
                            	<c:forEach var="parent" items="${parentCategories }">
	                                <li><a href="${base }/category/${parent.seo}"><p>${parent.name }</p></a>

	                                </li>
                                </c:forEach>
                            </ul>
                         </ul>
                    </li>
                    <li class="li1"><a href="${base }/san-pham-hot">Hot</a>

                    </li>
                    <li class="li1"><a href="${base }/san-pham-sale">Sale</a>

                    </li>
                    <li class="li1"><a href="${base }/blogs">Blog</a>

                    </li>
                    <li class="li1"><a href="${base }/contact">Contact</a>

                    </li>
                </ul>
            </div>
            <div class="main-icon">
                <ul class="icon list-unstyled">
                    <li>
                        <div class="search1">
                            <span onclick="openNav()"><i class="fas fa-search" ></i></span>
                        </div>

                    </li>
                    <li>
                        <div class="user">
                            <a href="${base }/account/info">
	                            <c:choose>
	                            	<c:when test="${isLogined }">
		                            	<c:choose>
		                            		<c:when test="${userLogined.avatar!=null}">
		                            			<img alt="" src="${base }/upload/${userLogined.avatar}">
		                            		</c:when>
		                            		<c:otherwise>
		                            			<span style="color: black;"><i class="far fa-user "></i></span>
		                            		</c:otherwise>
		                            	</c:choose>

	                            	</c:when>
	                            	<c:otherwise>
	                            		<span style="color: black;"><i class="far fa-user "></i></span>
	                            	</c:otherwise>
	                            </c:choose>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="love">
                            <a href="${base }/wishlist/view"><span style="color: black;"><i class="far fa-heart"></i></span></a>
                            <div class="love1">
                                <c:if test="${totalItems1!=null }">
                            		<p id="love">${totalItems1 }</p>
                            	</c:if>
                                <c:if test="${totalItems1==null }">
                            		<p id="love">0</p>
                            	</c:if>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="cart">
                            <a href="${base }/cart/view"><span style="color: black;"><i class="fas fa-cart-plus"></i></span></a>
                            <div class="cart1">
                            	<c:if test="${totalItems!=null }">
                            		<p id="addcart">${totalItems }</p>
                            	</c:if>
                                <c:if test="${totalItems==null }">
                            		<p id="addcart">0</p>
                            	</c:if>
                            </div>
                        </div>
                    </li>
                    <li id="limoney">
                        <div class="money">
                        	<c:if test="${totalPrice!=null }">
                            	<p id="money"><span style="margin-right: 3px; font-weight: 700; font-size: 25px !important;">$</span><fmt:formatNumber value="${totalPrice}" type = "number" groupingUsed="true" /></p>
                           	</c:if>
                              <c:if test="${totalPrice==null }">
                           		<p id="money"><span style="margin-right: 3px; font-weight: 700; font-size: 25px !important;">$</span>0</p>
                           	</c:if>

                        </div>
                    </li>
                    <li id="libar">
                        <div class="bar">
                            <p onclick="openNav1()"><i class="fas fa-bars"></i></p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

    </div>
    <div id="myNav" class="overlay1">
        <p class="closebtn1" onclick="closeNav()">&times;</p>
        <div class="overlay1-content">
          <form action="${base }/shop" method="get">
              <input id="keyword" name="keyword" value="${keyword }" type="text" placeholder="Search products here ...." >
              <button type="submit"><i style="color: white;" class="fas fa-search"></i></button>
          </form>
        </div>
    </div>
    <div id="mySidenav" class="sidenav">
         <p class="closebtn" onclick="closeNav1()">&times;</p>
         <ul class="all-category list-unstyled" >

         	<li class="category1"><p><a href="${base }/">Home</a> </p></li>
         	<li class="category1"><p><a href="${base }/shop">Shop</a> <i class="fas fa-chevron-down"></i><i class="fas fa-chevron-up"></i></p>
				<c:forEach var="parentCategory" items="${parentCategories }">
					<ul class="category2 list-unstyled">
						<li class="sub-category"><p><a href="${base }/category/${parentCategory.seo}">${parentCategory.name }</a></p></li>

					</ul>
				</c:forEach>
			</li>
			<li class="category1"><p><a href="${base }/san-pham-hot">Hot</a> </p></li>
			<li class="category1"><p><a href="${base }/san-pham-sale">Sale</a></p></li>
			<li class="category1"><p><a href="${base }/blogs">Blog</a> </p></li>
			<li class="category1"><p><a href="${base }/contact">Contact</a></p></li>

		</ul>

    </div>
