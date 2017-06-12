package com.huaao.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringUtil;
import com.huaao.dao.base.BaseDao;

@Service
public class DictionaryManageService {
	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public List queryDictionaryById(String id) {
		String sql = "select *  from sps_s_dictionary where id=" + id;
		return this.baseDao.queryForList(sql);
	}
	
	
	public List listChildrenByCode(int communityid,String code){
		String sql="select id,dictionary_name name,dictionary_value value  from sps_s_dictionary where dictionary_parent_id=(select id from sps_s_dictionary where dictionary_code='"+code+"'  and status=1) and status=1 order by dictionary_order asc";		
		return baseDao.queryForList(sql);
	}
	
	/**
	 * 
	* @Title: saveDictionary 
	* @Description: 保存数据字典，如果id存在则更新，否则新增一条记录
	* @author: lixiang
	* @param id
	* @param name
	* @param code
	* @param parentId
	* @param order
	* @param uid  参数说明 
	* @return: void    返回类型 
	* @throws
	 */
	public void saveDictionary(String id, String name, String code, String parentId, String order, int uid,int communityId,String value,String status,String img) {
		String sql = "";
		if (StringUtil.isEmpty(id)) {
			sql = "insert into sps_s_dictionary (communityid,dictionary_name,dictionary_code,dictionary_parent_id,dictionary_order,createtime,updatetime,uid,dictionary_value,status,dictionary_img) "
					+ "values('" + communityId + "','" + name+"','" + code + "'," + parentId + "," + order
					+ ",unix_timestamp(),unix_timestamp()," + uid + ",'" + value + "','" + status + "','"+img+"')";
		} else {
			sql = "update sps_s_dictionary set dictionary_name='" + name + "',dictionary_code='" + code
					+ "',dictionary_order=" + order + ",updatetime=unix_timestamp(),uid=" + uid + ",dictionary_value='"+value+"' ,status='"+status+"' ,dictionary_img='"+img+"' where id=" + id;
		}
		this.baseDao.update(sql);
	}

	public List queryDictionaryByParent(String parentId, String queryName) {
		String querySql = "";
		if (!StringUtil.isEmpty(queryName)) {
			querySql = " and dictionary_name like '%" + queryName + "%'";
		}
		String sql = "select a.id,dictionary_name,dictionary_code,a.createtime,a.updatetime,b.name username,dictionary_parent_id from sps_s_dictionary a,sps_b_user b where dictionary_parent_id="
				+ parentId + querySql + " and a.uid=b.id  order by dictionary_order";
		return this.baseDao.queryForList(sql);
	}
	/**
	 * 
	* @Title: queryDictionaryListByParent 
	* @Description: 带分页的获取数据字典列表
	* @author: lixiang
	* @param parentId
	* @param queryName
	* @param page
	* @return  参数说明 
	* @return: List    返回类型 
	* @throws
	 */
	public List queryDictionaryListByParent(String parentId, String queryName,int communityId) {
		String querySql = "";
		if (!StringUtil.isEmpty(queryName)) {
			querySql = " and dictionary_name like '%" + queryName + "%'";
		}
		/*String sql = "select * from sps_s_dictionary a where communityid="+communityId+" and dictionary_parent_id="
				+ parentId + querySql + "  order by id desc";*/
		String sql = "select * from sps_s_dictionary a where  dictionary_parent_id="
				+ parentId + querySql + "  order by id desc";
		return this.baseDao.queryForList(sql);
	}
	/**
	 * 
	* @Title: countDictionaryListByParent 
	* @Description: 获取数据字典列表页的数据条数
	* @author: lixiang
	* @param parentId
	* @param queryName
	* @return  参数说明 
	* @return: int    返回类型 
	* @throws
	 */
	public int countDictionaryListByParent(String parentId,String queryName,int communityId){
		String querySql = "";
		if (!StringUtil.isEmpty(queryName)) {
			querySql = " and dictionary_name like '%" + queryName + "%'";
		}
		String sql="select count(id) from sps_s_dictionary where  dictionary_parent_id="+parentId+querySql;
		return baseDao.queryForInt(sql);
	}
	/**
	 * 
	* @Title: deleteDictionaryById 
	* @Description: 删除一条数据字典记录
	* @author: lixiang
	* @param id  参数说明 
	* @return: void    返回类型 
	* @throws
	 */
	public void deleteDictionaryById(int id) {
		String sql = "delete from sps_s_dictionary where id=" + id;
		this.baseDao.update(sql);
		String sub_sql = "delete from sps_s_dictionary where dictionary_parent_id=" + id;
		this.baseDao.update(sub_sql);
	}
	/**
	 * 
	* @Title: listChildrenByParentCodeLike 
	* @Description: 根据父类的code按Like的方式列出子类
	* @author: lixiang
	* @param code
	* @return  参数说明 
	* @return: List    返回类型 
	* @throws
	 */
	public List listChildrenByParentCodeLike(String code){
		String sql="select id,dictionary_name name,dictionary_code code from sps_s_dictionary where dictionary_parent_id=(select id from sys_dictionary where dictionary_code like '"+code+"@%')";
		return baseDao.queryForList(sql);
	}
	/**
	 * 
	* @Title: listChildrenByParentCode 
	* @Description: 根据父类的code列出子类
	* @author: lixiang
	* @param code
	* @return  参数说明 
	* @return: List    返回类型 
	* @throws
	 */
	public List listChildrenByParentCode(String code){
		String sql="select id,dictionary_name name,dictionary_code code from sps_s_dictionary where dictionary_parent_id=(select id from sps_s_dictionary where dictionary_code = '"+code+"')";
		return baseDao.queryForList(sql);
	}
	/**
	 * 
	* @Title: checkCodeAvailable 
	* @Description: 检查该code是否存在，因为数据字典的code唯一。当更新数据项时code未进行修改，验证也会通过。
	* @author: lixiang
	* @param code
	* @param id
	* @return  参数说明 
	* @return: boolean    返回类型 
	* @throws
	 */
	public boolean checkCodeAvailable(String id,String code,int communityId,String type,String parentId) {
		String sql="";
		if(StringUtil.isEmpty(parentId)){
			if(StringUtil.isEmpty(id)){
				sql="select * from sps_s_dictionary where  dictionary_code='" + code + "' and  dictionary_parent_id=0 ";
			}else{
				sql="select * from sps_s_dictionary where id<>'"+id+"' and  dictionary_parent_id=0 and  dictionary_code='" + code + "'";
			}
		}else{
			if(StringUtil.isEmpty(id)){
				sql="select * from sps_s_dictionary where dictionary_parent_id='"+parentId+"' and dictionary_code='" + code + "'";
			}else{
				sql="select * from sps_s_dictionary where dictionary_parent_id='"+parentId+"' and id<>'"+id+"' and  dictionary_code='" + code + "'";
			}
		}
		
		
		List list = this.baseDao.queryForList(sql);
		if (list.size()>0) {
			return false;
		} else {
			return true;
		}
	}
}
