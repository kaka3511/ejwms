package com.huaao.web.system;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.model.home.AuthPassport;
import com.huaao.service.system.MenuRoleService;
import com.huaao.service.system.MenuService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/menuRole")
public class MenuController {
	
	@Autowired
	private MenuService mus;
	
	@Autowired
	private MenuRoleService menurole;
	
	@RequestMapping("/menuMannage")
	public String index() {
		return "/system/MenuTreeLink";
	}

	
	/**
	 * 查看列表集合
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/menuRoleTree")
	public void Menushowlist(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String praent_id=request.getParameter("Id");
		int roleid=Integer.valueOf(request.getParameter("roleid"));
		List<Map<String, Object>> listMenuRole=menurole.queryMenuForRole(roleid);
		int pid=Integer.valueOf(praent_id);
		@SuppressWarnings("unchecked")
		List<Map<String,Object>> list=mus.menuListshow(pid);
		String json="";
		JSONArray jaobj=new JSONArray();
		for (Map<String,Object> object : list) {
			JSONObject obj=new JSONObject();
			obj.put("id", object.get("id"));
			obj.put("text", object.get("menu_name"));
			List<Map<String,Object>> listchlid=mus.menuListshow( Integer.valueOf(object.get("id").toString()));
			if(listchlid.size()>0){
			JSONArray jsonchild=new JSONArray();
				for (Map<String, Object> map : listchlid) {
					
					JSONObject jslsat=new JSONObject();
					jslsat.put("id", map.get("id"));
					jslsat.put("text", map.get("menu_name"));
					JSONObject attr=new JSONObject();
					attr.put("id",0);
					for (int i=0;i<listMenuRole.size();i++) {
						if(listMenuRole.get(i).get("menu_id").toString().equals(map.get("id").toString())){
							jslsat.put("checked",true);
							attr.put("id", listMenuRole.get(i).get("id"));							
							listMenuRole.remove(i);
						}						
					}
					jslsat.put("attributes",attr);
					jsonchild.add(jslsat);
				}
				obj.put("children", jsonchild);
			}
			
			jaobj.add(obj);
		}
		System.out.println(jaobj.toString());
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jaobj.toString());
		response.getWriter().flush();
		response.getWriter().close();
	}

}
