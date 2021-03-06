package com.huaao.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.huaao.dao.base.BaseDao;

/** 
* @ClassName: flowService 
* @Description: 流程节点 
* @author yuhai
* @date 2017年4月10日 
* 
* 
*/
@Service
public class FlowNodeService {
	@Autowired
	private BaseDao baseDao;
	private String sql=null;
	
	public List findAll() {
		sql = "select * from sps_s_flow_node where is_valid=1";
		return baseDao.queryForList(sql);
	}
	
	public List findByFlowId(Integer flowId) {
		sql = "SELECT * FROM sps_s_dictionary d "
				+ "WHERE d.dictionary_value = 2 and d.dictionary_parent_id = (SELECT id FROM sps_s_dictionary WHERE dictionary_code=(SELECT CODE FROM sps_s_flow WHERE id = ?) "
				+ "AND dictionary_parent_id=0);";
		return baseDao.queryForList(sql, new Object[]{flowId});
	}
	
	@Transactional
	public int save(Integer id) {
		sql = "SELECT id FROM sps_s_flow WHERE CODE = (SELECT dictionary_code FROM sps_s_dictionary "
				+ "WHERE id = (SELECT dictionary_parent_id FROM sps_s_dictionary WHERE id = ?));";
		Integer flowId = baseDao.queryForInt(sql, new Object[] {id});
		
		sql = "SELECT MAX(`index`) FROM sps_s_flow_node WHERE flowId=?;";  
		int index = baseDao.queryForInt(sql, new Object[]{flowId}) + 1;
		
		sql = "SELECT * FROM sps_s_dictionary WHERE id=?;";
		List<Map<String, Object>> list = baseDao.queryForList(sql, new Object[] {id});
		Map<String, Object> map2 = list.get(0);
		String name = (String) map2.get("dictionary_name");
		String useridentity = (String) map2.get("dictionary_code");
		String type = (String) map2.get("dictionary_value"); 
		
		sql = "select * from sps_s_flow_node;";
		List<Map<String, Object>> list2 = baseDao.queryForList(sql);
		for(Map<String, Object> map: list2) {
			String type2 = (String) map.get("type");
			if(flowId.equals(map.get("flowId"))) {
				if(type.equals(type2)) {
					String useridentity2 = (String) map.get("useridentity"); 
					if(useridentity.equals(useridentity2)) {
						return 0;					
					}
				}				
			}
		}
		sql = "INSERT INTO sps_s_flow_node(NAME, flowId, `INDEX`, is_valid, useridentity, TYPE) values(?,?,?,1,?,?);";
		return baseDao.save(sql, new Object[] {name, flowId, index, useridentity, type});
	}
	
	@Transactional
	public void update(String name, Integer id) {
		sql = "update sps_s_flow_node set name=? where id=?;";
		baseDao.update(sql, new Object[] {name, id});
	}
	
	@Transactional
	public void delete(Integer id) {
		sql = "delete from sps_s_flow_node where id = ?;";
		baseDao.update(sql, new Object[] {id});
		sql = "DELETE FROM sps_s_flownode_user WHERE flownode_id=?;";
		baseDao.update(sql, new Object[] {id});
	}

	public List findNodesById(Integer id) {
		sql = "SELECT * FROM sps_s_flow_node WHERE flowId=? and is_valid=1;";
		return (List)baseDao.queryForList(sql, new Object[] {id});
	}
	
	public List findByFlowNode(Integer flowNodeId) {
		sql = "SELECT distinct u.*,'true' AS checks FROM jw_user u LEFT JOIN sps_s_flownode_user fu ON(u.id=fu.user_id) WHERE fu.flownode_id=? ORDER BY CONVERT(NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return (List)baseDao.queryForList(sql, new Object[] {flowNodeId});
	}
	
	public List loadUser(Integer userId) {
		sql = "select * from jw_user where id = userId;";
		return baseDao.queryForList(sql);
	}
	public List findRelUsers(Integer flowNodeId, Integer useridentity, Integer communityId) {
		sql = "select u.id, u.name, u.gender, u.position, d.name dept_name "
				+ "from jw_user u, sps_s_flownode_user fu, sps_b_dept d "
				+ "where  u.id = fu.user_id and fu.flownode_id = ? AND u.TYPE = 2 and u.useridentity = ? and u.communityid = ? AND u.status=3 AND u.building_id=0 and u.dept_id = d.id "
				+ "ORDER BY CONVERT(u.NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return baseDao.queryForList(sql, new Object[] {flowNodeId, useridentity, communityId});
	}
	
