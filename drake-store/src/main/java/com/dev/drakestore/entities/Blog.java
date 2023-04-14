package com.dev.drakestore.entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_blog")
public class Blog extends BaseEntity {
	@Column(name = "title", length = 2000, nullable = false)
	private String title;

	@Lob
	@Column(name = "content", nullable = false, columnDefinition = "LONGTEXT")
	private String content;

	@Lob
	@Column(name = "short_content", nullable = false, columnDefinition = "LONGTEXT")
	private String short_content;

	@Column(name = "seo", length = 200)
	private String seo;

	@Column(name = "tag", length = 100, nullable = false)
	private String tag;

	@Column(name = "avatar", length = 200, nullable = false)
	private String avatar;

	@Column(name = "comments")
	private Integer comments;

	@Column(name = "author", length = 200, nullable = false)
	private String author;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "blogs")
	private Set<Comment> comments1 = new HashSet<Comment>();

	public Set<Comment> getComments1() {
		return comments1;
	}

	public void setComments1(Set<Comment> comments1) {
		this.comments1 = comments1;
	}

	public Integer getComments() {
		return comments;
	}

	public void setComments(Integer comments) {
		this.comments = comments;
	}

	public String getShort_content() {
		return short_content;
	}

	public void setShort_content(String short_content) {
		this.short_content = short_content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	/**
	 * them 1 san pham vao danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void addRelationComment(Comment comment) {
		comments1.add(comment);
		comment.setBlogs(this);
	}

	/**
	 * xoa san pham khoi danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void deleteRelationComment(Comment comment) {
		comments1.remove(comment);
		comment.setBlogs(null);
	}

}
