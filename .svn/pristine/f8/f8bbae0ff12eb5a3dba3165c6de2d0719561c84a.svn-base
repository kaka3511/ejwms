/**
 * 
 */
package com.huaao.web.business;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.service.business.PointService;
import com.huaao.web.home.AuthHelper;

/** 
* @ClassName: PointControler 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月31日 上午10:58:31 
* 
* 
*/
@Controller@RequestMapping("point")
public class PointController {
	@Autowired
	private PointService pointService;
	
	
	@AuthPassport@RequestMapping("index")
	public String index(){
		
		return "business/pointMgr/index";
	}
	
	@AuthPassport@RequestMapping("list")
	@ResponseBody
	public RespInfo list(HttpServletRequest request){
		RespInfo result = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List list = pointService.queryForList(cuser.getCommunityId());
		
		result.setData(list);
		return result;
	}
	
	@AuthPassport@RequestMapping("mgr")
	@ResponseBody
	public RespInfo mgr(int userId, int point,String description,HttpServletRequest request){
		RespInfo result = new RespInfo(RespCode.Success.code, "");

		pointService.updateUser(userId, point);
		pointService.insertPointRecord(userId, point, 10, description, null, null);
		LogUtils.saveLog(request, "积分管理-添加积分");
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("id", userId);
		map.put("point", point);
		result.setData(map);
		return result;
	}

}
