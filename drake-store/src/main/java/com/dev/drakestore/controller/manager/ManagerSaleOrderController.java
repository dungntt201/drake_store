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
import com.dev.drakestore.entities.*;
import com.dev.drakestore.service.*;
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

import com.ibm.icu.text.DecimalFormat;

@Controller
public class ManagerSaleOrderController extends BaseController {

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@Autowired
	private ProductService productService;

	@Autowired

	private UserService userService;

	@Autowired
	private ProductSizeService productSizeService;

	@RequestMapping(value = { "/admin/edit-saleorder" }, method = RequestMethod.POST) // -> action
	public String listSaleOrder(final Model model, final HttpServletRequest request, final HttpServletResponse response,
								@ModelAttribute("saleorder") SaleOrder saleorder, RedirectAttributes redirectAttributes) throws Exception {

		SaleOrder onDB = saleOrderService.getById(saleorder.getId());
		// categoriesService.saveOrUpdate(category)
		// lấy ngày update

		// nếu đơn hàng chuyển sang trạng thái hủy thì cập nhật lại số lượng còn của sp
		// và số lượng đã bán của sản phẩm
		if (onDB.isCancel() == false && saleorder.isCancel() == true) {
			Calendar cal = Calendar.getInstance();
			Date ngay = cal.getTime();
			List<SaleOrderProducts> listSaleOrderProducts = saleOrderProductService
					.findBySaleOrderId(saleorder.getId());
			if (saleorder != null) {

				saleorder.setCode(onDB.getCode());
				saleorder.setCreated_date(onDB.getCreated_date());
				saleorder.setTotal(onDB.getTotal());
				saleorder.setCreated_by(onDB.getCreated_by());
				saleorder.setUser(onDB.getUser());
				saleorder.setUpdated_date(ngay);
				saleorder.setUpdated_by(getUserLogined().getId());
				saleorder.setCancel(true);
				saleorder.setConfirm(false);
				saleorder.setIs_delivery(false);
				saleOrderService.saveOrUpdate(saleorder);
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
			redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công!");
		} else {
			Calendar cal = Calendar.getInstance();
			Date ngay = cal.getTime();
			saleorder.setCode(onDB.getCode());
			saleorder.setCreated_date(onDB.getCreated_date());
			saleorder.setTotal(onDB.getTotal());
			saleorder.setCreated_by(onDB.getCreated_by());
			saleorder.setUser(onDB.getUser());
			saleorder.setUpdated_date(ngay);
			saleorder.setUpdated_by(getUserLogined().getId());
			System.out.println(saleorder.isCancel() + "," + saleorder.isConfirm());
			saleOrderService.saveOrUpdate(saleorder);
			redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công!");
		}

		// -> duong dan toi VIEW.
		return "redirect:/admin/list-saleorders";
	}

	@RequestMapping(value = { "/admin/edit-saleorder/{saleorderCode}" }, method = RequestMethod.GET) // -> action
	public String editSaleOrder(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("saleorderCode") String saleorderCode, RedirectAttributes redirectAttributes)
			throws IOException {
		// lay sp tu database
		SaleOrder saleorder = saleOrderService.findByCode(saleorderCode);
		if (saleorder != null) {
			model.addAttribute("saleorder", saleorder);
			return "manager/edit-saleorder"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("msg1", "Đơn hàng không tồn tại!");
			return "redirect:/admin/list-saleorders";
		}

	}

	// huyr controller
//	@RequestMapping(value = { "/cancel/{saleOrderCode}" }, method = RequestMethod.GET)
//	public String cancelOrder(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response,
//			@PathVariable("saleOrderCode") String saleOrderCode,
//			RedirectAttributes redirectAttributes)
//			throws Exception {
//		
//		Calendar cal = Calendar.getInstance();
//		Date ngay = cal.getTime();
//		SaleOrder saleOrder = saleOrderService.findByCode(saleOrderCode);
//		if(saleOrder!=null) {
//			if(!saleOrder.isStatus()) {
//			saleOrder.setCancel(true);
//			saleOrder.setUpdated_date(ngay);
//			}
//			saleOrderService.saveOrUpdate(saleOrder);
//			redirectAttributes.addFlashAttribute("msg","Hủy thành công đơn hàng "+saleOrderCode);
//			
//			return "redirect:/admin/list-saleorders";
//		}
//		return saleOrderCode;
//	}

	// xóa khỏi db
	@RequestMapping(value = { "/admin/saleorder/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody SaleOrder saleorder) {

		SaleOrder saleOrder = saleOrderService.findByCode(saleorder.getCode());
		if (saleOrder != null) {
			List<SaleOrderProducts> listSaleOrderProducts = saleOrderProductService
					.findBySaleOrderId(saleOrder.getId());
			// nếu đơn hàng k là trạng thái hủy hoặc đơn hàng chưa giao thành công thì cập
			// nhật lại số lượng còn của sp
			// và số lượng đã bán của sản phẩm trc khi xóa đơn hàng
			if ((saleOrder.isCancel() == false && saleOrder.isConfirm() == false && saleOrder.isIs_delivery() == false)
					|| (saleOrder.isCancel() == false && saleOrder.isConfirm() && saleOrder.isIs_delivery() == false)) {
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
			}
			saleOrderService.deleteSaleOrderByID(saleOrder.getId());

			// System.out.println(request.getParameter("min-price"));
			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("codeSaleOrder", saleorder.getCode());
			jsonResult.put("msg", "Xóa thành công");
			return ResponseEntity.ok(jsonResult);
		} else {
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("codeSaleOrder", saleorder.getCode());
			jsonResult.put("msg", "Xóa không thành công. Đơn hàng không tồn tại");
			return ResponseEntity.ok(jsonResult);
		}

	}

	// huy ajax
	@RequestMapping(value = { "/admin/saleorder/cancel" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> cancel(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody SaleOrder saleorder) {

		// nếu đơn hàng chuyển sang trạng thái hủy thì cập nhật lại số lượng còn của sp
		// và số lượng đã bán của sản phẩm
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		SaleOrder saleOrder = saleOrderService.findByCode(saleorder.getCode());
		if (saleOrder != null) {
			if (!saleOrder.isConfirm()) {
				saleOrder.setCancel(true);
				saleOrder.setUpdated_date(ngay);
				saleorder.setUpdated_by(getUserLogined().getId());
			}
			saleOrderService.saveOrUpdate(saleOrder);

			List<SaleOrderProducts> listSaleOrderProducts = saleOrderProductService.findBySaleOrderId(saleOrder.getId());
//			if (saleOrder != null) {
//				if (!saleOrder.isConfirm()) {
//					saleOrder.setCancel(true);
//					saleOrder.setUpdated_date(ngay);
//					saleorder.setUpdated_by(getUserLogined().getId());
//				}
//				saleOrderService.saveOrUpdate(saleOrder);
//			}
			for (SaleOrderProducts s : listSaleOrderProducts) {
				System.out.println(s.getProducts1().getId() + s.getSize());
				ProductSize p = productSizeService.getByProductIdAndSize(s.getProducts1().getId(), s.getSize());
				System.out.println(p.getProducts2().getTitle());
				Product p1 = productService.getById(s.getProducts1().getId());
				// update số lượng còn lại của sản phẩm
				p.setRemaining(p.getRemaining() + s.getQuantity());
				// update số lượng đã bán của sản phẩm
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
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("codeSaleOrder", saleorder.getCode());
			jsonResult.put("msg", "Hủy không thành công. Đơn hàng không tồn tại.");
			return ResponseEntity.ok(jsonResult);
		}
	}

	// xóa ajax status =0 (tạm thời k dùng nữa)
//	@RequestMapping(value = { "/admin/saleorder/delete" }, method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
//			final HttpServletResponse response, @RequestBody SaleOrder saleorder) {
//
//		Calendar cal = Calendar.getInstance();
//		Date ngay = cal.getTime();
//		SaleOrder saleOrder1 = saleOrderService.findByCode(saleorder.getCode());
//
//		if (saleOrder1 != null) {
//
//			saleOrder1.setStatus(false);
//			saleOrder1.setUpdated_date(ngay);
//			saleorder.setUpdated_by(getUserLogined().getId());
//
//			saleOrderService.saveOrUpdate(saleOrder1);
//		}
//		// System.out.println(request.getParameter("min-price"));
//		// trả kết quả
//		Map<String, Object> jsonResult = new HashMap<String, Object>();
//		jsonResult.put("code", 200);
//		jsonResult.put("status", "TC");
//		jsonResult.put("codeSaleOrder", saleorder.getCode());
//		return ResponseEntity.ok(jsonResult);
//	}

	@RequestMapping(value = { "/admin/list-saleorders" }, method = RequestMethod.GET) // -> action
	public String list_Saleorder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute("productSearch") ProductSearch ps) throws IOException {
		// http://localhost:9996/manager/products?keyword=java&page=1 search va phan
		// trang cho search
		// http://localhost:9996/manager/products?page=1 phan trang cho tat ca
		// page Paramater

		int sizeOfPage = 10;
		// String keyword = request.getParameter("keyword");
		// String keyword = request.getParameter("keyword");
		// String sort = request.getParameter("sort");
		// String filter = request.getParameter("filter");
		// ProductSearch ps = new ProductSearch();
		// ps.setKeyword(keyword);
		// ps.setSort(sort);
		// ps.setFilter(filter);
		// set page cho product search
		ps.setPage(getCurrentPage(request));

		// lấy bản ghi theo size phan trang theo key word và page
		List<SaleOrder> saleOrders = saleOrderService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<SaleOrder> saleOrders1 = saleOrderService.search1(ps);

		List<User> users = userService.findAll();
		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalSaleOrders = saleOrders1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalSaleOrders % sizeOfPage == 0) {
			totalPage = totalSaleOrders / sizeOfPage;
		} else {
			totalPage = totalSaleOrders / sizeOfPage + 1;
		}

		model.addAttribute("totalSaleOrders", saleOrders1.size());
		// day xuosng view de xu li
		model.addAttribute("saleOrders", saleOrders);

		model.addAttribute("users", users);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// Số bản ghi hiển thị đc của trang

		model.addAttribute("totalDisplay", saleOrders.size());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());

		model.addAttribute("productSearch", ps);
		model.addAttribute("sizeOfPage", sizeOfPage);
		return "manager/list-saleorder"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-saleorders" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// String keyword = request.getParameter("keyword");
		// ps.setKeyword(keyword);
		// lấy bản ghi theo size phan trang theo key word và page
		List<SaleOrder> saleOrders = saleOrderService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<SaleOrder> saleOrders1 = saleOrderService.search1(ps);

		List<User> users = userService.findAll();
		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalSaleOrders = saleOrders1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalSaleOrders % sizeOfPage == 0) {
			totalPage = totalSaleOrders / sizeOfPage;
		} else {
			totalPage = totalSaleOrders / sizeOfPage + 1;
		}
		// System.out.println(totalPage);
		String pattern = "###,###.###";
		DecimalFormat decimalFormat = new DecimalFormat(pattern);
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		// String format = decimalFormat.format(123456789.123);
		// System.out.println(format);
		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Code</th>" + "<th>Ngày tạo</th>" + "<th>Người mua</th>"
				+ "<th>Địa chỉ</th>" + "<th>Giá trị đơn hàng</th>" + "<th>Thanh toán</th>" + "<th>Trạng thái</th>"
				+ "<th>Xem chi tiết</th>";
		if (!ps.getFilter().equals("deleted")) {
			html += "<th>Hủy</th>";
		}

		html += "<th>Update</th>" + "</tr>";

		int index = 1;
		for (SaleOrder s : saleOrders) {
			html += "<tr>" + "<td>" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td id=\"code\">" + s.getCode() + "</td>" + "<td>"
					+ formatter.format(s.getCreated_date()) + "</td>" + "<td>" + s.getCustomer_name() + "</td>" + "<td>"
					+ s.getCustomer_address() + "</td>" + "<td>" + decimalFormat.format(s.getTotal()) + " VND</td>";
			if (s.isConfirm() && s.isIs_delivery()) {
				html += "<td>Đã thanh toán</td>";

			} else {
				html += "<td>Chưa thanh toán</td>";
			}

			if (s.isCancel() && s.isStatus()) {
				html += "<td>Đã hủy</td>";
			} else if (!s.isConfirm() && !s.isCancel() && s.isStatus()) {
				html += "<td id=\"confirm\">Chờ xác nhận</td>";
			} else if (s.isConfirm() && !s.isIs_delivery() && s.isStatus()) {
				html += "<td>Đang giao hàng</td>";
			} else if (!s.isStatus()) {
				html += "<td>Đã ẩn	</td>";
			} else {
				html += "<td>Đã giao hàng thành công</td>";
			}
			html += "<td><a href=\"/admin/detail-saleorder/" + s.getCode()
					+ "\" style=\"text-decoration:none;color:blue\"><i class=\"far fa-eye\"></i></a><br></td>";

			if (!ps.getFilter().equals("deleted")) {
				if (s.isConfirm()) {
					html += "<td><p style=\"text-decoration:none;color:red;font-weight: bolder\">Không thể hủy</p></td>";
				} else if (s.isCancel()) {
					html += "<td><p style=\"text-decoration:none;color:red;font-weight: bolder\">Không thể hủy</p></td>";
				} else {
					html += "<td id=\"cancel\"><p class=\"confirmation\" style=\"text-decoration:none;color:red;font-weight: bolder;cursor:pointer\">Hủy đơn</p></td>";
				}
			}

			html += "<td>" + "<a href=\"/admin/edit-saleorder/" + s.getCode()
					+ "\" style=\"text-decoration:none;font-weight: bolder;color:blue\"><i class=\"fas fa-edit\"></i></a><br>";
			// tạm thời bỏ nút ẩn
//			if (!ps.getFilter().equals("deleted")) {
//				html += "<p class=\"confirmation1\" style=\"text-decoration:none;color:red;font-weight: bolder;cursor: pointer;\"><i class=\"fas fa-eye-slash\"></i></p>";
//			}
			html += "<p class=\"confirmation2\" style=\"text-decoration:underline;color:red;cursor: pointer;font-weight: bolder\"><i class=\"fas fa-trash\"></i></p>"
					+ "</td>";

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
		jsonResult.put("totalSaleOrders", totalSaleOrders);
		jsonResult.put("totalDisplay", saleOrders.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/detail-saleorder/{saleorderCode}" }, method = RequestMethod.GET) // -> action
	public String detail_saleorder(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @PathVariable("saleorderCode") String saleorderCode,
			RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		SaleOrder saleorder = saleOrderService.findByCode(saleorderCode);
		if (saleorder != null) {
			List<SaleOrderProducts> saleOrderProducts = saleOrderProductService.findBySaleOrderId(saleorder.getId());

			List<Product> products = productService.findAll();

//		model.addAttribute("msg","Bạn đã sửa thành công sản phẩm có ID : "+product.getId());
			model.addAttribute("saleorder", saleorder);
			model.addAttribute("saleOderProducts", saleOrderProducts);
			model.addAttribute("products", products);
			return "manager/detail-saleorder"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("msg1", "Đơn hàng không tồn tại!");
			return "redirect:/admin/list-saleorders";
		}

	}

}
