/**
 * 
 */
package com.huaao.web.business;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.common.utilities.TwoDimensionCode;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.business.AuditRecord;
import com.huaao.model.content.Content;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.business.HealthTestRecordService;
import com.huaao.service.business.OnlineJobService;
import com.huaao.service.content.ContentService;
import com.huaao.service.goods.MallService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

/** 
* @ClassName: ContentController 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:43:41 
* 
* 
*/
@Controller@RequestMapping("/healthTestRecord")
public class HealthTestRecordController {

	
	@Autowired
	private HealthTestRecordService healthTestRecordService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(){
		return "business/healthTestRecord/index";
	}
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		List  list = healthTestRecordService.queryForList(cuser.getCommunityId());
		resp.setData(list);
		return resp;
	}
	
}
