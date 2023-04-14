package com.dev.drakestore.entities;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "tbl_users")
public class User extends BaseEntity implements UserDetails {
	private static final long PASSWORD_EXPIRATION_TIME = 30L * 24L * 60L * 60L * 1000L; // 30 days

	@Column(name = "username", length = 100, nullable = false)
	private String username;

	@Column(name = "password", length = 100)
	private String password;

	@Column(name = "email", length = 100, nullable = false)
	private String email;

	@Column(name = "full_name", length = 100, nullable = false)
	private String full_name;

	@Column(name = "provider", length = 45)
	private String provider;

	@Column(name = "avatar", length = 200)
	private String avatar;

	@Column(name = "reset_password_token", length = 45)
	private String reset_password_token;

	@Column(name = "fail_attemp")
	private Integer fail_attemp;

	@Column(name = "lock_time")
	private Date lock_time;

	@Column(name = "password_changed_time")
	private Date passwordChangedTime;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "users")
	private Set<Comment> comments1 = new HashSet<Comment>();

	public boolean isPasswordExpired() {
		if (this.passwordChangedTime == null)
			return false;

		long currentTime = System.currentTimeMillis();
		long lastChangedTime = this.passwordChangedTime.getTime();

		return currentTime > lastChangedTime + PASSWORD_EXPIRATION_TIME;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "users")
	public List<Role> roles = new ArrayList<Role>();

	@OneToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY, mappedBy = "user")

	private Set<SaleOrder> saleOrders = new HashSet<SaleOrder>();

	public Date getPasswordChangedTime() {
		return passwordChangedTime;
	}

	public void setPasswordChangedTime(Date passwordChangedTime) {
		this.passwordChangedTime = passwordChangedTime;
	}

	public String getReset_password_token() {
		return reset_password_token;
	}

	public void setReset_password_token(String reset_password_token) {
		this.reset_password_token = reset_password_token;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public void addRoles(Role role) {
		role.getUsers().add(this);
		roles.add(role);
	}

	public void deleteRoles(Role role) {
		role.getUsers().remove(this);
		roles.remove(role);
	}

	@Override
	public String getUsername() {
		return username;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public Integer getFail_attemp() {
		return fail_attemp;
	}

	public void setFail_attemp(Integer fail_attemp) {
		this.fail_attemp = fail_attemp;
	}

	public Date getLock_time() {
		return lock_time;
	}

	public void setLock_time(Date lock_time) {
		this.lock_time = lock_time;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Set<SaleOrder> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(Set<SaleOrder> saleOrders) {
		this.saleOrders = saleOrders;
	}

	public Set<Comment> getComments1() {
		return comments1;
	}

	public void setComments1(Set<Comment> comments1) {
		this.comments1 = comments1;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return roles;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return this.isStatus();
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String toString() {
		return "User [id=" + super.getId() + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", full_name=" + full_name + ", provider=" + provider + ", avatar=" + avatar
				+ ", reset_password_token=" + reset_password_token + ", fail_attemp=" + fail_attemp + ", lock_time="
				+ lock_time + ", passwordChangedTime=" + passwordChangedTime + "]";
	}

}
