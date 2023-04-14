package com.dev.drakestore.controller.user;

import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller

/// của phần đổi mk khi quá hạn đổi
public class PasswordController extends BaseController {
    @Autowired
    UserService userService;

    @Autowired
    CategoriesService categoriesService;

    @GetMapping("/change_password")
    public String showChangePasswordForm(Model model, RedirectAttributes redirectAttributes) {

        List<Categories> fullParent = categoriesService.findFullParentCategories();
        List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
        if (getUserLogined() != null) {
            if (getUserLogined().getProvider().equals("LOCAL")) {
                model.addAttribute("parentCategories", fullParent);
                model.addAttribute("childrenCategories", fullChildren);
                if (getUserLogined().isPasswordExpired()) {
                    model.addAttribute("message",
                            "Mật khẩu của bạn đã thay đổi quá 30 ngày. Vui thay đổi mật khẩu mới để tiếp tục trải nghiệm!");
                } else {
                    model.addAttribute("message", null);
                }
                return "change_password";
            } else {
                redirectAttributes.addFlashAttribute("msg1", "Tài khoản của bạn không thể cập nhật mật khẩu.");
                return "redirect:/account/info";
            }

        } else {
            redirectAttributes.addFlashAttribute("msg1",
                    "Bạn chưa đăng nhập. Vui lòng đăng nhập để trải nghiệm dịch vụ!");
            return "redirect:/account/login";
        }

    }

    @PostMapping("/change_password")
    public String processChangePassword(HttpServletRequest request, HttpServletResponse response, Model model,
                                        RedirectAttributes ra, @AuthenticationPrincipal Authentication authentication) throws ServletException {
//		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
//		User user = (User) userDetails;

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        if (oldPassword.equals(newPassword)) {
            model.addAttribute("err", "Mật khẩu mới phải khác mật khẩu cũ!");

            return "change_password";
        }

        User user = userService.loadUserByUsername(getUserLogined().getUsername());
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            model.addAttribute("err", "Mật khẩu cũ bạn nhập không chính xác!");
            return "change_password";

        } else {
            userService.changePassword(user, newPassword);
            request.logout();// logout
            ra.addFlashAttribute("message",
                    "Đổi mật khẩu thành công . Vui lòng đăng nhập để trải nghiệm dịch vụ của chúng tôi!");

            return "redirect:/account/login";
        }

    }
}
