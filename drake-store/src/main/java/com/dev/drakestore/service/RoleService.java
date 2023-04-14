package com.dev.drakestore.service;

import java.util.List;

import com.dev.drakestore.entities.Role;
import org.springframework.stereotype.Service;

@Service
public class RoleService extends BaseService<Role> {

	@Override
	protected Class<Role> clazz() {
		// TODO Auto-generated method stub
		return Role.class;
	}

	public List<Role> findAllActive() {
		String sql = "select * from tbl_roles where status=1";
		return super.executeNativeSql1(sql);
	}

	public Role loadRoleByName(String name) {
		String sql = "select * from tbl_roles u where u.name = '" + name + "'";
		List<Role> roles = this.executeNativeSql1(sql);
		if (roles == null || roles.size() <= 0)
			return null;
		return roles.get(0);
	}

}
