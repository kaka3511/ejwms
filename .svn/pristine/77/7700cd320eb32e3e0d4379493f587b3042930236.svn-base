package com.huaao.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringUtil;
import com.huaao.dao.base.BaseDao;

@Service
public class EntityManageService {
	
	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 查询站点
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	public List queryEntityList(int communityId,String entityeType) throws Exception {
		String sql = "select *,from_unixtime(createtime,'YYYY-MM-DD HH:MM:SS') as entityeCreatetime,from_unixtime(updatetime,'YYYY-MM-DD HH:MM:SS') as entityeUpdatetime from jw_entity where communityid="+communityId;
		if(!StringUtil.isEmpty(entityeType)){
			sql += " and type = "+entityeType;
		}
		sql +=" order by updatetime desc";
		List EntityList = this.baseDao.queryForList(sql);
		return EntityList;
	}
	
	/**
	 * 查询站点
	 * @return
	 * @throws Exception 
	 */
	public List queryEntityInfo(String id) throws Exception {
		String sql = "select * from jw_entity where id="+id;
		List EntityInfoList = this.baseDao.queryForList(sql);
		return EntityInfoList;
	}
	
	/**
	 * 添加或者修改站点
	 * @param Entity
	 * @param communityId
	 * @return
	 * @throws Exception
	 */
	public void saveEntityTransaction(String id,String name,String type,String address,String telephone,String description,int communityId,String img) throws Exception {
		String sql = "";
		if(StringUtil.isEmpty(id)){     //新增
			sql = "insert into jw_entity(name,type,address,telephone,description,communityid,createtime,updatetime,img) values('"+name+"',"+type+",'"+address+"','"+telephone+"','"+description+"',"+communityId+",unix_timestamp(),unix_timestamp(),'"+img+"')";
		}else{   				//修改
			if(!StringUtil.isEmpty(img)){
				sql = "update jw_entity set img='"+img+"',name='"+name+"',type="+type+",address='"+address+"',telephone='"+telephone+"',description='"+description+"',updatetime=unix_timestamp() where id="+id;
			}else{
				sql = "update jw_entity set name='"+name+"',type="+type+",address='"+address+"',telephone='"+telephone+"',description='"+description+"',updatetime=unix_timestamp() where id="+id;
			}
		}
		this.baseDao.update(sql);
	}
	
	/**
	 * 删除站点
	 * @return
	 * @throws Exception 
	 */
	public void deleteEntityTransaction(String id) throws Exception {
		String sql = "";
//		Object[] args = null;
		sql = "delete from jw_entity where id="+ id;
//		args = new Object[] {id};
//		this.baseDao.saveOrUpdate(sql, args);
		this.baseDao.update(sql);
	}
	
	/**
	 * 修改站点地理位置
	 * @param location
	 * @param communityId
	 * @return
	 * @throws Exception
	 */
	public void saveEntityLocationTransaction(String location,int id) throws Exception {
		String sql = "update jw_entity set location=?,updatetime=unix_timestamp() where id=?";
		Object[] args =  new Object[] {location,id};
		this.baseDao.update(sql,args);
	}
}
