/**
 * 
 */
package com.huaao.web.content;


import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.Header;
import org.apache.http.HeaderIterator;
import org.apache.http.HttpEntity;
import org.apache.http.ProtocolVersion;
import org.apache.http.RequestLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.entity.BasicHttpEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.params.HttpParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.huaao.service.business.NotifyService;
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
@Controller@RequestMapping("/notify")
public class NotifyController {

	 @Value("${notify.host}")  
	 private String notifyHost;
	@Autowired
	private NotifyService  notifyService;
	
	@AuthPassport@RequestMapping("/index")
	public String healthTestPaper(){
		
		return "content/notify/index";
	}
	@AuthPassport@RequestMapping("/view")
	public String view(String oper, Integer id,HttpServletRequest request){
		String page = "content/notify/mgr";
		request.setAttribute("oper", oper);
		return page;
	}
	
	@AuthPassport@RequestMapping(value = "/list" ,method= {RequestMethod.GET})
	@ResponseBody
	public RespInfo list(HttpServletRequest request ){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		List list = notifyService.queryForList();
		
		respInfo.setData(list);
		return respInfo;
	}
	
	@AuthPassport@RequestMapping(value = "/listUser" ,method= {RequestMethod.GET})
	@ResponseBody
	public RespInfo listUser(HttpServletRequest request ){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List list = notifyService.queryUserForList(cuser.getCommunityId());
		
		respInfo.setData(list);
		return respInfo;
	}
	@AuthPassport@RequestMapping("/mgr")
	@ResponseBody
	public RespInfo mgr(@RequestBody HashMap<String, Object> postData,HttpServletRequest request){
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		
		String oper = (String)postData.get("oper");
		String content = (String)postData.get("content");
		int userChoose = Integer.parseInt((String)postData.get("userChoose"));
		List<String> roleSelected = (List<String>)postData.get("roleSelected");
		String roles = "";
		for (String str : roleSelected) {
			roles+=str+",";
		}
		roles = roles.length()>0?roles.substring(0, roles.length()-1):roles;
		String userSelected = (String)postData.get("userSelected");
		
		notifyService.insert(content);
		LogUtils.saveLog(request, "通知管理-发布通知");
		try {
			notifyHost = notifyHost.endsWith("/")?notifyHost:notifyHost+"/";
			HttpClientBuilder.create().build().execute(new HttpGet(notifyHost+"auth/pushmsg.action?type="+userChoose+"&content="+content+"&uidStr="+(userChoose==2?roles:userSelected)));
		} catch (Exception e) {
			respInfo.setCode(RespCode.Fail.code);
		}
		return respInfo;
	}
	
    
    /**
     * 删除
     */
	@AuthPassport@RequestMapping(value="/del/{id}")
	@ResponseBody
	public RespInfo del(@PathVariable int id,HttpServletRequest request) throws Exception{
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		notifyService.del(id);
		LogUtils.saveLog(request, "通知管理-删除通知");
		respInfo.setData(id);
		return respInfo;
      }
	
	
	
}
