package com.huaao.web.system;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.model.system.Role;
import com.huaao.service.goods.GoodsSaleService;
import com.huaao.service.organization.OrganizationService;
import com.huaao.service.system.RoleManageService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/role")
public class RoleController {

	@Autowired
	private RoleManageService role;
	@Autowired
	private OrganizationService organse5;

	@RequestMapping("/roleMannage")
	public String index() {
		return "/system/roleMannage";
	}

	@RequestMapping("/roleMannage/addrole")
	public String addrole() {
		return "/system/MannageRole/saveRole";
	}

	@RequestMapping("/roleMannage/updateRole")
	public String updateRole() {
		return "/system/MannageRole/updateRole";
	}

	/**
	 * 查看列表集合
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/roleMannage/ListForPage")
	public void listForPage(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Map> list = role.queryForUserType();
		JSONArray ja = new JSONArray();
		String key = null;
		int index=1;
		for (Map map : list) {
			JSONObject obj = new JSONObject();
			key="rowid";
			obj.put("rows",index);
			index++;
			key = "role_id";
			obj.put(key, map.get(key));
			
			key = "role_code";
			obj.put(key, map.get(key));
			
			key = "role_name";
			obj.put(key, map.get(key));
			
			key = "is_valid";
			obj.put(key, map.get(key));
			
			key = "createtime";
			obj.put(key, map.get(key));
			
			key = "description";
			obj.put(key, map.get(key));
			ja.add(obj);
		}
		JSONObject objre=new JSONObject();
		objre.put("data", ja.toString());
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(objre.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}

	/**
	 * 删除其中一条数据
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/roleMannage/removeDate")
	public void removeDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 因为不清楚业务逻辑， 只做了简单数据删除
		int removeid = Integer.valueOf(request.getParameter("removeId"));
		JSONObject resu = new JSONObject();
		resu.put("result", role.updateRemove(removeid));
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(resu.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}

	/**
	 * 添加数据
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/roleMannage/addRoleinfo")
	public void addRoleInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean result=false;
//		// 这里需要相关联的uid填入到数据
		String name = request.getParameter("name");
		String code =request.getParameter("code");
		String desc=request.getParameter("desc");
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Role roleinfo=new Role();
		roleinfo.setCuser(user.getId());
		roleinfo.setIs_valid(1);
		roleinfo.setRole_name(name);
		roleinfo.setRole_code(code);
		roleinfo.setDescription(desc);
		if(!role.chaeckcode(code)){
			if(role.saveRole(roleinfo)){
				result=true;
			}		
		}

		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(result?"true":"false");
		response.getWriter().flush();
		response.getWriter().close();
	}
	

	/**
	 * 添加数据
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/roleMannage/updateRoleinfo")
	public void updateRoleInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean result=true;
		// 这里需要相关联的uid填入到数据
		String name = request.getParameter("name");
		String code =request.getParameter("code");
		String desc=request.getParameter("desc");
		String roleid=request.getParameter("id");
		UserInfo user=AuthHelper.getSessionUserAuth(request);
		Role roleinfo=new Role();
		roleinfo.setRole_id(Integer.valueOf(roleid));
		roleinfo.setCuser(user.getId());
		roleinfo.setIs_valid(1);
		roleinfo.setRole_name(name);
		roleinfo.setRole_code(code);
		roleinfo.setDescription(desc);
		if(role.chaeckcode(code,roleid)){
			result=false;	
		}else{
			if(role.updateEdit(roleinfo)){
				result=true;
			}		
		}

		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(result?"true":"false");
		response.getWriter().flush();
		response.getWriter().close();
	}

	public void likeListToString(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String likestring = request.getParameter("likeString");
		List<Map> list = role.queryForLikeString(likestring);
		JSONArray ja = new JSONArray();
		String key = null;
		for (Map map : list) {
			JSONObject obj = new JSONObject();
			key = "role_id";
			obj.put(key, map.get(key));
			
			key = "role_code";
			obj.put(key, map.get(key));
			
			key = "role_name";
			obj.put(key, map.get(key));
			
			key = "is_valid";
			obj.put(key, map.get(key));
			
			key = "createtime";
			obj.put(key, map.get(key));
			
			key = "description";
			obj.put(key, map.get(key));
			ja.add(obj);
		}
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(ja.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}
	
	

}
