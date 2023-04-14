package com.dev.drakestore.controller.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.controller.user.BaseController;
import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Product;
import com.dev.drakestore.entities.ProductSize;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.ProductService;
import com.dev.drakestore.service.ProductSizeService;
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
public class ManagerProductSizeController extends BaseController {
	@Autowired
	ProductService productService;

	@Autowired
	ProductSizeService productSizeService;

	@Autowired
	UserService userService;

	@RequestMapping(value = { "/admin/list-product-sizes" }, method = RequestMethod.GET) // -> action
	public String contact(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		int sizeOfPage = 10;

		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<ProductSize> sizes = productSizeService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<ProductSize> sizes1 = productSizeService.search1(ps);

		List<Product> products = productService.findAll();

		List<User> users = userService.findAll();
		model.addAttribute("totalDisplay", sizes.size());
		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalSizes = sizes1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalSizes % sizeOfPage == 0) {
			totalPage = totalSizes / sizeOfPage;
		} else {
			totalPage = totalSizes / sizeOfPage + 1;
		}

		model.addAttribute("users", users);
		model.addAttribute("totalSizes", sizes1.size());
		// day xuosng view de xu li
		model.addAttribute("sizes", sizes);

		model.addAttribute("products", products);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("product_id", ps.getProduct_id());
		model.addAttribute("productSearch", ps);
		model.addAttribute("sizeOfPage", sizeOfPage);
		// System.out.println(ps.getProduct_id());
		return "manager/list-product-sizes"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-product-sizes" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// lấy bản ghi theo size phan trang theo key word và page
		List<ProductSize> sizes = productSizeService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<ProductSize> sizes1 = productSizeService.search1(ps);

		List<Product> products = productService.findAll();

