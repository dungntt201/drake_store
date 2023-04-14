package com.dev.drakestore.service;

import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Contact;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class ContactService extends BaseService<Contact> {

	@Override
	protected Class<Contact> clazz() {
		// TODO Auto-generated method stub
		return Contact.class;
	}

	// lấy active
	public List<Contact> findActive() {
		String sql = "select * from tbl_contact where status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy active
	public List<Contact> findInActive() {
		String sql = "select * from tbl_contact where status=0;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// tất cả service đều thêm hàm search
// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của 1 trang 
	public List<Contact> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_contact p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.full_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.phone_number) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.email) like LOWER('%" + searchModel.getKeyword() + "%')) ";
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
				sql += "order by p.full_name asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.full_name desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
//							sql += " and p.status=1 ";

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

//tất cả service đều thêm hàm search
//hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<Contact> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_contact p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.full_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.phone_number) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.email) like LOWER('%" + searchModel.getKeyword() + "%')) ";
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
				sql += "order by p.full_name asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.full_name desc";
			} else {
				sql += "order by p.updated_date desc";
			}

		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";

		return executeNativeSql1(sql);
	}

	@Transactional
	public void deleteContactByID(int Id) {
		super.deleteById(Id);
	}

}
