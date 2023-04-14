package com.dev.drakestore.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.springframework.format.annotation.DateTimeFormat;

@MappedSuperclass
public abstract class BaseEntity {
	@Id // the hien la khoa chinh
	@GeneratedValue(strategy = GenerationType.IDENTITY) // AI tự động tăng
	@Column(name = "id")
	private Integer id;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")//khi lấy ngày từ input[type=date]sẽ chuyển từ String về date
	@Column(name = "created_date")
	private Date created_date;
	
	@Column(name = "created_by")
	private Integer created_by;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "updated_date")
	private Date updated_date;
	
	@Column(name = "updated_by")
	private Integer updated_by;
	
	@Column(name="status")
	private boolean status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public Integer getCreated_by() {
		return created_by;
	}

	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}

	public Date getUpdated_date() {
		return updated_date;
	}

	public void setUpdated_date(Date updated_date) {
		this.updated_date = updated_date;
	}

	public Integer getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(Integer updated_by) {
		this.updated_by = updated_by;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
}
