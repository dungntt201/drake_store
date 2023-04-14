package com.dev.drakestore.controller.user;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Blog;
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.Comment;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.BlogService;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.CommentService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class BlogController extends BaseController {
	@Autowired
	BlogService blogService;

	@Autowired
	CategoriesService categoriesService;

	@Autowired
	CommentService commentService;

	@Autowired
	UserService userService;

	@RequestMapping(value = { "/blogs" }, method = RequestMethod.GET) // -> action
	public String blog(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		int sizeOfPage = 5;
		// String keyword = request.getParameter("keyword");
		ProductSearch ps = new ProductSearch();
		// ps.setKeyword(keyword);
		ps.setFilter("active");// chỉ lấy các blog active
		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<Blog> blogs = blogService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Blog> blogs1 = blogService.search1(ps);

		// lấy all tags
		ArrayList<String> tags = new ArrayList<String>();

		for (Blog b : blogs1) {
			if (!tags.contains(b.getTag()) && b.isStatus()) {
				tags.add(b.getTag());
			}
		}

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

		List<User> user = userService.findAll();
		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);

		model.addAttribute("totalBlogs", blogs1.size());
		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", blogs.size());

		model.addAttribute("totalBlogs1", blogs1);

		model.addAttribute("totalTags", tags);
		// day xuosng view de xu li
		model.addAttribute("blogs", blogs);
		model.addAttribute("user", user);
		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());
		model.addAttribute("sizeOfPage", sizeOfPage);
		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		//
		// model.addAttribute("keyword", keyword);
		// cac views se duoc dat tai thu muc:
//		System.out.println(totalPage);
//		System.out.println(ps.getPage());

		return "user/blogs"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/blogs" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 5;
		ps.setFilter("active");// chỉ lấy blog active
		// System.out.println(ps.getTag());
		// String keyword = request.getParameter("keyword");
		// ps.setKeyword(keyword);
		// lấy bản ghi theo size phan trang theo key word và page
		List<Blog> blogs = blogService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Blog> blogs1 = blogService.search1(ps);

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

		List<User> user = userService.findAll();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		for (Blog b : blogs) {
			html += "<div class=\"all-blogs1\">" + "<a href=\"/blogs/" + b.getSeo() + "\">"
					+ "<img alt=\"img-blog\" src=\"/upload/" + b.getAvatar() + "\">" + "</a>" + "<p class=\"date\">"
					+ formatter.format(b.getCreated_date()) + "</p>" + "<a href=\"/blogs/tag/" + b.getTag()
					+ "\" class=\"tag\">" + b.getTag() + "</a>" + "<br>"
					+ "<p class=\"title\"><a  href=\"/${blog.seo}\">" + b.getTitle() + "</a></p>"
					+ "<div class=\"author\">" + "<div class=\"author1\">";

			html += "<p><i class=\"fas fa-user\"></i> <a href=\"#\">" + b.getAuthor() + "</a></p>";

			html += "</div>" + "<div class=\"comments\">";
			if (b.getComments() == null || b.getComments() == 0) {
				html += "<p><i class=\"fas fa-comments\"></i><span>0 Comments</span></p>";
			} else {
				html += "<p><i class=\"fas fa-comments\"></i><span>" + b.getComments() + " Comments</span></p>";
			}
			html += "</div>" + "</div>" + "<p class=\"short-content\">" + b.getShort_content() + "</p>"
					+ "<p class=\"btnn\"><a href=\"/blogs/" + b.getSeo()
					+ "\">Đọc thêm   <i class=\"fas fa-arrow-right\"></i></a></p>" + "</div>";
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

	@RequestMapping(value = { "/blogs/tag/{blogTag}" }, method = RequestMethod.GET) // -> action
	public String blogTag(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("blogTag") String blogTag) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		int sizeOfPage = 5;
		String tag = blogTag;
		ProductSearch ps = new ProductSearch();
		ps.setTag(blogTag);
		ps.setFilter("active");
		// lấy blog active
		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<Blog> blogs = blogService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Blog> blogs1 = blogService.search1(ps);

		//
		List<Blog> blogs2 = blogService.findAll();
		// lấy all tags
		ArrayList<String> tags = new ArrayList<String>();

		for (Blog b : blogs2) {
			if (!tags.contains(b.getTag()) && b.isStatus()) {
				tags.add(b.getTag());
			}
		}

		List<User> user = userService.findAll();
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

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("user", user);
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);

		model.addAttribute("totalBlogs", blogs1.size());
		model.addAttribute("totalBlogs1", blogs1);
		model.addAttribute("totalTags", tags);
		// day xuosng view de xu li
		model.addAttribute("blogs", blogs);
		model.addAttribute("totalDisplay", blogs.size());
		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());
		model.addAttribute("sizeOfPage", sizeOfPage);
		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("tag", blogTag);
		// cac views se duoc dat tai thu muc:
