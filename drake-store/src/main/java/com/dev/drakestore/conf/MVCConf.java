package com.dev.drakestore.conf;

import com.dev.drakestore.dto.Constants;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class MVCConf implements WebMvcConfigurer, Constants {
	/*
	 * cấu hình 1 controller de handler các request kiểu
	 * http://localhost:9999/user/css/styles.css static files như css, js, image
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// TODO Auto-generated method stub
//		WebMvcConfigurer.super.addResourceHandlers(registry);
		// classpath: <=> src/main/resource
		registry.addResourceHandler("/user/**").addResourceLocations("classpath:/user/");
		registry.addResourceHandler("/manager/**").addResourceLocations("classpath:/manager/");
		// resource handler cho phần upload ảnh từ người dùng.
		registry.addResourceHandler("/upload/**").addResourceLocations("file:" + UPLOAD_FOLDER_ROOT);
	}

	@Bean // -> bao spring biet folder chua view
	public ViewResolver viewResolver() {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class); // view engine dung de doc data tu controller tra ve va tron voi html code.
		bean.setPrefix("/WEB-INF/views/"); // duong dan toi folder chua views(user + manager)
		bean.setSuffix(".jsp"); // duoi file cua view
		return bean;
	}

	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(100000);
		return new CommonsMultipartResolver();
	}
}
