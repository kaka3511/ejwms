/**
 * 
 */
package com.huaao.web.system;

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
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.common.utilities.Page;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.service.system.CarouselService;
import com.huaao.web.home.AuthHelper;


/** 
* @ClassName: carouselController 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:43:41 
* 
* 
*/
@Controller
@RequestMapping("/carousel")
public class CarouselController {

	
	@Autowired
	private CarouselService carouselService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("menuSession","YES");
		return "system/carousel/carouselIndex";
	}
	
	@AuthPassport@RequestMapping("/cropper")
	public String cropper(){
		return "system/carousel/cropper";
	}
	
	@AuthPassport@RequestMapping("/form/{oper}")
	public String form(@PathVariable String oper,Integer id,Model model){
		if(oper.equals("show")||oper.equals("update")){
			Map<String, Object> record = carouselService.queryWith(id);
			model.addAttribute("record", record);
			model.addAttribute("oper", oper);
			
		}
		
		return "system/carousel/carouselForm";
	}
	
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		Page pager = new Page(request);
		HashMap<String, Object> map=new HashMap<String, Object>();
		HttpSession session = request.getSession(true);
		String o= (String) session.getAttribute("menuSession");
		if(o.equals("YES")){
			PramaStrHelper.removeAllPramaStrMap();
			session.setAttribute("menuSession","NO");
		}
		else{
			session.setAttribute("menuSession","NO");
			if(pager.getPramaStr() != null){
				PramaStrHelper.pramaStrMap.put("carouselPramaStrMap", pager.getPramaStr());
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("carouselPramaStrMap"));
			}
			else
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("carouselPramaStrMap"));
		}
		List  list = carouselService.queryForList(cuser.getCommunityId(),"MicroService");
		if(list.size()>0){			
			Map<String, Object> carousel = (Map<String, Object>)list.get(0);
			int carouselId = Integer.parseInt(carousel.get("id").toString());
			carouselService.queryForPage(cuser.getCommunityId(),carouselId,pager);
			map.put("records", pager.getTotalRows());
			map.put("pages", pager.getTotalPages());
			map.put("rows", pager.getResultList());
			respInfo.setData(map);
	}
		return respInfo;
	}
	
	
	
	
	@AuthPassport@RequestMapping("/add")
	@ResponseBody
	public RespInfo  publish( HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		List  list = carouselService.queryForList(cuser.getCommunityId(),"MicroService");
			
		Map<String, Object> carousel = (Map<String, Object>)list.get(0);
			
		
		int communityid = cuser.getCommunityId();
		String dictionary_img = request.getParameter("dictionary_img");
		int dictionary_order = Integer.parseInt(request.getParameter("dictionary_order"));
		
		String dictionary_name = request.getParameter("dictionary_name");
		String dictionary_code = request.getParameter("dictionary_code");
		int  dictionary_parent_id = Integer.parseInt(carousel.get("id").toString());
		
		String dictionary_value = request.getParameter("dictionary_value");
		int status = 1;
		int uid = cuser.getId();
		
		Long updatetime = new Date().getTime()/1000;
		Long createtime = new Date().getTime()/1000;
		
		int id = carouselService.insert(communityid,dictionary_img,dictionary_name,dictionary_code,dictionary_parent_id,dictionary_order,dictionary_value,status,createtime,updatetime,uid);
		LogUtils.saveLog(request,"轮播图管理-添加");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("dictionary_img", dictionary_img);
		map.put("dictionary_order", dictionary_order);
		map.put("dictionary_name", dictionary_name);
		map.put("dictionary_code", dictionary_code);
		map.put("dictionary_value", dictionary_value);
		map.put("updatetime", updatetime);
		
		resp.setData(map);
		return resp;
	}
	@AuthPassport@RequestMapping("/update")
	@ResponseBody
	public RespInfo  update(HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		List  list = carouselService.queryForList(cuser.getCommunityId(),"MicroService");
		
		Map<String, Object> carousel = (Map<String, Object>)list.get(0);
			
		int id = Integer.parseInt(request.getParameter("id").toString());
		String dictionary_img = request.getParameter("dictionary_img");
		int dictionary_order = Integer.parseInt(request.getParameter("dictionary_order"));
		
		String dictionary_name = request.getParameter("dictionary_name");
		String dictionary_code = request.getParameter("dictionary_code");
		
		String dictionary_value = request.getParameter("dictionary_value");
		int uid = cuser.getId();
		
		long updatetime= new Date().getTime()/1000;
		carouselService.update(dictionary_img,dictionary_name,dictionary_code,dictionary_order,dictionary_value,updatetime,uid,id);
		LogUtils.saveLog(request,"轮播图管理-修改");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("dictionary_img", dictionary_img);
		map.put("dictionary_order", dictionary_order);
		map.put("dictionary_name", dictionary_name);
		map.put("dictionary_code", dictionary_code);
		map.put("dictionary_value", dictionary_value);
		map.put("updatetime", updatetime);
		
		resp.setData(map);
		
		return resp;
	}
	
	@AuthPassport@RequestMapping("/del/{id}")
	@ResponseBody
	public RespInfo  del(@PathVariable Integer id,HttpServletRequest request){
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		carouselService.del(new Object[]{id});
		LogUtils.saveLog(request,"轮播图管理-删除");
		resp.setData(id);
		return resp;
	}
	
}
