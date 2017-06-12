package com.huaao.web.xiaoyu;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.service.xiaoyu.meetingroomxyService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("meetingroomxy")
public class meetingroomxyContrlller {

	@Value("${notify.host}")
	private String notifyHost;

	@Autowired
	meetingroomxyService ser;

	@AuthPassport
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("index");
		UserInfo user = AuthHelper.getSessionUserAuth(request);
		return "/business/xiaoyu/index";
	}

	@AuthPassport
	@RequestMapping("/list")
	@ResponseBody
	public RespInfo list(HttpServletRequest request) {
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
//		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List<Map<String,Object>> dicList = ser.queryallroom();
		for(int i=0;i<dicList.size();i++){
			long createtime=Long.valueOf(dicList.get(i).get("createtime").toString())*1000;
			createtime=createtime+(36000000 * 1000);
			dicList.get(i).put("endtime", createtime/1000);
			String str="已失效";
			if(createtime>(System.currentTimeMillis())){
				str="未失效";
			}
				dicList.get(i).put("isDead", str);
		}
		resp.setData(dicList);
		return resp;
	}

	@AuthPassport
	@RequestMapping("/create")
	@ResponseBody
	public RespInfo create(HttpServletRequest request) {
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
//		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		String roomName = request.getParameter("roomName");
		String projectName=request.getParameter("projectName");
//		String expirTime=request.getParameter("expirTime");
		try {
			notifyHost = notifyHost.endsWith("/") ? notifyHost : notifyHost + "/";
			CloseableHttpResponse closeableHttpResponse = HttpClientBuilder.create().build()
					.execute(new HttpGet(notifyHost + "auth/createMeetingRoomId.action?roomName=" + roomName));
		JSONObject json=JSONObject.fromObject(EntityUtils.toString(closeableHttpResponse.getEntity()));
		if(json.getString("code").equals("A00000")){
			JSONObject data=json.getJSONObject("data");
			String url=data.getString("url");
			long roomid=data.getLong("roomid");
			ser.insertroom(roomid, url, roomName,projectName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
//		List dicList = ser.queryallroom();
		resp.setData(null);
		return resp;
	}

}
