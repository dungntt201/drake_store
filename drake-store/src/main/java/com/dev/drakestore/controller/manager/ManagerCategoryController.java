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
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.service.CategoriesService;
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

import com.github.slugify.Slugify;

@Controller
public class ManagerCategoryController extends BaseController {
	// inject 1 bean (service) vaof trong 1 bean khac (controler)
	@Autowired
	private CategoriesService categoriesService;

	@Autowired
	private UserService userService;

	@RequestMapping(value = { "/admin/list-categories" }, method = RequestMethod.GET) // -> action
	public String ListCate(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {

		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater
		int sizeOfPage = 10;

		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<Categories> categories = categoriesService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Categories> categories1 = categoriesService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalCategories = categories1.size();
		// lấy số bản ghi 1 trang
		// int sizeOfPage = categoriesService.sizeOfPage();
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalCategories % sizeOfPage == 0) {
			totalPage = totalCategories / sizeOfPage;
		} else {
			totalPage = totalCategories / sizeOfPage + 1;
		}

		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", categories.size());

		model.addAttribute("totalCategories", categories1.size());
		// day xuosng view de xu li
		model.addAttribute("categories", categories);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("sizeOfPage", sizeOfPage);
		model.addAttribute("productSearch", ps);

		// cac views se duoc dat tai thu muc:
		return "manager/list-categories"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-categories" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// lấy bản ghi theo size phan trang theo key word và page
		List<Categories> categories = categoriesService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Categories> categories1 = categoriesService.search1(ps);

		// List<Categories> categories2 = categoriesService.findAll();

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalCategories = categories1.size();
		// lấy số bản ghi 1 trang
		// int sizeOfPage = categoriesService.sizeOfPage();
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalCategories % sizeOfPage == 0) {
			totalPage = totalCategories / sizeOfPage;
		} else {
			totalPage = totalCategories / sizeOfPage + 1;
		}

		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Name</th>" + "<th>Description</th>" + "<th>Parent Category</th>"
				+ "<th>Create date</th>" + "<th>Updated date</th>" + "<th>Status</th>" + "<th>Update</th>" + "</tr>";
		int index = 1;
		for (Categories c : categories) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getName() + "</td>" + "<td>"
					+ c.getDescription() + "</td>";
			if (c.getChildren() == null) {
				html += "<td></td>";

			} else {
				html += "<td>" + c.getChildren().getName() + "</td>";
			}
			html += "<td>" + formatter.format(c.getCreated_date()) + "</td>" + "<td>"
					+ formatter.format(c.getUpdated_date()) + "</td>";
			if (c.isStatus()) {
				html += "<td>Active</td>";
			} else {
				html += "<td>InActive</td>";
			}

