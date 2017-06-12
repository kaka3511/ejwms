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
public class PointService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForList(int communityid) {
		// TODO Auto-generated method stub
		String sql = "select * from jw_user where communityid = ?  and building_id!=2  and status=3 order by id desc";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	public void updateUser(int userId,int point) {
		// TODO Auto-generated method stub
		String sql1 =  "update jw_user set points=points+? where id = ?;";
		
		dao.saveOrUpdate(sql1, new Object[]{point,userId});
		
		
	}
	public void insertPointRecord(int uid,int points,int type,String description,Integer processor_uid,Integer other_id){
		String sql2 ="insert into sps_b_user_points (uid,points,type,description,processor_uid,other_id,createtime) values(?,?,?,?,?,?,unix_timestamp())";
		dao.saveOrUpdate(sql2, new Object[]{uid,points,type,description,processor_uid,other_id});
	}

}
