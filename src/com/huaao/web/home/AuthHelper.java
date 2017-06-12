package com.huaao.web.home;

import javax.servlet.http.HttpServletRequest;

import com.huaao.model.home.Community;
import com.huaao.model.home.UserInfo;

public class AuthHelper {
	
	public static void setSessionUserAuth(HttpServletRequest request, UserInfo user){
		request.getSession().setAttribute("user", user);
	}
	
	public static UserInfo getSessionUserAuth(HttpServletRequest request){
		return (UserInfo)request.getSession().getAttribute("user");
	}
	
	public static void setSessionCommunityrAuth(HttpServletRequest request, Community community){
		request.getSession().setAttribute("community", community);
	}
	
	public static Community getSessionCommunityAuth(HttpServletRequest request){
		return (Community)request.getSession().getAttribute("community");
	}

}
