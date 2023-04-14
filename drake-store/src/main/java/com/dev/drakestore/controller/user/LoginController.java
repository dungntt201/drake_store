package com.dev.drakestore.controller.user;

import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.dto.Utility;
import com.dev.drakestore.entities.*;
import com.dev.drakestore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class LoginController extends BaseController {
	@Autowired
	JavaMailSender mailSender;

	@Autowired
	UserService userService;
	@Autowired
	CategoriesService categoriesService;

	@Autowired
	SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@Autowired
	private ProductSizeService productSizeService;

	@Autowired
	private ProductService productService;

	@Autowired
	RoleService roleService;
	// hủy đơn controller
	/*
	 * @RequestMapping(value = { "/cancel-order/{saleOrderCode}" }, method =
	 * RequestMethod.GET) public String cancelOrder(final Model model, final
	 * HttpServletRequest request, final HttpServletResponse response,
	 * 
	 * @PathVariable("saleOrderCode") String saleOrderCode, RedirectAttributes
	 * redirectAttributes) throws Exception { Calendar cal = Calendar.getInstance();
	 * Date ngay = cal.getTime(); SaleOrder saleOrder =
	 * saleOrderService.findByCode(saleOrderCode); if (saleOrder != null) { if
	 * (!saleOrder.isConfirm()) { saleOrder.setCancel(true);
	 * saleOrder.setUpdated_date(ngay); } saleOrderService.saveOrUpdate(saleOrder);
	 * redirectAttributes.addFlashAttribute("msg", "Hủy thành công đơn hàng " +
	 * saleOrderCode);
	 * 
	 * return "redirect:/account/info"; } return saleOrderCode; }
	 */

	// huy ajax
	@RequestMapping(value = { "/cancel" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> cancel(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody SaleOrder saleorder) {

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		SaleOrder saleOrder = saleOrderService.findByCode(saleorder.getCode());
		if (saleOrder != null) {
			List<SaleOrderProducts> listSaleOrderProducts = saleOrderProductService
					.findBySaleOrderId(saleOrder.getId());

			if (saleOrder != null) {
				if (!saleOrder.isConfirm()) {
					saleOrder.setCancel(true);
					saleOrder.setUpdated_date(ngay);
					saleorder.setUpdated_by(getUserLogined().getId());
				}
				saleOrderService.saveOrUpdate(saleOrder);
			}

			for (SaleOrderProducts s : listSaleOrderProducts) {
				System.out.println(s.getProducts1().getId() + s.getSize());
				ProductSize p = productSizeService.getByProductIdAndSize(s.getProducts1().getId(), s.getSize());
				System.out.println(p.getProducts2().getTitle());
				Product p1 = productService.getById(s.getProducts1().getId());
				p.setRemaining(p.getRemaining() + s.getQuantity());
				p1.setSold(p1.getSold() - s.getQuantity());
				productService.saveOrUpdate(p1);
				productSizeService.saveOrUpdate(p);
			}
			// System.out.println(request.getParameter("min-price"));
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("codeSaleOrder", saleorder.getCode());
			jsonResult.put("msg", "Hủy thành công");
			return ResponseEntity.ok(jsonResult);
		} else {
			// System.out.println(request.getParameter("min-price"));
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("codeSaleOrder", saleorder.getCode());
			jsonResult.put("msg", "Hủy không thành công. Đơn hàng không tồn tại.");
			return ResponseEntity.ok(jsonResult);
		}
	}

	@RequestMapping(value = { "/account/login" }, method = RequestMethod.GET)
	public String cartView(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			RedirectAttributes redirectAttributes) throws Exception {
		// láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);

		model.addAttribute("newUser", new User());

		if (isLogined()) {
			return "redirect:/account/info";
		}
		return "login";
	}

	// register
	@RequestMapping(value = { "/account/login" }, method = RequestMethod.POST)
	public String register(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("newUser") User user, @RequestParam("userAvatar") MultipartFile userAvatar,
			RedirectAttributes redirectAttributes) throws Exception {
		User user1 = userService.loadUserByUsername(user.getUsername());
		User user2 = userService.findbyEmail(user.getEmail());
		if (user1 != null) {
			redirectAttributes.addFlashAttribute("success1", "Đăng kí thất bại.Username đã tồn tại.");
			return "redirect:/account/login";
		} else if (user2 != null) {
			redirectAttributes.addFlashAttribute("success1", "Đăng kí thất bại.Email đã tồn tại.");
			return "redirect:/account/login";
		} else {
			try {

				String AccountLink = Utility.getSiteURL(request) + "/account/info";
				sendEmail(user.getEmail(), AccountLink);
				redirectAttributes.addFlashAttribute("success",
						"Đăng kí thành công . Vui lòng đăng nhập để trải nghiệm dịch vụ của chúng tôi! ");
				userService.register(user, userAvatar);
			} catch (UnsupportedEncodingException | MessagingException e) {
				// TODO: handle exception
				redirectAttributes.addFlashAttribute("error", "Error while sending email or this is a broken email!");
			}
			return "redirect:/account/login";
		}

	}

	public void sendEmail(String recipientEmail, String link) throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom("tinhtrang0527@gmail.com", "DreamSneakers Support");
		helper.setTo(recipientEmail);

		String subject = "Here's the link to confirm new account";

		String content = "<p>Hello, " + recipientEmail + "</p>"
				+ "<p> Cảm ơn bạn đã đăng kí tài khoản tại DreamSneakers </p>"
				+ "<p>Bạn vui lòng truy cập vào tài khoản mình vừa đăng kí theo địa chỉ: " + "<a href=\"" + link
				+ "\">http://dreamsneakers.vn/account/info</a> "
				+ "để thực hiện đặt hàng và quản lí giao dịch nhanh chóng thuận tiện hơn</p>"

				+ "<br>" + "<p style='text-align:right'>Trân trọng</p> "
				+ "<p style='text-align:right'>Ban quản trị của hàng Dream Sneaker</p> ";

		helper.setSubject(subject);

		helper.setText(content, true);

		mailSender.send(message);
	}

	@RequestMapping(value = { "/account/info" }, method = RequestMethod.GET)
	public String cartView1(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			RedirectAttributes redirectAttributes) throws Exception {
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();

		// System.out.println(fullParent.size());
		model.addAttribute("parentCategories", fullParent);
		model.addAttribute("childrenCategories", fullChildren);

		if(getUserLogined().getId() == null){
			return "redirect:/logout";
		}
		User user = userService.getById(getUserLogined().getId());

		// reset số lần đăng nhập sai
		userService.resetFailedAttempts(user);

		String role = user.getRoles().get(0).getName();
		// System.out.println("role:" + role);

		List<SaleOrder> saleOrders = saleOrderService.findAllByUserId(getUserLogined().getId());
		if (user.getProvider().equals("LOCAL")) {
			model.addAttribute("checkLocal", true);
		} else {
			model.addAttribute("checkLocal", false);
		}
		model.addAttribute("saleOrders", saleOrders);
		model.addAttribute("user", user);
		model.addAttribute("role", role);
		model.addAttribute("totalSaleOrders", saleOrders.size());
		model.addAttribute("msg", "Xin chào " + user.getFull_name() + "!");
		if (!role.equals("USER")) {
			return "redirect:/admin/index";
		} else {
			return "user/account-info";
		}

	}

	@RequestMapping(value = { "/account/info" }, method = RequestMethod.POST)
	public String save(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("user") User user, @RequestParam("userAvatar") MultipartFile userAvatar,
			RedirectAttributes redirectAttributes) throws Exception {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		User userOnDB = userService.getById(user.getId());
		user.setPassword(userOnDB.getPassword());
		user.setUpdated_by(userOnDB.getId());
		user.setUpdated_date(ngay);
		// user.setEmail(userOnDB.getEmail());
		// user.setUsername(userOnDB.getUsername());
		for (Role r : roleService.findAll()) {
			if (r.getUsers().contains(userOnDB)) {
				r.deleteUsers(userOnDB);
				roleService.saveOrUpdate(r);
				r.addUsers(userOnDB);
				roleService.saveOrUpdate(r);
			}
		}
		userService.edit1(user, userAvatar);
		getUserLogined().setAvatar(user.getAvatar());
		getUserLogined().setFull_name(user.getFull_name());
		return "redirect:/account/info";
	}

//	@RequestMapping(value = { "/request-ajax" }, method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> contactAjax(final Model model , 
//						final HttpServletRequest request, 
//						final HttpServletResponse response, 
//						final @ModelAttribute USERdemo user
//						) throws Exception {
//		//chạy lại đi ô
//		// chỗ log lỗi đâu nhỉ, console ý, ở eclipse
//		// controller nhận đc file r đấy
//		// còn lại ô xử lý
//		// đưa ảnh vào folder nào đấy, như thầy hướng dẫn ý
//		System.out.println("alo...");
//		userService.edit(user);
//		System.out.println(user.getFile().getOriginalFilename());
//		Map<String, Object> jsonResult = new HashMap<String, Object>();
//		// 200 <-> thanh cong
//		// 500 <-> khong thanh cong
//		jsonResult.put("code", 200);
//		jsonResult.put("message", user);
//		return ResponseEntity.ok(jsonResult);
//	}
	@RequestMapping(value = { "/401" }, method = RequestMethod.GET)
	public String exception401(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		return "user/401-error";
	}
}
