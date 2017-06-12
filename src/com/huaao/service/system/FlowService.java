package com.huaao.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.system.Flow;

/** 
* @ClassName: flowService 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author yuhai
* @date 2017年4月10日 
* 
* 
*/
@Service
public class FlowService {
	@Autowired
	private BaseDao baseDao;
	private String sql=null;
	
	public List findAll() {
		sql = "select * from sps_s_flow where is_valid=1";
		return baseDao.queryForList(sql);
	}
	
	public List selectDicByCode(String code) {
		sql = "select dictionary_name from sps_s_dictionary where dictionary_code = ? and dictionary_parent_id <> 0;";
		return baseDao.queryForList(sql, new Object[]{code});
				
	}
	
	public List selectFromDic() {
		sql = "SELECT * FROM sps_s_dictionary WHERE dictionary_parent_id = (SELECT id FROM sps_s_dictionary WHERE dictionary_code='flow');";
		return baseDao.queryForList(sql);
	}

	@Transactional
	public int save(Flow flow) {
		sql="insert into sps_s_flow(name, type) values(?,?);";
		return baseDao.save(sql, new Object[]{flow.getName(), flow.getType()});
	}
	
	@Transactional
	public int save(String name, String code) {
		sql="insert into sps_s_flow(name, code, is_valid) values(?,?,1);";
		return baseDao.save(sql, new Object[]{name, code});
	}
	
	@Transactional
	public int save(Integer id) {
		sql = "select * from sps_s_dictionary where id = ?;";
		List<Map<String, Object>> list = baseDao.queryForList(sql, new Object[]{id});
		Map<String, Object>  map= list.get(0);
		String name = (String) map.get("dictionary_name");
		String code = (String) map.get("dictionary_code");
		sql = "select id from sps_s_flow where code = ?";
		List<Map<String, Object>> list2 = baseDao.queryForList(sql, new Object[]{code});
		if(list2.size() == 0) {
			sql = "insert into sps_s_flow(name, code, is_valid) values(?,?,1);";
			return baseDao.save(sql, new Object[]{map.get("dictionary_name"), map.get("dictionary_code")});					
		} else {
			return 0;
		}
	}
	
	@Transactional
	public int update(Flow flow) {
		sql = "update sps_s_flow set name=?,type=? where id=?;";
		return baseDao.update(sql, new Object[] {flow.getName(), flow.getType(), flow.getId()});
	}
	
	@Transactional
	public int delete(Integer id) {
		sql = "select flowId from sps_s_flow_node;";
		List<Map<String,Object>> list = baseDao.queryForList(sql);
		for(Map map : list) {
			if(id.equals(map.get("flowId"))) {
				return 0;
			}
		}
		sql = "DELETE FROM sps_s_flow WHERE id = ?;";
		return baseDao.update(sql, new Object[] {id});
	}
	
	@Transactional
	public Object findFlowById(Integer id) {
		sql = "SELECT * FROM sps_s_flow WHERE id = ?;";
		return (List)baseDao.queryForList(sql, new Object[] {id}).get(0);
	}
}
