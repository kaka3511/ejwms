/**
 * 
 */
package com.huaao.web.alert;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.common.utilities.Filter;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.service.alert.AlertService;
import com.huaao.service.business.PointService;
import com.huaao.web.home.AuthHelper;

/** 
* @ClassName: ContentController 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:43:41 
* 
* 
*/
@Controller
@RequestMapping("/alert")
public class AlertController {

	
	@Autowired
	private AlertService alertService;
	
	@Autowired
	private PointService pointService;
	
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		request.setAttribute("cuser", cuser);
		
		return "alert/index";
	}
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(Integer page,Integer rows , String filters,HttpServletRequest request){
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		Filter filter = null;
		if(org.apache.commons.lang.StringUtils.isNotBlank(filters)){
			ObjectMapper mapper = new ObjectMapper();
			try {
				filter = mapper.readValue(filters, Filter.class);
			} catch (JsonParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		StringBuilder filterStr  = new StringBuilder();
		Filter.buildFilterStr(filter, filterStr);
		
		List  list = alertService.queryForList(cuser.getCommunityId(),page,rows,filterStr.toString());
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		long recordSize = alertService.getCount(filterStr.toString());
		map.put("records", recordSize);
		map.put("pages", recordSize%rows==0?recordSize/rows:recordSize/rows+1);
		map.put("rows", list);
		resp.setData(map);
		
		return resp;
	}
	
	
	@AuthPassport@RequestMapping("/listForward")
	@ResponseBody
	public ArrayList<HashMap<String, Object>>  listForward(HttpServletRequest request){
		
		ArrayList<HashMap<String, Object>> roots = new ArrayList<HashMap<String, Object>>();
		
//		HashMap<String, Object> root1 = new HashMap<String, Object>();
//		root1.put("id", "1");
//		root1.put("text", "居民");
//		root1.put("children", alertService.queryRoleMemberForList(1));
//		
//		HashMap<String, Object> root2 = new HashMap<String, Object>();
//		root2.put("id", "2");
//		root2.put("text", "民警");
//		root2.put("children", alertService.queryRoleMemberForList(2));
//		
//		HashMap<String, Object> root3 = new HashMap<String, Object>();
//		root3.put("id", "3");
//		root3.put("text", "群干");
//		root3.put("children", alertService.queryRoleMemberForList(3));
//		
//		HashMap<String, Object> root4 = new HashMap<String, Object>();
//		root4.put("id", "4");
//		root4.put("text", "网格员");
//		root4.put("children", alertService.queryRoleMemberForList(4));
//		
//		HashMap<String, Object> root5 = new HashMap<String, Object>();
//		root5.put("id", "5");
//		root5.put("text", "医生");
//		root5.put("children", alertService.queryRoleMemberForList(5));
//		
//		roots.add(root1);
//		roots.add(root2);
//		roots.add(root3);
//		roots.add(root4);
//		roots.add(root5);
		List<Map<String, Object>>  list = alertService.queryDeptList(3, 2);
		for(Map<String,Object> item : list){
			HashMap<String, Object> root = new HashMap<String, Object>();
			root.put("id",item.get("id"));
			root.put("text", item.get("name"));
			root.put("children",alertService.queryDeptMemberForList(Integer.parseInt(item.get("id").toString())));
			roots.add(root);
		}
		
		return roots;
	}
	
	@AuthPassport@RequestMapping("/del/{id}")
	@ResponseBody
	public RespInfo  del(@PathVariable Integer id,HttpServletRequest request){
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		alertService.delWith(id);
		LogUtils.saveLog(request, "报警记录-删除报警");
		resp.setData(id);
		return resp;
	}
	
	@AuthPassport@RequestMapping("/view")
	public String view(String oper,Integer id,String flag,HttpServletRequest request){
		String page = "alert/mgr";
		request.setAttribute("oper", oper);
		request.setAttribute("flag", flag);
		if(oper.equals("edit")||oper.equals("show")){
			SqlRowSet rowSet = alertService.queryWith(id);
			request.setAttribute("rowSet", rowSet);
		}
		return  page;
	}
	@AuthPassport@RequestMapping(value="/auditing",method={RequestMethod.POST})
	@ResponseBody
	public RespInfo  auditing(@RequestBody HashMap<String, Object> postData,HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		int status = 1;
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		int id = Integer.parseInt(postData.get("id").toString());
		if(StringUtils.isEmpty(postData.get("forwardId"))){
			String result =(String) postData.get("result");
			long resulttime = new Date().getTime()/1000;
			alertService.updateStatus(id, status,result,resulttime);
			SqlRowSet rowSet=alertService.queryWith(id);
			rowSet.next();
			String uid=	rowSet.getString("uid");
			LogUtils.saveLog(request, "报警记录-直接处理");
			if(!StringUtils.isEmpty(postData.get("rewardId"))){
				
				int rewardId = Integer.parseInt(postData.get("rewardId").toString());
				int rewardPoints = Integer.parseInt(postData.get("rewardPoints").toString());
				pointService.updateUser(rewardId, rewardPoints);
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				map.put("resulttime", resulttime);
				map.put("status", 1);
				map.put("result", result);
				resp.setData(map);
				if(uid!=null)
				pointService.insertPointRecord(Integer.valueOf(uid), rewardPoints, 6, "解除警情加入积分", cuser.getId(),0);
			}
		}else{
			int forwardId = Integer.parseInt(postData.get("forwardId").toString());
			alertService.updateForward(id, forwardId);
			LogUtils.saveLog(request, "报警记录-委派");
		}
		
		
				
		return resp;
	}
}
