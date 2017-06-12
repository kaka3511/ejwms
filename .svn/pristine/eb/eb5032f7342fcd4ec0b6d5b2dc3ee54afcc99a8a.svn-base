package com.huaao.service.system;

import java.util.Date;
import java.util.List;

import javax.sql.RowSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

@Service
public class LogService {
	@Autowired
	private BaseDao baseDao;
	
	public List queryForList(String phone,String name,String title,String starttime,String endtime,int page,int pageSize){
		String sql = "SELECT * FROM  jw_log where create_phone like ? and create_name like ? and title like ? and create_date> ? and create_date <? order by create_date desc  limit ?,? ";
		return baseDao.queryForList(sql, new Object[]{ phone, name,title, starttime, endtime, page, pageSize});
	}
	
	public void insert(int type, String title, String create_by, String create_phone, String create_name, Date create_date, String remote_addr, String user_agent, String request_uri, String method, String params, String exception){
		String sql = "insert into jw_log (type, title, create_by, create_phone, create_name, create_date, remote_addr, user_agent, request_uri, method, params, exception) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		baseDao.update(sql, new Object[]{type, title, create_by, create_phone, create_name, create_date, remote_addr, user_agent, request_uri, method, params, exception});
	}
	
	public SqlRowSet getLogCount(){
		String sql = "select count(*) records from jw_log";
		return baseDao.queryForRowSet(sql);
	}
	
	
	
}
