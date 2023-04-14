package com.dev.drakestore.entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_category")
public class Categories extends BaseEntity {
	@Column(name = "name", length = 100, nullable = false)
	private String name;

	@Lob
	@Column(name = "description", nullable = false, columnDefinition = "LONGTEXT")
	private String description;

	@Column(name = "seo", length = 1000, nullable = true)
	private String seo;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "parent")
	private Set<Categories> parent = new HashSet<Categories>(); // sau làm thì đổi lại sang children

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "parent_id")
	private Categories children;// sau làm thì đổi lại sang parent

	@OneToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY, mappedBy = "categories")
	private Set<Product> products = new HashSet<Product>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Set<Categories> getParent() {
		return parent;
	}

	public void setParent(Set<Categories> parent) {
		this.parent = parent;
	}

	public Categories getChildren() {
		return children;
	}

	public void setChildren(Categories children) {
		this.children = children;
	}

	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

//	@PreRemove
//	public void SetNullForCategoryOfProduct() {
//		products.forEach(p -> p.setCategories(null));
//	}

	/**
	 * them 1 san pham vao danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void addRelationProduct(Product product) {
		products.add(product);
		product.setCategories(this);

	}

	/**
	 * xoa san pham khoi danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void deleteRelationProduct(Product product) {
		products.remove(product);
		product.setCategories(null);
	}

	/**
	 * them 1 Parent ID vao danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void addParentID(Categories category) {
		parent.add(category);
		category.setChildren(this);

	}

	/**
	 * xoa Parent ID khoi danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void deleteParentID(Categories category) {
		parent.remove(category);
		category.setChildren(null);
	}

}
