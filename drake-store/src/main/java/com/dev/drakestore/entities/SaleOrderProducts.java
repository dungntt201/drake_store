package com.dev.drakestore.entities;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_saleorder_products")

public class SaleOrderProducts extends BaseEntity {
	@Column(name = "price_at_buy", precision = 13, scale = 2)
	private BigDecimal price_at_buy;

	@Column(name = "size", length = 45)
	private String size;

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	@Column(name = "quantity")
	private Integer quantity;

	@Column(name = "status")
	private Boolean status;

	@Column(name = "product_name")
	private String product_name;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "saleorder_id")

	private SaleOrder saleOrders;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")

	private Product products1;

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public BigDecimal getPrice_at_buy() {
		return price_at_buy;
	}

	public void setPrice_at_buy(BigDecimal price_at_buy) {
		this.price_at_buy = price_at_buy;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public SaleOrder getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(SaleOrder saleOrders) {
		this.saleOrders = saleOrders;
	}

	public Product getProducts1() {
		return products1;
	}

	public void setProducts1(Product products1) {
		this.products1 = products1;
	}

}
