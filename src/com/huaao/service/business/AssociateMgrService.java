/**
 * 
 */
package com.huaao.service.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.dao.base.BaseDao;

/** 
* @ClassName: ContentService 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:46:52 
* 
* 
*/
@Service
public class AssociateMgrService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryPupilForList(int communityid) {
		// TODO Auto-generated method stub
		String sql = "select a.*,b.name community from sps_b_pupil_info a left join jw_community b on a.communityid = b.id left join sps_d_register_apply c on a.id = c.pupilid where c.status=8 and a.communityid = ? order by a.id desc";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	
	public List queryKeeperForListExclude(String[] keeperIdsAssociated,int communityid) {
		// TODO Auto-generated method stub
		String sql = "";
		if(keeperIdsAssociated.length==0){
			sql = "select a.*,b.name community from jw_user a left join jw_community b on a.communityid = b.id where a.communityid = ?  and a.building_id!=2 order by a.id ";
		}else{
			String excludeStr ="";
			for (String i : keeperIdsAssociated) {
				excludeStr+=i+",";
			}
			excludeStr = excludeStr.substring(0, excludeStr.length()-1);
			sql = "select a.*,b.name community from jw_user a left join jw_community b on a.communityid = b.id where a.id not in ("+excludeStr+") and a.communityid = ?  and a.building_id!=2 order by a.id ";
		}
		
		
		return dao.queryForList(sql,new Object[]{communityid});
	}
	
	public List queryAssociatedKeeperForListWith(Object[] params) {
		// TODO Auto-generated method stub
		String sql = "select c.id,c.name ,c.cellphone,d.name community,c.address from sps_b_pupil_info a left join sps_r_keeper_relation_pupil b  on  a.id = b.pupilid left join jw_user c  on  b.keeperid = c.id left join jw_community d on c.communityid = d.id where a.id = ? and a.communityid = ?";
		return dao.queryForList(sql,params);
	}
	/** 
	* @Title: insert 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void insertAssocaite(Object[] objects) {
		// TODO Auto-generated method stub
		String sql ="insert into sps_r_keeper_relation_pupil (pupilid,keeperid,status,createtime,cuser,type) values(?,?,?,unix_timestamp(),?,?)";
		dao.saveOrUpdate(sql, objects);
		
	}
	
	/** 
	* @Title: del 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param objects  参数说明 
	* @return void    返回类型 
	* @throws 
	*/
	public void delAssocaite(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "delete from sps_r_keeper_relation_pupil where pupilid=? and keeperid = ?";
		dao.update(sql, objects);
		
	}

}
