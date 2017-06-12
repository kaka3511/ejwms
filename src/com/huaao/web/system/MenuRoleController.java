package com.huaao.web.system;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.model.home.AuthPassport;
import com.huaao.service.system.MenuRoleService;

@Controller
@RequestMapping(value = "/menuMannage")
public class MenuRoleController {

	@Autowired
	private MenuRoleService menuroleser;

	/**
	 * 查看列表集合
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/updateOrinsertMenuRole")
	public void menuRoleList(HttpServletRequest request, HttpServletResponse response) throws Exception{
	//checked:checked,menuid:node.id,roleid: $("#selectRoleid").val(),attributes:node.attributes.id
		String checked=request.getParameter("checked");
		String menuid=request.getParameter("menuid");
		String roleid=request.getParameter("roleid");
		String attributes=request.getParameter("attributes");
		boolean requestData=false;
		if(checked.equals("true")){
			if(attributes.equals("0")){
				requestData=menuroleser.insertMenuForRole(Integer.valueOf(roleid),Integer.valueOf(menuid),1);
			}else{
				requestData=menuroleser.MenuForRole(Integer.valueOf(attributes),1);
			}
			//这里是选中的状态，对
		}else
		{
			requestData=menuroleser.MenuForRole(Integer.valueOf(attributes),0);
			//不选中的的状态下就对该条记录进行删除和状态隐藏。
			
		}
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(requestData?"true":"false");
		response.getWriter().flush();
		response.getWriter().close();
		
	}

}
