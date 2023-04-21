package com.dev.drakestore.entities;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="tbl_saleorder")
public class SaleOrder extends BaseEntity {
	@Column(name="code",length=100,nullable=false)
	private String code;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	
	private User user;
	
	@Column(name = "total", precision = 13, scale = 2, nullable = false)
	private BigDecimal total;
	
	@Column(name="customer_name",length=100,nullable=false)
	private String customer_name;
	
	@Column(name="customer_address",length=100,nullable=false)
	private String customer_address;
	
	@Column(name="seo",length =200)
	private String seo;
	
	@Column(name="customer_phone",length=100,nullable=false)
	private String customer_phone;
	
	@Column(name="customer_email",length=100,nullable=false)
	private String customer_email;
	
	@Column(name="is_delivery")
	private boolean is_delivery;
	
	@Column(name="cancel")
	private boolean cancel;
	
	@Column(name="confirm")
	private boolean confirm;

	@Column(name = "is_pay")
	private boolean is_pay;

	@Column(name = "ipn_return")
	private String ipn_return;

	@Column(name="message",length =2000)
	private String message;
	@OneToMany(cascade = CascadeType.ALL,
			fetch = FetchType.EAGER,
			mappedBy = "saleOrders")
	private Set<SaleOrderProducts> saleOrderProducts = new HashSet<SaleOrderProducts>();
	
	public boolean isConfirm() {
		return confirm;
	}

	public void setConfirm(boolean confirm) {
		this.confirm = confirm;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getCustomer_address() {
		return customer_address;
	}

	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public String getCustomer_phone() {
		return customer_phone;
	}

	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
	}

	public String getCustomer_email() {
		return customer_email;
	}

	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}
	
	public boolean isIs_delivery() {
		return is_delivery;
	}

	public void setIs_delivery(boolean is_delivery) {
		this.is_delivery = is_delivery;
	}
	
	public boolean isCancel() {
		return cancel;
	}

	public void setCancel(boolean cancel) {
		this.cancel = cancel;
	}

	public boolean isIs_pay() {
		return is_pay;
	}

	public void setIs_pay(boolean is_pay) {
		this.is_pay = is_pay;
	}

	public String getIpn_return() {
		return ipn_return;
	}

	public void setIpn_return(String ipn_return) {
		this.ipn_return = ipn_return;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Set<SaleOrderProducts> getSaleOrderProducts() {
		return saleOrderProducts;
	}

	public void setSaleOrderProducts(Set<SaleOrderProducts> saleOrderProducts) {
		this.saleOrderProducts = saleOrderProducts;
	}
	
	/**
	 * them  1 san pham vao danh sach @OneToMany
	 * @param product
	 */
	public void addRelationProduct(SaleOrderProducts saleOrderProduct) {
		saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setSaleOrders(this);
	}

	/**
	 * xoa san pham khoi danh sach @OneToMany
	 * @param product
	 */
	public void deleteRelationProduct(SaleOrderProducts saleOrderProduct) {
		saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setSaleOrders(this);
	}
	
}