			html += "<td>" + "<a href=\"/admin/edit-category/" + c.getSeo()
					+ "\" style=\"text-decoration:none;color:blue;font-weight:bolder\"><i class=\"fas fa-edit\"></i></a><br>";
//			if (!ps.getFilter().equals("deleted")) {
//				html += "<p class=\"confirmation\" style=\"text-decoration:none;color:red;cursor: pointer;font-weight:bolder\">Ẩn</p>";
//				// System.out.println(ps.getFilter());
//			} taajmthowi fbor nút ẩn
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
		jsonResult.put("totalCategories", totalCategories);
		jsonResult.put("totalDisplay", categories.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/add-category" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		List<Categories> categories = categoriesService.findAllActive();

		// day xuosng view de xu li
		model.addAttribute("categories", categories);

		model.addAttribute("category", new Categories());
		// cac views se duoc dat tai thu muc:
		return "manager/add-category"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/add-category" }, method = RequestMethod.POST) // -> action
	public String addCategory(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("category") Categories category, RedirectAttributes redirectAttributes) throws Exception {
		// lay ngay tao gans laij cho category edit
		// Date ngay1 = categoriesService.getById(category.getId()).getCreated_date();
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		// categoriesService.saveOrUpdate(category);
		if (category.getId() == null || category.getId() <= 0) {
			category.setCreated_date(ngay);
			category.setUpdated_date(ngay);
			category.setSeo(new Slugify().slugify(category.getName()));
			category.setCreated_by(getUserLogined().getId());
			categoriesService.saveOrUpdate(category);
			redirectAttributes.addFlashAttribute("msg", "Thêm mới thành công");
			// -> duong dan toi VIEW.
			return "redirect:/admin/add-category";
		} else {
			if (category.getChildren() != null) {
				System.out.println(true);
				if (categoriesService.checkIDInListChildren(category.getChildren().getId(), category.getId())) {
					redirectAttributes.addFlashAttribute("err",
							"Cập nhật thất bại. Không được lấy danh mục con làm danh mục cha.");
					Categories onDB = categoriesService.getById(category.getId());
					if (onDB != null) {
						// -> duong dan toi VIEW.
						return "redirect:/admin/edit-category/" + onDB.getSeo();
					} else {
						redirectAttributes.addFlashAttribute("err", "Danh mục không tồn tại.");
						return "redirect:/admin/list-categories";
					}

				} else {
					Categories onDB = categoriesService.getById(category.getId());
					category.setCreated_by(onDB.getCreated_by());
					category.setUpdated_by(getUserLogined().getId());
					category.setCreated_date(onDB.getCreated_date());
					category.setSeo(new Slugify().slugify(category.getName()));
					category.setUpdated_date(ngay);
					categoriesService.saveOrUpdate(category);
					redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
					// -> duong dan toi VIEW.
					return "redirect:/admin/list-categories";
				}
			} else {
				System.out.println(false);
				Categories onDB = categoriesService.getById(category.getId());
				category.setCreated_by(onDB.getCreated_by());
				category.setUpdated_by(getUserLogined().getId());
				category.setCreated_date(onDB.getCreated_date());
				category.setSeo(new Slugify().slugify(category.getName()));
				category.setUpdated_date(ngay);
				categoriesService.saveOrUpdate(category);
				redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
				// -> duong dan toi VIEW.
				return "redirect:/admin/list-categories";
			}

		}

	}

	@RequestMapping(value = { "/admin/edit-category/{categorySeo}" }, method = RequestMethod.GET) // -> action
	public String editCategory(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("categorySeo") String categorySeo, RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		Categories category = categoriesService.findBySeo(categorySeo);
		if (category != null) {
			// can lay danh sach categories tu db vaf tra ve view qau model
			List<Categories> categories = categoriesService.findAllActive(category.getId());

			// day xuosng view de xu li
			model.addAttribute("categories", categories);

			model.addAttribute("category", category);
			return "manager/add-category"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("err", "Danh mục không tồn tại.");
			// -> duong dan toi VIEW.
			return "redirect:/admin/list-categories";
		}

	}

	// xoa ajax chi doi status = 0
	@RequestMapping(value = { "/admin/category/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Categories category) {

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		Categories Category = categoriesService.getById(category.getId());

		if (Category != null) {
			// Category.setUpdated_by(Category.getUpdated_by());
			Category.setStatus(false);

			Category.setUpdated_date(ngay);
			Category.setUpdated_by(getUserLogined().getId());

			categoriesService.saveOrUpdate(Category);
		}
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("cateName", Category.getName());
		return ResponseEntity.ok(jsonResult);
	}

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/category/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Categories category) {

		Categories Category = categoriesService.getById(category.getId());

		List<Categories> list = categoriesService.findAllChildrenCateById(category.getId());
		if (list != null) {
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("cateName", Category.getName());
			jsonResult.put("msg", "Xóa không thành công. Không được xóa danh mục đang có danh mục con.");
			return ResponseEntity.ok(jsonResult);
		} else {
			if (Category != null) {
				categoriesService.deleteCategoryByID(category.getId());
				// System.out.println(request.getParameter("min-price"));
				// trả kết quả
				Map<String, Object> jsonResult = new HashMap<String, Object>();
				jsonResult.put("code", 200);
				jsonResult.put("status", "TC");
				jsonResult.put("cateName", Category.getName());
				jsonResult.put("msg", "Xóa thành công");
				return ResponseEntity.ok(jsonResult);
			} else {
				// trả kết quả
				Map<String, Object> jsonResult = new HashMap<String, Object>();
				jsonResult.put("code", 200);
				jsonResult.put("status", "TC");
				// .put("accountName", User.getUsername());
				jsonResult.put("msg", "Xóa không thành công. Danh mục không tồn tại");
				return ResponseEntity.ok(jsonResult);
			}

		}

	}
	// xoas khoir db controller
//		@RequestMapping(value = { "/admin/deleted-category/{categoryId}" }, method = RequestMethod.GET) // -> action
//		public String delete(final Model model, 
//				final HttpServletRequest request, 
//				final HttpServletResponse response,
//				@PathVariable("categoryId") int categoryId,
//				RedirectAttributes redirectAttributes)
//				throws IOException {
//			
//			categoriesService.deleteCategoryByID(categoryId);
//			redirectAttributes.addFlashAttribute("msg","Bạn đã delete thành công 1 category ");	
//			return "redirect:/admin/list-categories"; // -> duong dan toi VIEW.
//		}

}
