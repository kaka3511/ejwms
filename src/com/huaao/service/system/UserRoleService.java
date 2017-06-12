package com.huaao.service.system;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.organization.DeptNode;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Service
public class UserRoleService {
	
	@Autowired
	private BaseDao baseDao;
	
	private String sql;
	
	
	
	public List queryForis(int type,int  is){
		sql="select r.*,'true' as checks from sps_s_role r LEFT JOIN sps_s_user_role us on(r.role_id=us.role_id) where us.type=? and us.is_valid=? order by r.role_id";
		return 	baseDao.queryForList(sql,new Object[]{type,is});
	}
	
	public List queryForisNotUser(int is,String notid){
		sql="select r.*,'false' as checks from sps_s_role r where r.is_valid=? and role_id not IN(?)  order by r.role_id";
		return baseDao.queryForList(sql,new Object[]{is,notid});
	}
	
	public boolean updateUserRole(int is ,int id)
	{
		sql="update sps_s_user_role set is_valid=? where id=?";
		return baseDao.update(sql,new Object[]{is,id})>0;
	}
	
	
	public boolean saveUserRole(int roleid,int user_id,int type,int is){
		
		sql="insert into sps_s_user_role(role_id,user_id,is_valid,type)values(?,?,?,?)";
		return baseDao.update(sql,new Object[]{roleid,user_id,is,type})>0;
	}
	
	
	public List queryForuserRoleBy_Is_Type_Roleid(int role_id, int type,int is_valid){
		sql="select * from sps_s_user_role where role_id=? and type=? and  is_valid=? ";
		return baseDao.queryForList(sql,new Object[]{role_id,type,is_valid});
	}
	
	
	public List queryForuserRoleBy_Is_Type_usersid(int user_id,int role_id, int type,int is_valid){
		sql="select * from sps_s_user_role where user_id=? and role_id=? and type=?  ";
		return baseDao.queryForList(sql,new Object[]{user_id,role_id,type});
	}
	
	/**
	 * @Description: 构建社区组织树
	 * @param 无
	 * @author libi
	 * @return 社区组织树
	 */
	public JSONArray queryByParentCode(int communityId,int parentCode) {
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		String sql = "select * from sps_b_dept where  parentid=" + parentCode
				+ "  and status='1' ";
		Object[] args = new Object[] {};
		JSONArray ja=new JSONArray();
		List<?> list = baseDao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			
			JSONObject obj=new JSONObject();
			Map nodeMap = (Map) list.get(i);
			obj.put("id", nodeMap.get("id"));
			obj.put("text",nodeMap.get("name").toString());
	
			ja.add(obj);
		}
		return ja;
	}
	
	public JSONArray queryDeptListTree(List<Map<String, Object>> list,int communityId,int code,int roleid,int type,int is_valid) throws Exception {
		if(list.size()==0){
		 sql="select * from sps_s_user_role where role_id=? and type=? ";
		 list=baseDao.queryForList(sql, new Object[]{roleid,type});
		}
		JSONArray jalist = queryByParentCode(communityId,code);
		if (jalist == null || jalist.size() == 0) {
			return null;
		}
		for (Object object : jalist) {
			JSONObject obj=(JSONObject)object;
			JSONObject atrr=new JSONObject();
				atrr.put("id",0);
			for (int i = 0; i < list.size(); i++) {
				atrr.put("id",0);
				if(obj.getString("id").equals(list.get(i).get("user_id").toString())){
					atrr.put("id",list.get(i).get("id"));
					if(list.get(i).get("is_valid").toString().equals("1")){
						obj.put("checked",true);
					}
					list.remove(i);
					break;
				}
					
			}
			obj.put("attributes", atrr);			
			JSONArray jsTow=queryDeptListTree(list,communityId,obj.getInt("id"),roleid,type,is_valid);
		if(jsTow!=null){
			obj.put("children", jsTow);
		}
			
		}
		return jalist;
	}
	
	/**
	 * 模关键字查询到 的数据 未关联的数据
	 * @param likeStr
	 * @return
	 * @throws Exception
	 */
	public List queryforUserToLike(String likeStr)throws Exception {
		sql="select * from jw_user jw where jw.`name` LIKE ? OR jw.cellphone like ?";
		return baseDao.queryForList(sql,new Object[]{"%"+likeStr+"%","%"+likeStr+"%"});
	}
	
	
}
