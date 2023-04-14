package com.dev.drakestore.service;

import java.util.List;

import javax.transaction.Transactional;

import com.dev.drakestore.entities.ProductImage;
import org.springframework.stereotype.Service;

@Service
public class ProductImageService extends BaseService<ProductImage>{

	@Override
	protected Class<ProductImage> clazz() {
		// TODO Auto-generated method stub
		return ProductImage.class;
	}
	
	public List<ProductImage> findbyProductId(int id) {
			String sql = "SELECT * FROM drakestore.tbl_product_images where product_id=" + id;
			// String sql = "select * from tbl_products where category_id="+category_id+"
			// and limit 4";
			return super.executeNativeSql1(sql);
	}
	//xóa dữ liệu trong DB cần dùng @transitional
	 @Transactional
	 public void deleteProductImageByProductID(int Id) {
		 List<ProductImage> listPImage= findbyProductId(Id);
		 for(ProductImage P : listPImage) {
			 super.deleteById(P.getId());
		 }
	     
	 }

}
