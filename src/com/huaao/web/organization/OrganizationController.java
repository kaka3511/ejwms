package com.huaao.web.organization;


import java.io.PrintWriter;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.StringHelper;
import com.huaao.common.extension.StringUtil;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.Community;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.model.organization.Dept;
import com.huaao.model.organization.DeptNode;
import com.huaao.model.organization.DeptNodeEx;
import com.huaao.model.organization.Region;
import com.huaao.model.organization.UserType;
import com.huaao.service.organization.CommunityManageService;
import com.huaao.service.organization.OrganizationService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



@SuppressWarnings("rawtypes")
@Controller
@RequestMapping(value = "/organization")
public class OrganizationController {

	@Autowired
	private OrganizationService service;
	
	@Autowired
	private CommunityManageService communityManageService;
	
	/**
	 * 跳转到社区管理
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/organization")
    public String index() throws Exception { 	
        return "organization/organization";
    } 
    
    
    /**
	 * 跳转到人员信息管理
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/personRole")
    public String personRole() throws Exception { 	
        return "organization/personRole";
    } 
    
    /**
	 * 跳转到人员类型管理
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/personType")
    public String personInfo() throws Exception { 	
        return "organization/personType";
    } 
    
    @AuthPassport
    @RequestMapping(value = "/person")
    public String person() throws Exception { 	
        return "organization/personlist";
    } 
    
    /**
	 * 跳转到社区信息设置
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/modifyCommunity/{communityid}")
    public String modifyCommunity(@PathVariable int communityid, HttpServletRequest request) throws Exception { 	
    	Community community = communityManageService.queryCommunityInfo(communityid);
		request.setAttribute("community", community);
		request.setAttribute("enable", true);
        return "organization/communityManage";
    } 
    
    /**
	 * 跳转到新增社区
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/addCommunity")
    public String addCommunity() throws Exception { 
        return "organization/addCommunity";
    } 
    
    
    /**
	 * 社区管理树
	 * @return
	 * @throws Exception 
	 */
    @AuthPassport
    @RequestMapping(value = "/communityTree.do")
    public @ResponseBody List<DeptNode> communityTree(HttpServletRequest request) throws Exception { 		
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	List<DeptNode> root = this.service.queryDeptList(user.getCommunityId(),0);
    	return root;
    } 
    
    /**
     * 地区树
     * @param request
     * @return
     * @throws Exception
     */
    @AuthPassport
    @RequestMapping(value = "/regionTree.do")
    public @ResponseBody List<DeptNode> regionTree(HttpServletRequest request) throws Exception { 
    	List<DeptNode> root = this.service.queryRegionList(0);
    	return root;
    }
    
    @AuthPassport
    @RequestMapping(value = "/region")
    public String region() throws Exception { 	
        return "organization/region";
    } 
    
	@SuppressWarnings("unchecked")
	@AuthPassport
    @RequestMapping(value = "/queryRegion.do")
    public @ResponseBody Map queryRegion(HttpServletRequest request,String type, int kid, String name) throws Exception {
    	Map result = new HashMap<String, List>();
    	List<Region> deptList = service.getRegionList(kid);
    	result.put("data",deptList);
    	return result;
    }
	
	@AuthPassport
    @RequestMapping(value = "/queryRegionByPid.do")
    public @ResponseBody Map queryRegionByPid(HttpServletRequest request,String type, int pid, String name) throws Exception {
    	Map result = new HashMap<String, List>();
    	List<Region> deptList = service.findRegionListByPid(pid);
    	result.put("data",deptList);
    	return result;
    }
    
    
    
    @AuthPassport
    @RequestMapping(value = "/communityTreeEx.do")
    public @ResponseBody List<DeptNodeEx> communityTreeEx(HttpServletRequest request,int id) throws Exception { 		
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	List<DeptNodeEx> root = this.service.queryDeptListEx(user.getCommunityId(),id);
    	return root;
    } 
    
