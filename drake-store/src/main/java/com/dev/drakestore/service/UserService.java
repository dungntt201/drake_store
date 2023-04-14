package com.dev.drakestore.service;

import com.dev.drakestore.dto.Constants;
import com.dev.drakestore.dto.CustomOAuth2User;
import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.dto.UserNotFoundException;
import com.dev.drakestore.entities.Role;
import com.dev.drakestore.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class UserService extends BaseService<User> implements Constants {

	@Autowired
	RoleService roleService;
	public static final int MAX_FAILED_ATTEMPTS = 3;

	// private static final long LOCK_TIME_DURATION = 24 * 60 * 60 * 1000; // 24
	// hours
	private static final long LOCK_TIME_DURATION = 2 * 60 * 1000; // 2 minutes

	@Override
	protected Class<User> clazz() {
		// TODO Auto-generated method stub
		return User.class;
	}

	// tăng số lần đăng nhập lỗi của user
	@Transactional
	public void increaseFailedAttempts(User user) {
		if (user.getFail_attemp() == null) {
			user.setFail_attemp(1);
		} else {
			user.setFail_attemp(user.getFail_attemp() + 1);
		}
		super.saveOrUpdate(user);
	}

	// reset số lần đăng nhập lỗi của user
	@Transactional
	public void resetFailedAttempts(User user) {
		user.setFail_attemp(0);
		super.saveOrUpdate(user);
	}

	// khóa user status=0;
	@Transactional
	public void lock(User user) {
		user.setStatus(false);
		user.setLock_time(new Date());
		super.saveOrUpdate(user);
	}

	// mở khóa user và reset thời gian khóa

	@Transactional
	public boolean unlockWhenTimeExpired(User user) {
		long lockTimeInMillis = user.getLock_time().getTime();
		long currentTimeInMillis = System.currentTimeMillis();

		if (lockTimeInMillis + LOCK_TIME_DURATION < currentTimeInMillis) {
			user.setStatus(true);
			user.setLock_time(null);
			user.setFail_attemp(0);
			super.saveOrUpdate(user);
			return true;
		}

		return false;
	}

	@Transactional
	// đổi mật khẩu lúc mật khẩu quá hạn
	public void changePassword(User user, String newPassword) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
		String encodedPassword = passwordEncoder.encode(newPassword);
		user.setPassword(encodedPassword);

		user.setPasswordChangedTime(new Date());

		super.saveOrUpdate(user);
	}

	// active
	public List<User> findAllActive() {
		String sql = "select * from tbl_users where status=1";
		return super.executeNativeSql1(sql);
	}

	// inactive
	public List<User> findAllInActive() {
		String sql = "select * from tbl_users where status=0";
		return super.executeNativeSql1(sql);
	}

	// active
	public List<User> findAllLocal() {
		String sql = "SELECT * FROM drakestore.tbl_users where provider='LOCAL';";
		return super.executeNativeSql1(sql);
	}

	// active
	public List<User> findAllSocial() {
		String sql = "SELECT * FROM drakestore.tbl_users where provider!='LOCAL';";
		return super.executeNativeSql1(sql);
	}

	public User loadUserByUsername(String userName) {
		String sql = "select * from tbl_users u where u.username = '" + userName + "'";
		List<User> users = this.executeNativeSql1(sql);
		if (users == null || users.size() <= 0)
			return null;
		return users.get(0);
	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<User> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_users p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.username) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.full_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.provider) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.email) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				/* sql += "and p.status=1 "; */
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.username asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.username desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<User> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_users p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.username) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.full_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.provider) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.email) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				/* sql += "and p.status=1 "; */
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.username asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.username desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}

		return executeNativeSql1(sql);
	}

	// ajax
	@Transactional
	public void processOAuthPostLogin(CustomOAuth2User oauthUser) {
		String username = oauthUser.getName();
		String fullname = oauthUser.getFullname();
		String email = oauthUser.getEmail();
		String clientName = oauthUser.getOauth2ClientName();
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		User existUser = loadUserByUsername(username);

		Role role = roleService.loadRoleByName("USER");
		if (existUser == null) {
			User newUser = new User();
			newUser.setFull_name(fullname);
			newUser.setUsername(username);
			newUser.setCreated_date(ngay);
			newUser.setEmail(email);
			newUser.setProvider(clientName.toUpperCase());
			if (clientName.toUpperCase().equals("FACEBOOK")) {
				newUser.setAvatar("/users/avatars/facebook.jpg");
			} else {
				newUser.setAvatar("/users/avatars/google.jpg");
			}
			newUser.addRoles(role);
			newUser.setStatus(true);
			newUser.setLock_time(null);
			newUser.setFail_attemp(0);
			newUser.setPasswordChangedTime(null);
			super.saveOrUpdate(newUser);
		}
	}

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

