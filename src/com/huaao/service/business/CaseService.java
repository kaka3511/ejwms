/**
 * 
 */
package com.huaao.service.business;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementCreator;
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
public class CaseService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List<Map<String, Object>> queryForList(int communityid) {
		
		String sql  = "SELECT a.*,c.`name` as cuser FROM sps_b_pupil_info a left join sps_r_keeper_relation_pupil b on a.id = b.pupilid LEFT JOIN jw_user c on a.keeperid=c.id where a.communityid = ?;";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	
	/** 
	* @Title: insert 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return 自增长key
	* @throws 
	*/
	public int insert(final String[] params) {
		
		final String sql ="insert into sps_d_case (pupilid,title,description,createtime,cuser) values(?,?,?,?,?)";
		return dao.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				
				PreparedStatement stm = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
				for (int i = 0; i < params.length; i++) {
					String param = params[i];
					stm.setString(i+1, param);
					
				}
				return stm;
			}
		});
		
	}
	/** 
	* @Title: update 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void update(Object[] objects) {
		
		String sql = "update  sps_d_case set title=?,description=? where id=?";
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
		
		String sql = "delete from sps_d_case where id=?";
		String sql2 = "delete from sps_d_case_imgs where caseid=?";
		dao.update(sql, objects);
		dao.update(sql2, objects);
		
	}
	/** 
	* @Title: queryContentWith 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param id
	* @param @return  参数说明 
	* @return SqlRowSet    返回类型 
	* @throws 
	*/
	public List<Map<String, Object>> queryCaseForList(Object[] params) {
		
		String sql = "SELECT a.* FROM sun_ejingwu.sps_d_case a where pupilid=?  order by a.id desc ";
		return dao.queryForList(sql,params);
	}
	
	public List<Map<String, Object>> queryCaseImgsForList(Object[] params) {
		
		String sql = "SELECT * FROM sun_ejingwu.sps_d_case_imgs where caseid=? order by id desc";
		return dao.queryForList(sql,params);
	}
	public void insertCaseImgs(Object[] objects) {
		
		String sql ="insert into sps_d_case_imgs (caseid,img,brief,createtime,imgorder) values(?,?,?,?,?)";
		dao.saveOrUpdate(sql, objects);
		
	}
	public void delCaseImgs(Object[] objects) {
		
		String sql = "delete from sps_d_case_imgs where id=?";
		dao.update(sql, objects);
		
	}

	public SqlRowSet queryCaseWith(Object[] params) {
		
		String sql = "SELECT * FROM sun_ejingwu.sps_d_case where id=?";
		return dao.queryForRowSet(sql,params);
	}
	
	public List<Map<String, Object>> queryLastCaseWith(Object[] params) {
		
		String sql = "SELECT * FROM sun_ejingwu.sps_d_case where pupilid=? order by id desc";
		return dao.queryForList(sql,params);
	}

	public SqlRowSet queryPupilWith(Object[] params) {
		
		String sql = "SELECT * FROM sun_ejingwu.sps_b_pupil_info where id=? order by id desc";
		return dao.queryForRowSet(sql,params);
	}
	
	public void queryForPage(Integer communityid, Page pager) {
		StringBuffer sbf = new StringBuffer("SELECT a.*,c.`name` as cuser FROM sps_b_pupil_info a left join sps_r_keeper_relation_pupil b on a.id = b.pupilid LEFT JOIN jw_user c on a.keeperid=c.id where a.communityid =" + communityid);
		String additions = " ";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}
}
