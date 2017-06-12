package com.huaao.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

@Service 
public class MenuRoleService {
	private String sql=null;
	@Autowired
	private BaseDao baseDao;
	
	
	/** 
	* @Title: queryMenuForRole 
	* @Description: TODO(查询角色(暂时功能性实现，未做与其他公功能结合。业务逻辑)-需更新)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryMenuForRole(int role){
		sql="select * from sps_s_menu_role where role_id=? and is_valid=?";
		return baseDao.queryForList(sql,new Object[]{role,1});
	}
	
	public boolean MenuForRole(int id,int is){
		sql="update sps_s_menu_role set is_valid=? where id=?";
		return baseDao.update(sql,new Object[]{is,id})>0;
	}
	public boolean insertMenuForRole(int roleid,int menuid,int is){
		sql="insert into sps_s_menu_role(role_id,menu_id,is_valid)values(?,?,?)";
		return baseDao.update(sql,new Object[]{roleid,menuid,is})>0;
	}
}
