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
public class ScoreDonateService {

	@Autowired
	private BaseDao dao;
	/** 
	* @Title: queryList 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @return  参数说明 
	* @return List    返回类型 
	* @throws 
	*/
	public List queryForList(int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.name agent,c.name donate,d.title FROM sun_ejingwu.sps_d_score_donate a left join jw_user b on a.agentid=b.id left join jw_user c on a.donateid = c.id left join sps_d_content d on a.activityid = d.id where b.communityid = ?;";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	
	public void queryForScoreDonatePage(Integer communityid, Page pager) {
		StringBuffer sbf = new StringBuffer("SELECT a.*,b.name agent,c.name donate,d.title FROM sun_ejingwu.sps_d_score_donate a left join jw_user b on a.agentid=b.id left join jw_user c on a.donateid = c.id left join sps_d_content d on a.activityid = d.id where b.communityid=" + communityid);
		String additions = " ";
		pager.setCountSql(sbf.toString());
		pager.setCountSqlConditions(additions);
		dao.queryPageWithConditions(sbf.toString(), pager, additions);
		
	}

}
