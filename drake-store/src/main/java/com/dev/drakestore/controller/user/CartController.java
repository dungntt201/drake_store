package com.dev.drakestore.controller.user;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dev.drakestore.dto.Cart;
import com.dev.drakestore.dto.CartItem;
import com.dev.drakestore.entities.*;
import com.dev.drakestore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import freemarker.template.Configuration;
import freemarker.template.Template;

@Controller
public class CartController extends BaseController {
    @Autowired
    SaleOrderService saleOrderService;

    @Autowired
    ProductService productService;

    @Autowired
    ProductSizeService productSizeService;

    @Autowired
    CategoriesService categoriesService;

    // để gửi mail
    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    private Configuration freemarkerConfig;

    @Autowired
    private SaleOrderProductService saleOrderProductService;

    @RequestMapping(value = {"/order/finish"}, method = RequestMethod.POST)
    public String cartFinish(final Model model, final HttpServletRequest request, final HttpServletResponse response,
                             RedirectAttributes redirectAttributes
            /* Mail mail */) throws Exception {
        HttpSession session = request.getSession();
        // lấy ngày tạo
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();

        String customerEmail = "";
        String customerName = "";
        String customerAddress = request.getParameter("customerAddress");
        if (isLogined()) {
            User user = userService.getById(getUserLogined().getId());
            customerEmail = user.getEmail();
            customerName = user.getFull_name();

        } else {
            customerEmail = request.getParameter("customerEmail");
            customerName = request.getParameter("customerName");
        }
        String customerPhone = request.getParameter("customerPhone");
        String customerMessage = request.getParameter("message");

        // tạo hóa đơn
        SaleOrder saleOrder = new SaleOrder();
        saleOrder.setCustomer_address(customerAddress);
        saleOrder.setCode("DS" + String.valueOf(System.currentTimeMillis()));
        saleOrder.setTotal(getTotalPrice(request));
        saleOrder.setCustomer_phone(customerPhone);
        saleOrder.setCreated_date(date);
        saleOrder.setUpdated_date(date);
        saleOrder.setMessage(customerMessage);
        saleOrder.setStatus(true);
        saleOrder.setConfirm(false);// false là đơn hàng chưa xác nhận
        saleOrder.setIs_delivery(false);// false chưa giao hàng
        saleOrder.setCancel(false);// false là đơn hàng chưa hủy
        // is_delivery//null:chờ xác nhận; false đang giao ; true đã giao
        // saleOrder.setUpdated_date(ngay);
        // saleOrder.setIs_delivery(null);
        if (getUserLogined() != null) {
            User user = userService.getById(getUserLogined().getId());
            saleOrder.setUser(user);
            saleOrder.setCreated_by(user.getId());
            saleOrder.setCustomer_name(customerName);
            saleOrder.setCustomer_email(customerEmail);
        } else {
            saleOrder.setCustomer_name(customerName);
            saleOrder.setCustomer_email(customerEmail);
        }

        // BigDecimal total;
        // kết các sản phẩm trong giỏ hàng cho hóa đơn

        Cart cart = (Cart) session.getAttribute("cart");

        for (CartItem cartItem : cart.getCartItems()) {
            SaleOrderProducts saleOrderProducts = new SaleOrderProducts();
            saleOrderProducts.setProducts1(productService.getById(cartItem.getProductId()));
            saleOrderProducts.setQuantity(cartItem.getQuanlity());
            saleOrderProducts.setSize(cartItem.getSize());
            saleOrderProducts.setProduct_name(productService.getById(cartItem.getProductId()).getTitle());
            if (getUserLogined() != null) {
                User user = userService.getById(getUserLogined().getId());
                saleOrderProducts.setCreated_by(user.getId());
                saleOrderProducts.setCreated_date(date);

            } else {
                saleOrderProducts.setCreated_date(date);
            }
            // thêm vào csdl bảng tbl_saleorder_product thuộc tính price_at_buy để trong
            // manager khi xem chi tiết hóa đơn
            // sẽ vẫn xem đc giá lúc mua của sp trong hóa đơn nếu như sp đó đã bị sửa giá
            // trong db
            saleOrderProducts.setPrice_at_buy(cartItem.getPriceUnit());
            saleOrder.addRelationProduct(saleOrderProducts);
        }

        // lưu vào cơ sở dữ liệu
        saleOrderService.saveOrUpdate(saleOrder);

        // set sl đã bán cho sản phẩm trong giỏ hàng
        List<Product> products1 = productService.findAll();
        List<ProductSize> productSizes = productSizeService.findAll();
        for (Product pi : products1) {
            for (CartItem item : cart.getCartItems()) {
                if (item.getProductId() == pi.getId()) {
                    if (pi.getSold() == null) {
                        pi.setSold(item.getQuanlity());
                    } else {
                        pi.setSold(pi.getSold() + item.getQuanlity());
                    }
                }
            }
            productService.saveOrUpdate(pi);
        }

        // set số lượng còn lại cho size của sản phẩm trong giỏ hàng
        for (ProductSize ps : productSizes) {
            for (CartItem item : cart.getCartItems()) {
                if (item.getProductId() == ps.getProducts2().getId() && item.getSize().equals(ps.getSize())) {
                    ps.setRemaining(ps.getRemaining() - item.getQuanlity());
                }
            }
            productSizeService.saveOrUpdate(ps);
        }

        // gửi mail FreeMarker

        MimeMessage message = emailSender.createMimeMessage();

        boolean multipart = true;

        MimeMessageHelper helper = new MimeMessageHelper(message, multipart, "utf-8");

        // gửi nội dung là file html dùng freemaker
        Template t = freemarkerConfig.getTemplate("email-template.ftl");

        List<SaleOrderProducts> saleOrderProducts = saleOrderProductService.findBySaleOrderId(saleOrder.getId());

        List<Product> products = new ArrayList<Product>();

        for (SaleOrderProducts sl : saleOrderProducts) {
            // lay product theo saleorder de get title
            Product product = productService.getById(sl.getProducts1().getId());
            products.add(product);
        }
        // Map<String, Object> model1 = new HashMap<String, Object>();
        List<CartItem> cartItems = cart.getCartItems();

        // add model vào trang freemaker
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("saleorder", saleOrder);
        model.addAttribute("saleOrderProducts", saleOrderProducts);
        model.addAttribute("products", products);

        // mail.setModel1(model1);
        // truyền model vào cho template để hiern thị dữ liệu
        String html = FreeMarkerTemplateUtils.processTemplateIntoString(t, model);

        helper.setFrom("yeukohon235@gmail.com", "Drake Store");
        helper.setTo(saleOrder.getCustomer_email());
        helper.setText(html, true);
        helper.setSubject("Xác nhận đơn hàng");

//		        helper.setFrom(mail.getFrom());

        this.emailSender.send(message);

        // sau khi lưu xong thì xáo dữ liệu giỏ hàng
        session.setAttribute("cart", null);
        session.setAttribute("totalItems", null);
        session.setAttribute("totalPrice", getTotalPrice(request));
        redirectAttributes.addFlashAttribute("msg",
                "Chúc mừng bạn " + saleOrder.getCustomer_name() + " đã đặt hàng thành công!");
        return "redirect:/order/view";
    }

