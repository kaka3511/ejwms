package com.huaao.service.xiaoyu;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

@Service
public class meetingroomxyService {
	
	@Autowired
	private BaseDao dao;
	
	
	
	public List<Map<String,Object>> queryallroom(){
		String  sql="SELECT * FROM `sps_meeting_room_xy` order by id";
		return dao.queryForList(sql);
	} 
	public boolean insertroom(long roomid,String url,String name,String projectName){
		long time=System.currentTimeMillis()/1000;
		
		String sql="insert into sps_meeting_room_xy(createtime,updatetime,communityid,type,name,roomid,url,projectName)value(?,?,?,?,?,?,?,?)";
		int i=dao.update(sql,new Object[]{time,time,0,0,name,roomid,url,projectName});
		return i>0;
	}
}
