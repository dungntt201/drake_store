package com.dev.drakestore.controller.manager;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.BlogService;
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

import com.github.slugify.Slugify;

@Controller
public class ManagerBlogController extends BaseController {
	@Autowired
	BlogService blogService;

	@Autowired
	UserService userService;

	@RequestMapping(value = { "/admin/list-blogs" }, method = RequestMethod.GET) // -> action
	public String contact(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {

		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		// System.out.println(ps.getKeyword());
		int sizeOfPage = 10;
		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<Blog> blogs = blogService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Blog> blogs1 = blogService.search1(ps);

		List<User> users = userService.findAll();
		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalBlogs = blogs1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalBlogs % sizeOfPage == 0) {
			totalPage = totalBlogs / sizeOfPage;
		} else {
			totalPage = totalBlogs / sizeOfPage + 1;
		}

		model.addAttribute("totalDisplay", blogs.size());
		model.addAttribute("totalBlogs", blogs1.size());
		// day xuosng view de xu li
		model.addAttribute("blogs", blogs);

		model.addAttribute("users", users);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sizeOfPage", sizeOfPage);
		model.addAttribute("productSearch", ps);
		// cac views se duoc dat tai thu muc:
//		System.out.println(totalPage);
//		System.out.println(ps.getPage());
		return "manager/list-blogs"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-blogs" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// lấy bản ghi theo size phan trang theo key word và page
		List<Blog> blogs = blogService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Blog> blogs1 = blogService.search1(ps);

		List<User> users = userService.findAll();
		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalBlogs = blogs1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalBlogs % sizeOfPage == 0) {
			totalPage = totalBlogs / sizeOfPage;
		} else {
			totalPage = totalBlogs / sizeOfPage + 1;
		}
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Title</th>" + "<th>Avatar</th>" + "<th>Author</th>"
				+ "<th>Created date</th>" + "<th>Status</th>" + "<th>Tag</th>" + "<th>Update</th>" + "</tr>";

		int index = 1;
		for (Blog c : blogs) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getTitle() + "</td>"
					+ "<td><img alt=\"\" src=\"/upload/" + c.getAvatar() + "\"></td> ";

//			if (c.getAuthor() != null) {
//				for (User u : users) {
//					if (u.getId() == c.getCreated_by()) {
			html += "<td>" + c.getAuthor() + "</td>";
//					}
//				}
//			} else {
//				html += "<td></td>";
//			}

//			if (c.getUpdated_by() != null) {
//				for (User u : users) {
//					if (u.getId() == c.getUpdated_by()) {
//						html += "<td>" + u.getFull_name() + "</td>";
//					}
//				}
//			} else {
//				html += "<td></td>";
//			}
			html += "<td>" + formatter.format(c.getCreated_date()) + "</td>";
			if (c.isStatus()) {
				html += "<td>Active</td>";
			} else {
				html += "<td>InActive</td>";
			}
			html += "<td>" + c.getTag() + "</td>";

			html += "<td>" + "<a href=\"/admin/edit-blog/" + c.getSeo()
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
		jsonResult.put("totalBlogs", totalBlogs);
		jsonResult.put("totalDisplay", blogs.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/add-blogs" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		// List<Categories> categories = categoriesService.findAll();

		// day xuosng view de xu li
		// model.addAttribute("categories",categories);

		model.addAttribute("blog", new Blog());
		// cac views se duoc dat tai thu muc:
		return "manager/add-blog"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/add-blogs" }, method = RequestMethod.POST) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("blog") Blog blog, @RequestParam("blogAvatar") MultipartFile blogAvatar,
			RedirectAttributes redirectAttributes)
			// truyên attribute cho trang direct cần thuộc tính RedirectAttributes

			throws Exception {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		// kiem tra xem action la them moi hay chinh sua
		if (blog.getId() == null || blog.getId() <= 0) {
			blog.setSeo(new Slugify().slugify(blog.getTitle() + " " + String.valueOf(System.currentTimeMillis())));
			blog.setCreated_by(getUserLogined().getId());
			blog.setAuthor(getUserLogined().getFull_name());
			blog.setCreated_date(ngay);
			blogService.save(blog, blogAvatar);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Thêm mới thành công");
			return "redirect:/admin/add-blogs";

		} else {
			Blog onDB = blogService.getById(blog.getId());
			blog.setCreated_date(onDB.getCreated_date());
			blog.setUpdated_date(ngay);
			blog.setAuthor(onDB.getAuthor());
			blog.setCreated_by(onDB.getCreated_by());
			blog.setUpdated_by(getUserLogined().getId());
			blog.setSeo(new Slugify().slugify(blog.getTitle() + " " + String.valueOf(System.currentTimeMillis())));
			// System.out.println(product.getId());
			blogService.edit(blog, blogAvatar);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
			return "redirect:/admin/list-blogs";
		}
		// return "manager/add-or-edit-product-success"; // -> duong dan toi VIEW.

	}

	@RequestMapping(value = { "/admin/edit-blog/{blogSeo}" }, method = RequestMethod.GET) // -> action
	public String editProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("blogSeo") String blogSeo, RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		Blog blog = blogService.findBySeo(blogSeo);
		if (blog != null) {
			model.addAttribute("blog", blog);
			return "manager/add-blog"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("msg1", "Bài viết không tồn tại");
			return "redirect:/admin/list-blogs";
		}
		// return blogSeo;

	}

	// xoa ajax chi doi status = 0
	@RequestMapping(value = { "/admin/blog/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Blog blog) {

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		Blog Blog = blogService.getById(blog.getId());

		if (Blog != null) {
			// Category.setUpdated_by(Category.getUpdated_by());
			Blog.setStatus(false);

			Blog.setUpdated_date(ngay);
			Blog.setUpdated_by(getUserLogined().getId());

			blogService.saveOrUpdate(Blog);
		}
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("blogName", Blog.getTitle());
		return ResponseEntity.ok(jsonResult);
	}

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/blog/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Blog blog) {

		Blog Blog = blogService.getById(blog.getId());
		if (Blog != null) {
			// xóa bản ghi
			blogService.deleteBlogByID(Blog.getId());
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("blogName", Blog.getTitle());
			jsonResult.put("msg", "Xóa thành công.");
			return ResponseEntity.ok(jsonResult);
		} else {
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			// .put("accountName", User.getUsername());
			jsonResult.put("msg", "Xóa không thành công. Bài viết không tồn tại");
			return ResponseEntity.ok(jsonResult);
		}

	}

	// xoa khoir DB
//	@RequestMapping(value = { "/admin/deleted-blog/{blogId}" }, method = RequestMethod.GET) // -> action
//	public String delete(final Model model, final HttpServletRequest request, final HttpServletResponse response,
//			@PathVariable("blogID") int blogId, RedirectAttributes redirectAttributes) throws IOException {
//
//		Blog blog = blogService.getById(blogId);
//		if (blog != null) {
//			// day xuosng view de xu li
//			model.addAttribute("blog", blog);
//			// xóa bản ghi
//			blogService.deleteBlogByID(blogId);
//			redirectAttributes.addFlashAttribute("msg", "Bạn đã xóa thành công 1 blog");
//			return "redirect:/admin/list-blogs"; // -> duong dan toi VIEW.
//		}
//		return null;
//	}
}
