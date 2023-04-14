package com.dev.drakestore.dto;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User {
	private OAuth2User oauth2User;
	private String oauth2ClientName;

	public CustomOAuth2User(OAuth2User oauth2User, String oauth2ClientName) {
		this.oauth2User = oauth2User;
		this.oauth2ClientName = oauth2ClientName;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return oauth2User.getAttributes();
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return oauth2User.getAuthorities();
	}

	@Override
	public String getName() {
		// trả về username của tài khoản
		return oauth2User.getName();
	}

	public String getFullname() {
		// trả về tên của tài khoản
		return oauth2User.getAttribute("name");
	}

	public String getEmail() {
		// trả về email của tài khoản
		return oauth2User.getAttribute("email");
	}

	public String getOauth2ClientName() {
		// trả về nhà cung cấp tài khoản FB, GG, ...
		return this.oauth2ClientName;
	}

}
