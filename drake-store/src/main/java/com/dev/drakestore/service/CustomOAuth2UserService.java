package com.dev.drakestore.service;

import com.dev.drakestore.dto.CustomOAuth2User;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;


//phương thức loadUser () sẽ được Spring OAuth2 gọi khi xác thực thành công 
//và nó trả về một đối tượng CustomOAuth2User mới .
@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		// OAuth2UserRequest Đại diện cho một yêu cầu mà OAuth2UserService sử dụng khi
		// bắt đầu một yêu cầu tới UserInfo Endpoint.

		// get nhà cung cấp tài khoản
		String clientName = userRequest.getClientRegistration().getClientName();
		OAuth2User user = super.loadUser(userRequest);
		return new CustomOAuth2User(user, clientName);
	}
}
