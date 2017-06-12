package com.huaao.web.system;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.home.AuthPassport;
import com.huaao.service.system.LogService;

@Controller
@RequestMapping("log")
public class LogController {

	@Autowired
	private LogService logService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(){
		return "system/log";
	}
	@AuthPassport
	@RequestMapping("list")
	@ResponseBody
	public RespInfo list(String phone,String name,String title,String starttime,String endtime,Integer page,Integer rows){
		RespInfo resp = new RespInfo(RespCode.Success.code	, "");
		List list = logService.queryForList(StringUtils.isBlank(phone)?"%":"%"+phone+"%", StringUtils.isBlank(name)?"%":"%"+name+"%", StringUtils.isBlank(title)?"%":"%"+title+"%", StringUtils.isBlank(starttime)?"1900":starttime,  StringUtils.isBlank(endtime)?"9999":endtime, page, rows);
		SqlRowSet logCount = logService.getLogCount();
		logCount.next();
		Long count  = logCount.getLong("records");
		HashMap<String, Object> map = new HashMap<String , Object>();
		map.put("list", list);
		map.put("totalPage",Math.ceil(count/rows));
		map.put("records",count);
		resp.setData(map);
		return resp;
	}
}
