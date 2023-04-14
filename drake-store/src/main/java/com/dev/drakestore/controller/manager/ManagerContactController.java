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
import com.dev.drakestore.entities.Contact;
import com.dev.drakestore.service.ContactService;
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
public class ManagerContactController extends BaseController {

	@Autowired
	ContactService contactService;

	@RequestMapping(value = { "/admin/list-contact" }, method = RequestMethod.GET) // -> action
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
		List<Contact> contacts = contactService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Contact> contacts1 = contactService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalContacts = contacts1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalContacts % sizeOfPage == 0) {
			totalPage = totalContacts / sizeOfPage;
		} else {
			totalPage = totalContacts / sizeOfPage + 1;
		}

		model.addAttribute("totalContacts", contacts1.size());
		// day xuosng view de xu li
		model.addAttribute("contacts", contacts);

		// day trang hien tai xuong view de phan trang
		model.addAttribute("curPage", ps.getPage());

		// day tong so trang xuosng view de xu li
		model.addAttribute("totalPage", totalPage);

		// day keyword xuong view de xư li
		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());
		model.addAttribute("sort", ps.getSort());
		model.addAttribute("filter", ps.getFilter());

		// day keyword xuong view de xư li
		model.addAttribute("keyword", ps.getKeyword());

		model.addAttribute("productSearch", ps);
		model.addAttribute("totalDisplay", contacts.size());
		model.addAttribute("sizeOfPage", sizeOfPage);
		return "manager/list-contacts"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/list-contact" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> phanTrang(final ModelMap model, final HttpServletRequest request,
														 final HttpServletResponse response, @RequestBody ProductSearch ps) {

		int sizeOfPage = 10;
		// lấy bản ghi theo size phan trang theo key word và page
		List<Contact> contacts = contactService.search(ps, sizeOfPage);

		// laasy full bản ghi k phan trang theo keyword
		List<Contact> contacts1 = contactService.search1(ps);

		// lấy số lượng bản ghi full để tính tổng số trang phân đc
		int totalContacts = contacts1.size();
		// lấy số bản ghi 1 trang
		/* int sizeOfPage = productService.sizeOfPage(); */
		// tổng số trang
		int totalPage;
		// tính số page = số bản ghi / sizeofpage
		if (totalContacts % sizeOfPage == 0) {
			totalPage = totalContacts / sizeOfPage;
		} else {
			totalPage = totalContacts / sizeOfPage + 1;
		}

		String html = "";
		html += "<input id=\"curpage\" type='hidden' value=\"" + ps.getPage() + "\">";
		html += "<tr>" + "<th>ID</th>" + "<th>Full name</th>" + "<th>Email</th>" + "<th>Phone number</th>"
				+ "<th>Message</th>" + "<th>Status</th>" + "<th>Update</th>" + "</tr>";

		int index = 1;
		for (Contact c : contacts) {
			html += "<tr>" + "<td id=\"ID\">" + (sizeOfPage * ps.getPage() + index) + "</td>" + "<td>" + c.getFull_name() + "</td>" + "<td>"
					+ c.getEmail() + "</td>" + "<td>" + c.getPhone_number() + "</td> " + "<td>" + c.getMessage()
					+ "</td> ";

			if (c.isStatus()) {
				html += "<td>Active</td>";
			} else {
				html += "<td>InActive</td>";
			}

			html += "<td>" + "<a href=\"/admin/edit-contact/" + c.getId()
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
		jsonResult.put("totalContacts", totalContacts);
		jsonResult.put("totalDisplay", contacts.size());
		jsonResult.put("sizeOfPage", sizeOfPage);
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = { "/admin/add-contact" }, method = RequestMethod.GET) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		// can lay danh sach categories tu db vaf tra ve view qau model
		// day xuosng view de xu li

		model.addAttribute("contact", new Contact());
		// cac views se duoc dat tai thu muc:
		return "manager/add-contact"; // -> duong dan toi VIEW.
	}

	@RequestMapping(value = { "/admin/add-contact" }, method = RequestMethod.POST) // -> action
	public String addProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("contact") Contact contact, RedirectAttributes redirectAttributes)
			// truyên attribute cho trang direct cần thuộc tính RedirectAttributes

			throws Exception {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		// kiem tra xem action la them moi hay chinh sua
		if (contact.getId() == null || contact.getId() <= 0) {
			contact.setCreated_by(getUserLogined().getId());
			contact.setCreated_date(ngay);
			contactService.saveOrUpdate(contact);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Thêm mới thành công");
			return "redirect:/admin/add-contact";
		} else {
			Contact onDB = contactService.getById(contact.getId());
			contact.setCreated_date(onDB.getCreated_date());
			contact.setCreated_by(onDB.getCreated_by());
			contact.setUpdated_by(getUserLogined().getId());
			contact.setUpdated_date(ngay);
			// System.out.println(product.getId());
			contactService.saveOrUpdate(contact);
			// thông báo
			redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công");
			return "redirect:/admin/list-contact";
		}
		// return "manager/add-or-edit-product-success"; // -> duong dan toi VIEW.

	}

	@RequestMapping(value = { "/admin/edit-contact/{contactId}" }, method = RequestMethod.GET) // -> action
	public String editProduct(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("contactId") Integer contactId, RedirectAttributes redirectAttributes) throws IOException {
		// lay sp tu database
		Contact contact = contactService.getById(contactId);
		if (contact != null) {

//		model.addAttribute("msg","Bạn đã sửa thành công sản phẩm có ID : "+product.getId());
			model.addAttribute("contact", contact);
			return "manager/add-contact"; // -> duong dan toi VIEW.
		} else {
			redirectAttributes.addFlashAttribute("err", "Liên hệ không tồn tại");
			return "redirect:/admin/list-contact";
		}

	}

	// xoa ajax chi doi status = 0 k dùng nưuax
	//
	//
	@RequestMapping(value = { "/admin/contact/delete" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Contact contact) {

		System.out.println(contact.getId());
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();
		Contact Contact = contactService.getById(contact.getId());

		if (Contact != null) {
			// Category.setUpdated_by(Category.getUpdated_by());
			Contact.setStatus(false);

			Contact.setUpdated_date(ngay);
			Contact.setUpdated_by(getUserLogined().getId());

			contactService.saveOrUpdate(Contact);
		}
		// System.out.println(request.getParameter("min-price"));
		// trả kết quả
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", 200);
		jsonResult.put("status", "TC");
		jsonResult.put("contactName", Contact.getFull_name());
		return ResponseEntity.ok(jsonResult);
	}

	// xóa khỏi DB ajax
	@RequestMapping(value = { "/admin/contact/removeFromDB" }, method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromDB(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody Contact contact) {

		Contact Contact = contactService.getById(contact.getId());
		if (Contact != null) {
			// xóa bản ghi
			contactService.deleteContactByID(Contact.getId());

			// trả kết quả
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("contactName", Contact.getFull_name());
			jsonResult.put("msg", "Xóa thành công");
			return ResponseEntity.ok(jsonResult);

		} else {
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			jsonResult.put("code", 200);
			jsonResult.put("status", "TC");
			jsonResult.put("msg", "Xóa không thành công. Liên hệ không tồn tại");
			return ResponseEntity.ok(jsonResult);
		}
	}

	// xóa khỏi DB
//	@RequestMapping(value = { "/admin/deleted-contact/{contactId}" }, method = RequestMethod.GET) // -> action
//	public String delete(final Model model, final HttpServletRequest request, final HttpServletResponse response,
//			@PathVariable("contactId") int contactId, RedirectAttributes redirectAttributes) throws IOException {
//
//		// lay sp tu database
//		Contact contact = contactService.getById(contactId);
//		if (contact != null) {
//			// day xuosng view de xu li
//			// model.addAttribute("product",product);
//			// xóa bản ghi
//			contactService.deleteContactByID(contactId);
//			redirectAttributes.addFlashAttribute("msg", "Bạn đã xóa thành công 1 contact");
//			return "redirect:/admin/list-contact"; // -> duong dan toi VIEW.
//		}
//		return null;
//
//	}
}
