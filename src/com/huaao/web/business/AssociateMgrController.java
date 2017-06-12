/**
 * 
 */
package com.huaao.web.business;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.business.AuditRecord;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.business.AssociateMgrService;
import com.huaao.service.business.PoliceService;
import com.huaao.service.question.QuestionService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

/** 
* @ClassName: PoliceController 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月5日 下午2:58:42 
* 
* 
*/
@Controller@RequestMapping("/associateMgr")
public class AssociateMgrController {

	@Autowired
	private AssociateMgrService  associateService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(){
		
		return "business/associateMgr/index";
	}
	@AuthPassport@RequestMapping("/add")
	@ResponseBody
	public RespInfo add(int pupilId,int keeperId,HttpServletRequest request){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		associateService.insertAssocaite(new Object[]{pupilId,keeperId,1,cuser.getName(),0});
		LogUtils.saveLog(request, "关联被监护人-添加监护人");
		return respInfo;
	}
	
	@AuthPassport@RequestMapping(value = "/listPupil" ,method= {RequestMethod.GET})
	@ResponseBody
	public RespInfo listPupil(HttpServletRequest request ){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List list = associateService.queryPupilForList(cuser.getCommunityId());
		
		respInfo.setData(list);
		return respInfo;
	}
	
	@AuthPassport@RequestMapping(value = "/listKeeper" ,method= {RequestMethod.GET})
	@ResponseBody
	public RespInfo listKeeper(String keeperIds,HttpServletRequest request ){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		String[] idArr = new String[]{};
		if(keeperIds.trim().length()>0)
		idArr = keeperIds.substring(0, keeperIds.length()-1).split(",");
		List list = associateService.queryKeeperForListExclude(idArr,cuser.getCommunityId());
		
		respInfo.setData(list);
		return respInfo;
	}
	
	@AuthPassport@RequestMapping(value = "/listAssociatedKeeper/{pupilId}" ,method= {RequestMethod.GET})
	@ResponseBody
	public RespInfo listAssociatedKeeper(@PathVariable int pupilId,HttpServletRequest request ){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List list = associateService.queryAssociatedKeeperForListWith(new Object[]{pupilId,cuser.getCommunityId()});
		if(list.size()==1){
			Map item = (Map)list.get(0);
			if(item.get("id")==null)list.clear();
		}
		respInfo.setData(list);
		return respInfo;
	}
    
    /**
     * 删除
     */
	@AuthPassport@RequestMapping(value="/del")
	@ResponseBody
	public RespInfo del(int pupilId,int keeperId,HttpServletRequest request) throws Exception{
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		this.associateService.delAssocaite(new Object[]{pupilId,keeperId}); 
		LogUtils.saveLog(request, "关联被监护人-删除监护人");
		HashMap<String, Integer> data = new HashMap<String, Integer>();
		data.put("pupilId", pupilId);
		data.put("keeperId", keeperId);
		respInfo.setData(data);
		return respInfo;
    }
	
}
