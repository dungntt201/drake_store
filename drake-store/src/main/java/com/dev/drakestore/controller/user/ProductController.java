package com.dev.drakestore.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.Product;
import com.dev.drakestore.entities.ProductImage;
import com.dev.drakestore.entities.ProductSize;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.ProductImageService;
import com.dev.drakestore.service.ProductService;
import com.dev.drakestore.service.ProductSizeService;
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

import com.ibm.icu.text.DecimalFormat;

@Controller
public class ProductController extends BaseController {
	@Autowired
	private ProductService productService;

	@Autowired
	private ProductImageService productImageService;

	@Autowired
	private CategoriesService categoriesService;

	@Autowired
	private ProductSizeService productSizeService;

	@RequestMapping(value = { "/shop" }, method = RequestMethod.GET) // -> action
	public String contact(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater
		// System.out.println(request.getParameter("page"));
		int sizeOfPage = 12;

//		//set page cho product search
		ps.setPage(getCurrentPage(request));

//		// lấy bản ghi theo size phan trang theo key word và page
		List<Product> products = productService.search(ps, sizeOfPage);
//		
//		//laasy full bản ghi k phan trang theo keyword
		List<Product> products1 = productService.search1(ps);

//		//lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalProducts = products1.size();

		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		List<Categories> fullCate = categoriesService.findAllActive();

//		List<String> listSizes = new ArrayList<String>();
//		listSizes.add("37");
//		listSizes.add("38");
//		listSizes.add("39");
//		listSizes.add("40");
//		listSizes.add("41");
//		listSizes.add("42");
//		listSizes.add("43");
//		listSizes.add("44");
//		listSizes.add("XS");
//		listSizes.add("S");
//		listSizes.add("M");
//		listSizes.add("L");
//		listSizes.add("XL");
////		
//
//		//System.out.println(ps.getCategory_id());
//		model.addAttribute("listSizes", listSizes);

		model.addAttribute("fullCate", fullCate);
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		model.addAttribute("totalProducts", products1.size());
		model.addAttribute("productSearch", ps);
		model.addAttribute("sizes", ps.getSizes());
		// day xuosng view de xu li
		model.addAttribute("products", products);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", products.size());

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("minPrice", ps.getMinPrice());
		model.addAttribute("maxPrice", ps.getMaxPrice());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("category_id", ps.getCategory_id());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("sizeOfPage", sizeOfPage);
		// System.out.println(ps.getSort());
		// cac views se duoc dat tai thu muc:
		return "user/products"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/category/{category-seo}" }, method = RequestMethod.GET) // -> action
	public String categoryShop(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("category-seo") String categorySeo, @ModelAttribute("productSearch") ProductSearch ps)
			throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater
		// System.out.println(request.getParameter("page"));

		Categories category = categoriesService.findBySeo(categorySeo);

		if (category != null) {
			int sizeOfPage = 12;
			// //set page cho product search
			ps.setPage(getCurrentPage(request));

			if (ps.getCategory_id() <= 0) {
				ps.setCategory_id(category.getId());
			} else {
				ps.setCategory_id(ps.getCategory_id());
			}

			// System.out.println(ps.getCategory_id());
//			// lấy bản ghi theo size phan trang theo key word và page
			List<Product> products = productService.search(ps, sizeOfPage);
//			
//			//laasy full bản ghi k phan trang theo keyword
			List<Product> products1 = productService.search1(ps);

//			//lấy số lượng bản ghi full để tính tổng số trang phân đc
			int totalProducts = products1.size();

			// tổng số trang
			int totalPage;
			// tính số page = số bản ghi / sizeofpage
			if (totalProducts % sizeOfPage == 0) {
				totalPage = totalProducts / sizeOfPage;
			} else {
				totalPage = totalProducts / sizeOfPage + 1;
			}

			// láy category cha và con
			List<Categories> fullParent = categoriesService.findFullParentCategories();
			List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
			List<Categories> fullCate = categoriesService.findAll();

			/// laays category con theo category
			List<Categories> fullChildrenCateOfID = categoriesService.findChildrenOfParentCategory(category.getId());

			model.addAttribute("fullChildrenOfCate", fullChildrenCateOfID);
			model.addAttribute("fullCate", fullCate);
			model.addAttribute("parentCategories", fullParent);
			model.addAttribute("childrenCategories", fullChildren);
			model.addAttribute("totalProducts", products1.size());
			model.addAttribute("productSearch", ps);
			model.addAttribute("sizes", ps.getSizes());
			// day xuosng view de xu li
			model.addAttribute("products", products);

			// Số bản ghi hiển thị đc của trang

			model.addAttribute("totalDisplay", products.size());

			// day trang hien tai xuong view de phan trang
			model.addAttribute("curPage", ps.getPage());

			// day tong so trang xuosng view de xu li
			model.addAttribute("totalPage", totalPage);

			// day keyword xuong view de xư li
			model.addAttribute("keyword", ps.getKeyword());
			model.addAttribute("minPrice", ps.getMinPrice());
			model.addAttribute("maxPrice", ps.getMaxPrice());
			model.addAttribute("sort", ps.getSort());
			model.addAttribute("category_id", ps.getCategory_id());
			model.addAttribute("filter", ps.getFilter());
			model.addAttribute("cateSeo", categorySeo);
			model.addAttribute("cateName", category.getName());
			model.addAttribute("sizeOfPage", sizeOfPage);
			return "user/products2"; // -> duong dan toi VIEW.
		}
		return categorySeo;
	}

