package com.huaao.web.system;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.StringHelper;
import com.huaao.common.extension.StringUtil;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.model.system.Entity;
import com.huaao.service.system.EntityManageService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/entityManage")
public class EntityManageController{  
	
	@Autowired
    private EntityManageService entityManageService;
	
	@AuthPassport
    @RequestMapping(value = "/entityManage")
    public String index(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		UserInfo user=AuthHelper.getSessionUserAuth(request);
        return "system/entityManage";
    }  
	
	@AuthPassport
    @RequestMapping(value = "/entityMapManage/{id}",method = {RequestMethod.GET})
    public String entityMapManage(@PathVariable String id,HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		List entityInfoList = this.entityManageService.queryEntityInfo(id);
    	Iterator it = entityInfoList.iterator();
    	Entity entity = null;
		if(it.hasNext()){
			entity = new Entity();
			Map entityMap = (Map) it.next();
			entity.setId((Integer)entityMap.get("id"));
			entity.setName(entityMap.get("name").toString());
			entity.setAddress(entityMap.get("address").toString());
			entity.setLocation(entityMap.get("location")==null?"":entityMap.get("location").toString());
		}
		request.setAttribute("entity", entity);
        return "system/entityMapManage";
    }  
	
	/**
	 * 通过查询条件得到设备列表
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
    @RequestMapping(value = "/entityList.do", method = {RequestMethod.POST})
    public void shopList(HttpServletRequest request,HttpServletResponse response) throws Exception { 
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		String entityType = request.getParameter("entityType");				//设备类型
		List entityList = this.entityManageService.queryEntityList(user.getCommunityId(),entityType);
		Iterator it = entityList.iterator();
		JSONArray ja= new JSONArray();
		int i=1;
		while(it.hasNext()){
			Map entityMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", entityMap.get("id"));
			jo.element("name", entityMap.get("name"));
			jo.element("address", entityMap.get("address"));
			jo.element("img", entityMap.get("img")==null?"":entityMap.get("img").toString());
			jo.element("telephone", entityMap.get("telephone"));
			jo.element("description", entityMap.get("description"));
			String createtime = "";
			if(entityMap.get("createtime")!=null){
				createtime = StringHelper.toGenTime(entityMap.get("createtime").toString(), "yyyy-MM-dd HH:mm:ss");
			}
			jo.element("xh",i);
			i++;
			jo.element("createtime",createtime );
			String updatetime = "";
			if(entityMap.get("updatetime")!=null){
				updatetime = StringHelper.toGenTime(entityMap.get("updatetime").toString(), "yyyy-MM-dd HH:mm:ss");
			}
			jo.element("updatetime",updatetime);
			jo.element("type", entityMap.get("type"));
			jo.element("location", entityMap.get("location"));
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
     * 添加或者修改设备
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/saveEntity.do", method = {RequestMethod.POST})
    public void saveEntity(@RequestParam(value = "uploadImg") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception { 	
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	String id = request.getParameter("id");
    	String name = request.getParameter("name").trim();
    	String type = request.getParameter("type").trim();
    	String address = request.getParameter("address").trim();
    	String telephone = request.getParameter("telephone").trim();
    	String description = request.getParameter("description").trim();
    	String img = "";
    	String flag = "";
    	if (!file.isEmpty()) {
    		String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "E_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
    		flag = OSSUtil.uploadFile(file, fileName);
    	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
    	    if(!StringUtil.isEmpty(id)){     //新增
    	    	List EntityInfoList = this.entityManageService.queryEntityInfo(id);
    	    	Iterator it = EntityInfoList.iterator();
    	    	JSONObject jo = new JSONObject();
    			if(it.hasNext()){
    				Map entityMap = (Map) it.next();
    				if(entityMap.get("img")!=null&&!"".equals(entityMap.get("img"))){
    	    	    	OSSUtil.deleteFile(entityMap.get("img").toString().substring(SystemVariable.DomainName_OSS.length()+8));
    	    	    }
    			}
    	    }
		}
    	this.entityManageService.saveEntityTransaction(id,name,type,address,telephone,description,user.getCommunityId(),img);
    } 
	
    /**
     * 查询设备
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/queryEntityInfo.do", method = {RequestMethod.POST})
    public void queryEntityInfo(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
    	String id = (String)request.getParameter("id");
    	List EntityInfoList = this.entityManageService.queryEntityInfo(id);
    	Iterator it = EntityInfoList.iterator();
    	JSONObject jo = new JSONObject();
		if(it.hasNext()){
			Map entityMap = (Map) it.next();
			jo.element("id", entityMap.get("id"));
			jo.element("name", entityMap.get("name"));
			jo.element("address", entityMap.get("address"));
			jo.element("telephone", entityMap.get("telephone"));
			jo.element("description", entityMap.get("description"));
			jo.element("createtime", entityMap.get("createtime"));
			jo.element("updatetime",entityMap.get("updatetime"));
			jo.element("type", entityMap.get("type"));
			jo.element("location", entityMap.get("location"));
		}
    	response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    }
	
	/**
     * 删除设备
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/deleteEntity.do", method = {RequestMethod.POST})
    public void deleteEquip(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
    	String id = (String)request.getParameter("id");
    	this.entityManageService.deleteEntityTransaction(id);
    } 
	
    /**
     * 修改社区位置
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/saveEntityLocation.do", method = {RequestMethod.POST})
    public void saveEntityLocation(HttpServletRequest request,HttpServletResponse response,int id) throws Exception { 	
    	String location = request.getParameter("location");
    	//String id = request.getParameter("id");
    	
    	PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		this.entityManageService.saveEntityLocationTransaction(location,id);
		pw.print("true");
		pw.flush();
    	
    } 
}  