    /**
     * 
     * @param request
     * @return
     * @throws Exception
     */
    @AuthPassport
    @RequestMapping(value = "/communityAndTypeTree.do")
    public @ResponseBody List<DeptNode> communityAndTypeTree(HttpServletRequest request) throws Exception { 		
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	List<DeptNode> root = this.service.queryDeptAndTypeList(user.getCommunityId(),0);
    	return root;
    } 
    
    
    
   
    /**
	 * 社区管理，显示树的下一层
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@AuthPassport
    @RequestMapping(value = "/queryCommunity.do")
    public @ResponseBody Map queryCommunity(HttpServletRequest request,String type, int kid, String name) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
    	Map result = new HashMap<String, List>();
    	List<Dept> deptList = service.getDeptList(kid,user.getCommunityId());
    	result.put("data",deptList);
    	return result;
    }
	
	/**
	 * 下拉获取组织集
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@AuthPassport
    @RequestMapping(value = "/getCommunityList.do")
    public @ResponseBody Map getCommunityList(HttpServletRequest request) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
    	Map result = new HashMap<String, List>();
    	List<Dept> deptList = service.getCommunityList(user.getCommunityId());
    	result.put("data",deptList);
    	return result;
    }

	
   
  
	
	/**
	 * 查询人员类型
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@AuthPassport
    @RequestMapping(value = "/queryUserType.do")
    public @ResponseBody Map queryUserType(HttpServletRequest request, HttpServletResponse response,int deptid) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Map result = new HashMap<String, List>();
		List<UserType> typeList =null;
    	typeList = service.getUserTypeList(deptid,user.getCommunityId());
    	result.put("data",typeList);
    	return result;
	}
	
	
	@SuppressWarnings("unchecked")
	@AuthPassport
    @RequestMapping(value = "/queryUserTypeEx.do")
    public @ResponseBody Map queryUserTypeEx(HttpServletRequest request, HttpServletResponse response,int typeId) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Map result = new HashMap<String, List>();
		List<UserType> typeList =null;
    	typeList = service.getUserTypeListEx(user.getCommunityId(),typeId);
    	result.put("data",typeList);
    	return result;
	}
	
	private JSONObject handleData(List list){
		Iterator it = list.iterator();
		JSONArray ja = new JSONArray();
		int i = 1;
		while (it.hasNext()) {
			Map dictionaryMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", dictionaryMap.get("id"));
			jo.element("xh", i++);
			jo.element("name", dictionaryMap.get("name"));
			jo.element("code", dictionaryMap.get("code"));
			ja.add(jo);
		}
		JSONObject jo = new JSONObject();
		jo.element("data", ja);
		return jo;
	}
	
	
	
	/**
	 * 保存人员类型
	 * @return
	 * @throws Exception 
	 */
	@AuthPassport
    @RequestMapping(value = "/saveUserType.do")
    public @ResponseBody void saveUserType(HttpServletRequest request,HttpServletResponse response,int id, int code, String name, int dept,int role,String description,int status) throws Exception {
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		if(this.service.checkUserType(id,dept,role,code,user.getCommunityId())){
			if(id==0){
				this.service.saveUserType(code, name,dept,role,description,status,user.getCommunityId());
			}else {
				this.service.updateUserType(id,code, name,dept,role,description,status,user.getCommunityId());
				
			}
			pw.print("true");
		}else{
			pw.print("false");
		}
		pw.flush();
	}
	
	/**
	 * 删除人员类型
	 * @return
	 * @throws Exception 
	 */
	@AuthPassport
    @RequestMapping(value = "/deleteUserType.do")
    public @ResponseBody void deleteUserType(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		this.service.deleteUserType(id);
		pw.print("true");
		pw.flush();
	}
	
