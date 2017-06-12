package com.huaao.web.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.model.home.AuthPassport;
import com.huaao.service.system.UserTypeService;

import net.sf.json.JSONArray;

@Scope("prototype")
@Controller
@RequestMapping(value = "/UserType")
public class UserTypeController {
	@Autowired
	private UserTypeService typeser;
	
	/**
	 * 查看列表集合
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AuthPassport
	@RequestMapping(value = "/treeUserType")
	public void treeUserType(HttpServletRequest request, HttpServletResponse response) throws Exception{
	String  id=request.getParameter("id");
	JSONArray ja=typeser.queryTreeDeptUserType(1,Integer.valueOf(id));
	response.setContentType("text/html;charset=UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(ja.toString());
	response.getWriter().flush();
	response.getWriter().close();
	
	
	}

}
