package com.huaao.web.system;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.Community;
import com.huaao.model.home.UserInfo;
import com.huaao.service.system.FlowNodeService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/flowNode")
public class FlowNodeController {

	@Autowired
	private FlowNodeService flowNodeService;

	@AuthPassport
	@RequestMapping("/flowNodeIndex")
	public String index(HttpServletRequest request) {
		List flowNodeList = flowNodeService.findAll();
		request.setAttribute("flowNodeList", flowNodeList);
		return "system/flowNode/index";
	}

	@AuthPassport
	@RequestMapping(value = "/list.do", method = { RequestMethod.POST })
	public void flowNodeList(HttpServletRequest request, HttpServletResponse response, Integer id) throws Exception {
		List flowList = flowNodeService.findNodesById(id);
		Iterator it = flowList.iterator();
		JSONArray ja = new JSONArray();
		int index = 1;
		while (it.hasNext()) {
			Map flowMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", flowMap.get("id"));
			jo.element("name", flowMap.get("name"));
			jo.element("type", flowMap.get("type"));
			jo.element("index", index);
			index++;
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
	
	@AuthPassport
	@RequestMapping(value = "/listNodeFromDic")
	public void listNodeFromDic(HttpServletRequest request, HttpServletResponse response, Integer id) throws Exception {
		List nodeList = flowNodeService.findByFlowId(id);
		Iterator it = nodeList.iterator();
		JSONArray ja = new JSONArray();
		while (it.hasNext()) {
			Map flowMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", flowMap.get("id"));
			jo.element("nodeName", flowMap.get("dictionary_name"));
			jo.element("userIdentity", flowMap.get("dictionary_code"));
			//jo.element("index", flowMap.get("index"));
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

	@AuthPassport
	@RequestMapping(value = "/delete.do")
	public @ResponseBody void deleteFlowNode(HttpServletRequest request, HttpServletResponse response, int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		flowNodeService.delete(id);
		pw.print("true");
		pw.flush();
	}
	
	@AuthPassport
	@RequestMapping(value = "/save.do")
	public @ResponseBody void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		//Integer index = Integer.parseInt(request.getParameter("index"));
		Integer id = Integer.parseInt(request.getParameter("id"));
		int flag = flowNodeService.save(id);
		if(flag == 0) {
			pw.print("false");
		} else {
			pw.print("true");			
		}
		pw.flush();
	}

	//查找关联人员
	@AuthPassport
	@RequestMapping(value = "/selectByFlowNode")
	public void selectByFlowNode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer flowNodeId = Integer.parseInt(request.getParameter("id"));
		request.getSession().setAttribute("flowNode", flowNodeId);
		List flowList = flowNodeService.findByFlowNode(flowNodeId);
		Iterator it = flowList.iterator();
		JSONArray ja = new JSONArray();
		int index = 1;
		while (it.hasNext()) {
			Map flowMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("index", index);
			jo.element("name", flowMap.get("name"));
			jo.element("cellphone", flowMap.get("cellphone"));
			jo.element("address", flowMap.get("address"));
			ja.add(jo);
			index++;
		}
		JSONObject jo = new JSONObject();
		jo.element("data", ja);
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
	}
	
	@AuthPassport
	@RequestMapping(value = "/selectAllUser")
	public void selectAllUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int communityId = AuthHelper.getSessionUserAuth(request).getCommunityId();
		
		List relUsers = new ArrayList();
		List unRelUsers = new ArrayList();
		Integer flowNodeId = Integer.parseInt(request.getParameter("id"));
		request.getSession().setAttribute("flowNode", flowNodeId);
		Integer type = flowNodeService.getNodeType(flowNodeId);
		Integer identity = flowNodeService.getNodeIdentity(flowNodeId);
		if(type == 2) {
			relUsers = flowNodeService.findRelUsers(flowNodeId, identity, communityId);
			unRelUsers = flowNodeService.findUnRelUsers(identity, flowNodeId, communityId);			
		} else {
			relUsers = flowNodeService.findRelUsersByType(flowNodeId, type, communityId);
			unRelUsers = flowNodeService.findUnRelUsersByType(type, flowNodeId, communityId);			
		}
		
		Iterator it1 = relUsers.iterator();
		Iterator it2 = unRelUsers.iterator();
		JSONArray ja = new JSONArray();
		int index = 1;
		while (it1.hasNext()) {
			Map flowMap = (Map) it1.next();
			JSONObject jo = new JSONObject();
			if(flowMap.get("address") != null) {
				String address = flowMap.get("address").toString();								
				address = address.substring(0, address.indexOf(";"));
				jo.element("address", address);								
			} else {
				jo.element("address", flowMap.get("address"));				
			} 
			jo.element("index", index);
			jo.element("id", flowMap.get("id"));
			jo.element("name", flowMap.get("name"));
			jo.element("gender", flowMap.get("gender"));
			jo.element("deptName", flowMap.get("dept_name"));
			if(StringUtils.isEmpty(flowMap.get("position"))) {
				jo.element("position", "");				
			} else {
				jo.element("position", flowMap.get("position"));				
			}
			jo.element("status", "1");
			ja.add(jo);
			index++;
		}
		while (it2.hasNext()) {
			Map flowMap = (Map) it2.next();
			JSONObject jo = new JSONObject();
			if(flowMap.get("address") != null) {
				String address = flowMap.get("address").toString();								
				address = address.substring(0, address.indexOf(";"));
				jo.element("address", address);								
			} else {
				jo.element("address", flowMap.get("address"));				
			} 
			jo.element("index", index);
			jo.element("id", flowMap.get("id"));
			jo.element("name", flowMap.get("name"));
			jo.element("gender", flowMap.get("gender"));
			jo.element("deptName", flowMap.get("dept_name"));
			if(StringUtils.isEmpty(flowMap.get("position"))) {
				jo.element("position", "");				
			} else {
				jo.element("position", flowMap.get("position"));				
			}
			ja.add(jo);
			index++;
		}
		JSONObject jo = new JSONObject();
		jo.element("data", ja);
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
	}
	
	@AuthPassport
	@RequestMapping(value = "/saveUser.do")
	public @ResponseBody void saveUser(HttpServletRequest request, HttpServletResponse response, int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		//int communityId = AuthHelper.getSessionUserAuth(request).getCommunityId();
		Integer communityId = AuthHelper.getSessionUserAuth(request).getCommunityId();
		Integer flowNodeId = (Integer) request.getSession().getAttribute("flowNode");
		Integer flag = flowNodeService.isRelated(flowNodeId, communityId);
		if(flag == 0) {
			pw.print("false");			
 			pw.flush();
		} else if(flag == 1) {
			flowNodeService.saveUser(id, flowNodeId);
			pw.print("true");			
			pw.flush();
		}
	}
	
	@AuthPassport
	@RequestMapping(value = "/deleteUser.do")
	public @ResponseBody void deleteUser(HttpServletRequest request, HttpServletResponse response, int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		Integer flowNodeId = (Integer) request.getSession().getAttribute("flowNode");
		flowNodeService.deleteUser(id, flowNodeId);
		pw.print("true");
		pw.flush();
	}
	
	
}