	 /**
     * 人员管理列表
     */
    @AuthPassport
    @RequestMapping(value = "/personnlList.do")
    public void personnlList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
    	UserInfo user=AuthHelper.getSessionUserAuth(request);
    	String id = request.getParameter("id").toString();
    	String role = request.getParameter("role").toString();
    	String code = request.getParameter("code").toString();
    	String communityid = request.getParameter("communityid").toString();
    	int cId=0;
    	if(communityid==null||StringUtil.isEmpty(communityid)){
    		cId=0;
    	}else{
    		cId=Integer.valueOf(communityid);
    	}
    	List serviceList = this.service.querylistTransaction(cId,id,role,code);
    	Iterator it = serviceList.iterator();
    	JSONArray ja = new JSONArray();
    	int i=1;
    	while (it.hasNext()) {
    		Map maplist = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id",maplist.get("id"));
			jo.element("name",maplist.get("name"));
			jo.element("cellphone",maplist.get("cellphone"));
			jo.element("position",maplist.get("position")==null?"":maplist.get("position"));
//			jo.element("address",maplist.get("address"));
			jo.element("type",maplist.get("type"));
			jo.element("useridentity",maplist.get("useridentity"));
			jo.element("status",maplist.get("status"));
//			jo.element("idcard",maplist.get("idcard")== null?"":maplist.get("idcard").toString());
			String updatetime = "";
			if(maplist.get("updatetime")!=null){
				updatetime = StringHelper.toGenTime(maplist.get("updatetime").toString(), "yyyy-MM-dd HH:mm:ss");
			}
			jo.element("xh",i);
			i++;
			jo.element("updatetime",updatetime);
			jo.element("points",maplist.get("points"));
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
     * 删除用户
     * @param request
     * @param response
     * @throws Exception 
     */
	 
	@AuthPassport
    @RequestMapping(value = "/deleteUser.do")
    public @ResponseBody void deleteUser(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		this.service.deleteUser(id);
		pw.print("true");
		pw.flush();
	}
    
    /**
     * 保存组织信息 add by sfke
     * @param file
     * @param request
     * @param response
     * @throws Exception
     */
	@AuthPassport
	@RequestMapping(value = "/saveDeptInfo.do", method = { RequestMethod.POST })
	public void saveDeptInfo(@RequestParam(value = "uploadImg") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception { 	
		UserInfo user = AuthHelper.getSessionUserAuth(request);
		String id = request.getParameter("id");
		String name = request.getParameter("name").trim();
		String cellphone = request.getParameter("cellphone");
		String addr = request.getParameter("addr");
		String parentid = request.getParameter("parentid");
		String description = request.getParameter("description");
		String status = request.getParameter("status");
		String communityImg = request.getParameter("communityImg");
		String location = request.getParameter("location");
		String area = request.getParameter("area");
		
		int communityId=user.getCommunityId();
		
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
    	    	List imgList = service.queryDeptInfo(communityId,id);
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
			if(!communityImg.isEmpty()){
				img=communityImg;
			}
		}
		service.saveDeptInfo(id, name, cellphone, addr,parentid, description,communityId,status,img,location,area);
		
		pw.print("true");
		
		pw.flush();
	}
	
	/**
	 * 删除组织
	 * @param response
	 * @param id
	 * @throws Exception
	 */
	@AuthPassport
    @RequestMapping(value = "/deleteDeptInfo.do")
    public @ResponseBody void deleteDeptInfo(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		this.service.deleteDeptInfo(id);
		pw.print("true");
		pw.flush();
	}
	
	/**
	 * 获取用户积分记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
    @AuthPassport
    @RequestMapping(value = "/getUserScoreRecordList.do")
    public void getUserScoreRecordList(HttpServletRequest request,
			HttpServletResponse response,int uid) throws Exception {
    	List serviceList = service.getUserScoreRecordList(uid);
    	Iterator it = serviceList.iterator();
    	JSONArray ja = new JSONArray();
    	int i=1;
    	while (it.hasNext()) {
    		Map maplist = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("points",maplist.get("points"));
			jo.element("type",maplist.get("type"));
			jo.element("description",maplist.get("description"));
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
}
