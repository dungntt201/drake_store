package com.dev.drakestore.controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.entities.Blog;
import com.dev.drakestore.entities.Categories;
import com.dev.drakestore.entities.Product;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController extends BaseController {
	@Autowired
	CategoriesService categoriesService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductImageService productImageService;
	
	@Autowired
	BlogService blogService;
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/")
	public String home(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		//lấy 10 sp hot mới nhất
		List<Product> hotProducts = productService.findHotProducts();
		
		//lấy 10 sp sale hot mới nhất
		List<Product> saleProducts = productService.findSaleProducts();
		
		//lấy 3sp bestseller mới nhất
		List<Product> bestSellerProducts = productService.findBestSellerProducts();
		
		//lấy 3 sp hot mới nhất
		List<Product> hotProducts1 = productService.find3HotProducts();
		
		//lấy 3 sp sale hot mới nhất
		List<Product> saleProducts1 = productService.find3SaleProducts();
		
		//lấy 3 blog mới nhất
		List<Blog> blogs = blogService.find3Blog();
		//lấy ảnh sp
		//List<ProductImage> productImages = productImageService.findAll();
		
		
		//lay user ddeer hieenr thi tasc giar cuar post
		List<User> users = userService.findAll();
		
		model.addAttribute("users", users);
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		model.addAttribute("hotProducts", hotProducts);
		model.addAttribute("saleProducts", saleProducts);
		model.addAttribute("bestSellers", bestSellerProducts);
		model.addAttribute("hotProduct1", hotProducts1);
		model.addAttribute("saleProducts1", saleProducts1);
		model.addAttribute("blogs", blogs);
		// cac views se duoc dat tai thu muc:
		return "user/home"; // -> duong dan toi VIEW.
	}
	
	@RequestMapping("/about-us")
	public String about(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/about-us"; // -> duong dan toi VIEW.
	}
	@RequestMapping("/how-to-shop")
	public String HowToShop(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/how-to-shop"; // -> duong dan toi VIEW.
	}
	
	@RequestMapping("/payment")
	public String Payment(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/payment"; // -> duong dan toi VIEW.
	}
	@RequestMapping("/returns")
	public String Returns(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/returns"; // -> duong dan toi VIEW.
	}
	@RequestMapping("/delivery")
	public String Delivery(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/delivery"; // -> duong dan toi VIEW.
	}
	@RequestMapping("/privacy")
	public String Privacy(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response)
			throws IOException {
		//láy category cha và con
		List<Categories> fullParent = categoriesService.findFullParentCategories();
		List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
		
		
		//System.out.println(fullParent.size());
		model.addAttribute("parentCategories",fullParent);
		model.addAttribute("childrenCategories",fullChildren);
		
		// cac views se duoc dat tai thu muc:
		return "user/privacy"; // -> duong dan toi VIEW.
	}
}
