package com.huaao.service.system;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class UserTypeService {
	@Autowired
	private BaseDao baseDao;
	
	private String sql;
	
	
	public List querDeptForStatus(int status){
		sql="select * from sps_b_dept where `status`=? order by(parentid);";
		return baseDao.queryForList(sql,new Object[]{status});
	}
	
	public List queryUserTypeForStatus(int dept,int status){
		sql="select * from sps_s_user_type where dept=? and `status`=? ";
		return baseDao.queryForList(sql,new Object[]{dept,status});
	}
	
	
	
	
	
	public JSONArray queryTreeDeptUserType(int status,int role_id){
		List list=querDeptForStatus(1);
		JSONArray deptjsonarry=new JSONArray();
		for(int i=0;i<list.size();i++){
			Map<String,Object> map=(Map<String, Object>)list.get(i);
			JSONObject obj=new JSONObject();
			obj.put("id",map.get("id"));
			obj.put("text",map.get("name"));
			
			List<Map<String,Object>> listchild=queryUserTypeForStatus(Integer.valueOf(map.get("id").toString()),1);
			JSONArray jachild=new JSONArray();
			for (Map<String, Object> mapchild : listchild) {
				JSONObject objchlid=new JSONObject();
				JSONObject atrr=new JSONObject();
				atrr.put("id",0);
				objchlid.put("id",mapchild.get("id"));
				objchlid.put("text", mapchild.get("name"));
				 sql="select * from sps_s_user_role where user_id=? and role_id=? and type=? ";
				List<Map<String,Object>> listtype=baseDao.queryForList(sql, new Object[]{mapchild.get("id"),role_id,2});
				if(listtype.size()>0){
					if(listtype.get(0).get("is_valid").toString().equals("1")){
						objchlid.put("checked",true);
					}
					atrr.put("id",listtype.get(0).get("id"));
				}
				objchlid.put("attributes", atrr);
				jachild.add(objchlid);
			}
			if(listchild.size()>0){
				obj.put("children", jachild);
			}
			deptjsonarry.add(obj);
		}
		return deptjsonarry;
		
	}
}
