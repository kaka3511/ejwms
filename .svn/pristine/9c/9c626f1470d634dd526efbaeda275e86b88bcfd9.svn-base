package com.huaao.service.organization;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringHelper;
import com.huaao.common.extension.StringUtil;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.home.Community;

import net.sf.json.JSONArray;

@Service
public class CommunityManageService {
	
	@Autowired
	private BaseDao baseDao;
	
	/**
	 * 查询社区基本信息
	 * @param communityId
	 * @return
	 * @throws Exception
	 */
	@Cacheable(value = "communityInfoCache")
	public Community queryCommunityInfo(int communityId) throws Exception {
		String sql = "select * from jw_community where id=?";
		Object[] args =  new Object[] {communityId};
		List list = this.baseDao.queryForList(sql,args);
		Community community = null;
    	Iterator it = list.iterator();
		JSONArray ja= new JSONArray();
		if(it.hasNext()){
			community = new Community();
			Map communityMap = (Map) it.next();
			community.setId((Integer) communityMap.get("id"));
			community.setAddress(communityMap.get("address").toString());
			community.setArea(communityMap.get("area").toString());
			community.setLocation(communityMap.get("location").toString());
			community.setName(communityMap.get("name").toString());
			community.setDescription(communityMap.get("description").toString());
			community.setImg(communityMap.get("img").toString());
			community.setPasswd(communityMap.get("passwd").toString());
		}
		return community;
	}
	
	/**
	 * 修改社区地理位置
	 * @param device
	 * @param communityId
	 * @return
	 * @throws Exception
	 */
	public void saveCommunityLocationTransaction(String location,int communityId) throws Exception {
		String sql = "update jw_community set location=?,updatetime=unix_timestamp() where id=?";
		Object[] args =  new Object[] {location,communityId};
		this.baseDao.update(sql,args);
	}
	
	/**
	 * 修改社区基本资料
	 * @param communityName
	 * @param communityDescription
	 * @param communityId
	 * @throws Exception
	 */
	public void saveCommunityInfoTransaction(String communityName,String communityDescription,String communityPW,int communityId,String img) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update jw_community set name='"+communityName+"', description='"+communityDescription+"',updatetime=unix_timestamp()");
		if(!StringUtil.isEmpty(communityPW)){
			sql.append(",passwd='"+StringHelper.md5(communityPW)+"'");
		}
		if(!StringUtil.isEmpty(img)){
			sql.append(",img='"+img+"'");
		}
		sql.append(" where id="+communityId+"");
		this.baseDao.update(sql.toString());
	}
	
	/**
	 * 修改社区区域
	 * @param device
	 * @param communityId
	 * @return
	 * @throws Exception
	 */
	public void saveCommunityAreaTransaction(String area,int communityId) throws Exception {
		String sql = "update jw_community set area=?,updatetime=unix_timestamp() where id=?";
		Object[] args =  new Object[] {area,communityId};
		this.baseDao.update(sql,args);
	}
}