//		System.out.println(totalPage);
//		System.out.println(ps.getPage());
		return "user/tag-blogs"; // -> duong dan toi VIEW.
	}

	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet
	/// warning đang còn thiếu phần phân trang cho các blog theo Tag tajm thowif k
	/// phaan vif mooix tag cos 1 bai viet

	@RequestMapping(value = { "/blogs/{blogSeo}" }, method = RequestMethod.GET) // -> action
	public String detailBlog(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("blogSeo") String blogSeo) throws IOException {

		List<User> user = userService.findAll();
		ProductSearch ps = new ProductSearch();
		ps.setPage(getCurrentPage(request));
		// lay sp tu database
		Blog blog = blogService.findBySeo(blogSeo);
		ps.setBlog_id(blog.getId());

		if (blog != null) {
			int sizeOfPage = 10;
			// Blog blog = blogs.get(0);
			// đẩy cmt
			Comment cmt = new Comment();
			cmt.setBlogs(blog);
			List<Comment> comments = commentService.search(ps, sizeOfPage);
			List<Comment> comments1 = commentService.search1(ps);

			// lấy số lượng bản ghi full để tính tổng số trang phân đc
			int totalCmts = comments1.size();
			// lấy số bản ghi 1 trang
			/* int sizeOfPage = productService.sizeOfPage(); */
			// tổng số trang
			int totalPage;
			// tính số page = số bản ghi / sizeofpage
			if (totalCmts % sizeOfPage == 0) {
				totalPage = totalCmts / sizeOfPage;
			} else {
				totalPage = totalCmts / sizeOfPage + 1;
			}

			// day xuosng view de xu li

			// láy category cha và con
			List<Categories> fullParent = categoriesService.findFullParentCategories();
			List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

			// để in ra tất cả các tag
			List<Blog> blogs2 = blogService.findAll();

			// lấy all tags
			ArrayList<String> tags = new ArrayList<String>();

			for (Blog b : blogs2) {
				if (!tags.contains(b.getTag()) && b.isStatus()) {
					tags.add(b.getTag());
				}
			}

			// day trang hien tai xuong view de phan trang
			model.addAttribute("curPage", getCurrentPage(request));
			model.addAttribute("totalCmts", comments1.size());
			// day tong so trang xuosng view de xu li
			model.addAttribute("totalPage", totalPage);
			// lay cmt cua blog
			model.addAttribute("cmts", comments);
			// laays toong cmt cuar blog
			// model.addAttribute("")
			model.addAttribute("user", user);
			// cmt trong form
			model.addAttribute("cmt", cmt);
			model.addAttribute("parentCategories", fullParent);
			model.addAttribute("childrenCategories", fullChildren);
			model.addAttribute("totalTags", tags);
			model.addAttribute("blog", blog);
			model.addAttribute("blogSeo", blogSeo);
			return "user/detail-blog"; // -> duong dan toi VIEW.
		}
		return blogSeo;

	}

	@RequestMapping(value = { "/PhanTrangCmts" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang1(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// String keyword = request.getParameter("keyword");
		// ps.setKeyword(keyword);
		// lấy bản ghi theo size phan trang theo key word và page
		List<Comment> comments = commentService.search(ps, sizeOfPage);
		List<Comment> comments1 = commentService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalCmts = comments1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalCmts % sizeOfPage == 0) {
			totalPage = totalCmts / sizeOfPage;
		} else {
			totalPage = totalCmts / sizeOfPage + 1;
		}
		System.out.println(ps.getBlog_id());
		List<User> user = userService.findAll();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		for (Comment c : comments) {
			if (c.getUsers() != null) {
				html += "<div class=\"comments1\">" + "<div class=\"avatar\">";
				for (User u : user) {
					if (u.getId() == c.getUsers().getId()) {
						if (u.getAvatar() != null) {
							html += "<img alt=\"\" src=\"/upload/" + u.getAvatar() + "\">";
						} else {
							html += "<img alt=\"\" src=\"/user/Images/IMAGE2/avatar.jpg\">";
						}
					}
				}
				html += "</div>" + "<div class=\"comments11\">" + "<p class=\"fullname\">" + c.getFull_name() + "</p>"
						+ "<p class=\"date-cmt\">" + formatter.format(c.getCreated_date()) + "</p>"
						+ "<p class=\"cmt\">" + c.getComment() + "</p>" + "</div>" + "</div>";
			} else {
				html += "<div class=\"comments1\">" + "<div class=\"avatar\">" + "<img alt=\"\" src=\"/" + c.getAvatar()
						+ "\">" + "</div>" + "<div class=\"comments11\">" + "<p class=\"fullname\">" + c.getFull_name()
						+ "</p>" + "<p class=\"date-cmt\">" + formatter.format(c.getCreated_date()) + "</p>"
						+ "<p class=\"cmt\">" + c.getComment() + "</p>" + "</div>" + "</div>";
			}
		}
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("html", html);
		jsonResult.put("curPage", ps.getPage());
		jsonResult.put("totalPage", totalPage);
		jsonResult.put("totalCmts", totalCmts);

		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/save-comment" }, method = RequestMethod.POST) // -> action
	public String SaveComment(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("cmt") Comment cmt, RedirectAttributes redirectAttributes) throws IOException {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		cmt.setCreated_date(ngay);
		cmt.setStatus(true);
		if (isLogined()) {
			cmt.setFull_name(getUserLogined().getFull_name());
			cmt.setEmail(getUserLogined().getEmail());
			// cmt.setCreated_by(getUserLogined().getId());
			cmt.setUsers(getUserLogined());
			cmt.setComment(cmt.getComment());
		} else {
			cmt.setFull_name(cmt.getFull_name());
			cmt.setEmail(cmt.getEmail());
			cmt.setAvatar("user/Images/IMAGE2/avatar.jpg");
			cmt.setComment(cmt.getComment());
		}
		commentService.saveOrUpdate(cmt);
		Blog blog = blogService.getById(cmt.getBlogs().getId());
		if (blog.getComments() == null || blog.getComments() == 0) {
			blog.setComments(1);
		} else {
			blog.setComments(blog.getComments() + 1);
		}
		blogService.saveOrUpdate(blog);

		redirectAttributes.addFlashAttribute("msg",
				"Cảm ơn bạn " + cmt.getFull_name() + " đã bình luận về bài viết này");
		return "redirect:/blogs/" + blog.getSeo(); // -> duong dan toi VIEW.
	}

	// ajax (tạm thời k dùng nữa)

//	@RequestMapping(value = { "/save-comment" }, method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> saveCmt(final ModelMap model, final HttpServletRequest request,
//			final HttpServletResponse response, @RequestBody Comment cmt) {
//		Calendar cal = Calendar.getInstance();
//		Date ngay = cal.getTime();
//		cmt.setCreated_date(ngay);
//		cmt.setStatus(true);
//		boolean login;
//		if (isLogined()) {
//			cmt.setFull_name(getUserLogined().getFull_name());
//			cmt.setEmail(getUserLogined().getEmail());
//			cmt.setCreated_by(getUserLogined().getId());
//			cmt.setComment(cmt.getComment());
//			login = true;
//		} else {
//			cmt.setFull_name(cmt.getFull_name());
//			cmt.setEmail(cmt.getEmail());
//			cmt.setAvatar("user/Images/IMAGE2/avatar.jpg");
//			cmt.setComment(cmt.getComment());
//			login = false;
//		}
//		Blog blog = blogService.getById(cmt.getId_ajax());
//		cmt.setBlogs(blog);
//		commentService.saveOrUpdate(cmt);
//
//		if (blog.getComments() == null || blog.getComments() == 0) {
//			blog.setComments(1);
//		} else {
//			blog.setComments(blog.getComments() + 1);
//		}
//		blogService.saveOrUpdate(blog);
//
//		String html = "";
//		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
//		String strDate = formatter.format(cmt.getCreated_date());
//
//		html += "<div class=\"comments1\">" + "<div class=\"avatar\">";
//		if (isLogined()) {
//			if (getUserLogined().getAvatar() != null) {
//				html += "<img alt=\"\" src=\"/upload/" + getUserLogined().getAvatar() + "\">";
//			} else {
//				html += "<img alt=\"\" src=\"/user/Images/IMAGE2/avatar.jpg\">";
//			}
//		} else {
//			html += "<img alt=\"\" src=\"/user/Images/IMAGE2/avatar.jpg\">";
//		}
//
//		html += "</div>" + "<div class=\"comments11\">" + "<p class=\"fullname\">" + cmt.getFull_name() + "</p>"
//				+ "<p class=\"date-cmt\">" + strDate + "</p>" + "<p class=\"cmt\">" + cmt.getComment() + "</p>"
//				+ "</div>" + "</div>";
//
//		Map<String, Object> jsonResult = new HashMap<String, Object>();
//		jsonResult.put("code", 200);
//		jsonResult.put("status", "TC");
//		jsonResult.put("html", html);
//		jsonResult.put("full_name", cmt.getFull_name());
//		jsonResult.put("is_login", login);
//		return ResponseEntity.ok(jsonResult);
//	}
}
