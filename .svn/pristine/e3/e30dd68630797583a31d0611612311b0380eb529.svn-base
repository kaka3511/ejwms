package com.huaao.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.system.Role;

/** 
* @ClassName: ContentService 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author Zhangyu
* @date 2016年8月23日 下午14:15:52 
* 
* 
*/
@Service
public class RoleManageService {
	@Autowired
	private BaseDao baseDao;
	private String sql=null;
	
	/** 
	* @Title: queryForUserType 
	* @Description: TODO(查询角色(暂时功能性实现，未做与其他公功能结合。业务逻辑)-需更新)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForUserType(){
	//这里应该是根据用户的类型查询角色
	 sql="select * from sps_s_role where is_valid=1";
	return baseDao.queryForList(sql);
	}
	
	
	/** 
	* @Title: updateRemove 
	* @Description: TODO(删除角色(暂时功能性实现，未做与其他公功能结合。业务逻辑)-需更新)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public boolean updateRemove(int id){
	 sql="update sps_s_role  set is_valid=0 where role_id=?";
	 return baseDao.update(sql,new Object[]{id})>0;
	}
	
	/** 
	* @Title: saveRole 
	* @Description: TODO(添加角色(暂时功能性实现，未做与其他公功能结合。业务逻辑)-需更新)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public boolean saveRole(Role obj){
		sql="insert into sps_s_role(role_code,role_name,is_valid,createtime,cuser,description) values(?,?,1,unix_timestamp(),?,?);";
		return baseDao.update(sql, new Object[]{obj.getRole_code(),obj.getRole_name(),obj.getCuser(),obj.getDescription()})>0;
	}

	
	/** 
	* @Title: saveRole 
	* @Description: TODO(模糊查询角色角色(暂时功能性实现，未做与其他公功能结合。业务逻辑)-需更新)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForLikeString(String obj){
		sql="select * from sps_s_role where is_valid=1 and name like ?";
		return baseDao.queryForList(sql, new Object[]{("%"+obj+"%")});
	}
	
	public boolean updateEdit(Role role){
		sql="update sps_s_role set role_code=?,role_name=?,description=? where role_id=?";
		return baseDao.update(sql, new Object[]{role.getRole_code(),role.getRole_name(),role.getDescription(),role.getRole_id()})>0;
	}
	
	
	public boolean chaeckcode(String roleCode,String roleid){
		sql="select * from sps_s_role where role_code=? and role_id!=?";
		return baseDao.queryForList(sql,new Object[]{roleCode,roleid}).size()>0;
	}
	
	public boolean chaeckcode(String roleCode){
		sql="select * from sps_s_role where role_code=?";
		return baseDao.queryForList(sql,new Object[]{roleCode}).size()>0;
	}
	

}
