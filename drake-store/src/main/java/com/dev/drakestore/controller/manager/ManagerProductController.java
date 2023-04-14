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
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.Product;
import com.dev.drakestore.entities.ProductImage;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.ProductImageService;
import com.dev.drakestore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.slugify.Slugify;
import com.ibm.icu.text.DecimalFormat;

@Controller
public class ManagerProductController extends BaseController {
	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private CategoriesService categoriesService;

	@GetMapping("/admin/list-products") // -> action
	public String ListProducts(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps)
			// @RequestParam(required=false) String sizes)
			throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		int sizeOfPage = 10;

		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<Product> products = productService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Product> products1 = productService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalProducts = products1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}

		List<Categories> categories = categoriesService.findAll();

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

		// System.out.println(ps.getCategory_id());
		model.addAttribute("listSizes", listSizes);

		model.addAttribute("categories", categories);

		model.addAttribute("totalProducts", products1.size());

		model.addAttribute("totalDisplay", products.size());

		// day xuosng view de xu li
		model.addAttribute("products", products);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("minPrice", ps.getMinPrice());
		model.addAttribute("maxPrice", ps.getMaxPrice());

		model.addAttribute("sizes", ps.getSizes());

		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("category_id", ps.getCategory_id());
		// System.out.println(ps.getCategory_id());
		model.addAttribute("productSearch", ps);
		model.addAttribute("sizeOfPage", sizeOfPage);
		return "manager/list-products"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/add-products" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		List<Categories> categories = categoriesService.findAllActive();

		// day xuosng view de xu li
		model.addAttribute("categories", categories);

		model.addAttribute("product", new Product());
		// cac views se duoc dat tai thu muc:
		return "manager/add-product"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-products" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// lấy bản ghi theo size phan trang theo key word và page
		List<Product> products = productService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Product> products1 = productService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalProducts = products1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}

		String pattern = "###,###.###";
		DecimalFormat decimalFormat = new DecimalFormat(pattern);

		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Title</th>" + "<th>Price</th>" + "<th>Price Sale</th>" + "<th>Avatar</th>"
				+ "<th>Category</th>" + "<th>Sold</th>" + "<th>Is hot Product</th>" + "<th>Update</th>" + "</tr>";

		int index = 1;
		for (Product c : products) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getTitle() + "</td>" + "<td>"
					+ decimalFormat.format(c.getPrice()) + "</td>"

					+ "<td>" + decimalFormat.format(c.getPrice_sale()) + "</td>" + "<td><img alt=\"\" src=\"/upload/"
					+ c.getAvatar() + "\"></td>";
			if (c.getCategories() != null) {
				html += "<td>" + c.getCategories().getName() + "</td>";
			} else {
				html += "<td></td>";
			}
			if (c.getSold() == null || c.getSold() == 0) {
				html += "<td>0</td>";
			} else {
				html += "<td>" + c.getSold() + "</td>";
			}

			html += "<td>" + c.getIs_hot() + "</td>";

			html += "<td>" + "<a href=\"/admin/edit-product/" + c.getSeo()
					+ "\" style=\"text-decoration:none;color:blue;font-weight:bolder\"><i class=\"fas fa-edit\"></i></a><br>";
			/*
			 * if (!ps.getFilter().equals("deleted")) { html +=
			 * "<p class=\"confirmation\" style=\"text-decoration:none;color:red;cursor: pointer;font-weight:bolder\">Ẩn</p>"
			 * ; // System.out.println(ps.getFilter()); }
			 */
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
		jsonResult.put("totalProducts", totalProducts);
		jsonResult.put("totalDisplay", products.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/add-products" }, method = RequestMethod.POST) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("product") Product product, @RequestParam("productAvatar") MultipartFile productAvatar,
			@RequestParam("productPictures") MultipartFile[] productPictures, RedirectAttributes redirectAttributes)
			// truyên attribute cho trang direct cần thuộc tính RedirectAttributes

			throws Exception {

		// lấy tbl_product_Image để thwujc hiện edit
		List<ProductImage> productImages = productImageService.findAll();
		// System.out.println(product.getId());
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		// kiem tra xem action la them moi hay chinh sua
		if (product.getId() == null || product.getId() <= 0) {
			product.setCreated_date(ngay);
			product.setUpdated_date(ngay);
			product.setCreated_by(getUserLogined().getId());
			product.setSeo(
					new Slugify().slugify(product.getTitle() + " " + String.valueOf(System.currentTimeMillis())));
			productService.save(product, productAvatar, productPictures);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Thêm mới thành công");
			return "redirect:/admin/add-products";
		} else {
			Product onDB = productService.getById(product.getId());
			product.setUpdated_date(ngay);
			product.setCreated_date(onDB.getCreated_date());
			product.setCreated_by(onDB.getCreated_by());
			product.setUpdated_by(getUserLogined().getId());
			product.setSeo(
					new Slugify().slugify(product.getTitle() + " " + String.valueOf(System.currentTimeMillis())));
			// System.out.println(product.getId());
			productService.edit(product, productAvatar, productPictures, productImages);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
			return "redirect:/admin/list-products";
		}
		// return "manager/add-or-edit-product-success"; // -> duong dan toi VIEW.

	}

	@RequestMapping(value = { "/admin/edit-product/{productSeo}" }, method = RequestMethod.GET) // -> action
	public String editProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("productSeo") String productSeo, RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		Product product = productService.findBySeo(productSeo);
		if (product != null) {

			// Product product = products.get(0);
			// can lay danh sach categories tu db vaf tra ve view qau model
			List<Categories> categories = categoriesService.findAllActive();

			// day xuosng view de xu li
			model.addAttribute("categories", categories);

//		model.addAttribute("msg","Bạn đã sửa thành công sản phẩm có ID : "+product.getId());
			model.addAttribute("product", product);
			return "manager/add-product"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("msg1", "Sản phẩm không tồn tại");
			return "redirect:/admin/list-products";
		}

	}

	// xoa ajax chi doi status = 0
	@RequestMapping(value = { "/admin/product/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Product product) {

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		Product Product = productService.getById(product.getId());

		if (Product != null) {
			// Category.setUpdated_by(Category.getUpdated_by());
			Product.setStatus(false);
			;
			Product.setUpdated_date(ngay);
			Product.setUpdated_by(getUserLogined().getId());

			productService.saveOrUpdate(Product);
		}
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("proName", Product.getTitle());
		return ResponseEntity.ok(jsonResult);
	}

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/product/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Product product) {

		List<ProductImage> productImages = productImageService.findAll();
		// lay sp tu database
		Product Product = productService.getById(product.getId());
		if (Product != null) {
			productService.deleteProductByID(Product.getId(), productImages);

			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("proName", Product.getId());
			jsonResult.put("msg", "Xóa thành công.");
			return ResponseEntity.ok(jsonResult);
		} else {
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			// .put("accountName", User.getUsername());
			jsonResult.put("msg", "Xóa không thành công. Sản phẩm không tồn tại");
			return ResponseEntity.ok(jsonResult);
		}

	}
	// xóa db contronller
//	@RequestMapping(value = { "/admin/deleted-product/{productId}" }, method = RequestMethod.GET) // -> action
//	public String delete(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response,
//			@PathVariable("productId") int productId,
//			RedirectAttributes redirectAttributes)
//			throws IOException {
//		List<ProductImage> productImages = productImageService.findAll();
//		//lay sp tu database
//		Product product = productService.getById(productId);
//		if(product!=null) {
//			//day xuosng view de xu li
//			model.addAttribute("product",product);
//			//xóa bản ghi
//			productService.deleteProductByID(productId, productImages);
//			redirectAttributes.addFlashAttribute("msg","Bạn đã xóa thành công 1 product");	
//			return "redirect:/admin/list-products"; // -> duong dan toi VIEW.
//		}
//		return null;
//		
//	}
}
