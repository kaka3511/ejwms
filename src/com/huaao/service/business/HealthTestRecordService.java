/**
 * 
 */
package com.huaao.service.business;

import java.util.List;
import java.util.Map;

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
public class HealthTestRecordService {

	@Autowired
	private BaseDao dao;
	public List queryForList(int communityid) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.name,c.name pupil FROM sun_ejingwu.sps_d_question_record a left join jw_user b on a.answerid = b.id left join sps_b_pupil_info c on a.directid = c.id where a.questiontype = 2 and b.communityid = ?;";
		return dao.queryForList(sql,new Object[]{communityid});
	}
	

}
