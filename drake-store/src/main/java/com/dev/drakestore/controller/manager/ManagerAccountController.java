package com.dev.drakestore.controller.manager;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.controller.user.BaseController;
import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Blog;
import com.dev.drakestore.entities.Comment;
import com.dev.drakestore.entities.Role;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.BlogService;
import com.dev.drakestore.service.CommentService;
import com.dev.drakestore.service.RoleService;
import com.dev.drakestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ManagerAccountController extends BaseController {
	@Autowired
	UserService userService;

	@Autowired
	RoleService roleService;

	@Autowired
	CommentService commentService;

	@Autowired
	BlogService blogService;

	@RequestMapping(value = { "/admin/account/list-accounts" }, method = RequestMethod.GET) // -> action
	public String contact(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {

		int sizeOfPage = 5;
		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<User> users = userService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<User> users1 = userService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalUsers = users1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalUsers % sizeOfPage == 0) {
			totalPage = totalUsers / sizeOfPage;
		} else {
			totalPage = totalUsers / sizeOfPage + 1;
		}

		model.addAttribute("totalUsers", users1.size());
		// day xuosng view de xu li
		model.addAttribute("users", users);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("totalDisplay", users.size());
		model.addAttribute("sizeOfPage", sizeOfPage);

		// day keyword xuong view de xư li
		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());

		model.addAttribute("productSearch", ps);

		return "manager/list-users"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/account/list-accounts" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
														 final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 5;
		List<User> users = userService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<User> users1 = userService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalUsers = users1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalUsers % sizeOfPage == 0) {
			totalPage = totalUsers / sizeOfPage;
		} else {
			totalPage = totalUsers / sizeOfPage + 1;
		}

		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Username</th>" + "<th>Email</th>" + "<th>Full_name</th>"
				+ "<th>Avatar</th>" + "<th>Provider</th>" + "<th>Status</th>" + "<th>Update</th>" + "</tr>";

		int index = 1;
		for (User c : users) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getUsername() + "</td>" + "<td>"
					+ c.getEmail() + "</td>" + "<td>" + c.getFull_name() + "</td> ";
			if (c.getAvatar() != null) {
				html += "<td><img alt=\"\" src=\"/upload/" + c.getAvatar() + "\"></td> ";
			} else {
				html += "<td></td> ";
			}

			html += "<td>" + c.getProvider() + "</td>";
			if (c.isStatus()) {
				html += "<td>Active</td>";
			} else {
				html += "<td>InActive</td>";
			}

			html += "<td>" + "<a href=\"/admin/account/edit-account/" + c.getUsername()
					+ "\" style=\"text-decoration:none;color:blue;font-weight:bolder\"><i class=\"fas fa-edit\"></i></a><br>";
