package com.dev.drakestore.conf;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.dto.CustomOAuth2User;
import com.dev.drakestore.service.CustomOAuth2UserService;
import com.dev.drakestore.service.UserDetailServiceImpl;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

@EnableWebSecurity
public class SecureConf {
	@Configuration
	// @Order(1)
	public static class AdminConf extends WebSecurityConfigurerAdapter {
		@Autowired
		private CustomOAuth2UserService oauth2UserService;
		@Autowired
		private UserDetailServiceImpl userDetailsService;
		@Autowired
		private UserService userService;

		// URL chứa dấu gạch chéo kép.
		// Spring Security đã thêm lớp nghiêm ngặt của bức tường trong phiên bản cao
		// hơn,
		// giúp cho việc xác minh URL trở nên nghiêm ngặt hơn.
		// k có cái này k load đc ảnh lên web
		@Bean
		public HttpFirewall httpFirewall() {
			return new DefaultHttpFirewall();
		}

		// public void configure(HttpSecurity http) throws Exception{
		@Override
		protected void configure(final HttpSecurity http) throws Exception {

			http.csrf().disable().authorizeRequests(); // bat dau cau hinh security

			// Cấu hình remember me,
			http.rememberMe()
					// mã để vẫn login tự động đc khi khởi động lại ứng dụng,
					// nếu k có thì sẽ mất khi khởi động lại ứng dụng
					.key("uniqueAndSecret")
					// thơi gian lưu, thời gian là 1296000 giây = 15 ngày
					.tokenValiditySeconds(1296000);

			http.authorizeRequests()
					// cho phép các request static không bị ràng buộc .antMatchers("/")
					.antMatchers("/user/**", "/manager/**", "/upload/**")

					.permitAll()

					// các request kiểu: "/admin/" phải đăng nhập vaf phair xasc thuwjc vs role
					// laf ADMIN

					.antMatchers("/admin/account/**").hasAuthority("SUPER_ADMIN").antMatchers("/admin/**")
					.hasAnyAuthority("ADMIN", "SUPER_ADMIN").antMatchers("/account/info").authenticated()

					.antMatchers("/account/login**").permitAll()

					.anyRequest().permitAll().and()

					// cấu hình trang đăng nhập
					.formLogin().loginPage("/account/login")

					.loginProcessingUrl("/account/perform-login")

					.failureHandler(loginFailureHandler)

					// .successHandler(loginSuccessHandler)
					// .failureUrl("/account/login?login_error=true")
					.defaultSuccessUrl("/account/info", true)

					.permitAll().and()
					// config for oauth2
					.oauth2Login().loginPage("/account/login").userInfoEndpoint().userService(oauth2UserService).and()
					.successHandler(new AuthenticationSuccessHandler() {
						@Override
						public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
								Authentication authentication) throws IOException, ServletException {

							CustomOAuth2User oauthUser = (CustomOAuth2User) authentication.getPrincipal();

							userService.processOAuthPostLogin(oauthUser);

							response.sendRedirect("/account/info");
						}
					})
					// Khi người dùng đã login, với vai trò XX.
					// Nhưng truy cập vào trang yêu cầu vai trò YY,
					// Ngoại lệ AccessDeniedException sẽ ném ra.
					.and().exceptionHandling().accessDeniedPage("/401").and()

					// cấu hình cho phần logout
					.logout().logoutUrl("/logout").logoutSuccessUrl("/account/login").invalidateHttpSession(true)
					.deleteCookies("JSESSIONID").permitAll();

		}

		@Autowired
		public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {

			// Sét đặt dịch vụ để tìm kiếm User trong Database.
			// Và sét đặt PasswordEncoder.
			auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder(4));
		}

		@Autowired
		private CustomLoginFailureHandler loginFailureHandler;

		@Autowired
		private CustomLoginSuccessHandler loginSuccessHandler;

		public static void main(String[] args) {
			System.out.println(new BCryptPasswordEncoder(4).encode("guest"));
		}
	}
}