	@RequestMapping(value = { "/san-pham-hot" }, method = RequestMethod.GET) // -> action
	public String hotProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater
		// System.out.println(request.getParameter("page"));
		int sizeOfPage = 12;

		ps.setPage(getCurrentPage(request));
		ps.setHot(true);
		// set hot để filter

//		// lấy bản ghi theo size phan trang theo key word và page
		List<Product> products = productService.search(ps, sizeOfPage);
//		
//		//laasy full bản ghi k phan trang theo keyword
		List<Product> products1 = productService.search1(ps);

//		//lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalProducts = products1.size();

		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		List<Categories> fullCate = categoriesService.findAllActive();

//		List<String> listSizes = new ArrayList<String>();
//		listSizes.add("37");
//		listSizes.add("38");
//		listSizes.add("39");
//		listSizes.add("40");
//		listSizes.add("41");
//		listSizes.add("42");
//		listSizes.add("43");
//		listSizes.add("44");
//		listSizes.add("XS");
//		listSizes.add("S");
//		listSizes.add("M");
//		listSizes.add("L");
//		listSizes.add("XL");
////		
//
//		//System.out.println(ps.getCategory_id());
//		model.addAttribute("listSizes", listSizes);

		model.addAttribute("fullCate", fullCate);
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		model.addAttribute("totalProducts", products1.size());

		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", products.size());
		model.addAttribute("productSearch", ps);
		model.addAttribute("sizes", ps.getSizes());
		// day xuosng view de xu li
		model.addAttribute("products", products);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("minPrice", ps.getMinPrice());
		model.addAttribute("maxPrice", ps.getMaxPrice());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("category_id", ps.getCategory_id());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("sizeOfPage", sizeOfPage);
		model.addAttribute("is_hot", ps.isHot());
		// cac views se duoc dat tai thu muc:
		return "user/hot-products"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/san-pham-sale" }, method = RequestMethod.GET) // -> action
	public String saleProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("productSearch") ProductSearch ps) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater
		// System.out.println(request.getParameter("page"));
		int sizeOfPage = 12;
//		//set page cho product search
		ps.setPage(getCurrentPage(request));
		// ps.setSize(size);
		ps.setSale(true);

//		// lấy bản ghi theo size phan trang theo key word và page
		List<Product> products = productService.search(ps, sizeOfPage);
//		
//		//laasy full bản ghi k phan trang theo keyword
		List<Product> products1 = productService.search1(ps);

//		//lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalProducts = products1.size();

		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}

		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		List<Categories> fullCate = categoriesService.findAllActive();