		List<User> users = userService.findAll();

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalSizes = sizes1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalSizes % sizeOfPage == 0) {
			totalPage = totalSizes / sizeOfPage;
		} else {
			totalPage = totalSizes / sizeOfPage + 1;
		}

		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Size</th>" + "<th>Remaining</th>" + "<th>Product</th>" + "<th>Status</th>"
				+ "<th>Update</th>" + "</tr>";

		int index = 1;
		for (ProductSize c : sizes) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getSize() + "</td>" + "<td>"
					+ c.getRemaining() + "</td>" + "<td>" + c.getProducts2().getTitle() + "</td>";
			if (c.isStatus()) {
				html += "<td>Active</td>";
			} else {
				html += "<td>InActive</td>";
			}
			html += "<td>" + "<a href=\"/admin/edit-product-sizes/" + c.getId()
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
		jsonResult.put("totalSizes", totalSizes);
		jsonResult.put("totalDisplay", sizes.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/add-product-sizes" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		List<Product> products = productService.findAll();

		List<String> listSizes = new ArrayList<String>();
		listSizes.add("37");
		listSizes.add("38");
		listSizes.add("39");
		listSizes.add("40");
		listSizes.add("41");
		listSizes.add("42");
		listSizes.add("43");
		listSizes.add("44");
		listSizes.add("XS");
		listSizes.add("S");
		listSizes.add("M");
		listSizes.add("L");
		listSizes.add("XL");

		// day xuosng view de xu li
		model.addAttribute("products", products);
		model.addAttribute("sizes", listSizes);
		model.addAttribute("productSize", new ProductSize());
		// cac views se duoc dat tai thu muc:
		return "manager/add-product-sizes"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/add-product-sizes" }, method = RequestMethod.POST) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSize") ProductSize productSize, RedirectAttributes redirectAttributes)
			// truyên attribute cho trang direct cần thuộc tính RedirectAttributes

			throws Exception {

		List<ProductSize> ps1 = productSizeService.findByProductId(productSize.getProducts2().getId());

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		if (productSize.getId() == null || productSize.getId() <= 0) {
			int a = 0;
			for (ProductSize ps : ps1) {
				if (ps.getSize().equals(productSize.getSize())) {
					a = 1;
					break;
				} else {
					a = 0;
				}
			}
			if (a == 0) {

				productSize.setCreated_by(getUserLogined().getId());
				productSize.setCreated_date(ngay);
				productSizeService.saveOrUpdate(productSize);
				// thông báo
				redirectAttributes.addFlashAttribute("msg", "Thêm mới thành công");
				return "redirect:/admin/add-product-sizes";
			} else {
				redirectAttributes.addFlashAttribute("err", "Thêm mới thất bại. Size đã tồn tại");
				return "redirect:/admin/add-product-sizes";
			}

		} else {
			ProductSize onDB = productSizeService.getById(productSize.getId());
			int a = 0;
			for (ProductSize ps : ps1) {
				if (ps.getSize().equals(productSize.getSize()) && ps.getId() != productSize.getId()) {
					a = 1;
					break;
				} else {
					a = 0;
				}
			}
			if (a == 0) {
				productSize.setCreated_by(onDB.getCreated_by());
				productSize.setUpdated_by(getUserLogined().getId());
				productSize.setCreated_date(onDB.getCreated_date());
				productSize.setUpdated_date(ngay);
				// System.out.println(product.getId());
				productSizeService.saveOrUpdate(productSize);
				// thông báo
				redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
				return "redirect:/admin/list-product-sizes";
			} else {

				redirectAttributes.addFlashAttribute("err", "Cập nhật thất bại. Size đã tồn tại");
				return "redirect:/admin/edit-product-sizes/" + productSize.getId();
			}

		}

		// return "manager/add-or-edit-product-success"; // -> duong dan toi VIEW.

	}

	@RequestMapping(value = { "/admin/edit-product-sizes/{productSizeId}" }, method = RequestMethod.GET) // -> action
	public String editProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("productSizeId") int productSizeId, RedirectAttributes redirectAttributes)
			throws IOException {
		// lay sp tu database
		ProductSize productSize = productSizeService.getById(productSizeId);
		List<String> listSizes = new ArrayList<String>();
		listSizes.add("37");
		listSizes.add("38");
		listSizes.add("39");
		listSizes.add("40");
		listSizes.add("41");
		listSizes.add("42");
		listSizes.add("43");
		listSizes.add("44");
		listSizes.add("XS");
		listSizes.add("S");
		listSizes.add("M");
		listSizes.add("L");
		listSizes.add("XL");
		if (productSize != null) {

			// Product product = products.get(0);
			// can lay danh sach categories tu db vaf tra ve view qau model
			// can lay danh sach categories tu db vaf tra ve view qau model
			List<Product> products = productService.findAll();
			model.addAttribute("sizes", listSizes);
			// day xuosng view de xu li
			model.addAttribute("products", products);

			// model.addAttribute("msg","Bạn đã sửa thành công sản phẩm có ID :
			// "+product.getId());
			model.addAttribute("productSize", productSize);
			return "manager/add-product-sizes"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("err", "Size Sản phẩm không tồn tại");
			return "redirect:/admin/list-product-sizes";
		}

	}

	// xoa ajax chi doi status = 0
	@RequestMapping(value = { "/admin/product-sizes/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSize size) {

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		ProductSize Size = productSizeService.getById(size.getId());

		if (Size != null) {
			// Category.setUpdated_by(Category.getUpdated_by());
			Size.setStatus(false);
			Size.setUpdated_date(ngay);
			Size.setUpdated_by(getUserLogined().getId());

			productSizeService.saveOrUpdate(Size);
		}

		// Product pro = productService.getById(Size.getProducts2())
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("SizeName", Size.getSize());
		jsonResult.put("proSeo", Size.getProducts2().getSeo());
		return ResponseEntity.ok(jsonResult);
	}

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/product-sizes/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSize size) {

		ProductSize Size = productSizeService.getById(size.getId());
		if (Size != null) {
			productSizeService.deleteProductSizeByID(size.getId());
			// System.out.println(request.getParameter("min-price"));
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("SizeName", Size.getSize());
			jsonResult.put("proSeo", Size.getProducts2().getSeo());
			jsonResult.put("msg", "Xóa thành công.");
			return ResponseEntity.ok(jsonResult);
		} else {
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			// .put("accountName", User.getUsername());
			jsonResult.put("msg", "Xóa không thành công. Size sản phẩm không tồn tại");
			return ResponseEntity.ok(jsonResult);
		}

	}

//	@RequestMapping(value = { "/admin/deleted-product-sizes/{productSizeId}" }, method = RequestMethod.GET) // -> action
//	public String delete(final Model model, final HttpServletRequest request, final HttpServletResponse response,
//			@PathVariable("productSizeId") int productSizeId, RedirectAttributes redirectAttributes)
//			throws IOException {
//
//		// lay sp tu database
//		ProductSize productSize = productSizeService.getById(productSizeId);
//		if (productSize != null) {
//			// day xuosng view de xu li
//			// model.addAttribute("product",product);
//			// xóa bản ghi
//			productSizeService.deleteProductSizeByID(productSizeId);
//			redirectAttributes.addFlashAttribute("msg", "Bạn đã xóa thành công 1 product size");
//			return "redirect:/admin/list-product-sizes"; // -> duong dan toi VIEW.
//		}
//		return null;
//
//	}
}
