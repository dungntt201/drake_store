package com.dev.drakestore.controller.user;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.dto.UserNotFoundException;
import com.dev.drakestore.dto.Utility;
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import net.bytebuddy.utility.RandomString;

@Controller

// của phần quên mk
public class ForgotPasswordController extends BaseController {
	@Autowired
	CategoriesService categoriesService;

	@Autowired
	UserService userService;

	@Autowired
	JavaMailSender mailSender;

	@GetMapping("/forgot_password")
	public String showForgotPasswordForm(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		return "forgot_password";

	}

	@PostMapping("/forgot_password")
	public String processForgotPassword(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		String email = request.getParameter("email");
		String token = RandomString.make(30);

		User user = userService.findbyEmail(email);
		if (user != null) {
			try {
				userService.updateResetPasswordToken(token, email);
				String resetPasswordLink = Utility.getSiteURL(request) + "/reset_password?token=" + token;
				sendEmail(email, resetPasswordLink);
				model.addAttribute("message",
						"Chúng tôi vừa gửi cho bạn 1 link đến email của bạn để đổi mật khẩu.Vui lòng check email đó.");

			} catch (UserNotFoundException ex) {
				model.addAttribute("error", ex.getMessage());
			} catch (UnsupportedEncodingException | MessagingException e) {
				model.addAttribute("error", "Error while sending email or this is a broken email!");
			}
		} else {
			model.addAttribute("error",
					"Email này không được liên kết với tài khoản nào! Vui lòng nhập đúng email liên kết với tài khoản của bạn!");
		}

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		return "forgot_password";
	}

	public void sendEmail(String recipientEmail, String link) throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom("tinhtrang0527@gmail.com", "DreamSneakers Support");
		helper.setTo(recipientEmail);

		String subject = "Here's the link to reset your password";

		String content = "<p>Hello, " + recipientEmail + "</p>" + "<p>You have requested to reset your password.</p>"
				+ "<p>Click the link below to change your password:</p>" + "<p><a href=\"" + link
				+ "\">Change my password</a>" + "</p>" + "<br>"
				+ "<p>Ignore this email if you do remember your password, " + "or you have not made the request.</p>";

		helper.setSubject(subject);

		helper.setText(content, true);

		mailSender.send(message);
	}

	@GetMapping("/reset_password")
	public String showResetPasswordForm(@Param(value = "token") String token, Model model,
			RedirectAttributes redirectAttributes) {

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		User user = userService.findbyToken(token);
		model.addAttribute("token", token);

		if (user == null) {
			redirectAttributes.addFlashAttribute("message1", "Invalid Token");
			return "redirect:/forgot_password";
		}

		return "reset_password";
	}

	@PostMapping("/reset_password")
	public String processResetPassword(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		String token = request.getParameter("token");
		String password = request.getParameter("password");

		User user = userService.findbyToken(token);

		if (user == null) {
			redirectAttributes.addFlashAttribute("message1", "Invalid Token");
			return "redirect:/forgot_password";
		} else {

//			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
//			if (passwordEncoder.matches(password, user.getPassword())) {
//				redirectAttributes.addFlashAttribute("message1", "Mật khẩu mới phải khác mật khẩu cũ!");
//				return "redirect:/reset_password?token=" + token;
//
//			} else {
			userService.updatePassword(user, password);

			redirectAttributes.addFlashAttribute("message1",
					"Đổi mật khẩu thành công . Vui lòng đăng nhập để trải nghiệm dịch vụ của chúng tôi! ");
		}
		// }

		return "redirect:/account/login";
	}
}
