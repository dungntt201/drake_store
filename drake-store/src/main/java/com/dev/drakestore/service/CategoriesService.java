package com.dev.drakestore.service;


import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Categories;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class CategoriesService extends BaseService<Categories> {

	@Override
	protected Class<Categories> clazz() {
		// TODO Auto-generated method stub
		return Categories.class;
	}

	//
	public List<Categories> findAllActive(Integer id) {
		String sql = "select * from tbl_category where status=1 and id!=" + id;
		return super.executeNativeSql1(sql);
	}

	public List<Categories> findAllActive() {
		String sql = "select * from tbl_category where status=1;";
		return super.executeNativeSql1(sql);
	}

	//
	public List<Categories> findAllInActive() {
		String sql = "select * from tbl_category where status=0";
		return super.executeNativeSql1(sql);
	}
//	public List<Categories> findOneByName(String name) {
//		String sql="select * from tbl_category where name=" + name;
//		return super.executeNativeSql(sql,-1);
//	} 

	// tìm category theo category cha
	public List<Categories> findChildrenOfParentCategory(int category_id) {
		String sql = "select * from tbl_category where (parent_id= " + category_id + " or id= " + category_id
				+ " ) and status=1";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// tìm kiếm các category cha
	public List<Categories> findFullParentCategories() {
		String sql = "SELECT * FROM tbl_category where parent_id is null and status=1";
		return executeNativeSql1(sql);
	}

	// tìm category con
	public List<Categories> findFullChildrenCategories() {
		String sql = "SELECT * FROM tbl_category where parent_id is not null and status=1";
		return executeNativeSql1(sql);
	}

	// tìm sản phẩm theo trường seo
	public Categories findBySeo(String seo) {
		String sql = "select * from tbl_category where seo = '" + seo + "'";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		// return super.executeNativeSql1(sql);
		List<Categories> categories = this.executeNativeSql1(sql);
		if (categories == null || categories.size() <= 0)
			return null;
		return categories.get(0);
	}

	public List<Categories> findAllChildrenCateById(int id) {
		String sql = "with recursive cte (id,name,description,created_date,updated_date,created_by,updated_by,parent_id,status,seo) as ("
				+ "	select id,name,description,created_date,updated_date,created_by,updated_by,parent_id,status,seo "
				+ " from drakestore.tbl_category  where parent_id = " + id
				+ "	union all  select p.id,p.name,p.description,p.created_date,p.updated_date,p.created_by,p.updated_by,p.parent_id,p.status,p.seo "
				+ " from drakestore.tbl_category p" + "	inner join cte on p.parent_id = cte.id) "
				+ " SELECT * FROM cte ;";

		List<Categories> list = this.executeNativeSql1(sql);
		if (list == null || list.size() <= 0) {
			return null;
		} else {
			return list;
		}
	}

	public boolean checkIDInListChildren(int id, int IdParent) {
		List<Categories> list = findAllChildrenCateById(IdParent);
		if (list == null || list.size() <= 0) {
			return false;
		} else {
			int check = 0;
			for (Categories c : list) {
				if (c.getId() == id) {
					check = 1;
					break;
				}
			}
			if (check == 1) {
				return true;
			} else {
				return false;
			}
		}
	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<Categories> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_category p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.description) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.parent_id) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("parent")) {
				sql += "and (p.parent_id is null and p.status=1) ";
			} else if (searchModel.getFilter().equals("children")) {
				sql += "and (p.parent_id is not null and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
//						sql+="and p.status=1 ";
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.name asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.name desc";
			} else {
				sql += "order by p.updated_date desc";
			}
		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<Categories> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_category p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.description) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.parent_id) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("parent")) {
				sql += "and (p.parent_id is null and p.status=1) ";
			} else if (searchModel.getFilter().equals("children")) {
				sql += "and (p.parent_id is not null and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
//						sql+="and p.status=1 ";
				sql += " ";
			}
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("name:asc")) {
				sql += "order by p.name asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.name desc";
			} else {
				sql += "order by p.updated_date desc";
			}
		}

		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort())) {
			sql += "order by p.updated_date desc";
		}

		return executeNativeSql1(sql);
	}

	@Transactional
	public Categories save(Categories category) {
		// kiểm tra xem có upload avatar k
		// luu vao db
		return super.saveOrUpdate(category);
	}

	// xóa cần dùng @Transactional
	@Transactional
	public void deleteCategoryByID(int Id) {
		super.deleteById(Id);
	}

}
