package com.dev.drakestore.conf;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Autowired
	private UserService userService;

	// đang lỗi
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.out.println("abcdef");
		String username = request.getParameter("username");
		User user = userService.loadUserByUsername(username);
		userService.resetFailedAttempts(user);
		System.out.println("abcdef" + user.getFull_name());

		// super.setDefaultTargetUrl("/admin/index");
		super.onAuthenticationSuccess(request, response, authentication);
		response.sendRedirect("/admin/index");
	}

	private User getLoggedInCustomer() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Object principal = null;

		if (authentication != null) {
			principal = authentication.getPrincipal();
		}

		if (principal != null && principal instanceof UserDetails) {
			UserDetails userDetails = (UserDetails) principal;
			return (User) (userDetails);
		}

		return null;
	}

}
