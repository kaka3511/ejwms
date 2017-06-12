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
public class PupilService {

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
		String sql = "select * from sps_b_pupil_info where communityid = ? order by id desc";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	/** 
	* @Title: insert 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void insert(String head_img,String keeperid,String name,String score,String cellphone,String idcard,String type,String illness,String gender,String age,String communityid,String curaddr,String addr,String imgs,String nums) {
		// TODO Auto-generated method stub
		String sql ="insert into sps_b_pupil_info (head_img,keeperid,name,score,cellphone,idcard,type,illness,gender,age,communityid,curaddr,addr,imgs,nums) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		dao.saveOrUpdate(sql, new Object[]{head_img,keeperid,name,score,cellphone,idcard,type,illness,gender,age,communityid,curaddr,addr,imgs,nums});
		
	}
	/** 
	* @Title: update 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void update(String head_img,String name,String score,String cellphone,String idcard,String type,String illness,String gender,String age,String curaddr,String addr,String imgs,String nums,String id) {
		// TODO Auto-generated method stub
		String sql = "update  sps_b_pupil_info set head_img=?,name=?,score=?,cellphone=?,idcard=?,type=?,illness=?,gender=?,age=?,curaddr=?,addr=?,imgs=?,nums=? where id=?";
		dao.update(sql, new Object[]{head_img,name,score,cellphone,idcard,type,illness,gender,age,curaddr,addr,imgs,nums,id});
		
	}
	/** 
	* @Title: del 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void del(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "delete from sps_b_pupil_info where id=?";
		dao.update(sql, objects);
		
	}
	/** 
	* @Title: queryContentWith 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param id
	* @param @return  参数说明 
	* @return SqlRowSet    返回类型 
	* @throws 
	*/
	public SqlRowSet queryWith(Integer id) {
		// TODO Auto-generated method stub
		String sql = "select * from sps_b_pupil_info where id=?";
		return dao.queryForRowSet(sql,new Object[]{id});
	}

}
