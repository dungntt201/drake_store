package com.dev.drakestore.entities;

import java.math.BigDecimal;
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
@Table(name = "tbl_products")
public class Product extends BaseEntity {
	@Column(name = "title", length = 1000, nullable = false)
	private String title;

	@Column(name = "price", precision = 13, scale = 2, nullable = false)
	private BigDecimal price;

	@Column(name = "price_sale", precision = 13, scale = 2)
	private BigDecimal price_sale;

	@Lob
	@Column(name = "detail_description", nullable = false, columnDefinition = "LONGTEXT")
	private String details;

	@Column(name = "avatar", length = 1000, nullable = false)
	private String avatar;

	@Column(name = "is_hot")
	private Boolean is_hot;

	@Column(name = "sold")
	private Integer sold;

	@Column(name = "seo", length = 1000, nullable = true)
	private String seo;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")

	private Categories categories;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "products")
	private Set<ProductImage> product_Images = new HashSet<ProductImage>();

	@OneToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY, mappedBy = "products1")

	private Set<SaleOrderProducts> saleOrderProducts = new HashSet<SaleOrderProducts>();

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "products2")

	private Set<ProductSize> product_Sizes = new HashSet<ProductSize>();

	public Set<ProductSize> getProduct_Sizes() {
		return product_Sizes;
	}

	public void setProduct_Sizes(Set<ProductSize> product_Sizes) {
		this.product_Sizes = product_Sizes;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getPrice_sale() {
		return price_sale;
	}

	public void setPrice_sale(BigDecimal price_sale) {
		this.price_sale = price_sale;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public Boolean getIs_hot() {
		return is_hot;
	}

	public void setIs_hot(Boolean is_hot) {
		this.is_hot = is_hot;
	}

	public Integer getSold() {
		return sold;
	}

	public void setSold(Integer sold) {
		this.sold = sold;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Categories getCategories() {
		return categories;
	}

	public void setCategories(Categories categories) {
		this.categories = categories;
	}

	public Set<ProductImage> getProduct_Images() {
		return product_Images;
	}

	public void setProduct_Images(Set<ProductImage> product_Images) {
		this.product_Images = product_Images;
	}

	public Set<SaleOrderProducts> getSaleOrderProducts() {
		return saleOrderProducts;
	}

	public void setSaleOrderProducts(Set<SaleOrderProducts> saleOrderProducts) {
		this.saleOrderProducts = saleOrderProducts;
	}

	/**
	 * them 1 san pham vao danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void addRelationProduct(ProductImage product_Image) {
		product_Images.add(product_Image);
		product_Image.setProducts(this);
	}

//	/**
//	 * xoa san pham khoi danh sach @OneToMany
//	 * 
//	 * @param product
//	 */
//	public void deleteRelationProduct(ProductImage product_Image) {
//		product_Images.remove(product_Image);
//		product_Image.setProducts(null); 
//		//set null k đc vì product_id not null (đang lỗi)
//	}

	/**
	 * them 1 size san pham vao danh sach @OneToMany
	 * 
	 * @param product
	 */
	public void addSizeProduct(ProductSize product_Size) {
		product_Sizes.add(product_Size);
		product_Size.setProducts2(this);
	}

//	/**
//	 * xoa san pham khoi danh sach @OneToMany
//	 * 
//	 * @param product
//	 */
//	public void deleteSizeProduct(ProductSize product_Size) {
//		product_Sizes.remove(product_Size);
//		product_Size.setProducts2(null);
//		//set null k đc vì product_id not null (đang lỗi)
//	}

	public void addRelationSaleOrderProduct(SaleOrderProducts saleOrderProduct) {
		saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setProducts1(this);
	}
//
//	/**
//	 * xoa san pham khoi danh sach @OneToMany
//	 * 
//	 * @param product
//	 */
//	public void deleteRelationSaleOrderProduct(SaleOrderProducts saleOrderProduct) {
//		saleOrderProducts.remove(saleOrderProduct);
//		saleOrderProduct.setProducts1(null);
//		//set null k đc vì product_id not null (đang lỗi)
//	}
}
