/**
 * 
 */
package com.huaao.service.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

/** 
* @ClassName: ContentService 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:46:52 
* 
* 
*/
@Service
public class NotifyService {

	@Autowired
	private BaseDao dao;

	public List queryForList() {
		// TODO Auto-generated method stub
		String sql = "select * from sps_d_notify order by id desc";
		return dao.queryForList(sql);
	}


	public void insert(String content) {
		// TODO Auto-generated method stub
		String sql ="insert into sps_d_notify (content,createtime) values(?,unix_timestamp())";
		dao.saveOrUpdate(sql, new Object[]{content});
		
	}
	
	public void del(int id) {
		// TODO Auto-generated method stub
		String sql = "delete from sps_d_notify where id = ?";
		dao.update(sql, new Object[]{id});
		
	}


	/** 
	* @Title: queryUserForList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryUserForList(int communityid) {
		String sql = "select *from jw_user where communityid = ? and building_id!=2 order by id desc" ;
		return dao.queryForList(sql,new Object[]{communityid});
		
	}

}
