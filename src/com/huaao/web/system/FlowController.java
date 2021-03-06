package com.huaao.web.system;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaao.model.home.AuthPassport;
import com.huaao.model.system.Flow;
import com.huaao.service.system.FlowService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/flow")
public class FlowController {

	@Autowired
	private FlowService flowService;
	
	@AuthPassport@RequestMapping("/flowIndex")
	public String index(HttpServletRequest request){
		List flowList = flowService.findAll();
		request.setAttribute("flowList", flowList);
		return "system/flow/index";
	}

	@AuthPassport
	@RequestMapping(value = "/list.do", method = { RequestMethod.POST })
	public void flowList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List flowList = flowService.findAll();
		
		int index = 1;
		Iterator it = flowList.iterator();
		JSONArray ja= new JSONArray();
		while(it.hasNext()){
			Map flowMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", flowMap.get("id"));
			jo.element("index", index);
			String code = (String) flowMap.get("code");
			List dicList = flowService.selectDicByCode(code);
			if(dicList.size() != 0) {
				Map dicMap = (Map) dicList.iterator().next();
				String name = (String) dicMap.get("dictionary_name");
				jo.element("name", name);				
				jo.element("code", flowMap.get("code"));
				ja.add(jo);
				index++;
			}
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
    public @ResponseBody void deleteFlow(HttpServletResponse response,int id) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		Integer flag = flowService.delete(id);
		if(flag == 0) {
			pw.print("false");
		} else {
			pw.print("true");			
		}
		pw.flush();
	}
	

	@AuthPassport
    @RequestMapping(value = "/save.do")
    public @ResponseBody void save(HttpServletRequest request,HttpServletResponse response) throws Exception {
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		String id = request.getParameter("addFlowName");
		int flag = flowService.save(Integer.parseInt(id));
		if(flag == 0) {
			pw.print("false");
		} else {
			pw.print("true");			
		}
		pw.flush();
	}
	
	@AuthPassport
	@RequestMapping(value = "/listFromDic")
	public void listFromDic(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List flowList = flowService.selectFromDic();
		Iterator it = flowList.iterator();
		JSONArray ja = new JSONArray();
		while (it.hasNext()) {
			Map flowMap = (Map) it.next();
			JSONObject jo = new JSONObject();
			jo.element("id", flowMap.get("id"));
			jo.element("name", flowMap.get("dictionary_name"));
			jo.element("code", flowMap.get("dictionary_code"));
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
