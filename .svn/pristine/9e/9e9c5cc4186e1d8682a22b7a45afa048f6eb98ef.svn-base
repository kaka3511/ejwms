/**
 * 
 */
package com.huaao.service.question;

import java.util.List;

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
public class QuestionService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForList(int questionType,int communityid) {
		// TODO Auto-generated method stub
		String sql = "select * from sps_d_question  where questiontype=? and communityid = ? order by id desc";
		return dao.queryForList(sql,new Object[]{questionType,communityid});
	}
	/** 
	* @Title: insert 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void insert(Object[] objects) {
		// TODO Auto-generated method stub
		String sql ="insert into sps_d_question (communityid,question,option0,score0,option1,score1,option2,score2,option3,score3,option4,score4,option5,score5," +
					"answer,type,questiontype,createtime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,unix_timestamp())";
		dao.saveOrUpdate(sql, objects);
		
	}
	/** 
	* @Title: update 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void update(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "update sps_d_question set question=?,option0=?,score0=?,option1=?,score1=?,option2=?,score2=?,option3=?,score3=?,option4=?,score4=?,option5=?,score5=?,answer=?,type=? where id=?";
		dao.update(sql, objects);
		
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
		String sql = "delete from sps_d_question where id = ?";
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
		String sql = "select * from sps_d_question where id=?";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	
	public void queryForQuestion1Page(Integer communityid, Page pager) {
		StringBuffer sbf = new StringBuffer("select * from sps_d_question  where questiontype=1 and communityid =" + communityid);
		String additions = "  order by id desc";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}
	
	public void queryForQuestion2Page(Integer communityid, Page pager) {
		StringBuffer sbf = new StringBuffer("select * from sps_d_question  where questiontype=2 and communityid =" + communityid);
		String additions = "  order by id desc";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}

}