//	//ajax
//	@Transactional
//	public User edit(USERdemo user) throws Exception {
//		//lay thong tin trong db
//		User userOnDb = super.getById(user.getId());
//		
//		Calendar cal = Calendar.getInstance();
//		Date ngay = cal.getTime();
//		
//		userOnDb.setCreated_date(userOnDb.getCreated_date());
//		userOnDb.setEmail(userOnDb.getEmail());
//		userOnDb.setProvider(userOnDb.getProvider());
//		userOnDb.setUsername(userOnDb.getUsername());
//		userOnDb.setStatus(true);
//		userOnDb.setUpdated_date(ngay);
//		userOnDb.setFull_name(user.getFull_name());
//		
//		//kiểm tra xem có upload avatar k
//		if(!isEmptyUploadFile(user.getFile())) {
//			//xóa file trong folder
//			new File("C:/Users/ASUS/eclipse-workspace/com.devpro.drakestore/Uploads/"+userOnDb.getAvatar()).delete();
//			
//			String path = "C:/Users/ASUS/eclipse-workspace/com.devpro.drakestore/Uploads/users/avatars/"
//					+user.getFile().getOriginalFilename();
//			user.getFile().transferTo(new File(path));
//			userOnDb.setAvatar("/users/avatars/"+user.getFile().getOriginalFilename());
//		}else {
//			//sd lai avatar cũ
//			userOnDb.setAvatar(userOnDb.getAvatar());
//		}
//
//		//luu vao db
//		return super.saveOrUpdate(userOnDb);
//	}

	// controller basic edit user
	@Transactional
	public User edit1(User user, MultipartFile userAvatar) throws Exception {
		// lay thong tin trong db
		User userOnDb = super.getById(user.getId());

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		user.setCreated_date(userOnDb.getCreated_date());
		user.setEmail(userOnDb.getEmail());
		user.setProvider(userOnDb.getProvider());
		user.setUsername(userOnDb.getUsername());
		user.setFail_attemp(userOnDb.getFail_attemp());
		user.setLock_time(userOnDb.getLock_time());
		user.setPasswordChangedTime(userOnDb.getPasswordChangedTime());
		user.setStatus(true);
		user.setUpdated_date(ngay);
		user.setCreated_by(userOnDb.getCreated_by());
		user.setPassword(userOnDb.getPassword());
		// user.setFull_name(userOnDb.getFull_name());
		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(userAvatar)) {
			// xóa file trong folder
			new File(UPLOAD_FOLDER_ROOT + userOnDb.getAvatar()).delete();

			String path = UPLOAD_FOLDER_ROOT + "users/avatars/" + userAvatar.getOriginalFilename();
			userAvatar.transferTo(new File(path));
			user.setAvatar("/users/avatars/" + userAvatar.getOriginalFilename());
		} else {
			// sd lai avatar cũ
			user.setAvatar(userOnDb.getAvatar());
		}

		// luu vao db

		return super.saveOrUpdate(user);
	}

	// edit admin
	@Transactional
	public User edit2(User user, MultipartFile userAvatar) throws Exception {
		// lay thong tin trong db
		User userOnDb = super.getById(user.getId());

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		if (!StringUtils.isEmpty(user.getPassword())) {
			if (user.getPassword().equals(userOnDb.getPassword())) {
				user.setPassword(userOnDb.getPassword());
			} else {
				BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
				String encodedPassword = passwordEncoder.encode(user.getPassword());
				user.setPassword(encodedPassword);
			}
		} else {
			user.setPassword(null);
		}

		user.setCreated_date(userOnDb.getCreated_date());
		user.setUpdated_date(ngay);
		user.setProvider(userOnDb.getProvider());
		user.setUpdated_date(ngay);
		user.setCreated_by(userOnDb.getCreated_by());
		user.setFail_attemp(userOnDb.getFail_attemp());
		user.setLock_time(userOnDb.getLock_time());
		user.setPasswordChangedTime(userOnDb.getPasswordChangedTime());
		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(userAvatar)) {
			// xóa file trong folder
			new File(UPLOAD_FOLDER_ROOT + userOnDb.getAvatar()).delete();

			String path = UPLOAD_FOLDER_ROOT + "users/avatars/" + userAvatar.getOriginalFilename();
			userAvatar.transferTo(new File(path));
			user.setAvatar("/users/avatars/" + userAvatar.getOriginalFilename());
		} else {
			// sd lai avatar cũ
			user.setAvatar(userOnDb.getAvatar());
		}

		// luu vao db
		return super.saveOrUpdate(user);
	}

	// controller basic
	@Transactional
	public User register(User user, MultipartFile userAvatar) throws Exception {
		// lay thong tin trong db
		// User userOnDb = super.getById(user.getId());

		if (user.getRoles().size() <= 0) {
			Role role = roleService.loadRoleByName("USER");
			user.addRoles(role);
		}

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		user.setCreated_date(ngay);
		user.setProvider("LOCAL");
		user.setStatus(true);
		user.setFail_attemp(0);
		user.setLock_time(null);
		user.setPasswordChangedTime(ngay);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);

		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(userAvatar)) {
			// xóa file trong folder
			// new
			// File("C:/Users/ASUS/eclipse-workspace/com.devpro.drakestore/Uploads/"+userOnDb.getAvatar()).delete();

			String path = UPLOAD_FOLDER_ROOT + "users/avatars/" + userAvatar.getOriginalFilename();
			userAvatar.transferTo(new File(path));
			user.setAvatar("/users/avatars/" + userAvatar.getOriginalFilename());
		} else {
			// sd lai avatar cũ
			user.setAvatar(null);
		}

		// luu vao db
		return super.saveOrUpdate(user);
	}

	public User findbyEmail(String email) {
		String sql = "select * from tbl_users u where u.email = '" + email + "' and u.provider= 'LOCAL'";
		List<User> users = this.executeNativeSql1(sql);
		if (users == null || users.size() <= 0)
			return null;
		return users.get(0);
	}

	public User findbyToken(String token) {
		String sql = "select * from tbl_users u where u.reset_password_token = '" + token + "'";
		List<User> users = this.executeNativeSql1(sql);
		if (users == null || users.size() <= 0)
			return null;
		return users.get(0);
	}

	@Transactional
	public void updateResetPasswordToken(String token, String email) throws UserNotFoundException {
		User user = findbyEmail(email);
		if (user != null) {
			user.setReset_password_token(token);
			super.saveOrUpdate(user);
		} else {
			throw new UserNotFoundException("Could not find any user with the email " + email);
		}
	}

	@Transactional
	public void updatePassword(User user, String newPassword) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(4);
		String encodedPassword = passwordEncoder.encode(newPassword);
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		user.setPasswordChangedTime(ngay);
		user.setPassword(encodedPassword);
		user.setReset_password_token(null);
		super.saveOrUpdate(user);
	}

	@Transactional
	public void deleteUserByID(int Id) {

		User onDB = this.getById(Id);
		String path = onDB.getAvatar();
		new File(UPLOAD_FOLDER_ROOT + path).delete();

		super.deleteById(Id);
	}

	public static void main(String[] args) {
		String a = "abc";
		String b = "abc";
		a.concat(b);
		System.out.println(a);
	}
}
