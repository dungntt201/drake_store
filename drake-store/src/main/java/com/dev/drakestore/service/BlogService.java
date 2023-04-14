package com.dev.drakestore.service;


import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.Constants;
import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Blog;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BlogService extends BaseService<Blog> implements Constants {

	@Override
	protected Class<Blog> clazz() {
		// TODO Auto-generated method stub
		return Blog.class;
	}

	// lấy active
	public List<Blog> findActive() {
		String sql = "select * from tbl_blog where status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy active
	public List<Blog> findInActive() {
		String sql = "select * from tbl_blog where status=0;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy 3 blog mới nhất
	public List<Blog> find3Blog() {
		String sql = "select * from tbl_blog where status=1 order by created_date desc limit 3";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy sp bằng seo
	public Blog findBySeo(String seo) {
		String sql = "select * from tbl_blog where seo = '" + seo + "'";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		List<Blog> blogs = this.executeNativeSql1(sql);
		if (blogs == null || blogs.size() <= 0)
			return null;
		return blogs.get(0);
		// return super.executeNativeSql1(sql);
	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<Blog> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_blog p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.title) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.content) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.tag) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}
		if (!StringUtils.isEmpty(searchModel.getTag())) {
			sql += "and LOWER(p.tag) like LOWER('%" + searchModel.getTag() + "%')";
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
				sql += "order by p.title asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.title desc";
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

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<Blog> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_blog p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.title) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.content) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.tag) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.seo) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}

		if (!StringUtils.isEmpty(searchModel.getTag())) {
			sql += "and LOWER(p.tag) like LOWER('%" + searchModel.getTag() + "%')";
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
				sql += "order by p.title asc";
			} else if (searchModel.getSort().equals("name:desc")) {
				sql += "order by p.title desc";
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

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public Blog save(Blog blog, MultipartFile blogAvatar) throws Exception {
		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		blog.setCreated_date(ngay);
		blog.setUpdated_date(ngay);
		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(blogAvatar)) {
			String path = UPLOAD_FOLDER_ROOT + "blogs/avatars/" + blogAvatar.getOriginalFilename();
			// lưu vào folder
			blogAvatar.transferTo(new File(path));
			blog.setAvatar("/blogs/avatars/" + blogAvatar.getOriginalFilename());
		}

		// luu vao db
		return super.saveOrUpdate(blog);
	}

	@Transactional

	public void edit(Blog blog, MultipartFile blogAvatar) throws Exception {
		// lay thong tin trong db
		Blog blogOnDb = super.getById(blog.getId());

		Calendar cal = Calendar.getInstance();
		Date ngay = cal.getTime();

		blog.setCreated_date(blogOnDb.getCreated_date());
		blog.setUpdated_date(ngay);

		// kiểm tra xem có upload avatar k
		if (!isEmptyUploadFile(blogAvatar)) {
			// xóa file trong folder
			new File(UPLOAD_FOLDER_ROOT + blogOnDb.getAvatar()).delete();

			String path = UPLOAD_FOLDER_ROOT + "blogs/avatars/" + blogAvatar.getOriginalFilename();
			blogAvatar.transferTo(new File(path));
			blog.setAvatar("/blogs/avatars/" + blogAvatar.getOriginalFilename());
		} else {
			// sd lai avatar cũ
			blog.setAvatar(blogOnDb.getAvatar());
		}

		// luu vao db
		super.saveOrUpdate(blog);
	}

	// xóa dữ liệu trong DB cần dùng @transitional
	@Transactional
	public void deleteBlogByID(int Id) {
		Blog blogOnDb = super.getById(Id);
		// xóa ảnh avatar của product vừa xóa trong folder avatar
		new File(UPLOAD_FOLDER_ROOT + blogOnDb.getAvatar()).delete();
		super.deleteById(Id);
	}
}
