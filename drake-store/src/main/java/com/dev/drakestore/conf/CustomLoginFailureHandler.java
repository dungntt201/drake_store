package com.dev.drakestore.conf;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.dev.drakestore.entities.User;

@Component
public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Autowired
	private UserService userService;

	// đang nhập lỗi sẽ chạy vào hàm này
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String username = request.getParameter("username");
		User user = userService.loadUserByUsername(username);

		// nếu username tồn tại
		if (user != null) {
			// nếu user k bị khóa (hàm isAccountNonLocked() là của UserDetails return về
			// status của User
			// Spring xác thực thông qua UserDetails)
			if (user.isEnabled() && user.isAccountNonLocked()) {
				if (user.getFail_attemp() <= UserService.MAX_FAILED_ATTEMPTS - 1) {
					userService.increaseFailedAttempts(user);
					exception = new LockedException("Mật khẩu không chính xác! Vui lòng điền đúng thông tin mật khẩu!");
				} else {
					userService.lock(user);
					exception = new LockedException(
							"Bạn đã nhập sai quá 3 lần! Tài khoản của bạn sẽ bị khóa trong 2 phút trước khi bạn có thể đăng nhập lại!");
				}

				// nếu user bị khóa
			} else if (!user.isAccountNonLocked()) {
				if (user.getLock_time() == null) {
					exception = new LockedException(
							"Tài khoản của bạn đang bị khóa. Vui lòng liên hệ với chúng tôi để được giúp đỡ!");
				} else {
					if (userService.unlockWhenTimeExpired(user)) {
						exception = new LockedException(
								"Tài khoản của bạn đã đc mở khóa. Vui lòng nhập lại đúng tài khoản của mình!");
					} else {
						exception = new LockedException(
								"Tài khoản của bạn đang bị khóa. Vui lòng đợi hết thời gian khóa để có thể đăng nhập lại!");
					}
				}

			}

		} else {
			exception = new LockedException(
					"Thông tin đăng nhập không chính xác! Vui lòng điền đúng thông tin tài khoản!");
		}
		//

		super.setDefaultFailureUrl("/account/login?login_error=true");
		super.onAuthenticationFailure(request, response, exception);
	}
}
