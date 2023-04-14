package com.dev.drakestore.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.dto.ProductSearch;
import com.dev.drakestore.entities.SaleOrder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class SaleOrderService extends BaseService<SaleOrder> {

	@Override
	protected Class<SaleOrder> clazz() {
		// TODO Auto-generated method stub
		return SaleOrder.class;
	}

	// lấy saleorder theo tháng và năm
	public List<SaleOrder> findAllByMonthAndYear(int year, int month) {
		String sql = "SELECT * FROM drakestore.tbl_saleorder as p where month(p.created_date)=" + month
				+ " and year(p.created_date)=" + year + " and p.confirm=1 and p.is_delivery=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// xóa cần dùng @Transactional
	@Transactional
	public void deleteSaleOrderByID(int Id) {
		super.deleteById(Id);
	}

	// lấy tất cả hóa đơn active
	public List<SaleOrder> findAllActive() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả hóa đơn active
	public List<SaleOrder> findAllInActive() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where status=0;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả hóa đơn chưa xác nhận active
	public List<SaleOrder> findAllConfirm() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where confirm=0 and cancel=0 and status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả hóa đơn đang giao
	public List<SaleOrder> findAllDelivery() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where confirm=1 and cancel=0 and is_delivery=0 and status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả hóa đơn đã giao
	public List<SaleOrder> findAllDelivered() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where confirm=1 and cancel=0 and is_delivery=1 and status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy tất cả hóa đơn đã hủy
	public List<SaleOrder> findAllCancel() {
		String sql = "SELECT * FROM drakestore.tbl_saleorder where cancel=1 and status=1;";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	public List<SaleOrder> findAllSortByDate() {
		String sql = "SELECT * FROM tbl_saleorder where status=1 order by created_date desc";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	// lấy sp bằng seo
	public SaleOrder findByCode(String code) {
		String sql = "select * from tbl_saleorder where code = '" + code + "'";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		List<SaleOrder> saleOrders = this.executeNativeSql1(sql);
		if (saleOrders == null || saleOrders.size() <= 0)
			return null;
		return saleOrders.get(0);
		// return super.executeNativeSql1(sql);
	}

	public List<SaleOrder> findAllByUserId(int id) {
		String sql = "SELECT * FROM tbl_saleorder where user_id = '" + id + "' order by created_date desc";
		// String sql = "select * from tbl_products where category_id="+category_id+"
		// and limit 4";
		return super.executeNativeSql1(sql);
	}

	public List<SaleOrder> search(ProductSearch searchModel, int sizeOfPage) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_saleorder p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.code) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_email) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_address) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_phone) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}
		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("unconfirm")) {
				sql += "and (p.confirm!=1 and p.cancel!=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("delivering")) {
				sql += "and (p.confirm=1 and p.is_delivery!=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("delivered")) {
				sql += "and (p.confirm=1 and p.is_delivery=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("cancel")) {
				sql += "and (p.cancel=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
//				sql+="and p.status=1 ";
				sql += " ";
			}
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		if (searchModel.getStartDate() != null && searchModel.getEndDate() != null) {

			cal.setTime(searchModel.getEndDate());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			// searchModel.setEndDate(cal.getTime());
			String endDate = sdf.format(cal.getTime());

			sql += "and (p.created_date>='" + sdf.format(searchModel.getStartDate()) + "' and p.created_date<='"
					+ endDate + "') ";

		} else if (searchModel.getStartDate() != null && searchModel.getEndDate() == null) {

			sql += "and (p.created_date>='" + sdf.format(searchModel.getStartDate()) + "') ";

		} else if (searchModel.getStartDate() == null && searchModel.getEndDate() != null) {

			cal.setTime(searchModel.getEndDate());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			// searchModel.setEndDate(cal.getTime());
			String endDate = sdf.format(cal.getTime());

			sql += "and (p.created_date<='" + endDate + "') ";
		} else {
			sql += "";
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("lowtohigh")) {
				sql += "order by p.total asc";
			} else if (searchModel.getSort().equals("hightolow")) {
				sql += "order by p.total desc";
			} else {
				sql += "order by p.updated_date desc";
			}
		}
		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort()) && searchModel.getEndDate() == null
				&& searchModel.getStartDate() == null) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";

		return executeNativeSql(sql, searchModel.getPage(), sizeOfPage);
	}

	// tất cả service đều thêm hàm search
	// hầm này để lấy full bản ghi với điều kiện so sánh để tính số trang sẽ phân đc
	public List<SaleOrder> search1(ProductSearch searchModel) {
		// khởi tạo câu lệnh
		String sql = "SELECT * FROM tbl_saleorder p WHERE 1=1 ";

		// tim kiem san pham theo seachText
		if (!StringUtils.isEmpty(searchModel.getKeyword())) {
			sql += "and (LOWER(p.code) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_name) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_email) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_address) like LOWER('%" + searchModel.getKeyword() + "%')"
					+ " or LOWER(p.customer_phone) like LOWER('%" + searchModel.getKeyword() + "%')) ";
		}
		if (!StringUtils.isEmpty(searchModel.getFilter())) {
			if (searchModel.getFilter().equals("unconfirm")) {
				sql += "and (p.confirm!=1 and p.cancel!=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("delivering")) {
				sql += "and (p.confirm=1 and p.is_delivery!=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("delivered")) {
				sql += "and (p.confirm=1 and p.is_delivery=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("cancel")) {
				sql += "and (p.cancel=1 and p.status=1) ";
			} else if (searchModel.getFilter().equals("inactive")) {
				sql += "and p.status=0 ";
			} else if (searchModel.getFilter().equals("active")) {
				sql += "and p.status=1 ";
			} else {
//				sql+="and p.status=1 ";
				sql += " ";
			}
		}

		// chuyển date sang string dùng SimpleDateFormat theo định dạng để so sánh trong
		// sql
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		if (searchModel.getStartDate() != null && searchModel.getEndDate() != null) {

			// vì so sánh <= ngày thì chỉ lấy đến ngày nhỏ hơn
			// nên t dùng calender để tạo 1 biến dịch thêm 1 ngày là tương tự <= chuẩn
			// và so sánh vs biến đó
			// SimpleDateFormat sdf.format() là chuyển Date về String
			// chuyển String về date thì dùng sdf.parse(chuỗi), chuỗi phải giống định dạng
			// sdf
			// nên t dùng thêm try catch để bắt ngoại lệ

			cal.setTime(searchModel.getEndDate());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			String endDate = sdf.format(cal.getTime());

			sql += "and (p.created_date>='" + sdf.format(searchModel.getStartDate()) + "' and p.created_date<='"
					+ endDate + "') ";

		} else if (searchModel.getStartDate() != null && searchModel.getEndDate() == null) {

			sql += "and (p.created_date>='" + sdf.format(searchModel.getStartDate()) + "') ";

		} else if (searchModel.getStartDate() == null && searchModel.getEndDate() != null) {

			cal.setTime(searchModel.getEndDate());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			String endDate = sdf.format(cal.getTime());

			sql += "and (p.created_date<='" + endDate + "') ";
		} else {
			sql += "";
		}

		if (!StringUtils.isEmpty(searchModel.getSort())) {
			if (searchModel.getSort().equals("latest")) {
				sql += "order by p.created_date desc";
			} else if (searchModel.getSort().equals("oldest")) {
				sql += "order by p.created_date asc";
			} else if (searchModel.getSort().equals("lowtohigh")) {
				sql += "order by p.total asc";
			} else if (searchModel.getSort().equals("hightolow")) {
				sql += "order by p.total desc";
			} else {
				sql += "order by p.updated_date desc";
			}
		}
		if (StringUtils.isEmpty(searchModel.getKeyword()) && StringUtils.isEmpty(searchModel.getFilter())
				&& StringUtils.isEmpty(searchModel.getSort()) && searchModel.getEndDate() == null
				&& searchModel.getStartDate() == null) {
			sql += "order by p.updated_date desc";
		}
		// chi lay san pham chua xoa
		// sql += " and p.status=1 ";

		return executeNativeSql1(sql);
	}
}