	public List findRelUsersByType(Integer flowNodeId, Integer type, Integer communityId) {
		sql = "select u.id, u.name, u.gender, u.position, d.name dept_name "
				+ "from jw_user u, sps_s_flownode_user fu, sps_b_dept d "
				+ "where  u.id = fu.user_id and fu.flownode_id = ? "
				+ "AND u.TYPE = ? and u.communityid = ? AND u.status=3 AND u.building_id=0 and u.dept_id = d.id "
				+ "ORDER BY CONVERT(u.NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return baseDao.queryForList(sql, new Object[] {flowNodeId, type, communityId});
	}
	
	public List findUnRelUsers(Integer useridentity, Integer flowNodeId, Integer communityId) {
		sql = "SELECT u.id, u.name, u.gender, u.name, u.position, d.name dept_name FROM jw_user u, sps_b_dept d "
				+ "WHERE u.dept_id = d.id AND u.name != ' ' AND u.id NOT IN (SELECT user_id FROM sps_s_flownode_user WHERE flownode_id = ?) "
				+ "AND u.TYPE = 2 AND u.useridentity = ? and u.communityid = ? AND u.status=3 AND u.building_id=0 ORDER BY CONVERT(u.NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return baseDao.queryForList(sql, new Object[] {flowNodeId, useridentity, communityId});
				
	}
	
	public List findUnRelUsersByType(Integer type, Integer flowNodeId, Integer communityId) {
		sql = "SELECT u.id, u.name, u.gender, u.name, u.position, d.name dept_name FROM jw_user u, sps_b_dept d "
				+ "WHERE u.dept_id = d.id and u.NAME != ' ' AND u.id NOT IN (SELECT user_id FROM sps_s_flownode_user WHERE flownode_id = ?) AND u.type = ? and u.communityid = ? AND u.status=3 AND u.building_id=0 "
				+ "ORDER BY CONVERT(u.NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return baseDao.queryForList(sql, new Object[] {flowNodeId, type, communityId});
				
	}
	
	public List findAllUser() {
		sql = "SELECT * FROM jw_user WHERE NAME != ' ' AND id NOT IN (SELECT user_id FROM sps_s_flownode_user) ORDER BY CONVERT(NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return (List)baseDao.queryForList(sql);
	}
	
	
	public Integer getNodeType(Integer nodeId) {
		sql = "SELECT TYPE FROM sps_s_flow_node WHERE id = ?;";
		return baseDao.queryForInt(sql, new Object[] {nodeId});
	}
	
	public Integer getNodeIdentity(Integer nodeId) {
		sql = "SELECT useridentity FROM sps_s_flow_node WHERE id = ?;";
		return baseDao.queryForInt(sql, new Object[] {nodeId});
		
	}
	
	public List selectNodeFromDic() {
		sql = "SELECT * FROM sps_s_dictionary WHERE dictionary_parent_id = (SELECT id FROM sps_s_dictionary WHERE dictionary_name='业务流程类型') AND dictionary_code NOT IN (SELECT CODE FROM sps_s_flow);";
		return baseDao.queryForList(sql);
	}
	
	public Integer isRelated(Integer flowNodeId, Integer communityid) {
		sql = "SELECT id FROM sps_s_flownode_user WHERE flownode_id = ? and communityid = ?;";
		List<Map<String,Object>> list = baseDao.queryForList(sql, new Object[] {flowNodeId, communityid});
		if(list.size() != 0) {
			return 0;
		}
		return 1;
	}
	
	@Transactional
	public Integer saveUser(Integer userId, Integer flowNodeId) {
		sql = "select communityid from jw_user where id = ?;";
		Integer communityid = baseDao.queryForInt(sql, new Object[] {userId});
		sql = "INSERT INTO sps_s_flownode_user(flownode_id, user_id, communityid, is_valid) VALUES(?, ?, ?, 1);";
		baseDao.update(sql, new Object[] {flowNodeId, userId, communityid});
		return 1;
	}
	
	@Transactional
	public void deleteUser(Integer id, Integer flowNodeId) {
		sql = "DELETE FROM sps_s_flownode_user WHERE flownode_id = ? AND user_id=?;";
		baseDao.update(sql, new Object[] {flowNodeId, id});
	}
	
	public List findAllUserType() {
		sql = "SELECT DISTINCT TYPE FROM jw_user;";
		return baseDao.queryForList(sql);
	}
	
	public List findUserByType(Integer type) {
		sql = "SELECT * FROM jw_user WHERE NAME != ' ' AND id NOT IN (SELECT user_id FROM sps_s_flownode_user) AND TYPE = ? ORDER BY CONVERT(NAME USING gbk) COLLATE gbk_chinese_ci ASC;";
		return baseDao.queryForList(sql, new Object[] {type});
	}
	
}
