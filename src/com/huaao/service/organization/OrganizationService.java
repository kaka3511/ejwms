package com.huaao.service.organization;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.organization.Dept;
import com.huaao.model.organization.DeptNode;
import com.huaao.model.organization.DeptNodeEx;
import com.huaao.model.organization.Region;
import com.huaao.model.organization.UserType;

@Service
@SuppressWarnings("rawtypes")
public class OrganizationService {
	@Autowired
	private BaseDao dao;
	

	/**
	 * 保存、修改组织信息
	 * @param id
	 * @param name
	 * @param cellphone
	 * @param addr
	 * @param parentid
	 * @param description
	 * @param communityId
	 * @param status
	 * @param img
	 * @throws Exception
	 */
	public void saveDeptInfo(String id, String name,String cellphone,String addr,String parentid,String description,int communityId,String status,String img,String location,String area) throws Exception {
		String sql="";
		if(id.isEmpty()||"0".equals(id)){
			sql = "insert into sps_b_dept(name,cellphone,addr,parentid,description,status,communityid,img,location,area) values('" 
	                 + name + "', '" + cellphone + "', '" + addr + "'," + parentid +",'"+ description + "'," + status + ","
				     + communityId + ",'"+img+"','"+location+"','"+area+"')";
		}else{
			 sql = "update sps_b_dept set  name='" + name + "', cellphone='" + cellphone + "' ,addr='"+addr+"',parentid="+parentid
					 +",description='"+description+"',status="+status+",communityid="+communityId+",img='"+img+"' ,location='"+location+"' ,area='"+area+"' where id=" + id;
		}
		 
		dao.update(sql);
	}
	
	/**
	 * 删除
	 * @param id
	 * @throws Exception
	 */
	public void deleteDeptInfo(int id) throws Exception {
		String sql = "update  sps_b_dept set status=0   where id=" + id;
		dao.update(sql);
	}

