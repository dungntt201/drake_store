package com.dev.drakestore.entities;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="tbl_product_size")
public class ProductSize extends BaseEntity{
	@Column(name = "size",length=45,nullable = false)
	private String size;
	
	@Column(name = "remaining", nullable = false)
	private Integer remaining;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product products2;

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	

	public Integer getRemaining() {
		return remaining;
	}

	public void setRemaining(Integer remaining) {
		this.remaining = remaining;
	}

	public Product getProducts2() {
		return products2;
	}

	public void setProducts2(Product products2) {
		this.products2 = products2;
	}
	
	
}
