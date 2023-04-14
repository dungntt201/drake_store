<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<div class="menu-footer">
        <div class="menu-footer1">
            <div class="menuft">
                <div class="mnft1">
                    <img src="${base}/user/Images/IMAGE2/drake_logo.png" style="margin-top:15px;"><br><br><br>
                    <i style="color: gray;" class="fas fa-map-marker-alt"></i><span style="color: gray;" >Hanoi, Vietnam</span><br><br>
                    <i style="color: gray;" class="fas fa-phone-alt"></i><a  href="tel:+84981982267">+84 981 982 267</a><br><br>
                    <i style="color: gray;" class="far fa-envelope"></i><a  href="mailto:dung.ntt992001@gmail.com">dung.ntt992001@gmail.com</a>
                </div>
                <div class="mnft1" id="mnft1">
                    <p id="mnft">Information</p>
                    <a href="${base }/about-us"><p id="amn">About Us</p></a>
                    <a href="${base }/blogs"><p id="amn1">Lastest Post</p></a>
                    <a href="${base }/shop"><p id="amn1">Products</p></a>
                    <a href="${base }/san-pham-sale"><p id="amn1">Sale</p></a>
                    <a href="${base }/contact"><p id="amn1">Contact Us</p></a>
                </div>
            </div>
            <div class="menuft">
                <div class="mnft1" id="mnft1">
                    <p id="mnft">My Account</p>
                    <a href="${base }/account/info"><p id="amn">My Account</p></a>
                    <a href="${base }/account/login"><p id="amn1">Login / Register</p></a>
                    <a href="${base }/cart/view"><p id="amn1">Cart</p></a>
                    <a href="${base }/wishlist/view"><p id="amn1">Wishlist</p></a>
                    <a href="${base }/account/info"><p id="amn1">Order History</p></a>
                </div>
                <div class="mnft1" id="mnft1">
                    <p id="mnft">Help & Support</p>
                    <a href="${base }/how-to-shop"><p id="amn">How To Shop</p></a>
                    <a href="${base }/payment"><p id="amn1">Payment</p></a>
                    <a href="${base }/returns"><p id="amn1">Returns</p></a>
                    <a href="${base }/delivery"><p id="amn1">Delivery</p></a>
                    <a href="${base }/privacy"><p id="amn1">Privacy & Cookie Policy</p></a>
                </div>
            </div>
        </div>
    </div>
    <div class="payment">
        <div class="payment1">
            <div class="payment11">
                <p><i class="far fa-copyright"></i>Copyright Drake Stores 2023.<br> Designed and Developed by <a href="#">DungNguyenTheTien</a></p>
            </div>
            <div class="socialnw">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
                <a href="#"><i class="fab fa-pinterest"></i></a>
                <a href="#"><i class="fas fa-rss"></i></a>
            </div>
            <div class="payment12">
                <a href="#">
                    <img id="imgpm" src="${base}/user/Images/IMAGE2/payment1.png" alt="payment">
                </a>
                <a href="#">
                    <img src="${base}/user/Images/IMAGE2/payment2.png" alt="payment">
                </a>
                <a href="#">
                    <img src="${base}/user/Images/IMAGE2/payment3.png" alt="payment">
                </a>
                <a href="#">
                    <img src="${base}/user/Images/IMAGE2/payment4.png" alt="payment">
                </a>
            </div>
        </div>
    </div>
