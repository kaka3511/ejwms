package com.huaao.service.business;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.organization.Dept;
import com.huaao.model.organization.DeptNode;



@Service
public class SubjectService {
	@Autowired
	private BaseDao dao;
	
	
		
	/**
	 * 封装属性菜单数据
	 * @param paremt
	 * @return
	 */
	public List<DeptNode> queryParentNodeTree(int parentid,String value){
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		String sql ="select * from sps_d_subject where parent_id=? and status=? and dept_type_no=? order by subject_order asc";
		List<Map<String,Object>> listmap=dao.queryForList(sql,new Object[]{parentid,1,value});
			for (Map<String, Object> map : listmap) {
				DeptNode node = new DeptNode();
				node.setId((Integer) map.get("id"));
				node.setText(map.get("name").toString());
				node.setCode(20);
				node.setRole(Integer.valueOf(value));
				node.setChildren(queryParentNodeTree(node.getId(),value));	
				treeList.add(node);
			}
		return treeList;
	}
	
	public List<DeptNode> queryUnitNodeTree(int communityId,int parentid){
		List<DeptNode> treeList = new ArrayList<DeptNode>();
		String sql = "select * from sps_s_dictionary where  dictionary_parent_id=111  and status='1' order by dictionary_order asc  ";
		List<Map<String,Object>> listmap = dao.queryForList(sql);
		
		for (Map<String, Object> map : listmap) {
			DeptNode node = new DeptNode();
			Number num = (Number) map.get("id");
			node.setId(num.intValue());
			node.setText(map.get("dictionary_name").toString());
			node.setCode(10);
			node.setRole(Integer.valueOf(map.get("dictionary_value").toString()));
			node.setChildren(queryParentNodeTree(0,map.get("dictionary_value").toString()));	
			treeList.add(node);
		}
		
		
		return treeList;
	}
	
	
	public List<Map<String,Object>> querySubject(int dept,int paretanid){
		String sql ="select @rowno:=@rowno+1 as xh,sub.* from sps_d_subject  sub,(select @rowno:=0)t where sub.parent_id=? and sub.status=? and sub.dept_id=? order by sub.subject_order ASC";
		return dao.queryForList(sql,new Object[]{paretanid,1,dept});
	}
	
	public List querylistTransaction (String deptTypeNo,String type) throws Exception {
		String sql = "";
		if("0".equals(type)){
			sql=" select * from sps_d_subject where status=1 order by subject_order desc";
		}else{
			if("1".equals(type)){
				sql=" select * from sps_d_subject where status=1 and dept_type_no="+Integer.valueOf(deptTypeNo)+" order by subject_order asc";
			}else{
				if("2".equals(type)){
					sql=" select * from sps_d_subject where status=1 and (parent_id="+Integer.valueOf(deptTypeNo)+" or id="+Integer.valueOf(deptTypeNo)+") order by subject_order asc";
				}
				
			}
		}
		List serverParamList = this.dao.queryForList(sql);
		return serverParamList;
	}
	
	public List querySubjectInfo(String id) throws Exception {
		String sql = "select * from sps_d_subject where id="+id;
		return dao.queryForList(sql);
	}
	
	public void saveSubjectInfo(String id, String name,String order,String dept_type_no,String parentid,String status,String img,String cuser,long createtime,int deptId) throws Exception {
		String sql="";
		if(id.isEmpty()||"0".equals(id)){
			sql = "insert into sps_d_subject(name,img,subject_order,parent_id,dept_type_no,dept_id,createtime,cuser,status) values('" 
	                 + name + "', '" + img + "', '" + order + "'," + parentid +",'"+ dept_type_no + "',"+deptId+"," + createtime + ",'"
				     + cuser + "','"+status+"')";
		}else{
			 sql = "update sps_d_subject set  name='" + name + "', img='" + img + "' ,subject_order='"+order+"',parent_id="+parentid
					 +",dept_type_no='"+dept_type_no+"',dept_id="+deptId+",createtime="+createtime+",cuser='"+cuser+"' ,status="+status+" where id=" + id;
		}
		 
		dao.update(sql);
	}
	
	public Boolean deleteSubject(int id) throws Exception {
		Boolean ret=true;
		String sql = "select * from sps_d_service_guide where subject_id="+id;
		List list= dao.queryForList(sql);
		if(list.size()>0){
			ret=false;
		}else{
			sql = "update  sps_d_subject set status=0   where id=" + id;
			dao.update(sql);
		}
		 return ret;
		
	}
	
	
	public List queryContentListTransaction (String deptTypeNo,String type) throws Exception {
		String sql = "";
		if("0".equals(type)){
			sql=" select * from sps_d_service_guide where status=1 order by updatetime desc";
		}else{
			if("1".equals(type)||"2".equals(type)){
				sql=" select * from sps_d_service_guide where status=1 and subject_id="+Integer.valueOf(deptTypeNo)+" order by updatetime desc";
			}
		}
		List serverParamList = this.dao.queryForList(sql);
		return serverParamList;
	}
	
	public void deleteSubjectContent(int id) throws Exception {
		 String sql = "update  sps_d_service_guide set status=0   where id=" + id;
		 dao.update(sql);
	}
	
	public List querySubjectContentInfo(String id) throws Exception {
		String sql = "select * from sps_d_service_guide where id="+id;
		return dao.queryForList(sql);
	}
	
	public static void main(String[] args) {
		String a = "Helvetica, 'STHeiti STXihei', 'Microsoft JhengHei', 'Microsoft YaHei'";
		System.out.println(a.replace("'", "\\'"));
	}
	public void saveSubjectContentInfo(String id,String subject_id,String title,String content,String summary,String img,int cuser,long createtime,long updatetime) throws Exception {
		String sql="";
		if(id.isEmpty()||"0".equals(id)){
			sql = "insert into sps_d_service_guide(subject_id,title,content,summary,summary_img,createtime,cuser,updatetime,status) values(" 
	                 + subject_id + ", '" + title + "', '" + content.replace("'", "\\'") + "','" + summary +"','"+ img + "',"+createtime+"," + cuser + ","
				     + updatetime + ",'1')";
		}else{
			 sql = "update sps_d_service_guide set  subject_id=" + subject_id + ", title='" + title + "' ,content='"+content.replace("'", "\\'")+"',summary='"+summary
					 +"',summary_img='"+img+"',cuser="+cuser+",updatetime="+updatetime+" where id=" + id;
		}
		 
		dao.update(sql);
	}
	
	public String queryUsernameById(String id) throws Exception {
		String name="";
		String sql = "select * from jw_user where building_id=2 and  id="+id;
		SqlRowSet rs=dao.queryForRowSet(sql);
		while(rs.next()){
			name=rs.getString("name");
		}
		return name;
	}
}
