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
public class PupilUpdateHistoryService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForList(int pupilId) {
		// TODO Auto-generated method stub
		String sql = "select * from sps_d_operation_record where applyid=? order by createtime";
		return dao.queryForList(sql,new Object[]{pupilId});
	}
	public void insert(int type,int pupilId,int uid,String name,String content,long createtime,int status){
		String sql2 ="insert into sps_d_operation_record (type, applyid,uid,name, content, createtime, status) values(?,?,?,?,?,?,?)";
		dao.saveOrUpdate(sql2, new Object[]{ type, pupilId,uid,name, content, createtime, status});
	}

}
