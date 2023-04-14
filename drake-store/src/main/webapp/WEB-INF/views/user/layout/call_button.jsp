<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<div class="hotline-phone-ring-wrap">
    <div class="hotline-phone-ring">
        <div class="hotline-phone-ring-circle"></div>
        <div class="hotline-phone-ring-circle-fill"></div>
        <div class="hotline-phone-ring-img-circle">
        <a href="tel:0981982267" class="pps-btn-img">
            <img src="${base }/user/Images/IMAGE3/icon-call-nh.png" alt="Gọi điện thoại" width="50">
        </a>
        </div>
    </div>
<%--    <div class="hotline-bar">--%>
<%--        <a href="tel:0981982267">--%>
<%--            <span class="text-hotline">0981982267</span>--%>
<%--        </a>--%>
<%--    </div>--%>
</div>