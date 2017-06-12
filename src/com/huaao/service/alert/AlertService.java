/**
 * 
 */
package com.huaao.service.alert;

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
import org.terracotta.modules.ehcache.event.FireRejoinOperatorEventClusterListener;

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
public class AlertService {

	@Autowired
	private BaseDao dao;
	public List queryWellcomeForList(int lastStatus,int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.name cuser,5 rtype from  jw_alert a left join  jw_user b on a.uid = b.id where a.status =? and a.communityid =?;";
		return dao.queryForList(sql, new Object[]{lastStatus,communityid});
	}
	public List<Map<String, Object>> queryForList(int communityid, Integer page, Integer row, String filterStr) {
		filterStr = filterStr.replace("type", "a.type");
		filterStr = filterStr.replace("status", "a.status");
		String sql = "SELECT a.*,b.name apply,d.name forward FROM jw_alert a left join jw_user b on a.uid=b.id left join jw_user d on a.forward = d.id where a.status!=2 and a.communityid = ? "+(filterStr.length()>0?" and "+filterStr:"")+"order by a.id desc  limit "+(page-1)*row+","+row;
		return dao.queryForList(sql,new Object[]{communityid});
	}
	
	public void updateStatus(int id,int status,String result,Long resulttime){
		String sql = "update jw_alert set status = ?,result=?,resulttime=? where id = ?";
		dao.update(sql, new Object[]{status,result,resulttime,id});
	}
	
	public void updateForward(int id,int forwardId){
		String sql = "update jw_alert set forward = ? where id = ?";
		dao.update(sql, new Object[]{forwardId,id});
	}

	public SqlRowSet queryWith(int id) {
		
		String sql = "SELECT a.*,b.name apply,b.cellphone,b.location police_location FROM sun_ejingwu.jw_alert a left join jw_user b on a.uid=b.id where a.id = ? ";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	
	public List queryRoleMemberForList(int type) {
		
		String sql = "SELECT id,name text,cellphone FROM sun_ejingwu.jw_user where type=?";
		return dao.queryForList(sql,new Object[]{type});
	}
	
	public List<Map<String, Object>>  queryDeptMemberForList(int deptId) {
		
		String sql = "SELECT id,name text,cellphone FROM sun_ejingwu.jw_user where dept_id=?  ";
		return dao.queryForList(sql,new Object[]{deptId});
	}

	public List<Map<String, Object>>  queryDeptList(int parentId,int type) {
		
		String sql = "SELECT id,name FROM sun_ejingwu.sps_b_dept where parentid=? and type=? order by id  ";
		return dao.queryForList(sql,new Object[]{parentId,type});
	}

	public void delWith(int id) {
		String sql = "update jw_alert set status = ? where id = ?";
		dao.update(sql, new Object[]{2,id});
	}
	
	public long getCount(String filterStr){
		String sql = "select count(*) from jw_alert where status!=2"+(filterStr.length()>0?" and "+filterStr:"");
		SqlRowSet set = dao.queryForRowSet(sql);
		set.next();
		return set.getLong(1);
	}
}