    @RequestMapping(value = {"/order/view"}, method = RequestMethod.GET)
    public String orderView(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
            throws Exception {
        // session tương tự như kiểu Map và được lưu trên main memory.
        HttpSession session = request.getSession();

        // Lấy thông tin giỏ hàng.
        Cart cart = null;
        if (session.getAttribute("cart") == null) {
//			cart = (Cart) session.getAttribute("cart");
            model.addAttribute("msg1", "Bạn không có sản phẩm nào trong giỏ hàng");
        } else {
            cart = (Cart) session.getAttribute("cart");
            if (cart.getCartItems().size() == 0) {
                model.addAttribute("msg1", "Bạn không có sản phẩm nào trong giỏ hàng");
            }
        }
        List<Categories> fullParent = categoriesService.findFullParentCategories();
        List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
        List<Product> products = productService.findAll();

        model.addAttribute("parentCategories", fullParent);
        model.addAttribute("childrenCategories", fullChildren);
        model.addAttribute("products", products);
        return "user/order";
    }

    @RequestMapping(value = {"/cart/view"}, method = RequestMethod.GET)
    public String cartView(final Model model, final HttpServletRequest request, final HttpServletResponse response)
            throws Exception {
        List<Categories> fullParent = categoriesService.findFullParentCategories();
        List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
        // session tương tự như kiểu Map và được lưu trên main memory.
        HttpSession session = request.getSession();
        // List<Product> products1 = productService.findAll();

        List<Product> products = productService.findAll();
        // Lấy thông tin giỏ hàng.
        Cart cart = null;
        if (session.getAttribute("cart") == null) {
//			cart = (Cart) session.getAttribute("cart");
            model.addAttribute("msg1", "Bạn không có sản phẩm nào trong giỏ hàng");
        } else {
            cart = (Cart) session.getAttribute("cart");
            if (cart.getCartItems().size() == 0) {
                model.addAttribute("msg1", "Bạn không có sản phẩm nào trong giỏ hàng");
            }
        }
        // System.out.println(products.size());
        model.addAttribute("parentCategories", fullParent);
        model.addAttribute("childrenCategories", fullChildren);
        model.addAttribute("products", products);
        return "user/cart";
    }

    @RequestMapping(value = {"/wishlist/view"}, method = RequestMethod.GET)
    public String wishListView(final Model model, final HttpServletRequest request, final HttpServletResponse response)
            throws Exception {
        List<Categories> fullParent = categoriesService.findFullParentCategories();
        List<Categories> fullChildren = categoriesService.findFullChildrenCategories();
        // session tương tự như kiểu Map và được lưu trên main memory.
        HttpSession session = request.getSession();
        // List<Product> products1 = productService.findAll();

        List<Product> products = productService.findAll();
        List<ProductSize> productSizes = productSizeService.findAll();
        // Lấy thông tin giỏ hàng.
        Cart wishlist = null;
        if (session.getAttribute("wishlist") == null) {
//			cart = (Cart) session.getAttribute("cart");
            model.addAttribute("msg1", "Bạn không có sản phẩm yêu thích nào trong WishList");
        } else {
            wishlist = (Cart) session.getAttribute("wishlist");
            if (wishlist.getCartItems().size() == 0) {
                model.addAttribute("msg1", "Bạn không có sản phẩm yêu thích nào trong WishList");
            }
        }
        // System.out.println(products.size());
        model.addAttribute("parentCategories", fullParent);
        model.addAttribute("childrenCategories", fullChildren);
        model.addAttribute("productSizes", productSizes);
        model.addAttribute("products", products);
        return "user/wishlist";
    }

    @RequestMapping(value = {"/cart/add"}, method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> addToCart(final Model model, final HttpServletRequest request,
                                                         final HttpServletResponse response, @RequestBody CartItem newItem) {

        List<Product> products = productService.findAll();

        // session tương tự như kiểu Map và được lưu trên main memory.
        HttpSession session = request.getSession();

        // Lấy thông tin giỏ hàng.
        Cart cart = null;
        if (session.getAttribute("cart") != null) {
            cart = (Cart) session.getAttribute("cart");
        } else {
            cart = new Cart();
            session.setAttribute("cart", cart);
            // từ attribute này để for ra trên màn hình view cart nó tương tự
            // model.addAtrribue
        }

        // Lấy danh sách size để get số lượng còn
        List<ProductSize> productSizes = productSizeService.findAll();
        // Lấy danh sách sản phẩm có trong giỏ hàng
        List<CartItem> cartItems = cart.getCartItems();
        String msg = null;
        // kiểm tra nếu có trong giỏ hàng thì tăng số lượng
        boolean isExists = false;
        for (CartItem item : cartItems) {
            if (item.getProductId() == newItem.getProductId() && item.getSize().equals(newItem.getSize())) {
                isExists = true;
                for (ProductSize ps : productSizes) {
                    if (ps.getSize().equals(newItem.getSize()) && ps.getProducts2().getId() == newItem.getProductId()) {
                        if (ps.getRemaining() >= item.getQuanlity() + newItem.getQuanlity()) {
                            item.setQuanlity(item.getQuanlity() + newItem.getQuanlity());
                            msg = null;
                        } else {
                            msg = "Số lượng còn lại của sản phẩm: \" " + ps.getProducts2().getTitle() + " - SIZE "
                                    + item.getSize() + "\" không đủ";
                        }
                    }
                }
            }
        }

        // String avt = null;
        // nếu sản phẩm chưa có trong giỏ hàng
        if (!isExists) {
            Product productInDb = productService.getById(newItem.getProductId());
            // avt = productInDb.getAvatar();
            for (ProductSize ps : productSizes) {
                if (ps.getSize().equals(newItem.getSize()) && ps.getProducts2().getId() == newItem.getProductId()) {
                    if (ps.getRemaining() >= newItem.getQuanlity()) {
                        newItem.setQuanlity(newItem.getQuanlity());
                        newItem.setProductName(productInDb.getTitle());
                        newItem.setProductAvatar(productInDb.getAvatar());
                        // nếu có giá sale thì lấy giá sale
                        if (productInDb.getPrice_sale() == productInDb.getPrice()
                                || productInDb.getPrice_sale() == null) {
                            newItem.setPriceUnit(productInDb.getPrice());
                        } else {
                            newItem.setPriceUnit(productInDb.getPrice_sale());
                        }
                        cart.getCartItems().add(newItem);
                        msg = null;
                    } else {
                        msg = "Số lượng còn lại của sản phẩm: \" " + ps.getProducts2().getTitle() + " - SIZE "
                                + newItem.getSize() + "\" không đủ";
                    }
                }

            }

        }
        // trả kết quả

        Map<String, Object> jsonResult = new HashMap<String, Object>();
        jsonResult.put("code", 200);
        jsonResult.put("status", "TC");
        jsonResult.put("totalItems", getTotalItems(request));
        jsonResult.put("totalPrice", getTotalPrice(request));
        jsonResult.put("message", msg);
        jsonResult.put("cart", cart.getCartItems());
        // jsonResult.put("item",newItem);
        session.setAttribute("totalItems", getTotalItems(request));
        session.setAttribute("totalPrice", getTotalPrice(request));
        // session.setAttribute("products", products);
        // System.out.println(getTotalPrice(request));
        return ResponseEntity.ok(jsonResult);
    }

    @RequestMapping(value = {"/cart/delete"}, method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> deleteItem(final ModelMap model, final HttpServletRequest request,
                                                          final HttpServletResponse response, @RequestBody CartItem Item) {

        // System.out.println(Item.getSize());
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Iterator<CartItem> iterator = cart.getCartItems().iterator();
        while (iterator.hasNext()) {
            CartItem ci = iterator.next();
            if (ci.getProductId() == Item.getProductId() && ci.getSize().equals(Item.getSize())) {
                iterator.remove();
            }
        }

        // trả kết quả
        Map<String, Object> jsonResult = new HashMap<String, Object>();
        jsonResult.put("code", 200);
        jsonResult.put("status", "TC");
        jsonResult.put("totalItems", getTotalItems(request));
        jsonResult.put("totalPrice", getTotalPrice(request));

        // sl tren cart header
        session.setAttribute("totalItems", getTotalItems(request));
        session.setAttribute("totalPrice", getTotalPrice(request));
        return ResponseEntity.ok(jsonResult);
    }

    @RequestMapping(value = {"/cart/editQuanlity"}, method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> editQuality(final ModelMap model, final HttpServletRequest request,
                                                           final HttpServletResponse response, @RequestBody CartItem Item) {
        String a = null;
        // Lấy danh sách sai để get số lượng còn
        List<ProductSize> productSizes = productSizeService.findAll();
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Iterator<CartItem> iterator = cart.getCartItems().iterator();
        while (iterator.hasNext()) {
            CartItem ci = iterator.next();
            if (ci.getProductId() == Item.getProductId() && Item.getQuanlity() > 0
                    && ci.getSize().equals(Item.getSize())) {
                for (ProductSize ps : productSizes) {
                    if (ps.getSize().equals(Item.getSize()) && ps.getProducts2().getId() == Item.getProductId()) {
                        if (ps.getRemaining() >= Item.getQuanlity()) {
                            ci.setQuanlity(Item.getQuanlity());
                            a = null;
                        } else {
                            a = "Vượt quá số lượng còn lại của sản phẩm " + ci.getProductName() + " size "
                                    + ci.getSize();
                        }
                    }

                }

            }
            if (ci.getProductId() == Item.getProductId() && Item.getQuanlity() == 0
                    && ci.getSize().equals(Item.getSize())) {
                iterator.remove();
            }
        }

        // trả kết quả
        Map<String, Object> jsonResult = new HashMap<String, Object>();
        jsonResult.put("code", 200);
        jsonResult.put("status", "TC");
        jsonResult.put("totalItems", getTotalItems(request));
        jsonResult.put("totalPrice", getTotalPrice(request));
        jsonResult.put("productId", Item.getProductId());
        jsonResult.put("productSize", Item.getSize());
        jsonResult.put("productPrice", Item.getPriceUnit());
        jsonResult.put("productQuanlity", Item.getQuanlity());

        jsonResult.put("message", a);
        session.setAttribute("totalItems", getTotalItems(request));
        session.setAttribute("totalPrice", getTotalPrice(request));
        return ResponseEntity.ok(jsonResult);
    }

    @RequestMapping(value = {"/wishlist/add"}, method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> addWishList(final Model model, final HttpServletRequest request,
                                                           final HttpServletResponse response, @RequestBody CartItem newItem) {

        List<Product> products = productService.findAll();

        // session tương tự như kiểu Map và được lưu trên main memory.
        HttpSession session = request.getSession();

        // Lấy thông tin giỏ hàng.
        Cart wishlist = null;
        if (session.getAttribute("wishlist") != null) {
            wishlist = (Cart) session.getAttribute("wishlist");
        } else {
            wishlist = new Cart();
            session.setAttribute("wishlist", wishlist);
            // từ attribute này để for ra trên màn hình view wishlist
        }

        // Lấy danh sách size để get số lượng còn
        List<ProductSize> productSizes = productSizeService.findAll();
        // Lấy danh sách sản phẩm có trong giỏ hàng
        List<CartItem> cartItems = wishlist.getCartItems();
        String a = null;
        // kiểm tra nếu có trong wishlist thì tăng số lượng
        boolean isExists = false;
        for (CartItem item : cartItems) {
            if (item.getProductId() == newItem.getProductId() && item.getSize().equals(newItem.getSize())) {
                isExists = true;
                a = "Sản phẩm đã tồn tại trong WishList";
                break;
            }
        }

        // nếu sản phẩm chưa có trong wishlist
        if (!isExists) {
            Product productInDb = productService.getById(newItem.getProductId());
            for (ProductSize ps : productSizes) {
                if (ps.getSize().equals(newItem.getSize()) && ps.getProducts2().getId() == newItem.getProductId()) {
                    newItem.setProductName(productInDb.getTitle());
                    newItem.setProductAvatar(productInDb.getAvatar());
                    // nếu có giá sale thì lấy giá sale
                    if (productInDb.getPrice_sale() == productInDb.getPrice() || productInDb.getPrice_sale() == null) {
                        newItem.setPriceUnit(productInDb.getPrice());
                    } else {
                        newItem.setPriceUnit(productInDb.getPrice_sale());
                    }
                    a = null;
                    wishlist.getCartItems().add(newItem);
                }

            }

        }

        // trả kết quả
        Map<String, Object> jsonResult = new HashMap<String, Object>();
        jsonResult.put("code", 200);
        jsonResult.put("status", "TC");
        jsonResult.put("totalItems1", getTotalItems1(request));
        jsonResult.put("message1", a);
        jsonResult.put("wishlist", wishlist.getCartItems());

        // sl treen heart header
        session.setAttribute("totalItems1", getTotalItems1(request));
        // session.setAttribute("products1", products);
        return ResponseEntity.ok(jsonResult);

        // ResponseEntity đại diện cho toàn bộ phản hồi HTTP: mã trạng thái, tiêu đề và
        // nội dung .
        // Do đó, chúng tôi có thể sử dụng nó để định cấu hình đầy đủ phản hồi HTTP.
        // Nếu chúng ta muốn sử dụng nó, chúng ta phải trả lại nó từ điểm cuối; Mùa xuân
        // lo phần còn lại.
        // ResponseEntity là một kiểu chung.
        // @GetMapping("/hello")
        // ResponseEntity<String> hello() {
        // return new ResponseEntity<>("Hello World!", HttpStatus.OK);
        // }
    }

    @RequestMapping(value = {"/wishlist/delete"}, method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> deleteWishListItem(final ModelMap model,
                                                                  final HttpServletRequest request, final HttpServletResponse response, @RequestBody CartItem Item) {

        HttpSession session = request.getSession();
        Cart wishlist = (Cart) session.getAttribute("wishlist");
        Iterator<CartItem> iterator = wishlist.getCartItems().iterator();
        while (iterator.hasNext()) {
            CartItem ci = iterator.next();
            if (ci.getProductId() == Item.getProductId() && ci.getSize().equals(Item.getSize())) {
                iterator.remove();
            }
        }

        // trả kết quả
        Map<String, Object> jsonResult = new HashMap<String, Object>();
        jsonResult.put("code", 200);
        jsonResult.put("status", "TC");
        jsonResult.put("totalItems1", getTotalItems1(request));
        session.setAttribute("totalItems1", getTotalItems1(request));
        return ResponseEntity.ok(jsonResult);
    }

    // TÍNH SỐ sp TRONG GIỎ HÀNG THEO SỐ LƯỢNG TỪNG SP
    private int getTotalItems(final HttpServletRequest request) {
        HttpSession httpSession = request.getSession();

        if (httpSession.getAttribute("cart") == null) {
            return 0;
        }

        Cart cart = (Cart) httpSession.getAttribute("cart");
        List<CartItem> cartItems = cart.getCartItems();

        int total = 0;
        for (CartItem item : cartItems) {
            total += item.getQuanlity();
        }

        return total;
    }

    // tÍNH SỐ SP TRONG WISHLIST THEO SỐ SẢN PHẩm
    private int getTotalItems1(final HttpServletRequest request) {
        HttpSession httpSession = request.getSession();

        if (httpSession.getAttribute("wishlist") == null) {
            return 0;
        }

        Cart wishlist = (Cart) httpSession.getAttribute("wishlist");
        List<CartItem> cartItems = wishlist.getCartItems();

        int total = 0;
        for (CartItem item : cartItems) {
            total += 1;
        }

        return total;
    }

    private BigDecimal getTotalPrice(final HttpServletRequest request) {
        HttpSession httpSession = request.getSession();

        if (httpSession.getAttribute("cart") == null) {
            return BigDecimal.ZERO;
        }

        Cart cart = (Cart) httpSession.getAttribute("cart");
        List<CartItem> cartItems = cart.getCartItems();

        // tinh toan vs BigDecimal
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            // phải đổi int sang Bigdecimal vs phép nhân = hàm multiply();
            // phép cộng = hàm add()
            totalPrice = totalPrice.add(item.getPriceUnit().multiply(new BigDecimal(item.getQuanlity())));
        }

        return totalPrice;
    }
}