//		List<String> listSizes = new ArrayList<String>();
//		listSizes.add("37");
//		listSizes.add("38");
//		listSizes.add("39");
//		listSizes.add("40");
//		listSizes.add("41");
//		listSizes.add("42");
//		listSizes.add("43");
//		listSizes.add("44");
//		listSizes.add("XS");
//		listSizes.add("S");
//		listSizes.add("M");
//		listSizes.add("L");
//		listSizes.add("XL");
////		
//
//		//System.out.println(ps.getCategory_id());
//		model.addAttribute("listSizes", listSizes);

		model.addAttribute("fullCate", fullCate);
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);
		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", products.size());
		model.addAttribute("totalProducts", products1.size());
		model.addAttribute("productSearch", ps);
		model.addAttribute("sizes", ps.getSizes());
		// day xuosng view de xu li
		model.addAttribute("products", products);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("minPrice", ps.getMinPrice());
		model.addAttribute("maxPrice", ps.getMaxPrice());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("category_id", ps.getCategory_id());
		model.addAttribute("filter", ps.getFilter());
		model.addAttribute("sizeOfPage", sizeOfPage);
		model.addAttribute("is_hot", ps.isHot());
		model.addAttribute("sale", ps.isSale());
		// cac views se duoc dat tai thu muc:
		return "user/sale-products"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/shop/{productSeo}" }, method = RequestMethod.GET) // -> action
	public String detailProduct(Model model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("productSeo") String productSeo) throws IOException {
		// lay sp tu database
		Product product = productService.findBySeo(productSeo);
		if (product != null) {

			// láy category cha và con
			List<Categories> fullParent = categoriesService.findFullParentCategories();
			List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
			List<Categories> fullCate = categoriesService.findAllActive();
			List<ProductImage> productImages = productImageService.findAll();
			List<ProductSize> productSizes = productSizeService.findAllSortBySize();

			List<Product> related = productService.findRalatedProducts(product.getCategories().getId(),
					product.getId());

			model.addAttribute("productSizes", productSizes);
			model.addAttribute("relatedProducts", related);
			model.addAttribute("productImgs", productImages);
			model.addAttribute("fullCate", fullCate);
			model.addAttribute("parentCategories", fullParent);
			model.addAttribute("childrenCategories", fullChildren);
			model.addAttribute("product", product);
			return "user/product-details"; // -> duong dan toi VIEW.
		}
		return productSeo;

	}

	@RequestMapping(value = { "/shop" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 12;
		// String keyword = request.getParameter("keyword");
		// ps.setKeyword(keyword);
		List<Product> products = productService.search(ps, sizeOfPage);
		List<Product> products1 = productService.search1(ps);
		int totalProducts = products1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		//// tính số page = số bản ghi / sizeofpage
		if (totalProducts % sizeOfPage == 0) {
			totalPage = totalProducts / sizeOfPage;
		} else {
			totalPage = totalProducts / sizeOfPage + 1;
		}
		// System.out.println(totalPage);
		String pattern = "###,###.###";
		DecimalFormat decimalFormat = new DecimalFormat(pattern);

		// String format = decimalFormat.format(123456789.123);
		// System.out.println(format);
		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		for (Product product : products) {
			html += "<div class=\"row col-xl-4 col-lg-4 col-md-4 col-sm-6 col-xs-12 tinh justify-content-left\">"
					+ "<div class=\"tinh1\" style=\"position: relative;\">";
			if (product.getIs_hot()) {
				html += "<div class=\"badge bg-danger text-white position-absolute\" style=\"top: 10px; left: 10px; font-size: 15px\">Hot</div>";
			}
			html += "<a href=\"/shop/" + product.getSeo() + "\">" + "<img class=\"card-img-top\" src=\"/upload/"
					+ product.getAvatar() + "\" alt=\"...\" width=\"100%\" height=\"250px\"/>" + "</a>";
			html += "<div class=\"text-center\">" + "<a href=\"/shop/" + product.getSeo()
					+ "\" style=\"text-decoration: none\" class=\"text-black\">"
					+ "<p style=\"font-size: 17px; margin:20px 10px 0 10px\" class=\"fw-bolder\">" + product.getTitle()
					+ "</p>" + "</a>";
			if (product.getPrice_sale().compareTo(product.getPrice()) < 0) {
				html += "<div  class=\"badge bg-dark text-white position-absolute\" style=\"top: 10px; right: 10px;font-size: 15px\">Sale</div>"
						+ "<span style=\"font-size: 16px\" class=\"text-muted text-decoration-line-through\">"
						+ decimalFormat.format(product.getPrice()) + " VND</span><br>"
						+ "<span style=\"font-size: 16px\" class=\"fw-bolder\">"
						+ decimalFormat.format(product.getPrice_sale()) + " VND<span>";
			} else {
				html += "<span class=\"fw-bolder\" style=\"font-size: 16px\">"
						+ decimalFormat.format(product.getPrice()) + " VND</span>";
			}
			html += "</div><br><br>";
			html += "</div>";
			html += "</div>";
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
//		jsonResult.put("totalPrice", getTotalPrice(request));
//
//		session.setAttribute("totalItems", getTotalItems(request));
//		session.setAttribute("totalPrice", getTotalPrice(request));
//		//System.out.println(getTotalPrice(request));
		return ResponseEntity.ok(jsonResult);
	}

}
