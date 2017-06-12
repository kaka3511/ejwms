package com.huaao.web.system;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.huaao.model.home.AuthPassport;
import com.huaao.service.system.SystemService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/system")
public class SystemController {

	@Autowired
	private SystemService systemService;

	
	   @AuthPassport
	    @RequestMapping(value = "/download.do")
	    public void download(HttpServletRequest request,
				HttpServletResponse response) throws Exception {
	    	
	    	JSONArray ja = new JSONArray();
	    	
	    	System.out.println("1111");
	    	JSONObject jo = new JSONObject(); 
			jo.element("data", ja);
			response.setContentType("text/html;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jo);
			pw.flush();
	    }
}