	/**
	 * 根据id查询相应组织
	 * @param communityId
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List queryDeptInfo(int communityId,String id) throws Exception {
		String sql = "select * from sps_s_user_type where communityid="+communityId;
		return dao.queryForList(sql);
	}
		
	
	public List getCommunityList (int communityId) throws Exception {
		List<Dept> deptList = new ArrayList<Dept>();
//		String sql = "select * from sps_b_dept where communityid="+communityId+"  and status='1' order by id asc";
		String sql = "select * from sps_b_dept where status='1' order by id asc";
		List list = this.dao.queryForList(sql);
		for (int i = 0; i < list.size(); i++) {
			Dept node = new Dept();
			Map nodeMap = (Map) list.get(i);
			node.setId((Integer) nodeMap.get("id"));
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			deptList.add(node);
		}
		return deptList;
	}
	

	public List getDeptList(int id, int communityid) throws Exception {
		List<Dept> deptList =this.getDeptListByRootId(communityid,id);
		if (deptList == null || deptList.size() == 0) {
			return null;
		}
		return deptList;
		
	}
	
	public List<Dept> getDeptListByRootId(int communityId,int parentCode) {
		List<Dept> deptList = new ArrayList<Dept>();
		String sql="";
		if(parentCode==0){
			 /*sql = "select * from sps_b_dept where communityid="+communityId+"  and status='1' order by id desc";*/
			 sql = "select * from sps_b_dept where status='1' order by id desc";
		}else{
			/* sql = "select * from sps_b_dept where communityid="+communityId+" and (parentid=" + parentCode + " or id="+parentCode+" )  and status='1' order by id desc";*/
			 sql = "select * from sps_b_dept where  (parentid=" + parentCode + " or id="+parentCode+" )  and status='1' order by id desc";
		}
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			Dept node = new Dept();
			Map nodeMap = (Map) list.get(i);
			node.setXh(i+1);
			node.setCellphone(nodeMap.get("cellphone")==null?"":nodeMap.get("cellphone").toString());
			node.setId((Integer) nodeMap.get("id"));
			node.setDescription(nodeMap.get("description")==null?"":nodeMap.get("description").toString());
			node.setImg(nodeMap.get("img")==null?"":nodeMap.get("img").toString());
			node.setLocation(nodeMap.get("location")==null?"":nodeMap.get("location").toString());
			node.setArea(nodeMap.get("area")==null?"":nodeMap.get("area").toString());
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			node.setAddr(nodeMap.get("addr")==null?"":nodeMap.get("addr").toString());
			node.setStatus((Integer)nodeMap.get("status"));
			node.setParentid((Integer)nodeMap.get("parentid"));
			deptList.add(node);
		}
		return deptList;
	}
	
	public List getUserTypeList(int deptid, int communityid) throws Exception {
		List<UserType> typeList =this.getUserTypeListByDeptId(communityid,deptid);
		if (typeList == null || typeList.size() == 0) {
			return null;
		}
		return typeList;
		
	}
	
	public List<UserType> getUserTypeListByDeptId(int communityId,int deptid) {
		List<UserType> typeList = new ArrayList<UserType>();
		String sql="";
		if(deptid==0){
			/*sql = "select * from sps_s_user_type where communityid="+communityId+" and  status='1' order by id desc";*/
			sql = "select * from sps_s_user_type where   status='1' order by id desc";
		}else{
			/*sql = "select * from sps_s_user_type where communityid="+communityId+" and dept=" + deptid + " and status='1' order by id desc";*/
			sql = "select * from sps_s_user_type where  dept=" + deptid + " and status='1' order by id desc";
		}
	
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			UserType node = new UserType();
			Map nodeMap = (Map) list.get(i);
			node.setXh(i+1);
			node.setCode((Integer) nodeMap.get("code"));
			node.setRole((Integer) nodeMap.get("role"));
			node.setId((Integer) nodeMap.get("id"));
			node.setDept((Integer) nodeMap.get("dept"));
			node.setDescription(nodeMap.get("description")==null?"":nodeMap.get("description").toString());			
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			typeList.add(node);
		}
		return typeList;
	}
	
	
	public List<UserType> getUserTypeListEx(int communityId,int typeid) {
		List<UserType> typeList = new ArrayList<UserType>();
		/*String sql= "select * from sps_s_user_type where communityid="+communityId+"  and status='1' order by id desc";*/
		String sql= "select * from sps_s_user_type where  status='1' order by id desc";
		/*if(typeid==1){
			sql = "select * from sps_s_user_type where communityid="+communityId+" and code=1 and status='1' order by id desc";
		}else{
			sql = "select * from sps_s_user_type where communityid="+communityId+" and code!=1 and  status='1' order by id desc";
		}*/
		
		
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			UserType node = new UserType();
			Map nodeMap = (Map) list.get(i);
			//node.setXh(i+1);
			node.setCode((Integer) nodeMap.get("code"));
			node.setRole((Integer) nodeMap.get("role"));
			node.setId((Integer) nodeMap.get("id"));
			//node.setDept((Integer) nodeMap.get("dept"));		
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			typeList.add(node);
		}
		/*if(typeid==1){
			for (int i = 0; i < list.size(); i++) {
				UserType node = new UserType();
				Map nodeMap = (Map) list.get(i);
				//node.setXh(i+1);
				//node.setCode((Integer) nodeMap.get("code"));
				//node.setRole((Integer) nodeMap.get("role"));
				node.setId((Integer) nodeMap.get("role"));
				//node.setDept((Integer) nodeMap.get("dept"));		
				node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
				typeList.add(node);
			}
		}else{
			for (int i = 0; i < list.size(); i++) {
				UserType node = new UserType();
				Map nodeMap = (Map) list.get(i);
				//node.setXh(i+1);
				//node.setCode((Integer) nodeMap.get("code"));
				//node.setRole((Integer) nodeMap.get("role"));
				node.setId((Integer) nodeMap.get("code"));
				//node.setDept((Integer) nodeMap.get("dept"));		
				node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
				typeList.add(node);
			}
		}
		*/
		
		return typeList;
	}
	

	/**
	 * @Description: 构建社区组织树
	 * @param 无
	 * @author libi
	 * @return 社区组织树
	 */
	public List<DeptNode> findByParentCode(int communityId,int parentCode) {
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		/*String sql = "select * from sps_b_dept where communityid="+communityId+" and parentid=" + parentCode
				+ "  and status='1' ";*/
		String sql = "select * from sps_b_dept where  parentid=" + parentCode
				+ "  and status='1' ";
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			DeptNode node = new DeptNode();
			Map nodeMap = (Map) list.get(i);
			node.setId((Integer) nodeMap.get("id"));
			node.setText(nodeMap.get("name").toString());
			treeList.add(node);
		}
		return treeList;
	}
	

	public List<DeptNode> queryDeptList(int communityId,int code) throws Exception {
		List<DeptNode> list = findByParentCode(communityId,code);
		if (list == null || list.size() == 0) {
			return null;
		}
		for (DeptNode node : list) {
			List<DeptNode> temp=queryDeptList(communityId,node.getId());
			node.setChildren(temp);
			if(temp==null||temp.size()==0){
				node.setIcon("jstree-organize-icon");
			}
		}
		return list;
	}
	
	
	/**
	 * 地区树构造
	 * @param communityId
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<DeptNode> queryRegionList(int code) throws Exception {
		List<DeptNode> list = findRegionByParentCode(code);
		if (list == null || list.size() == 0) {
			return null;
		}
		for (DeptNode node : list) {
			List<DeptNode> temp=queryRegionList(node.getId());
			node.setChildren(temp);
			if(temp==null||temp.size()==0){
				node.setIcon("jstree-organize-icon");
			}
		}
		return list;
	}
	
	public List<DeptNode> findRegionByParentCode(int parentCode) {
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		String sql = "select * from sps_b_region where  parentid=" + parentCode
				+ "  and status='1' ";
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			DeptNode node = new DeptNode();
			Map nodeMap = (Map) list.get(i);
			node.setId((Integer) nodeMap.get("id"));
			node.setText(nodeMap.get("name").toString());
			treeList.add(node);
		}
		return treeList;
	}
	
	public List getRegionList(int id) throws Exception {
		List<Region> regionList =this.getRegionListByRootId(id);
		if (regionList == null || regionList.size() == 0) {
			return null;
		}
		return regionList;
		
	}
	
	public List<Region> getRegionListByRootId(int parentCode) {
		List<Region> regionList = new ArrayList<Region>();
		String sql="";
		if(parentCode==0){
			 sql = "select * from sps_b_region where status='1' order by zonecode asc";
		}else{
			 sql = "select * from sps_b_region where (parentid=" + parentCode + " or id="+parentCode+" )  and status='1' order by zonecode asc";
		}
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			Region node = new Region();
			Map nodeMap = (Map) list.get(i);
			node.setXh(i+1);
			node.setId((Integer) nodeMap.get("id"));
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			node.setCode(nodeMap.get("zonecode")==null?"":nodeMap.get("zonecode").toString());
			node.setStatus((Integer)nodeMap.get("status"));
			node.setParentid((Integer)nodeMap.get("parentid"));
			regionList.add(node);
		}
		return regionList;
	}
	
	public List<Region> findRegionListByPid(int pid) {
		List<Region> regionList = new ArrayList<Region>();
		String sql="";
			 sql = "select * from sps_b_region where (parentid=" + pid + "  )  and status='1' order by zonecode asc";
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			Region node = new Region();
			Map nodeMap = (Map) list.get(i);
			node.setXh(i+1);
			node.setId((Integer) nodeMap.get("id"));
			node.setName(nodeMap.get("name")==null?"":nodeMap.get("name").toString());
			node.setCode(nodeMap.get("zonecode")==null?"":nodeMap.get("zonecode").toString());
			node.setStatus((Integer)nodeMap.get("status"));
			node.setParentid((Integer)nodeMap.get("parentid"));
			regionList.add(node);
		}
		return regionList;
	}
	
	/**
	 * 扩展树
	 * @param communityId
	 * @param parentCode
	 * @return
	 */
	public List<DeptNodeEx> findByParentCodeEx(int communityId,int parentCode) {
		List<DeptNodeEx> treeList = new ArrayList<DeptNodeEx>();
		String sql = "select * from sps_b_dept where communityid="+communityId+" and parentid=" + parentCode
				+ "  and status='1' ";
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			DeptNodeEx node = new DeptNodeEx();
			Map nodeMap = (Map) list.get(i);
			node.setId((Integer) nodeMap.get("id"));
			node.setText(nodeMap.get("name").toString());
			if((Integer)nodeMap.get("is_leaf")==1){
				node.setChildren(false);
			}else{
				node.setChildren(true);
			}
			treeList.add(node);
		}
		return treeList;
	}
	
	public List<DeptNodeEx> queryDeptListEx(int communityId,int code) throws Exception {
		List<DeptNodeEx> list = findByParentCodeEx(communityId,code);
		if (list == null || list.size() == 0) {
			return null;
		}
		return list;
	}
	
	
	//用户树
	public List<DeptNode> queryDeptAndTypeList(int communityId,int code) throws Exception {
		List<DeptNode> list = findByDeptAndTypeParentCode(communityId,code);
		if (list == null || list.size() == 0) {
			return null;
		}
		for (DeptNode node : list) {
			node.setChildren(queryDeptAndTypeList(communityId,node.getId()));
		}
		return list;
	}
	
	public List<DeptNode> findByDeptAndTypeParentCode(int communityId,int parentCode) {
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		String sql="";
		//人员类型
	   /* sql = "select * from sps_s_user_type where communityid="+communityId+" and dept=" + parentCode
						+ "  and status='1' ";*/
	    sql = "select * from sps_s_user_type where dept=" + parentCode
				+ "  and status='1' ";
				Object[] argsType = new Object[] {};
				List<?> typeList = dao.queryForList(sql, argsType);
				for (int i = 0; i < typeList.size(); i++) {
					DeptNode node = new DeptNode();
					Map nodeMap = (Map) typeList.get(i);
					node.setId((Integer) nodeMap.get("id"));
					node.setText(nodeMap.get("name").toString());
					node.setIcon("jstree-person-icon");
					node.setRole((Integer) nodeMap.get("role"));
					node.setCode((Integer) nodeMap.get("code"));
					node.setCommunityid((Integer) nodeMap.get("communityid"));
					treeList.add(node);
				}
				
		//组织
		/* sql = "select * from sps_b_dept where communityid="+communityId+" and parentid=" + parentCode
				+ "  and status='1'  ";*/
		 sql = "select * from sps_b_dept where  parentid=" + parentCode
					+ "  and status='1'  ";
		Object[] args = new Object[] {};
		List<?> list = dao.queryForList(sql, args);
		for (int i = 0; i < list.size(); i++) {
			DeptNode node = new DeptNode();
			Map nodeMap = (Map) list.get(i);
			node.setId((Integer) nodeMap.get("id"));
			node.setText(nodeMap.get("name").toString());
			node.setIcon("jstree-group-icon");
			node.setCode(0);
			node.setRole(0);
			treeList.add(node);
		}
		
		return treeList;
	}
	

	/**
	 * @Description: 保存人员类型
	 * @param 编号、名称、社区ID
	 * @author libi
	 * @return
	 */
	public void saveUserType(int code, String name,int dept,int role,String description,int status, int communityid) throws Exception {
		String sql = "insert into sps_s_user_type(code, name, dept,role,description,status,communityid) values(" 
	                 + code + ", '" + name + "', " + dept + "," + role +",'"+ description + "'," + status + ","
				     + communityid + ")";
		dao.update(sql);
	}

	/**
	 * @Description: 查询人员类型
	 * @param 社区ID
	 * @author libi
	 * @return 类型list
	 */
	public List queryUserType(int communityId) throws Exception {
		String sql = "select * from sps_s_user_type where communityid="+communityId;
		return dao.queryForList(sql);
	}
	
	public int countUserType(int communityId)throws Exception{
		String sql = "select count(id) from sps_s_user_type where communityid="+communityId;
		
		return dao.queryForInt(sql);
	}
	/**
	 * @Description: 删除人员类型
	 * @param 社区ID
	 * @author libi
	 * @return
	 */
	public void deleteUserType(int id) throws Exception {
		String sql = "update  sps_s_user_type set status=0   where id=" + id;
		dao.update(sql);
	}
	
	/**
	 * 人员类型检验
	 * @param id
	 * @param dept
	 * @param role
	 * @param code
	 * @param communityid
	 * @return
	 * @throws Exception
	 */
	public Boolean checkUserType(int id,int dept,int role,int code,int communityid) throws Exception {
		Boolean ret=true;
		int num=0;
		String sql = "select * from sps_s_user_type  where dept=" + dept+" and role="+role+" and code="+code+" and communityid="+communityid+" " ;
		List list=dao.queryForList(sql);
		if(id==0&&list.size()>0){
			ret=false; 
		}else{
			if(id!=0&&list.size()>1){
				ret=false; 
			}
		}
		
		return ret;
	}

	/**
	 * @Description: 修改人员类型
	 * @param 社区ID
	 * @author libi
	 * @return 类型list
	 */
	public void updateUserType(int id,int code, String name,int dept,int role,String description,int status, int communityid) throws Exception {
		String sql = "update sps_s_user_type set  code=" + code + ", name='" + name + "' ,dept="+dept+",role="+role+",description='"+description+"',status="+status+",communityid="+communityid+"  where id=" + id;
		dao.update(sql);
	}

	/**
	 * 参数列表
	 */
	public List querylistTransaction (int communityId,String id,String role,String code) throws Exception {
		String sql = "";
		if("0".equals(id)){
			sql=" select * from jw_user where status!=0 and building_id=0 and communityid="+communityId;
		}else{
			if("0".equals(code)){
				//sql="select * from jw_user where type in (select DISTINCT code from sps_s_user_type where status=1 and dept="+id+")";
				sql=" select * from jw_user where  status!=0 and building_id=0 and dept_id ="+id+" and   communityid="+communityId;
			}else{
				sql=" select * from jw_user where status!=0 and building_id=0 and  type ="+code+" and useridentity = "+role+" and communityid="+communityId;
			}
		}
		
		sql +=" order by updatetime desc";
		List serverParamList = this.dao.queryForList(sql);
		return serverParamList;
	}
	
	
	public List getUserScoreRecordList (int uid) throws Exception {
		String sql=" select * from sps_b_user_points where  uid="+ uid +" order by createtime desc";
		
		List list = this.dao.queryForList(sql);
		return list;
	}
	
	public void deleteUser(int id) throws Exception {
		String sql = "update  jw_user set cellphone=concat(concat(cellphone,'_'),id),status=0   where id=" + id;
		dao.update(sql);
	}
}
