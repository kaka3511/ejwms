package com.huaao.web.organization;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.StringUtil;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.Community;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.organization.CommunityManageService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/communityManage")
public class CommunityManageController{  
	
	@Autowired
    private CommunityManageService CommunityManageService;
	
	@AuthPassport
    @RequestMapping(value = "/communityManage")
    public String index(HttpServletRequest request,HttpServletResponse response) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Community community = this.CommunityManageService.queryCommunityInfo(user.getCommunityId());
		request.setAttribute("community", community);
        return "system/communityManage";
    }  
	
    /**
     * 修改社区位置
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/saveCommunityLocation.do", method = {RequestMethod.POST})
    public void saveCommunityLocation(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		UserInfo user=AuthHelper.getSessionUserAuth(request);
    	String location = request.getParameter("location");
    	this.CommunityManageService.saveCommunityLocationTransaction(location,user.getCommunityId());
    } 
	
    /**
     * 修改社区基本信息
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/saveCommunityInfo.do", method = {RequestMethod.POST})
    public void saveCommunityInfo(@RequestParam(value = "uploadImg") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		UserInfo user=AuthHelper.getSessionUserAuth(request);
    	String communityName = request.getParameter("communityName");
    	String communityDescription = request.getParameter("communityDescription");
    	String communityPW = request.getParameter("communityPW");
    	String img = "";
    	String flag = "";
    	JSONObject jo = new JSONObject();
    	if (!file.isEmpty()) {
    		String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "C_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
    		flag = OSSUtil.uploadFile(file, fileName);
    	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
    	    Community community = this.CommunityManageService.queryCommunityInfo(user.getCommunityId());
    	    if(!StringUtil.isEmpty(community.getImg())){
    	    	OSSUtil.deleteFile(community.getImg().substring(SystemVariable.DomainName_OSS.length()+8));
    	    }
		}
    	this.CommunityManageService.saveCommunityInfoTransaction(communityName,communityDescription,communityPW,user.getCommunityId(),img);
    	jo.element("flag", flag);
    	jo.element("img", img);
    	response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    } 
	
    /**
     * 修改社区区域
     * @param request
     * @param response
     * @throws Exception 
     */
	@AuthPassport
    @RequestMapping(value = "/saveCommunityArea.do", method = {RequestMethod.POST})
    public void saveCommunityArea(HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		UserInfo user=AuthHelper.getSessionUserAuth(request);
    	String area = request.getParameter("area");
    	this.CommunityManageService.saveCommunityAreaTransaction(area,user.getCommunityId());
    }
	
	@AuthPassport
    @RequestMapping(value = "/queryCommunityLocation.do")
    public void queryCommunityLocation(HttpServletRequest request,HttpServletResponse response) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Community community = this.CommunityManageService.queryCommunityInfo(user.getCommunityId());
		JSONObject jo = new JSONObject();
		jo.element("location", community.getLocation());
    	response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    } 
}  
