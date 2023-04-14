package com.dev.drakestore.service;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.Constants;
import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Product;
import com.dev.drakestore.entities.ProductImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProductService extends BaseService<Product> implements Constants {

	@Autowired
	private ProductImageService productImageService;

	@Override
	protected Class<Product> clazz() {
		// TODO Auto-generated method stub
		return Product.class;
	}

	// lấy 12sp
	public List<Product> findProductsActive() {
		String sql = "SELECT * FROM drakestore.tbl_products where status =1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";

		return super.executeNativeSql1(sql);
	}

// lấy 12sp
	public List<Product> findProductsInActive() {
		String sql = "SELECT * FROM drakestore.tbl_products where status =0;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 12sp
	public List<Product> find12Products() {
		String sql = "SELECT * FROM drakestore.tbl_products where status =1 order by updated_date desc limit 12";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 3p bán chyaj nhất
	public List<Product> findBestSellerProducts() {
		String sql = "SELECT * FROM tbl_products where status =1 order by sold desc limit 3";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 3sp hot mưới nhất
	public List<Product> find3HotProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where status =1 and is_hot = 1  order by created_date desc limit 3";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 3 sp sale

	public List<Product> find3SaleProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where price > price_sale and status = 1  order by created_date desc limit 3";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 10 sp tạo mới nhất
	public List<Product> findHotProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where is_hot = 1 and status=1 order by created_date desc limit 10";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả sp tạo mới nhất
	public List<Product> findAllHotProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where is_hot = 1 and status = 1   order by created_date desc";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}
	// lấy 10 sp sale

	public List<Product> findSaleProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where price > price_sale and status=1  order by created_date desc limit 10";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả sản phẩm sale
	public List<Product> findAllSaleProducts() {
		String sql = "SELECT * FROM drakestore.tbl_products where price > price_sale and status=1  order by created_date desc";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy sp bằng seo
	public Product findBySeo(String seo) {
		String sql = "select * from tbl_products where  seo = '" + seo + "'";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		// return super.executeNativeSql1(sql);
		List<Product> products = this.executeNativeSql1(sql);
		if (products == null || products.size() <= 0)
			return null;
		return products.get(0);
	}

	// lấy sản phẩm liên quan theo category
	public List<Product> findRalatedProducts(int category_id, int id) {
		String sql = "select * from tbl_products where status=1 and category_id=" + category_id + " and id!=" + id
				+ " limit 4";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<Product> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		// khởi tạo câu lệnh
		String sql = "";
		if (searchModel.getCategory_id() >= 1) {
			if (searchModel.getSizes() != null && searchModel.getSizes().length > 0) {
				sql += "SELECT distinct p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_product_size s "
						+ "on p.id = s.product_id " + "inner join tbl_category c " + "on p.category_id = c.id ";
				sql += "where (s.size ='";
				if (searchModel.getSizes().length == 1) {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						sql += searchModel.getSizes()[i] + "') ";
					}
				} else {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						if (i != searchModel.getSizes().length - 1) {
							sql += searchModel.getSizes()[i] + "' or s.size='";
						} else {
							sql += searchModel.getSizes()[i] + "'";
						}
					}
					sql += ") ";
				}

				sql += "and( c.id =" + searchModel.getCategory_id() + " " + "or c.parent_id="
						+ searchModel.getCategory_id() + " ) ";

			} else {
				sql += "SELECT p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_category c "
						+ "on p.category_id = c.id " + "where ( c.id =" + searchModel.getCategory_id() + " "
						+ "or c.parent_id=" + searchModel.getCategory_id() + " ) ";
			}
		} else {
			if (searchModel.getSizes() != null && searchModel.getSizes().length > 0) {
				sql += "SELECT distinct p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_product_size s "
						+ "on p.id = s.product_id where (s.size ='";
				if (searchModel.getSizes().length == 1) {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						sql += searchModel.getSizes()[i] + "') ";
					}
				} else {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						if (i != searchModel.getSizes().length - 1) {
							sql += searchModel.getSizes()[i] + "' or s.size='";
						} else {
							sql += searchModel.getSizes()[i] + "'";
						}
					}
					sql += ") ";
				}
				// +searchModel.getSize()+"' ";
			} else {
				sql += "SELECT * FROM tbl_products p WHERE 1=1 ";
			}
		}

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.title) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.detail_description) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.category_id) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}
		if (!StringUtils.isEmpty(searchModel.getMinPrice())) {
			sql += "and (p.price >= " + searchModel.getMinPrice() + ") ";
		}
		if (!StringUtils.isEmpty(searchModel.getMaxPrice())) {
			sql += "and (p.price <= " + searchModel.getMaxPrice() + ") ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("hot")) {
				sql += "and (p.is_hot=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("sale")) {
				sql += "and (p.price_sale<p.price and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				sql += "and p.status=1 ";
				// để phù hợp với bên giao diện FE
//				sql += " ";
			}
		} else {
			// trường hợp mới vào trang
			sql += "and p.status=1 ";
		}

		// dùng bên giao diện để hiển thị trang hot và sale
		if (searchModel.isHot()) {
			sql += "and (p.is_hot=1) ";
		}
		if (searchModel.isSale()) {
			sql += "and (p.price > p.price_sale) ";
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.title asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.title desc";
			} else if (searchModel.getSort().equals("lowtohigh")) {
				sql += "order by p.price asc";
			} else if (searchModel.getSort().equals("hightolow")) {
				sql += "order by p.price desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}
		if (searchModel.getCategory_id() < 1 && (searchModel.getSizes() == null || searchModel.getSizes().length == 0)
				&& StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getMinPrice())
				&& StringUtils.isEmpty(searchModel.getMaxPrice()) && StringUtils.isEmpty(searchModel.getFilter())
				&& !searchModel.isHot() && !searchModel.isSale() && StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<Product> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "";
		if (searchModel.getCategory_id() >= 1) {
			if (searchModel.getSizes() != null && searchModel.getSizes().length > 0) {

				sql += "SELECT distinct p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_product_size s "
						+ "on p.id = s.product_id " + "inner join tbl_category c " + "on p.category_id = c.id ";
				sql += "where (s.size ='";
				if (searchModel.getSizes().length == 1) {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						sql += searchModel.getSizes()[i] + "') ";
					}
				} else {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						if (i != searchModel.getSizes().length - 1) {
							sql += searchModel.getSizes()[i] + "' or s.size='";
						} else {
							sql += searchModel.getSizes()[i] + "'";
						}
					}
					sql += ") ";
				}

				sql += "and( c.id =" + searchModel.getCategory_id() + " " + "or c.parent_id="
						+ searchModel.getCategory_id() + " ) ";

			} else {
				sql += "SELECT p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_category c "
						+ "on p.category_id = c.id " + "where ( c.id =" + searchModel.getCategory_id() + " "
						+ "or c.parent_id=" + searchModel.getCategory_id() + " ) ";
			}
		} else {
			if (searchModel.getSizes() != null && searchModel.getSizes().length > 0) {

				sql += "SELECT distinct p.id,p.title,p.price,p.price_sale,p.detail_description,p.avatar,"
						+ "p.category_id,p.created_date,p.updated_date,p.created_by,p.updated_by,"
						+ "p.status,p.seo,p.is_hot,p.sold" + " FROM tbl_products p inner join " + "tbl_product_size s "
						+ "on p.id = s.product_id where (s.size ='";
				if (searchModel.getSizes().length == 1) {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						sql += searchModel.getSizes()[i] + "') ";
					}
				} else {
					for (int i = 0; i < searchModel.getSizes().length; i++) {
						if (i != searchModel.getSizes().length - 1) {
							sql += searchModel.getSizes()[i] + "' or s.size='";
						} else {
							sql += searchModel.getSizes()[i] + "'";
						}
					}
					sql += ") ";
				}

			} else {
				sql += "SELECT * FROM tbl_products p WHERE 1=1 ";
			}
		}

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.title) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.detail_description) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.category_id) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}
		if (!StringUtils.isEmpty(searchModel.getMinPrice())) {
			sql += "and (p.price >= " + searchModel.getMinPrice() + ")";
		}
		if (!StringUtils.isEmpty(searchModel.getMaxPrice())) {
			sql += "and (p.price <= " + searchModel.getMaxPrice() + ")";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("hot")) {
				sql += "and (p.is_hot=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("sale")) {
				sql += "and (p.price_sale<p.price and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				sql += "and p.status=1 ";
				// để phù hợp với bên giao diện FE
//					sql += " ";
			}
		} else {
			// trường hợp mới vào trang
			sql += "and p.status=1 ";
		}

		//// dùng bên giao diện để hiển thị trang hot và sale
		if (searchModel.isHot()) {
			sql += "and (p.is_hot=1 and p.status=1) ";
		}
		if (searchModel.isSale()) {
			sql += "and (p.price > p.price_sale and p.status=1) ";
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.title asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.title desc";
			} else if (searchModel.getSort().equals("lowtohigh")) {
				sql += "order by p.price asc";
			} else if (searchModel.getSort().equals("hightolow")) {
				sql += "order by p.price desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (searchModel.getCategory_id() < 1 && (searchModel.getSizes() == null || searchModel.getSizes().length == 0)
				&& StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getMinPrice())
				&& StringUtils.isEmpty(searchModel.getMaxPrice()) && StringUtils.isEmpty(searchModel.getFilter())
				&& !searchModel.isHot() && !searchModel.isSale() && StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";
		// System.out.println(sql);
		return executeNativeSql1(sql);
	}

	private boolean isEmptyUploadFile(MultipartFile[] images) {
		if (images == null || images.length <= 0)
			return true;

		if (images.length == 1 && images[0].getOriginalFilename().isEmpty())
			return true;

		return false;
	}

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public Product save(Product product, MultipartFile productAvatar, MultipartFile[] productPictures)
			throws Exception {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		product.setCreated_date(ngay);
		product.setUpdated_date(ngay);
		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(productAvatar)) {
//			String path = "C:\\Users\\ASUS\\eclipse-workspace\\com.devpro.drakestore\\Uploads\\products\\avatars\\"
//					+ productAvatar.getOriginalFilename();
			String path = UPLOAD_FOLDER_ROOT + "products/avatars/" + productAvatar.getOriginalFilename();
			productAvatar.transferTo(new File(path));
			product.setAvatar("/products/avatars/" + productAvatar.getOriginalFilename());
		}

		if (!isEmptyUploadFile(productPictures)) {
			String path = UPLOAD_FOLDER_ROOT + "products/pictures/";
			for (MultipartFile pic : productPictures) {
				// lưu aanhr vào folder
				pic.transferTo(new File(path + pic.getOriginalFilename()));
				// thêm vào tbl_products_images
				ProductImage pi = new ProductImage();
				pi.setPath("/products/pictures/" + pic.getOriginalFilename());
				pi.setTitle(pic.getOriginalFilename());
				pi.setStatus(true);
				product.addRelationProduct(pi);
			}

		}

		// luu vao db
		return super.saveOrUpdate(product);
	}

	@Transactional

	public Product edit(Product product, MultipartFile productAvatar, MultipartFile[] productPictures,
			List<ProductImage> productImage) throws Exception {
		// lay thong tin trong db
		Product productOnDb = super.getById(product.getId());

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		product.setCreated_date(productOnDb.getCreated_date());
		product.setUpdated_date(ngay);

		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(productAvatar)) {
			// xóa file trong folder
			new File(UPLOAD_FOLDER_ROOT + productOnDb.getAvatar()).delete();
//			File file2 = new File(UPLOAD_FOLDER_ROOT + productOnDb.getAvatar());

			String path = UPLOAD_FOLDER_ROOT + "products/avatars/" + productAvatar.getOriginalFilename();
			productAvatar.transferTo(new File(path));
			product.setAvatar("/products/avatars/" + productAvatar.getOriginalFilename());
		} else {
			// sd lai avatar cũ
			product.setAvatar(productOnDb.getAvatar());
		}

		if (!isEmptyUploadFile(productPictures)) {
			// xoa anh trong folder pictures
			for (ProductImage pi1 : productImage) {
				if (pi1.getProducts().getId() == product.getId()) {
					new File(UPLOAD_FOLDER_ROOT + pi1.getPath()).delete();
					// productOnDb.deleteRelationProduct(pi1);
				}
			}
			// xóa bản ghi trong tbl_product_images liên kết vs tbl_product
			productImageService.deleteProductImageByProductID(product.getId());

			// luu ảnh mới vào
			String path = UPLOAD_FOLDER_ROOT + "products/pictures/";
			for (MultipartFile pic : productPictures) {
				pic.transferTo(new File(path + pic.getOriginalFilename()));
				// thêm vào tbl_products_images
				ProductImage pi = new ProductImage();
				pi.setPath("/products/pictures/" + pic.getOriginalFilename());
				pi.setTitle(pic.getOriginalFilename());
				product.addRelationProduct(pi);
			}

		}

		// luu vao db
		return super.saveOrUpdate(product);
	}

	// xóa dữ liệu trong DB cần dùng @transitional
	@Transactional
	public void deleteProductByID(int Id, List<ProductImage> productImage) {
		Product productOnDb = super.getById(Id);

		// xóa ảnh avatar của product vừa xóa trong folder avatar
		new File(UPLOAD_FOLDER_ROOT + productOnDb.getAvatar()).delete();
		// xóa ảnh pictures của productImage vừa xóa cùng vs product trong folder
		// pictures
		for (ProductImage pi1 : productImage) {
			if (pi1.getProducts().getId() == Id) {
				new File(UPLOAD_FOLDER_ROOT + pi1.getPath()).delete();
			}
		}
		// productImageService.deleteProductImageByProductID(Id);
		super.deleteById(Id);
	}
}
