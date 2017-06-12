/**
 * 
 */
package com.huaao.web.goods;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.huaao.common.utilities.Page;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.common.utilities.TwoDimensionCode;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.business.AuditRecord;
import com.huaao.model.content.Content;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.content.ContentService;
import com.huaao.service.goods.GoodsSaleService;
import com.huaao.service.goods.MallService;
import com.huaao.service.goods.ScoreDonateService;
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
@Controller@RequestMapping("/scoreDonate")
public class ScoreDonateController {

	
	@Autowired
	private ScoreDonateService scoreDonateService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("menuSession","YES");
		return "goods/scoreDonate/index";
	}
	
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		Page pager = new Page(request);
		HttpSession session = request.getSession(true);
		String o= (String) session.getAttribute("menuSession");
		if(o.equals("YES")){
			PramaStrHelper.removeAllPramaStrMap();
			session.setAttribute("menuSession","NO");
		}
		else{
			session.setAttribute("menuSession","NO");
			if(pager.getPramaStr() != null){
				PramaStrHelper.pramaStrMap.put("scoreDonatePramaStrMap", pager.getPramaStr());
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("scoreDonatePramaStrMap"));
			}
			else
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("scoreDonatePramaStrMap"));
		}
		HashMap<String, Object> map=new HashMap<String, Object>();
		scoreDonateService.queryForScoreDonatePage(cuser.getCommunityId(),pager);
		map.put("records", pager.getTotalRows());
		map.put("pages", pager.getTotalPages());
		map.put("rows", pager.getResultList());
		respInfo.setData(map);
		return respInfo;
	}
	
}
