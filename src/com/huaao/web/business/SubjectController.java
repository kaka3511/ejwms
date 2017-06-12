package com.huaao.web.business;

import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.StringHelper;
import com.huaao.common.extension.StringUtil;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.model.organization.DeptNode;
import com.huaao.service.business.SubjectService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller@RequestMapping("/Subject")
public class SubjectController {
	
	@Autowired
	SubjectService service;
	
	@AuthPassport@RequestMapping("/SubjectIndex")
	public String index(HttpServletRequest request){
		UserInfo currentUser = AuthHelper.getSessionUserAuth(request);
		
		request.setAttribute("cuser", currentUser);
		return "business/Subject/index";
	}
	
	
	
    /**
	 * 办事指南科目结构树
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/subjectTree.do")
    public @ResponseBody List<DeptNode> subjectTree(HttpServletRequest request) throws Exception { 		
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	List<DeptNode> root = this.service.queryUnitNodeTree(user.getCommunityId(),3);
    	return root;
    } 
    
    @AuthPassport
    @RequestMapping(value = "/getSubjectList.do")
    public void getSubjectList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
    	String deptTypeNo = request.getParameter("deptTypeNo").toString();
    	String type = request.getParameter("type").toString();    //type=0无关联,type=1单位类型关联,type=2科目关联
    	List serviceList = this.service.querylistTransaction(deptTypeNo,type);
    	Iterator it = serviceList.iterator();
    	JSONArray ja = new JSONArray();
    	int i=1;
    	while (it.hasNext()) {
    		Map maplist = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id",maplist.get("id"));
			jo.element("name",maplist.get("name"));
			jo.element("img",maplist.get("img")==null?"":maplist.get("img"));
			jo.element("subject_order",maplist.get("subject_order")==null?"":maplist.get("subject_order"));
			jo.element("parent_id",maplist.get("parent_id"));
			//jo.element("dept_id",maplist.get("dept_id"));
			jo.element("cuser",maplist.get("cuser"));
			jo.element("dept_type_no",maplist.get("dept_type_no"));
			jo.element("status",maplist.get("status"));
			String createtime = "";
			if(maplist.get("createtime")!=null){
				createtime = StringHelper.toGenTime(maplist.get("createtime").toString(), "yyyy-MM-dd HH:mm:ss");
			}
			jo.element("xh",i);
			i++;
			jo.element("createtime",createtime);
			ja.add(jo);
		}
    	JSONObject jo = new JSONObject(); 
		jo.element("data", ja);
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    }
    
    /**
   	 * 根据deptid 和 paretanid查询数据
   	 * @return
   	 * @throws Exception 
   	 */
       @AuthPassport
       @RequestMapping(value = "/queryTosubjectid.do")
    public @ResponseBody  Map queryTosubjectid(HttpServletRequest request,int dept,int paretanid){
    	Map<String, List<Map<String, Object>>> result = new HashMap<String, List<Map<String, Object>>>();
    	List<Map<String,Object>> list=this.service.querySubject(dept, paretanid);
    	result.put("data",list);
    	return result;
    }
       
