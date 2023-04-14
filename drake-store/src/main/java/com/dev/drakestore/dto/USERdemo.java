package com.dev.drakestore.dto;

import org.springframework.web.multipart.MultipartFile;

public class USERdemo {
	private int id;
	private MultipartFile file;
	private String full_name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	
}
