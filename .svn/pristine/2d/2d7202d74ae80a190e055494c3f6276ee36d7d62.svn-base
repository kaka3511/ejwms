package com.huaao.web.system;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.dao.base.BaseDao;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.service.organization.OrganizationService;
import com.huaao.service.system.UserRoleService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Scope("prototype")
@Controller
@RequestMapping(value = "/UserRole")
public class UserRoleController {
	
	@Autowired
	private UserRoleService roleser;

	
	//先查出所有关联了的角色，然后查出没有关联的角色。
	//把这两个角色的数据集结合起来就是完整的角色表中的数据
	//然后为相应的角色附上角色的是否被关联的状态属性。方便前台显示数据
	//然后为显示的数据选择用户，通过选择角色和用户关联插入到数据库中就ok了
	
	

	@RequestMapping("/UserRoleMannage")
	public String index() {
		return "/system/UserRole";
	}

	
	
	/**
	 * 查看列表集合
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/selectLikeToString")
	public void selectLikeToString(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String likeStr=request.getParameter("likeStr");
		int roleid=Integer.valueOf(request.getParameter("id").toString());
		//查询到的所有符合关键字用户
		List<Map<String,Object>> list=roleser.queryforUserToLike(likeStr);
		JSONObject dataJson=new JSONObject();
		JSONArray userRole=new JSONArray();
		//根据用户查询这个用户和角色的关联关系是否存在，如果存在则把相应数据填充进json中在页面显示被选中状态
		for (Map<String, Object> map : list) {
			JSONObject obj=new JSONObject();
			obj.put("id",map.get("id"));
			obj.put("name",map.get("name"));
			obj.put("cellPhone", map.get("cellphone"));
			List<Map<String,Object>> listselect=roleser.queryForuserRoleBy_Is_Type_usersid(Integer.valueOf(map.get("id").toString()),roleid,3, 1);
			if(listselect.size()>0){
			obj.put("userroleid", listselect.get(0).get("id"));

			if(listselect.get(0).get("is_valid").toString().equals("1"))obj.put("check",true);
			}else{
			obj.put("userroleid",0);
			obj.put("check",false);
			}
			//查询到的用户信息是否被关联到这条角色信息			
			userRole.add(obj);	
		}
		dataJson.put("data", userRole);
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(dataJson.toString());
		response.getWriter().flush();
		response.getWriter().close();
		
	}
	
	
    /**
  	 * 社区管理树
  	 * @return
  	 * @throws Exception 
  	 */
      @AuthPassport
      @RequestMapping(value = "/EasyTreeDatejson.do")
      public void  EasyTreeDatejson(HttpServletRequest request, HttpServletResponse response) throws Exception { 		
      	UserInfo user=AuthHelper.getSessionUserAuth(request);
      	int roleid=Integer.valueOf(request.getParameter("id").toString());
     	JSONArray ja = this.roleser.queryDeptListTree(new ArrayList<Map<String,Object>>(),user.getCommunityId(),0,roleid,1,1);
     	
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		response.getWriter().write(ja!=null?ja.toString():"[]");
		response.getWriter().flush();
		response.getWriter().close();

      }
      
      /**
    	 * 社区管理树
    	 * @return
    	 * @throws Exception 
    	 */
        @AuthPassport
        @RequestMapping(value = "/updateUserRole.do")
      public void updateUserRole(HttpServletRequest request, HttpServletResponse response) throws Exception { 
    	  boolean boo=false;
    	  String check=request.getParameter("checked");
    	  String userroleid=request.getParameter("userroleid");
    	  String userid=request.getParameter("userid");
    	  String roleid=request.getParameter("roleid");
    	  String type=request.getParameter("Type");
    	  //表示没有添加过这条数据
    	  if(userroleid.equals("0")){
    		  boo=this.roleser.saveUserRole(Integer.valueOf(roleid),Integer.valueOf(userid),Integer.valueOf(type), 1);
    		  
    	  }else{
    		  boo=this.roleser.updateUserRole(check.equals("false")?0:1,Integer.valueOf(userroleid));
    	  // 表示已经添加过了这条数据只需要重新激活这条数据就好了。	  
   	  }
    	  
  		response.setContentType("text/html;charset=UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		response.getWriter().write(boo?"true":"false");
  		response.getWriter().flush();
  		response.getWriter().close();
    	  
      }
	
}
