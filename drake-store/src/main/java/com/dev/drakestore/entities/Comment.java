package com.dev.drakestore.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_comment")
public class Comment extends BaseEntity {
	@Column(name = "full_name", length = 200, nullable = false)
	private String full_name;

	@Column(name = "email", length = 200, nullable = false)
	private String email;

	@Column(name = "comment", length = 2000, nullable = false)
	private String comment;

	@Column(name = "avatar", length = 2000)
	private String avatar;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "blog_id")
	private Blog blogs;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User users;

	// thêm này cho phần save cmt (id của blog)
	@Column(name = "id_ajax")
	private Integer id_ajax;

	public User getUsers() {
		return users;
	}

	public void setUsers(User users) {
		this.users = users;
	}

	public Integer getId_ajax() {
		return id_ajax;
	}

	public void setId_ajax(Integer id_ajax) {
		this.id_ajax = id_ajax;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

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

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Blog getBlogs() {
		return blogs;
	}

	public void setBlogs(Blog blogs) {
		this.blogs = blogs;
	}

}
