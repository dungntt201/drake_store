package com.dev.drakestore.service;


import java.util.List;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.Comment;
import org.springframework.stereotype.Service;

@Service
public class CommentService extends BaseService<Comment> {

	@Override
	protected Class<Comment> clazz() {
		// TODO Auto-generated method stub
		return Comment.class;
	}

	// lấy số cmt theo size vs blog ID
//	public List<Comment> findCommentByBlogID(int id, int page, int SizeOfPage) {
//		String sql = "SELECT * FROM tbl_comment where blog_id = " + id + " order by created_date desc";
//		return super.executeNativeSql(sql, page, SizeOfPage);
//	}
//
	// lấy all comment by blog_id
	public List<Comment> findByBlogId(Integer id) {
		String sql = "select * from tbl_comment where blog_id = " + id;
		return super.executeNativeSql1(sql);
	}

	// tất cả service đều thêm hàm search
	// hàm này lấy bản ghi với điều kiện so sánh nhưng chỉ lấy số bả ghi = size của
	// 1 trang
	public List<Comment> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_comment p WHERE 1=1 ";

		if (searchModel.getBlog_id() >= 1) {
			sql += "and p.blog_id = " + searchModel.getBlog_id() + " ";
		}

		sql += "and p.status= 1 order by p.created_date desc";

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<Comment> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_comment p WHERE 1=1 ";

		if (searchModel.getBlog_id() >= 1) {
			sql += "and p.blog_id = " + searchModel.getBlog_id() + " ";
		}

		sql += "and p.status= 1 order by p.created_date desc";

		return executeNativeSql1(sql);
	}

}
