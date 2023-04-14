package com.dev.drakestore.controller.manager;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.controller.user.BaseController;
import com.dev.drakestore.entities.*;
import com.dev.drakestore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ManagerHomeController extends BaseController {
	@Autowired
	private SaleOrderService saleOrderService;
	@Autowired
	private CategoriesService categoriesService;

	@Autowired
	private ProductService productService;

	@Autowired
	private UserService userService;

	@Autowired
	private BlogService blogService;

	@Autowired
	private ContactService contactService;

	public BigDecimal getTotalByMonthAndYear(int year, int month) {
		BigDecimal total = BigDecimal.ZERO;
		List<SaleOrder> list = saleOrderService.findAllByMonthAndYear(year, month);
		for (SaleOrder s : list) {
			total = total.add(s.getTotal());
		}
		return total;
	}

	@RequestMapping(value = { "/admin/index" }, method = RequestMethod.GET) // -> action
	public String contact(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// cac views se duoc dat tai thu muc:
		// từ java 1.1 nếu dùng date.getYear sẽ trả về year -1900
		// nên dùng cách này
		Calendar date = new GregorianCalendar();
		int year = date.get(Calendar.YEAR); // 2012
		BigDecimal total = BigDecimal.ZERO;
		for (int i = 1; i <= 12; i++) {
			model.addAttribute("thang" + i, getTotalByMonthAndYear(year, i));
			total = total.add(getTotalByMonthAndYear(year, i));
		}
		model.addAttribute("total", total);

		// saleorrder
		List<SaleOrder> all = saleOrderService.findAll();
		List<SaleOrder> allActive = saleOrderService.findAllActive();
		List<SaleOrder> allInActive = saleOrderService.findAllInActive();
		List<SaleOrder> confirm = saleOrderService.findAllConfirm();
		List<SaleOrder> delivery = saleOrderService.findAllDelivery();
		List<SaleOrder> delivered = saleOrderService.findAllDelivered();
		List<SaleOrder> cancel = saleOrderService.findAllCancel();

		// category
		List<Categories> category = categoriesService.findAll();
		List<Categories> categoryActive = categoriesService.findAllActive();
		List<Categories> categoryInActive = categoriesService.findAllInActive();
		List<Categories> parentCategory = categoriesService.findFullParentCategories();
		List<Categories> childrenCategory = categoriesService.findFullChildrenCategories();

		// product
		List<Product> product = productService.findAll();
		List<Product> productActive = productService.findProductsActive();
		List<Product> productInActive = productService.findProductsInActive();

		// user
		List<User> user = userService.findAll();
		List<User> userActive = userService.findAllActive();
		List<User> userInActive = userService.findAllInActive();
		List<User> local = userService.findAllLocal();
		List<User> social = userService.findAllSocial();

		// blog
		List<Blog> blog = blogService.findAll();
		List<Blog> blogActive = blogService.findActive();
		List<Blog> blogInActive = blogService.findInActive();

		List<Contact> contact = contactService.findAll();
		List<Contact> contactActive = contactService.findActive();
		List<Contact> contactInActive = contactService.findInActive();

		model.addAttribute("year", year);

		model.addAttribute("all", all.size());
		model.addAttribute("allActive", allActive.size());
		model.addAttribute("allInActive", allInActive.size());
		model.addAttribute("confirm", confirm.size());
		model.addAttribute("delivery", delivery.size());
		model.addAttribute("delivered", delivered.size());
		model.addAttribute("cancel", cancel.size());
		model.addAttribute("confirmList", confirm);

		model.addAttribute("category", category.size());
		model.addAttribute("categoryActive", categoryActive.size());
		model.addAttribute("categoryInActive", categoryInActive.size());
		model.addAttribute("parentCategory", parentCategory.size());
		model.addAttribute("childrenCategory", childrenCategory.size());

		model.addAttribute("product", product.size());
		model.addAttribute("productActive", productActive.size());
		model.addAttribute("productInActive", productInActive.size());

		model.addAttribute("user", user.size());
		model.addAttribute("userActive", userActive.size());
		model.addAttribute("userInActive", userInActive.size());
		model.addAttribute("local", local.size());
		model.addAttribute("social", social.size());

		model.addAttribute("blog", blog.size());
		model.addAttribute("blogActive", blogActive.size());
		model.addAttribute("blogInActive", blogInActive.size());

		model.addAttribute("contact", contact.size());
		model.addAttribute("contactActive", contactActive.size());
		model.addAttribute("contactInActive", contactInActive.size());

		return "manager/index1"; // -> duong dan toi VIEW.
	}
}