    @AuthPassport
   	@RequestMapping(value = "/saveSubject.do", method = { RequestMethod.POST })
   	public void saveSubject(@RequestParam(value = "uploadImg") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception { 	
   		UserInfo user = AuthHelper.getSessionUserAuth(request);
   		String id = request.getParameter("id");
   		String name = request.getParameter("name").trim();
   		String order = request.getParameter("order");
   		String dept_type_no = request.getParameter("dept_type_no");
   		String parentid = request.getParameter("parent_id");
   		String status = request.getParameter("status");
   		String communityImg = request.getParameter("communityImg");
   		if("undefined".equals(communityImg)) {
   			communityImg = "";
   		}
   		String img = "";
       	String flag = "";
   		
   		PrintWriter pw = response.getWriter();
   		response.setContentType("text/html; charset=UTF-8");
   		if (!file.isEmpty()) {
   			String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "E_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
       		flag = OSSUtil.uploadFile(file, fileName);
       	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
       	    if(!StringUtil.isEmpty(id)){     //新增
       	    	List imgList = service.querySubjectInfo(id);
       	    	Iterator it = imgList.iterator();
       	    	JSONObject jo = new JSONObject();
       			if(it.hasNext()){
       				Map entityMap = (Map) it.next();
       				if(entityMap.get("img")!=null&&!"".equals(entityMap.get("img"))){
       	    	    	OSSUtil.deleteFile(entityMap.get("img").toString().substring(SystemVariable.DomainName_OSS.length()+8));
       	    	    }
       			}
       	    }
   		}else{
   			if(communityImg!=null&&!communityImg.isEmpty()){
   				img=communityImg;
   			}
   		}
   		long createtime= new Date().getTime()/1000;
   		service.saveSubjectInfo(id,name,order,dept_type_no,parentid,status,img,user.getName(),createtime,1);
   		
   		pw.print("true");
   		pw.flush();
   	}
       
   
    
    /**
     * 删除
     * @param request
     * @param sid
     */
	@AuthPassport
    @RequestMapping(value = "/deleteSubject.do")
    public @ResponseBody void deleteSubject(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		Boolean res=this.service.deleteSubject(id);
		pw.print(res);
		pw.flush();
	}
	
	
	
	@AuthPassport
    @RequestMapping(value = "/getSubjectContentList.do")
    public void getSubjectContentList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
    	String deptTypeNo = request.getParameter("deptTypeNo").toString();
    	String type = request.getParameter("type").toString();    //type=0无关联,type=1单位类型关联,type=2科目关联
    	List serviceList = this.service.queryContentListTransaction(deptTypeNo,type);
    	Iterator it = serviceList.iterator();
    	JSONArray ja = new JSONArray();
    	int i=1;
    	while (it.hasNext()) {
    		Map maplist = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id",maplist.get("id"));
			jo.element("subject_id",maplist.get("subject_id"));
			jo.element("title",maplist.get("title")==null?"":maplist.get("title"));
			jo.element("summary",maplist.get("summary")==null?"":maplist.get("summary"));
			jo.element("summary_img",maplist.get("summary_img")==null?"":maplist.get("summary_img"));
			jo.element("content",maplist.get("content"));
			/*String name="";
			if(!"".equals(maplist.get("cuser"))){
				name=this.service.queryUsernameById(maplist.get("cuser").toString());
			}
			jo.element("cuser",name);*/
			jo.element("cuser", maplist.get("cuser"));
			jo.element("status",maplist.get("status"));
			String updatetime = "";
			if(maplist.get("updatetime")!=null){
				updatetime = StringHelper.toGenTime(maplist.get("updatetime").toString(), "yyyy-MM-dd HH:mm:ss");
			}
			jo.element("xh",i);
			i++;
			jo.element("updatetime",updatetime);
			ja.add(jo);
		}
    	JSONObject jo = new JSONObject(); 
		jo.element("data", ja);
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    }
	
	/**
     * 删除
     * @param request
     * @param sid
     */
	@AuthPassport
    @RequestMapping(value = "/deleteSubjectContent.do")
    public @ResponseBody void deleteSubjectContent(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		this.service.deleteSubjectContent(id);
		pw.print(true);
		pw.flush();
	}
	
	   @AuthPassport
	   //	@RequestMapping(value = "/saveSubjectContent.do", method = { RequestMethod.POST })
	 	@RequestMapping(value = "/saveSubjectContent.do")
	   	public void saveSubjectContent(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
	   		UserInfo user = AuthHelper.getSessionUserAuth(request);
	   		String id = request.getParameter("id");
	   		String subject_id = request.getParameter("subject_id");
	   		String title = request.getParameter("title");
	   		String summary = request.getParameter("summary");
	    	String content = request.getParameter("content");
	   		String img = request.getParameter("summary_img");
	       	String flag = "";
	   		
	   		PrintWriter pw = response.getWriter();
	   		response.setContentType("text/html; charset=UTF-8");
	   		/*if (!file.isEmpty()) {
	   			String pathName=file.getFileItem().getName();
	            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
	            String fileName = "E_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
	       		flag = OSSUtil.uploadFile(file, fileName);
	       	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
	       	    if(!StringUtil.isEmpty(id)){     //新增
	       	    	List imgList = service.querySubjectContentInfo(id);
	       	    	Iterator it = imgList.iterator();
	       	    	JSONObject jo = new JSONObject();
	       			if(it.hasNext()){
	       				Map entityMap = (Map) it.next();
	       				if(entityMap.get("img")!=null&&!"".equals(entityMap.get("img"))){
	       	    	    	OSSUtil.deleteFile(entityMap.get("img").toString().substring(SystemVariable.DomainName_OSS.length()+8));
	       	    	    }
	       			}
	       	    }
	   		}else{
	   			if(communityImg!=null&&!communityImg.isEmpty()){
	   				img=communityImg;
	   			}
	   		}*/
	   		long createtime= new Date().getTime()/1000;
	   		long updatetime= new Date().getTime()/1000;
	   		service.saveSubjectContentInfo(id,subject_id,title,content,summary,img,user.getId(),createtime,updatetime);
	   		
	   		pw.print("true");
	   		pw.flush();
	   	}
}
