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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
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
import com.huaao.common.utilities.Page;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.common.utilities.TwoDimensionCode;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.content.Content;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.business.CaseService;
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
@Controller@RequestMapping("/case")
public class CaseController {

	
	@Autowired
	private CaseService caseService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		request.setAttribute("cuser", cuser);
		HttpSession session = request.getSession(true);
		session.setAttribute("menuSession","YES");
//		List<String> pramaStr = PramaStrHelper.getSpecificPrama("casePramaStrMap");
//		if(pramaStr != null){
//			if(pramaStr.get(0) != "")
//				request.setAttribute("type_query", pramaStr.get(0));
//			else
//				request.setAttribute("type_query", -1);
//			request.setAttribute("keeper_query", pramaStr.get(2));
//			request.setAttribute("pupil_query", pramaStr.get(1));
//		}
		return "business/case/index";
	}
	@AuthPassport@RequestMapping("/view")
	public String view(String oper,Integer id,HttpServletRequest request){
		String page = "business/case/mgr";
		request.setAttribute("oper", oper);
		
		if(oper.equals("add")){
			request.setAttribute("pupilId", id);
		}else if(oper.equals("show")||oper.equals("edit")){
			SqlRowSet rowSet = caseService.queryCaseWith(new Object[]{id});
			List<Map<String, Object>> imgList = caseService.queryCaseImgsForList(new Object[]{id});
				request.setAttribute("rowSet", rowSet);
				request.setAttribute("imgs", imgList);
		}
		return  page;
	}
	@AuthPassport@RequestMapping(value="/mgr",method={RequestMethod.POST})
	@ResponseBody
	public RespInfo  mgr(@RequestBody HashMap<String, Object> postData,HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		String oper = postData.get("oper").toString();
		
		String title = null;
		String description = null;
		List<Map<String, Object>> imgs = null;
		
		String caseId = null; 
				
		
		if(oper.equals("add")){
			String pupilId = postData.get("pupilId").toString();
			title = postData.get("title").toString();
			description = postData.get("description").toString();
			imgs = (List<Map<String, Object>>)postData.get("imgs");
			
			int key = caseService.insert(new String[]{pupilId,title,description,new Date().getTime()/1000+"",cuser.getId()+""});
			LogUtils.saveLog(request, "病例档案-添加档案");
			for (Map<String, Object> img : imgs) {
				
				caseService.insertCaseImgs(new Object[]{key,img.get("img"),img.get("description"),new Date().getTime()/1000,1});
			}
		}else if(oper.equals("show")||oper.equals("edit")){
			caseId = postData.get("caseId").toString();
			title = postData.get("title").toString();
			description = postData.get("description").toString();
			imgs = (List<Map<String, Object>>)postData.get("imgs");
			List<Integer> imgIdsRemoved = (List<Integer>)postData.get("imgIdsRemoved");
			
			caseService.update(new Object[]{title,description,caseId});
			LogUtils.saveLog(request, "病例档案-修改档案");
			for (Integer imgId : imgIdsRemoved) {
				caseService.delCaseImgs(new Object[]{imgId});
			}
			for (Map<String, Object> img : imgs) {
				
				caseService.insertCaseImgs(new Object[]{caseId,img.get("img"),img.get("description"),new Date().getTime()/1000,1});
			}
		}else if(oper.equals("del")){
			
			caseId = postData.get("caseId").toString();
			caseService.del(new Object[]{caseId});
			LogUtils.saveLog(request, "病例档案-删除档案");
		}
			
		return resp;
	}
	@AuthPassport@RequestMapping("/listPupil")
	@ResponseBody
	public RespInfo  listPupil(HttpServletRequest request){
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
				PramaStrHelper.pramaStrMap.put("casePramaStrMap", pager.getPramaStr());
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("casePramaStrMap"));
			}
			else
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("casePramaStrMap"));
		}
		List<String> pramaStr = PramaStrHelper.getSpecificPrama("casePramaStrMap");
		if(pramaStr != null){
			if(pramaStr.get(0) != "")
				request.setAttribute("type_query", pramaStr.get(0));
			else
				request.setAttribute("type_query", -1);
			request.setAttribute("keeper_query", pramaStr.get(2));
			request.setAttribute("pupil_query", pramaStr.get(1));
		}
		caseService.queryForPage(cuser.getCommunityId(),pager);
		map.put("records", pager.getTotalRows());
		map.put("pages", pager.getTotalPages());
		map.put("rows", pager.getResultList());
		respInfo.setData(map);
		return respInfo;
	}
	
	@AuthPassport@RequestMapping("/viewCase/{pupilId}")
	public String  viewCase(@PathVariable Integer pupilId,HttpServletRequest request){
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		SqlRowSet pupil = caseService.queryPupilWith(new Object[]{pupilId});
		pupil.next();
		
		request.setAttribute("pupil", pupil.getString("name"));
		return "business/case/viewCase";
	}
	
	@AuthPassport@RequestMapping("/listCase/{pupilId}")
	@ResponseBody
	public RespInfo  listCase(@PathVariable Integer pupilId,HttpServletRequest request){
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		List  list = caseService.queryCaseForList(new Object[]{pupilId});
		resp.setData(list);
		return resp;
	}
	
	
	@AuthPassport@RequestMapping("/del/{id}")
	@ResponseBody
	public RespInfo  del(@PathVariable Integer id,HttpServletRequest request){
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		caseService.del(new Object[]{id});
		LogUtils.saveLog(request, "病例档案-删除档案");
		resp.setData(id);
		return resp;
	}
	
		
		/**
		 * 图片上传
		 * @throws IOException 
		 */
	    @AuthPassport@RequestMapping(value = "/uploadImg", method = {RequestMethod.POST})
		public void uploadImg(@RequestParam(value = "file") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws IOException{
			UserInfo user =AuthHelper.getSessionUserAuth(request);
			String img ="";
			String flag = "";
			JSONObject jo = new JSONObject();
	    	if (!file.isEmpty()) {
	    		String pathName=file.getFileItem().getName();
	            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
	            String fileName = "C_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
	    		flag = OSSUtil.uploadFile(file, fileName);
	    		
	    	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
			}
	    	jo.element("flag", flag);
	    	jo.element("img", img);
	    	response.setContentType("text/html;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jo);
			pw.flush();
	    }
}