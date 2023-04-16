package com.dev.drakestore.conf;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.entities.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;


@Component
@Slf4j
public class PasswordExpirationFilter implements Filter {
	// Một Filter là một đối tượng được sử dụng để chặn các yêu cầu HTTP và phản hồi
	// của ứng dụng của bạn. Bằng cách sử dụng filter, chúng ta có thể thực hiện hai
	// hoạt động tại hai trường hợp sau:
	// Trước khi gửi request tới controller.
	// Trước khi gửi response tới client.

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;

		if (isUrlExcluded(httpRequest)) {
			// Cho phép request được đi tiếp. (Vượt qua Filter này).
			chain.doFilter(request, response);
			return;
		}

		User user = getLoggedInCustomer();

		if (user != null && user.isPasswordExpired()) {
			// nếu mk hết hạn thì mặc định chuyển hướng về trang đổi mật khẩu
			showChangePasswordPage(response, httpRequest, user);
		} else {
			// Cho phép request được đi tiếp. (Vượt qua Filter này).
			chain.doFilter(httpRequest, response);
		}
	}

	private boolean isUrlExcluded(HttpServletRequest httpRequest) throws IOException, ServletException {
		String url = httpRequest.getRequestURL().toString();
		// System.out.println("url:" + url);
		if (url.endsWith(".css") || url.endsWith(".png") || url.endsWith(".PNG") || url.endsWith(".jpeg")
				|| url.endsWith(".JPEG") || url.endsWith(".jpg") || url.endsWith(".JPG") || url.endsWith(".js")
				|| url.endsWith("/change_password")) {
			// chỉ cho phép request đến những url này
			return true;
		}

		return false;
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

	private void showChangePasswordPage(ServletResponse response, HttpServletRequest httpRequest, User user)
			throws IOException {
		log.info("Customer: " + user.getFull_name() + " - Password Expired: [Last time password changed: " + user.getPasswordChangedTime() + "]");

		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String redirectURL = httpRequest.getContextPath() + "/change_password";
		httpResponse.sendRedirect(redirectURL);
	}
}
