package com.dev.drakestore.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.transaction.Transactional;

import com.dev.drakestore.entities.BaseEntity;
import org.springframework.stereotype.Service;

@Service
public abstract class BaseService<E extends BaseEntity> {

	// private static int SIZE_OF_PAGE = 5;

	@PersistenceContext // entity manager

	// Persistence context có thể coi là một “môi trường” chứa toàn bộ
	// các đối tượng mà ta tạo ra và lưu vào csdl trong mỗi session.

	// Một Session, hay là 1 phiên, là một giao dịch, có phạm vi tùy vào từng ứng
	// dụng.
	// Khi ta làm việc với DB thông qua một Persistence Context, mọi thực-thể sẽ gắn
	// vào context này,
	// mỗi bản ghi trong DB mà ta tương tác sẽ tương ứng với 1 thực thể trong
	// context này.

	// Trong Hibernate, PersistenceContext được tạo ra nhờ org.hibernate.Session .
	// Với JPA, PersistenceContext được thể hiện thông qua class
	// javax.persistence.EntityManager.
	// JPA là bộ đặc tả cho việc lưu dữ liệu vào DB dành cho ngôn ngữ Java,
	// Hibernate sau này đã tuân theo bộ đặc tả đó. Khi đó nếu dùng combo
	// JPA-Hibernate,
	// thì Persistence Context được tạo ra bởi EntityManager interface,
	// thực tế sẽ là một lớp bọc lấy cái Session object ở phía dưới.
	// Nếu ta xài thẳng Session (ko xài EntityManager) thì sẽ có nhiều phương thức
	// cho ta xài hơn,
	// tiện dụng hơn.

	EntityManager entityManager;// quan li casc entity da tao

	protected abstract Class<E> clazz();

//	public int sizeOfPage() {
//		return SIZE_OF_PAGE;
//	}
	public E getById(int id) {
		return entityManager.find(clazz(), id);
	}

	@SuppressWarnings("unchecked")
	public List<E> findAll() {
		Table tbl = clazz().getAnnotation(Table.class);
		return entityManager.createNativeQuery("SELECT * FROM " + tbl.name(), clazz()).getResultList();
	}

	@Transactional
	public E saveOrUpdate(E entity) {
		if (entity.getId() == null || entity.getId() <= 0) {
			// System.out.println("null");
			entityManager.persist(entity);
			entityManager.flush();
			return entity;
		} else {
			// System.out.println("not null");
			E entity1 = entityManager.merge(entity);
			entityManager.flush();
			return entity1;
		}
	}

	public void delete(E entity) {
		entityManager.remove(entity);
	}

	public void deleteById(int id) {
		E entity = this.getById(id);
		delete(entity);
	}

	// để thuc thi cau lenh sql co phân trang
	@SuppressWarnings("unchecked")
	public List<E> executeNativeSql(String sql, int page, int sizeOfPage) {
		try {

			Query query = entityManager.createNativeQuery(sql, clazz());
			// neu page >=0 thi moi phan trang
			// ban ghi trong sql cos chi so tu 0
			if (page >= 0) {
				// dung de phan trang
				// kqua ban ghi ddaau tien can lay
				// neu page=0 =>setFirst=0;
				query.setFirstResult(page * sizeOfPage);
				// so luong ban ghi can lay
				query.setMaxResults(sizeOfPage);

			}
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<E>();
		}
	}

	// để thuc thi cau lenh sql maf k phan trang
	@SuppressWarnings("unchecked")
	public List<E> executeNativeSql1(String sql) {
		try {

			Query query = entityManager.createNativeQuery(sql, clazz());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<E>();
		}
	}
}
