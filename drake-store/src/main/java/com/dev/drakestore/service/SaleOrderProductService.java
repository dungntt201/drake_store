package com.dev.drakestore.service;

import java.util.List;

import com.dev.drakestore.entities.SaleOrderProducts;
import org.springframework.stereotype.Service;

@Service
public class SaleOrderProductService extends BaseService<SaleOrderProducts> {

	@Override
	protected Class<SaleOrderProducts> clazz() {
		// TODO Auto-generated method stub
		return SaleOrderProducts.class;
	}
	
	public List<SaleOrderProducts> findBySaleOrderId( int saleOrderID){
		String sql = "SELECT * FROM tbl_saleorder_products where saleorder_id ="+saleOrderID;
		//String sql = "select * from tbl_products where category_id="+category_id+" and limit 4";
		return super.executeNativeSql1(sql);
	}

}
