<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- directive JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- directive SPRING-FORM -->
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                	<c:if test="${isLogined }">
                		<c:choose>
                			<c:when test="${userLogined.avatar==null }">
			                	<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
			                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
			                        <li><a class="dropdown-item" href="#!">${userLogined.full_name}</a></li>
			                        <li><a class="dropdown-item" href="${base }/account/info">Details</a></li>
			                        <li><hr class="dropdown-divider" /></li>
			                        <li><a class="dropdown-item" href="${base }/logout">Logout</a></li>
			                    </ul>
                			</c:when>
                			<c:otherwise>
                				<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><img alt="user-avatar" src="${base }/upload/${userLogined.avatar}" width="30px" height="30px" style="border-radius: 50%"></a>
			                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
			                        <li><a class="dropdown-item" href="#!">${userLogined.full_name}</a></li>
			                        <li><a class="dropdown-item" href="${base }/admin/account/edit-account/${userLogined.username}">Details</a></li>
			                        <li><hr class="dropdown-divider" /></li>
			                        <li><a class="dropdown-item" href="${base }/logout">Logout</a></li>
			                    </ul>
                			</c:otherwise>
                		</c:choose>
                		
                	
                	</c:if>
                   
                </li>
            </ul>
        </nav>