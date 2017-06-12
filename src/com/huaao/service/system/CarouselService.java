/**
 * 
 */
package com.huaao.service.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.common.utilities.Page;
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
public class CarouselService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForList(int communityid,String dicCode) {
		// TODO Auto-generated method stub
		String sql = "select * from sps_s_dictionary where  communityid = ? and dictionary_code = ? order by dictionary_order";
		return dao.queryForList(sql, new Object[]{communityid,dicCode});
	}
	public List queryForList(int communityid,int pId) {
		// TODO Auto-generated method stub
		String sql = "select * from sps_s_dictionary where  communityid = ? and dictionary_parent_id = ? order by dictionary_order";
		return dao.queryForList(sql, new Object[]{communityid,pId});
	}
	/** 
	* @Title: insert 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public int insert(int communityid,String dictionary_img,String dictionary_name,String dictionary_code,int  dictionary_parent_id,int dictionary_order,String dictionary_value,int status,long createtime,long updatetime,int uid) {
		// TODO Auto-generated method stub
		String sql ="insert into sps_s_dictionary (communityid,dictionary_img,dictionary_name,dictionary_code,dictionary_parent_id,dictionary_order,dictionary_value,status,createtime,updatetime,uid) values(?,?,?,?,?,?,?,?,?,?,?)";
		return dao.save(sql, new Object[]{communityid,dictionary_img,dictionary_name,dictionary_code,dictionary_parent_id,dictionary_order,dictionary_value,status,createtime,updatetime,uid});
		
	}
	/** 
	* @Title: update 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void update(String dictionary_img,String dictionary_name,String dictionary_code,int dictionary_order,String dictionary_value,long updatetime,int uid,int id) {
		// TODO Auto-generated method stub
		String sql = "update  sps_s_dictionary set dictionary_img=?,dictionary_name=?,dictionary_code=?,dictionary_order=?,dictionary_value=?,updatetime=?,uid=? where id=?";
		dao.update(sql, new Object[]{dictionary_img,dictionary_name,dictionary_code,dictionary_order,dictionary_value,updatetime,uid,id});
		
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
		String sql = "delete from sps_s_dictionary where id=?";
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
	public Map<String, Object> queryWith(Integer id) {
		// TODO Auto-generated method stub
		String sql = "select a.* from sps_s_dictionary a  where a.id=?";
		List<Map<String, Object>> list = dao.queryForList(sql,new Object[]{id});
		if(list.size()>0)return list.get(0);
		else return new HashMap<String, Object>();
	}
	
	
	public void queryForPage(Integer communityid, int pId, Page pager) {
		StringBuffer sbf = new StringBuffer("select * from sps_s_dictionary where communityid ="+ communityid+" and dictionary_parent_id ="+pId);
		String additions = " order by dictionary_order";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}
	

}
