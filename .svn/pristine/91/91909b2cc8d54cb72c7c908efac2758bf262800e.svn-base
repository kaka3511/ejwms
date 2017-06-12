package com.huaao.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

@Service
public class MenuService {
	private String sql=null;
	@Autowired
	private BaseDao baseDao;
	
	/** 
	* @Title: queryForUserType 
	* @Description: TODO(查询菜单信息)。 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List menuListshow(int parent_id){
		sql="select * FROM sps_s_menu where menu_parent_id=? ORDER BY menu_order";
		return baseDao.queryForList(sql,new Object[]{parent_id});
	}
}
