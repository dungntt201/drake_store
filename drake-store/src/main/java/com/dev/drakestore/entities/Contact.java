package com.dev.drakestore.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="tbl_contact")
public class Contact extends BaseEntity {
	@Column(name = "full_name",length=100,nullable = false)
	private String full_name;
	
	@Column(name = "email",length=100,nullable = false)
	private String email;
	
	@Column(name = "message",length=1000,nullable = false)
	private String message;
	
	@Column(name="phone_number",length=100,nullable = false)
	private String phone_number;

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	
	
}