//			if (!ps.getFilter().equals("deleted")) {
//				html += "<p class=\"confirmation\" style=\"text-decoration:none;color:red;cursor: pointer;font-weight:bolder\">Ẩn</p>";
//				// System.out.println(ps.getFilter());
//			}
			html += "<p class=\"confirmation1\" style=\"text-decoration:underline;color:red;cursor: pointer;font-weight: bolder\"><i class=\"fas fa-trash\"></i></p>";
			html += "</td>";
			index++;
		}

		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("html", html);
		jsonResult.put("curPage", ps.getPage());
		jsonResult.put("totalPage", totalPage);
		jsonResult.put("totalAccounts", totalUsers);
		jsonResult.put("totalDisplay", users.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/account/add-account" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		List<Role> roles = roleService.findAllActive();

		// day xuosng view de xu li
		model.addAttribute("roles", roles);

		model.addAttribute("newUser", new User());
		// cac views se duoc dat tai thu muc:
		return "manager/add-account"; // -> duong dan toi VIEW.
	}

	// register
	@RequestMapping(value = { "/admin/account/add-account" }, method = RequestMethod.POST)
	public String AddOrEdit(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("newUser") User user, @RequestParam("userAvatar") MultipartFile userAvatar,
			@RequestParam("role") String[] roles, RedirectAttributes redirectAttributes) throws Exception {

		// trường hợp thêm mới
		if (user.getId() == null || user.getId() <= 0) {

			for (int i = 0; i < roles.length; i++) {
				user.addRoles(roleService.loadRoleByName(roles[i]));
			}

			User user1 = userService.loadUserByUsername(user.getUsername());
			User user2 = userService.findbyEmail(user.getEmail());
			// nếu username hoặc email đã tồn tại thì không cho phép sửa
			if (user1 != null && user2 != null) {
				redirectAttributes.addFlashAttribute("msg", "Thêm mới không thành công, username và email đã tồn tại!");
				return "redirect:/admin/account/add-account";
			} else if (user1 != null && user2 == null) {
				redirectAttributes.addFlashAttribute("msg", "Thêm mới không thành công, username đã tồn tại!");
				return "redirect:/admin/account/add-account";
			} else if (user1 == null && user2 != null) {
				redirectAttributes.addFlashAttribute("msg", "Thêm mới không thành công, email đã tồn tại!");
				return "redirect:/admin/account/add-account";
			} else {

				user.setCreated_by(getUserLogined().getId());
				userService.register(user, userAvatar);
				redirectAttributes.addFlashAttribute("msg1", "Thêm mới thành công");
				return "redirect:/admin/account/add-account";
			}
		} else {
			User userOnDB = userService.getById(user.getId());

			// trường hợp sửa mà username và email giữ nguyên
			if (userOnDB.getUsername().equals(user.getUsername()) && userOnDB.getEmail().equals(user.getEmail())) {

				// trường hợp user đăng đăng nhập # vs user đang sửa
				if (getUserLogined().getId() != userOnDB.getId()) {
					if (userOnDB.getProvider().equals("FACEBOOK") || userOnDB.getProvider().equals("GOOGLE")) {
						user.setUpdated_by(getUserLogined().getId());
						for (Role r : roleService.findAll()) {
							if (r.getUsers().contains(userOnDB)) {
								r.deleteUsers(userOnDB);
								roleService.saveOrUpdate(r);
								r.addUsers(userOnDB);
								roleService.saveOrUpdate(r);
							}
						}
						// user.setPassword(null);
						// user.setUsername(userOnDB.getUsername());
						// user.setEmail(userOnDB.getEmail());
						userService.edit2(user, userAvatar);

						redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
						return "redirect:/admin/account/list-accounts";
					} else {
						for (Role r : roleService.findAll()) {
							if (r.getUsers().contains(userOnDB)) {
								r.deleteUsers(userOnDB);
								roleService.saveOrUpdate(r);
							}
						}
						for (int i = 0; i < roles.length; i++) {
							user.addRoles(roleService.loadRoleByName(roles[i]));
						}

						user.setUpdated_by(getUserLogined().getId());
						userService.edit2(user, userAvatar);
						redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
						return "redirect:/admin/account/list-accounts";
					}

				} else {
					user.setUpdated_by(getUserLogined().getId());
					for (Role r : roleService.findAll()) {
						if (r.getUsers().contains(userOnDB)) {
							r.deleteUsers(userOnDB);
							roleService.saveOrUpdate(r);
							r.addUsers(userOnDB);
							roleService.saveOrUpdate(r);
						}
					}

					userService.edit2(user, userAvatar);

					// hiern thì lại tện của user đăng nhập trên màn hình
					User userAfterEdit = userService.getById(user.getId());
					getUserLogined().setFull_name(user.getFull_name());
					getUserLogined().setAvatar(userAfterEdit.getAvatar());
					getUserLogined().setUsername(userAfterEdit.getUsername());
					redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
					return "redirect:/admin/account/list-accounts";
				}

			}
			// trường hợp username giữ nguyên, email thay đổi
			else if (userOnDB.getUsername().equals(user.getUsername())
					&& !userOnDB.getEmail().equals(user.getEmail())) {

				User user2 = userService.findbyEmail(user.getEmail());
				// nếu email thay đổi đã tồn tại thì k cho phép sửa
				if (user2 != null) {
					redirectAttributes.addFlashAttribute("msg", "Cập nhật không thành công, email đã tồn tại!");
					return "redirect:/admin/account/edit-account/" + userOnDB.getUsername();
				} else {
					// trường hợp user đăng đăng nhập # vs user đang sửa
					if (getUserLogined().getId() != userOnDB.getId()) {
						if (userOnDB.getProvider().equals("FACEBOOK") || userOnDB.getProvider().equals("GOOGLE")) {
							user.setUpdated_by(getUserLogined().getId());
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
									r.addUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							// user.setPassword(null);
							// user.setUsername(userOnDB.getUsername());
							// user.setEmail(userOnDB.getEmail());
							userService.edit2(user, userAvatar);

							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						} else {
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							for (int i = 0; i < roles.length; i++) {
								user.addRoles(roleService.loadRoleByName(roles[i]));
							}

							user.setUpdated_by(getUserLogined().getId());
							userService.edit2(user, userAvatar);
							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						}
					} else {
						user.setUpdated_by(getUserLogined().getId());
						for (Role r : roleService.findAll()) {
							if (r.getUsers().contains(userOnDB)) {
								r.deleteUsers(userOnDB);
								roleService.saveOrUpdate(r);
								r.addUsers(userOnDB);
								roleService.saveOrUpdate(r);
							}
						}
						userService.edit2(user, userAvatar);
						// hiern thì lại tện của user đăng nhập trên màn hình
						User userAfterEdit = userService.getById(user.getId());
						getUserLogined().setFull_name(user.getFull_name());
						getUserLogined().setAvatar(userAfterEdit.getAvatar());
						getUserLogined().setUsername(userAfterEdit.getUsername());
						redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
						return "redirect:/admin/account/list-accounts";
					}
				}

			}
			// trường hợp username thay đổi, email giữ nguyên
			else if (!userOnDB.getUsername().equals(user.getUsername())
					&& userOnDB.getEmail().equals(user.getEmail())) {

				User user1 = userService.loadUserByUsername(user.getUsername());
				// nếu username đã tồn tại thì k cho phép sửa
				if (user1 != null) {
					redirectAttributes.addFlashAttribute("msg", "Cập nhật không thành công, username đã tồn tại!");
					return "redirect:/admin/account/edit-account/" + userOnDB.getUsername();
				} else {
					// trường hợp user đăng đăng nhập # vs user đang sửa
					if (getUserLogined().getId() != userOnDB.getId()) {
						if (userOnDB.getProvider().equals("FACEBOOK") || userOnDB.getProvider().equals("GOOGLE")) {
							user.setUpdated_by(getUserLogined().getId());
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
									r.addUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							// user.setPassword(null);
							// user.setUsername(userOnDB.getUsername());
							// user.setEmail(userOnDB.getEmail());
							userService.edit2(user, userAvatar);

							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						} else {
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							for (int i = 0; i < roles.length; i++) {
								user.addRoles(roleService.loadRoleByName(roles[i]));
							}

							user.setUpdated_by(getUserLogined().getId());
							userService.edit2(user, userAvatar);
							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						}
					} else {
						user.setUpdated_by(getUserLogined().getId());
						for (Role r : roleService.findAll()) {
							if (r.getUsers().contains(userOnDB)) {
								r.deleteUsers(userOnDB);
								roleService.saveOrUpdate(r);
								r.addUsers(userOnDB);
								roleService.saveOrUpdate(r);
							}
						}
						userService.edit2(user, userAvatar);
						// hiern thì lại tện của user đăng nhập trên màn hình
						User userAfterEdit = userService.getById(user.getId());
						getUserLogined().setFull_name(user.getFull_name());
						getUserLogined().setAvatar(userAfterEdit.getAvatar());
						getUserLogined().setUsername(userAfterEdit.getUsername());
						redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
						return "redirect:/admin/account/list-accounts";
					}
				}
			}
			// trường hơp cả email và username đều sửa
			else {

				User user1 = userService.loadUserByUsername(user.getUsername());
				User user2 = userService.findbyEmail(user.getEmail());

				// nếu username hoặc email đã tồn tại thì không cho phép sửa
				if (user1 != null && user2 != null) {
					redirectAttributes.addFlashAttribute("msg",
							"Cập nhật không thành công, username và email đã tồn tại!");
					return "redirect:/admin/account/edit-account/" + userOnDB.getUsername();
				} else if (user1 != null && user2 == null) {
					redirectAttributes.addFlashAttribute("msg", "Cập nhật không thành công, username đã tồn tại!");
					return "redirect:/admin/account/edit-account/" + userOnDB.getUsername();
				} else if (user1 == null && user2 != null) {
					redirectAttributes.addFlashAttribute("msg", "Cập nhật không thành công, email đã tồn tại!");
					return "redirect:/admin/account/edit-account/" + userOnDB.getUsername();
				}

				else {
					// trường hợp user đăng đăng nhập # vs user đang sửa
					if (getUserLogined().getId() != userOnDB.getId()) {
						if (userOnDB.getProvider().equals("FACEBOOK") || userOnDB.getProvider().equals("GOOGLE")) {
							user.setUpdated_by(getUserLogined().getId());
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
									r.addUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							// user.setPassword(null);
							// user.setUsername(userOnDB.getUsername());
							// user.setEmail(userOnDB.getEmail());
							userService.edit2(user, userAvatar);

							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						} else {
							for (Role r : roleService.findAll()) {
								if (r.getUsers().contains(userOnDB)) {
									r.deleteUsers(userOnDB);
									roleService.saveOrUpdate(r);
								}
							}
							for (int i = 0; i < roles.length; i++) {
								user.addRoles(roleService.loadRoleByName(roles[i]));
							}

							user.setUpdated_by(getUserLogined().getId());
							userService.edit2(user, userAvatar);
							redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
							return "redirect:/admin/account/list-accounts";
						}
					} else {
						user.setUpdated_by(getUserLogined().getId());
						for (Role r : roleService.findAll()) {
							if (r.getUsers().contains(userOnDB)) {
								r.deleteUsers(userOnDB);
								roleService.saveOrUpdate(r);
								r.addUsers(userOnDB);
								roleService.saveOrUpdate(r);
							}
						}
						userService.edit2(user, userAvatar);
						// hiern thì lại tện của user đăng nhập trên màn hình
						User userAfterEdit = userService.getById(user.getId());
						getUserLogined().setFull_name(user.getFull_name());
						getUserLogined().setAvatar(userAfterEdit.getAvatar());
						getUserLogined().setUsername(userAfterEdit.getUsername());
						redirectAttributes.addFlashAttribute("msg1", "Cập nhật thành công");
						return "redirect:/admin/account/list-accounts";
					}
				}
			}

		}
		// return "redirect:/admin/add-account";
	}

	@RequestMapping(value = { "/admin/account/edit-account/{username}" }, method = RequestMethod.GET) // -> action
	public String editCategory(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("username") String username, RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		User user = userService.loadUserByUsername(username);
		if (user != null) {
			if (user.getProvider().equals("FACEBOOK") || user.getProvider().equals("GOOGLE")) {
				model.addAttribute("SOCIAL", true);

			} else {
				model.addAttribute("SOCIAL", false);
			}
			// can lay danh sach categories tu db vaf tra ve view qau model
			List<Role> roles = roleService.findAllActive();

			// day xuosng view de xu li
			model.addAttribute("roles", roles);

			model.addAttribute("newUser", user);
			model.addAttribute("userRoles", user.getRoles());
			return "manager/add-account"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("msg", "Tài khoản không tồn tại");
			return "redirect:/admin/account/list-accounts";
		}

	}

	// xoa ajax chi doi status = 0
	@RequestMapping(value = { "/admin/account/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody User user) {

		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		User User = userService.getById(user.getId());

		if (User != null) {
			User.setStatus(false);
			User.setUpdated_date(date);
			User.setUpdated_by(getUserLogined().getId());

			userService.saveOrUpdate(User);
		}

		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("accountName", User.getUsername());
		return ResponseEntity.ok(jsonResult);
	}

	// khi nào làm đén thì làm phần update số lượng comments khi xoa suser
	// khi nào làm đén thì làm phần update số lượng comments khi xoa suser
	// khi nào làm đén thì làm phần update số lượng comments khi xoa suser

	// done

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/account/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody User user) {
		System.out.println(user.getId());
		if (getUserLogined().getId() == user.getId()) {
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("msg", "Xóa không thành công. Không được phép xóa tài khoản đang đăng nhập");
			return ResponseEntity.ok(jsonResult);
		} else {
			User User = userService.getById(user.getId());
			// phải xóa bỏ role trc khi xóa vì nếu k sẽ xóa tất cả các user có cùng role vs
			// user bị xóa
			if (User != null) {
				for (Role r : roleService.findAll()) {
					if (r.getUsers().contains(User)) {
						r.deleteUsers(User);
						roleService.saveOrUpdate(r);
					}
				}
				userService.saveOrUpdate(User);
				userService.deleteUserByID(User.getId());

				// update comments

//				List<Blog> blogs = blogService.findAll();
//				for (Blog b : blogs) {
//					List<Comment> comments = commentService.findByBlogId(b.getId());
//					b.setComments(comments.size());
//					blogService.saveOrUpdate(b);
//				}
				// System.out.println(User.getRoles().size());
				// trả kết quả
				Map<String, Object> jsonResult = new HashMap<String, Object>();
				jsonResult.put("code", 200);
				jsonResult.put("status", "TC");
				// jsonResult.put("accountName", User.getUsername());
				jsonResult.put("msg", "Xóa thành công.");
				return ResponseEntity.ok(jsonResult);
			} else {
				// trả kết quả
				Map<String, Object> jsonResult = new HashMap<String, Object>();
				jsonResult.put("code", 200);
				jsonResult.put("status", "TC");
				// .put("accountName", User.getUsername());
				jsonResult.put("msg", "Xóa không thành công. Tài khoản không tồn tại");
				return ResponseEntity.ok(jsonResult);
			}

		}
	}

}
