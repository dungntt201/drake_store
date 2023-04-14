package com.dev.drakestore.controller.user;

import javax.servlet.http.HttpServletRequest;

import com.dev.drakestore.dto.CustomOAuth2User;
import com.dev.drakestore.entities.Role;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;


@Controller

public abstract class BaseController {
	@Autowired
	UserService userService;

	public int getCurrentPage(HttpServletRequest request) {
		try {
			// page tren web la tu 1
			// page tren sql la tu 0 nen phair lay page-1 de lay tu ban ghi dau tien
			// ban ghi trong sql cos chi so tu 0
			if (Integer.parseInt(request.getParameter("page")) - 1 >= 0) {
				return Integer.parseInt(request.getParameter("page")) - 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}

	@ModelAttribute("isLogined")
	public boolean isLogined() {
		boolean isLogined = false;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails || principal instanceof OAuth2User) {
			isLogined = true;
		}
		return isLogined;
	}

	@ModelAttribute("userLogined")
	public User getUserLogined() {
		Object userLogined = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (userLogined != null) {
			if (userLogined instanceof UserDetails) {
				User u = (User) userLogined;
				u.setPassword(null);
				return u;
			}
			if (userLogined instanceof OAuth2User) {
				CustomOAuth2User userOAuth2 = (CustomOAuth2User) userLogined;
				String username = userOAuth2.getName();
				return userService.loadUserByUsername(username);
			}
		}
		return null;
	}

	@ModelAttribute("projectTitle")
	public String getTitle() {
		return "Drake Store";
	}

	@ModelAttribute("isSuperAdmin")
	public boolean checkSuperAdmin() {
		boolean check = false;
		if (isLogined() == true) {
			if (getUserLogined() != null) {
				for (Role r : getUserLogined().getRoles()) {
					if (r.getName().equals("SUPER_ADMIN")) {
						check = true;
						break;
					}
				}
			} else {
				check = false;
			}
		} else {
			check = false;
		}
		return check;
	}

}
