package com.huaao.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaao.common.extension.StringUtil;
import com.huaao.dao.base.BaseDao;

@Service
public class QuestionManageService {

	@Autowired
	private BaseDao baseDao;

	/**
	 * 查询所有题目
	 */
	public List queryListTransaction(String  type) {
		String sql = "select id,question,question,type FROM sps_d_question where type !=0 ";
		if(type != null && !"0".equals(type)){
			sql += " and type="+type;
		}
		sql +=" order by createtime desc";
		List query = this.baseDao.queryForList(sql);
		return query;
	}

	/**
	 * 添加题目
	 */
	public void savequestionTransaction(Integer communityId,String question,
			String option0, Integer score0, String option1, Integer score1,
			String option2, Integer score2, String option3, Integer score3,
			String option4,Integer score4,String option5,Integer score5, String answer, String type,String questionType) {
		
		String sql ="insert into sps_d_question (communityid,question,option0,score0,option1,score1,option2,score2,option3,score3,option4,score4,option5,score5," +
				"answer,type,questiontype,createtime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,unix_timestamp())";
		baseDao.saveOrUpdate(sql, new Object[]{communityId,question, option0, score0, option1, score1, option2, score2, option3, score3,option4, score4,option5, score5, answer, type,questionType});
	}
	
	/**
	 * 修改
	 */
	public void updatequestionTransaction(String id, String question,
			String option0, Integer score0, String option1, Integer score1,
			String option2, Integer score2, String option3, Integer score3,
			String option4,Integer score4,String option5,Integer score5, String answer, String type) {
		String sql = "";
		if (!StringUtil.isEmpty(id)) {
			sql="update sps_d_question set question ='"+question
					+"',option0 = '"+option0
					+"',score0 = "+score0  
					+",option1 = '"+option1
					+"',score1 = "+score1
					+",option2 = '"+option2
					+"',score2 = "+score2
					+",option3 = '"+option3
					+"',score3 = "+score3
					+",option4 = '"+option4
					+"',score4 = "+score4
					+",option5 = '"+option5
					+"',score5 = "+score5
					+",answer = '"+answer
					+"',type = "+type
					+",createtime=unix_timestamp()"
					+" where id= "+id;
		}
		this.baseDao.update(sql);
		System.out.println(sql);
	}
	
	/**
	 * 删除
	 */
	public void deletePersonnlTransaction(String id) throws Exception {
		String sql = "";
		Object[] args = null;
		sql="delete from sps_d_question where id=?";
		args = new Object[]{id};
		this.baseDao.saveOrUpdate(sql, args);
	}
	/**
	 * 查询
	 */
	public List querySetTransaction(String id) throws Exception {
		String sql = "select * from sps_d_question where id= "+id;
		List serviceSetList = this.baseDao.queryForList(sql);
		return serviceSetList;
	}
}
