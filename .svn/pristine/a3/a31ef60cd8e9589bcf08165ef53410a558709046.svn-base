/**
 * 
 */
package com.huaao.service.business;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringHelper;
import com.huaao.common.extension.StringUtil;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.dao.base.BaseDao;

import net.sf.json.JSONObject;

/** 
* @ClassName: ContentService 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:46:52 
* 
* 
*/
@Service
public class AuthenticationService {

	@Autowired
	private BaseDao dao;
	
	public List queryWellcomeForList(int lastStatus,int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,a.name cuser ,4 rtype from  jw_user  a where status =? and a.communityid = ?;";
		return dao.queryForList(sql, new Object[]{lastStatus,communityid});
	}
	public List queryForList(int communityid, Integer page, Integer rows, String filterStr) {
		// TODO Auto-generated method stub
		//String sql = "SELECT * from jw_user where status in (2,3,4) and building_id <>2 and communityid = ? order by updatetime desc";
//		filterStr = filterStr.replace("type", "a.type");
//		filterStr = filterStr.replace("status", "a.status");
//		filterStr = filterStr.replace("name", "a.name");
//		filterStr = filterStr.replace("cellphone", "a.cellphone");
		if(filterStr == null){
			filterStr = "";
		}
		String sql = "SELECT a.*,a.updatetime apply_time,b.updatetime audit_time from jw_user a left join jw_user_verify b on a.id = b.uid where a.status in (1,2,3,4) and a.building_id <>2 and a.communityid = ? "+(filterStr.length()>0?" and "+filterStr:"")+" order by a.updatetime desc limit "+(page-1)*rows+","+rows;
		return dao.queryForList(sql,new Object[]{communityid});
	}
	public void updateInfo(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "update jw_user set status=?,type=?,useridentity=?,name=?,idcard=? ,gender = ? where id = ?";
		dao.update(sql, objects);
		
	}
	public void updateUser(String name,String img,String cellphone,String position,String number,String idcard,String address,String useridentity,String id) {
		// TODO Auto-generated method stub
		if(!StringUtil.isEmpty(useridentity)){
			int useridentityEx=Integer.parseInt(useridentity)%100;
			int type=(Integer.parseInt(useridentity)-useridentityEx)/100;
			String sql = "SELECT * from sps_s_user_type where role=? and code=? and status=1 ";
			List<?> list=dao.queryForList(sql,new Object[]{useridentityEx,type});
			Iterator it = list.iterator();
			String dept="";
			while (it.hasNext()) {
	    		Map maplist = (Map) it.next();
	    		dept=maplist.get("dept")==null?"":maplist.get("dept").toString();
			}
			if(!StringUtil.isEmpty(dept)){
				sql = "update jw_user set name=?,img=?,cellphone=?,position=?,number=?,idcard=?,address=?,dept_id=?,type=?,useridentity=? where id = ?";
				dao.update(sql, new Object[]{name,img,cellphone,position,number,idcard,address,dept,type,useridentityEx,id});
				
				
				sql = "update jw_user_verify set name=?,idcard=?,usertype=?,useridentity=? where uid = ?";
				dao.update(sql, new Object[]{name,idcard,type,useridentityEx,id});
			}
		}
	
	}
	public void updateVerifyRecord(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "update jw_user_verify set idcard_img1=? ,idcard_img2=? where uid = ?";
		dao.update(sql, objects);
		
	}
	public void updateRejectReason(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "update jw_user_verify set reject_reason=?,updatetime=unix_timestamp() where uid = ?";
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
	public SqlRowSet queryWith(Integer id,Integer type) {
		// TODO Auto-generated method stub
		String sql="";
		//if(type==1||type==2){
			//sql="select a.*,b.idcard_img1,b.idcard_img2,b.reject_reason,b.description,c.`name` as useridentityname from jw_user a LEFT JOIN jw_user_verify b on a.id=b.uid  LEFT JOIN sps_s_user_type c on a.type=c.`code` and a.useridentity=c.role where  a.id=? LIMIT 1";
		//}else{
		//	sql="select a.*,b.idcard_img1,b.idcard_img2,b.reject_reason,b.description,c.`name` as useridentityname from jw_user a LEFT JOIN jw_user_verify b on  a.id=b.uid  LEFT JOIN sps_s_user_type c on a.type=c.`code` where  a.id=? ";
		//}
		//String sql = "SELECT a.*,b.idcard_img1,b.idcard_img2,b.uid,b.usertype v_usertype,b.useridentity v_useridentity,b.name v_name,b.idcard v_idcard ,b.reject_reason,c.name dept_name,c.id dept_id,d.name useridentityname,d.role,d.code FROM sun_ejingwu.jw_user a left join jw_user_verify b on a.id = b.uid  left join sps_b_dept c on a.dept_id = c.id left join sps_s_user_type d on a.type = d.code and a.useridentity= d.role and a.dept_id = d.dept where a.id = ?";
			sql = "SELECT a.avdroomid,a.dept_id,a.dt_type,a.id,a.name,a.cellphone,a.type,a.useridentity,a.createtime,a.updatetime,a.location,a.communityid,a.img,a.position,a.points,a.authcode,a.deviceid,a.idcard,a.address,a.yuntuid,a.number,a.getui_cid,a.gender,a.birthday,a.residenttype,a.building_id,a.building_id,b.idcard_img1,b.idcard_img2,b.reject_reason,b.description,c.`name` AS useridentityname FROM jw_user a  LEFT JOIN jw_user_verify b ON a.id=b.uid  LEFT JOIN sps_s_user_type c ON a.type=c.`code` AND a.useridentity=c.role WHERE  a.id=? LIMIT 1";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	
	public SqlRowSet queryVerifyWith(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * from jw_user_verify where uid = ?";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	public void insertVerify(Object[] params) {
		// TODO Auto-generated method stub
		String sql = "insert into jw_user_verify values(?,?,?,?,?,unix_timestamp(),unix_timestamp(),?,?,?,?)";
		dao.saveOrUpdate(sql,params);
	}

	public SqlRowSet selectAddrById(Integer id){
		String sql="select address from jw_user where id=? ";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	
	public long getCount(int communityid, String filterStr){
		if(filterStr == null) filterStr = "";
		String sql = "SELECT count(*) from jw_user a left join jw_user_verify b on a.id = b.uid where a.status in (1,2,3,4) and a.building_id <>2 and a.communityid = ?"+(filterStr.length()>0?" and "+filterStr:"");
		SqlRowSet set = dao.queryForRowSet(sql, new Object[]{communityid});
		set.next();
		return set.getLong(1);
	}
}
