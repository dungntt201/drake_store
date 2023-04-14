package com.dev.drakestore.service;

import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.ProductSize;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;


@Service
public class ProductSizeService extends BaseService<ProductSize> {

	@Override
	protected Class<ProductSize> clazz() {
		// TODO Auto-generated method stub
		return ProductSize.class;
	}

	public List<ProductSize> findByProductId(int id) {
		String sql = "select * from tbl_product_size where status=1 and product_id = '" + id + "'";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		// return super.executeNativeSql1(sql);
		return super.executeNativeSql1(sql);
	}

	public List<ProductSize> findAllSortBySize() {
		String sql = "select * from tbl_product_size order by size asc";
		return super.executeNativeSql1(sql);
	}

	public ProductSize getByProductIdAndSize(int id, String size) {
		String sql = "SELECT * FROM tbl_product_size p WHERE p.product_id =" + id + " AND LOWER(p.size) = LOWER('"
				+ size + "')";
		List<ProductSize> productsizes = this.executeNativeSql1(sql);
		if (productsizes == null || productsizes.size() <= 0)
			return null;
		return productsizes.get(0);

	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<ProductSize> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_product_size p WHERE 1=1 ";
		if (searchModel.getProduct_id() > 0) {
			sql += "and p.product_id=" + searchModel.getProduct_id() + " ";
		}
		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.size) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.product_id) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				/* sql += "and p.status=1 "; */
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.size asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.size desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (searchModel.getProduct_id() < 1 && StringUtils.isEmpty(searchModel.getKeyword())
				&& StringUtils.isEmpty(searchModel.getFilter()) && StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// sql += "order by updated_date desc";
		// chi lay san pham chua xoa
//						sql += " and p.status=1 ";

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<ProductSize> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_product_size p WHERE 1=1 ";
		if (searchModel.getProduct_id() > 0) {
			sql += "and p.product_id=" + searchModel.getProduct_id() + " ";
		}
		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.size) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.product_id) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
				/* sql += "and p.status=1 "; */
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.size asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.size desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (searchModel.getProduct_id() < 1 && StringUtils.isEmpty(searchModel.getKeyword())
				&& StringUtils.isEmpty(searchModel.getFilter()) && StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";

		return executeNativeSql1(sql);
	}

	@Transactional
	public void deleteProductSizeByID(int Id) {
		super.deleteById(Id);
	}

}
