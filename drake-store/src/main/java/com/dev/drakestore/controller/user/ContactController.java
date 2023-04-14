package com.dev.drakestore.controller.user;

import java.io.IOException;
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

import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.Contact;
import com.dev.drakestore.service.CategoriesService;
import com.dev.drakestore.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class ContactController extends BaseController {
	@Autowired
	CategoriesService categoriesService;
	
	@Autowired
	ContactService contactService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value = { "/contact" }, method = RequestMethod.GET) // -> action
	public String contact(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		//System.out.println(fullParent.size());
		model.addAttribute("newContact",new Contact());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		return "user/contact"; // -> duong dan toi VIEW.
	}
	
	//ajax
	  @RequestMapping(value = { "/contact" }, method = RequestMethod.POST) 
	  public ResponseEntity<Map<String, Object>> contactAjax(final Model model , 
			  final HttpServletRequest request, 
			  final HttpServletResponse response,
			  final @RequestBody Contact contact ) throws Exception
			   { 
	  
		  //chạy lại đi ô //
		  //chỗ log lỗi đâu nhỉ, console ý, ở eclipse // controller nhận đc file r đấy //
		 // còn lại ô xử lý // đưa ảnh vào folder nào đấy, như thầy hướng dẫn ý 
		  Calendar cal = Calendar.getInstance(); 
		  Date ngay = cal.getTime();
		  contact.setCreated_date(ngay); 
		  contact.setStatus(true);
		  contactService.saveOrUpdate(contact); 
		  sendEmail(contact.getEmail(),contact.getFull_name());
		  //System.out.println(contact.getEmail()); 
		  Map<String, Object> jsonResult = new HashMap<String, Object>(); // 200 <-> thanh cong // 500 <-> khong thanhcong
		   jsonResult.put("code", 200); 
		   jsonResult.put("message", contact); 
		   return ResponseEntity.ok(jsonResult);
		  
	  }
	 
//	@RequestMapping(value = { "/contact" }, method = RequestMethod.POST) // -> action
//	public String SaveComment(final Model model,
//			final HttpServletRequest request,
//			final HttpServletResponse response,
//			@ModelAttribute("newContact") Contact contact,
//			RedirectAttributes redirectAttributes
//			)
//			throws IOException, MessagingException {
//		Calendar cal = Calendar.getInstance();
//		Date ngay = cal.getTime();
//		contact.setCreated_date(ngay);
//		contact.setStatus(true);
//		contactService.saveOrUpdate(contact);
//		sendEmail(contact.getEmail());
//		
//		redirectAttributes.addFlashAttribute("msg","Cảm ơn bạn "+contact.getFull_name()+" đã gửi liên hệ");
//		return "redirect:/contact"; // -> duong dan toi VIEW.
//	}
	public void sendEmail(String recipientEmail,String name)
            throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();              
        MimeMessageHelper helper = new MimeMessageHelper(message);
         
        helper.setFrom("tinhtrang0527@gmail.com", "DreamSneakers Support");
        helper.setTo(recipientEmail);
         
        String subject = "Here's the link to confirm your contact";
         
        String content = "<p>Hello, "+name
        		+ "</p>"
                + "<p> Cảm ơn bạn đã gửi liên hệ tại DreamSneakers </p>"
                + "<p>Chúng tôi sẽ gửi cho bạn nhưng thông báo về sản phẩm và ưu đãi cho bạn</p>"
                + "<br>"
                + "<p style='text-align:right'>Trân trọng</p> "
                + "<p style='text-align:right'>Ban quản trị của hàng Dream Sneaker</p> ";
         
        helper.setSubject(subject);
         
        helper.setText(content, true);
         
        mailSender.send(message);
    }
}
