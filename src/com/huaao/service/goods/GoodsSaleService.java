/**
 * 
 */
package com.huaao.service.goods;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import com.huaao.common.utilities.Page;
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
public class GoodsSaleService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryWellcomeForList(int lastStatus,int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.name cuser,3 rtype from  sps_d_sale_goods a left join  jw_user b on a.applyid = b.id where a.status =? and b.communityid = ?;";
		return dao.queryForList(sql, new Object[]{lastStatus,communityid});
	}
	public List queryForList(int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.id,a.name title,a.status,a.images,a.score,a.number,b.name FROM sun_ejingwu.sps_d_sale_goods a left join  jw_user b on a.applyid = b.id where a.status <> 0 and b.communityid = ? order by a.id desc;";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	public int updateStatus(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "update sps_d_sale_goods set status=? where id = ? and status =?";
		return dao.update(sql, objects);
		
	}
	
	//获取之前的审计记录
		public Map queryPreAuditRecord(int applyId){
		String sql = "select *from sps_d_audit_record  where applyid = ? order by id";
		
		List list = dao.queryForList(sql, new Integer[]{applyId});
		if(!list.isEmpty())return (Map)list.get(list.size()-1);
		return null;
	}
	
	public void insertAuditRecord(Object[] objects) {
		// TODO Auto-generated method stub
		String sql = "insert into sps_d_audit_record  (communityid, type, 	applyid, audit, status, auditdate, remark, preid) values (?,?,?,?,?,?,?,?)";
		dao.saveOrUpdate(sql, objects);
		
	}
	/** 
	* @Title: queryContentWith 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param id
	* @param @return  参数说明 
	* @return SqlRowSet    返回类型 
	* @throws 
	*/
	public SqlRowSet queryWith(Integer id) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.name keeper,c.name pupil,c.type pupil_type,c.head_img ,c.idcard,c.gender,c.age,d.name community,c.addr from sps_d_sale_goods a left join jw_user b on a.applyid = b.id  left join sps_b_pupil_info c on a.supplyid = c.id left join jw_community d on c.communityid = d.id  where a.id=?";
		return dao.queryForRowSet(sql,new Object[]{id});
	}
	
	public void queryForGoodSaleListPage(Integer communityid, Page pager) {
		StringBuffer sbf = new StringBuffer("SELECT a.id,a.name title,a.status,a.images,a.score,a.number,b.name FROM sun_ejingwu.sps_d_sale_goods a left join  jw_user b on a.applyid = b.id where a.status <> 0 and b.communityid =" + communityid);
		String additions = " order by a.id desc";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}

}
