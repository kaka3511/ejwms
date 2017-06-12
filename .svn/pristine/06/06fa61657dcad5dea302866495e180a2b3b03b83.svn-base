package com.huaao.service.system;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringHelper;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.home.Community;
import com.huaao.model.home.UserInfo;

@Service
public class UserService {
	@Autowired
	private BaseDao baseDao;
	
	private String sql;
	
	public List queryForUserToLike(String likeName){
		sql="select * from jw_user jw where jw.`name` like ?";
		return baseDao.queryForList(sql,new Object[]{likeName});
	}
	
	
	public UserInfo queryforUserInfoBean(String cellphone,String pwd) throws Exception{
		//根据用户名查询，查询用户是否存在
		sql="select * from jw_user jw where jw.cellphone=?";
		List<Map<String,Object>> list=baseDao.queryForList(sql,new Object[]{cellphone});
		UserInfo userInfo = new UserInfo();
		if(list.size()>0){
			if(list.get(0).get("passwd").equals(StringHelper.md5(pwd))){
				Map<String,Object> map=list.get(0);
//					sql="select * from jw_community where id=?";
//				List<Map<String,Object>> commulist=baseDao.queryForList(sql,new Object[]{map.get("communityid").toString()});				
//				Community community = new Community();
//				if(commulist.size()>0){
//					community.setName();
//				}
				
				userInfo.setEnable(true);
				userInfo.setName(map.get("name").toString());
				userInfo.setAccount(map.get("cellphone").toString());
				userInfo.setId((Integer) map.get("id"));
				
			}else{
				userInfo.setEnable(false);
				userInfo.setError("用户个人密码错误!");
			}
		}else{
			
			userInfo.setEnable(false);
			userInfo.setError("用户不存在!");
		}
		return userInfo;
	}
	
}
