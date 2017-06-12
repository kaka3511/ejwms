package com.huaao.web.home;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.home.AccountUser;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.UserInfo;
import com.huaao.model.system.Menu;
import com.huaao.service.alert.AlertService;
import com.huaao.service.business.AuthenticationService;
import com.huaao.service.business.OnlineJobService;
import com.huaao.service.business.PoliceService;
import com.huaao.service.goods.GoodsSaleService;
import com.huaao.service.home.HomeService;

@Controller
@RequestMapping(value = "/home")
public class HomeController{  
	
	@Autowired
    private HomeService homeService;
	
	
	@Autowired
	private PoliceService policeService;
	
	@Autowired
	private OnlineJobService onlineJobService;
	
	@Autowired
	private GoodsSaleService goodsSaleService;
	
	@Autowired
	private AuthenticationService authenticationService;
	
	@Autowired
	private AlertService alertService;
    
	/**
	 * 跳转到首页
	 * @return
	 */
    @AuthPassport
    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request,HttpServletResponse response) {
		try {
			UserInfo user=AuthHelper.getSessionUserAuth(request);
			List<Menu> menu = this.homeService.findByParentCode(user.getId());
			//			List<Menu> menu=this.homeService.queryMenuList(0);
		    request.setAttribute("menu", menu);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "home/toLogin";
		}
        return "home/index";
    }  
    
	/**
	 * 跳转到欢迎界面
	 * @return
	 */
    @AuthPassport
    @RequestMapping(value = "/welcome")
    public String welcome(HttpServletRequest request) { 	
    	UserInfo cuser = AuthHelper.getSessionUserAuth(request);
    	
    	request.setAttribute("cuser", cuser);
    	
        return "home/welcome";
    }  
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/wellcome/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
    	UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		List  list = new ArrayList();
		
		
		int type = cuser.getUsertype();
		int curStatus1 = -1;//自助登记
		int curStatus2 = -1;//网上办事
		int curStatus3 = 1;//爱心义卖
		int curStatus4 = 2;//实名认证
		int curStatus5 = 0;//报警处理
		
		List list1 = new ArrayList<Object>();
    	
    	List  list2 = new ArrayList<Object>();
    	
    	List  list3 = new ArrayList<Object>();
    	
    	List  list4 = new ArrayList<Object>();
    	
    	List  list5 = new ArrayList<Object>();
    	
    	List  list6 = new ArrayList<Object>();
    	if(cuser.getId()==9999){  
    		//超级管理员不显示所有待办业务
    	}else{
    		if(type==2){
    			//民警
    			int userIdentity = cuser.getUserIdentity();
    			curStatus1 = 2;
    			//curStatus2 = 2;
    			curStatus3 = 1;
    			
    			switch (userIdentity) {
    			case 1:
    				curStatus2 = 2;
    				break;
    			case 2:
    				curStatus2 = 7;
    				break;
    			case 3:
    				curStatus2 = 8;
    				break;
    			}
    			
    			list1 = policeService.queryWellcomeForList(curStatus1,cuser.getCommunityId());
    	    	
    	    	list2 = onlineJobService.queryWellComeForList(curStatus2,cuser.getCommunityId());
    	    	
    	    	list3 = goodsSaleService.queryWellcomeForList(curStatus3,cuser.getCommunityId());
    	    	
    	    	list4 = authenticationService.queryWellcomeForList(curStatus4,cuser.getCommunityId());
    	    	
    	    	list5 = alertService.queryWellcomeForList(curStatus5,cuser.getCommunityId());
    	    	
    		}else if(type==3){
    			//群干，参与网上办事、爱心义卖审核
    			curStatus2 = 1;
    			curStatus3 = 1;
    			list2 = onlineJobService.queryWellComeForList(curStatus2,cuser.getCommunityId());
    			list3 = goodsSaleService.queryWellcomeForList(curStatus3,cuser.getCommunityId());
    			
    			list4 = authenticationService.queryWellcomeForList(curStatus4,cuser.getCommunityId());
    	    	
    	    	list5 = alertService.queryWellcomeForList(curStatus5,cuser.getCommunityId());
    		}else if(type==4){
    			//网格员，参与自助登记、爱心义卖审核
    			curStatus1 = 1;
    			curStatus3 = 1;
    			
    			list1 = policeService.queryWellcomeForList(curStatus1,cuser.getCommunityId());
    			 list3 = goodsSaleService.queryWellcomeForList(curStatus3,cuser.getCommunityId());
    			 
    			  list4 = authenticationService.queryWellcomeForList(curStatus4,cuser.getCommunityId());
    		    	
    		    	list5 = alertService.queryWellcomeForList(curStatus5,cuser.getCommunityId());
    		}else if(type==5){
    			//医生，只参与网上办事审核
    			curStatus2 = 3;
    			
    			list2 = onlineJobService.queryWellComeForList(curStatus2,cuser.getCommunityId());
    			list6 = onlineJobService.queryWellComeForList(11,cuser.getCommunityId());
    		}
    		
        	
        	list.addAll(list1);
        	list.addAll(list2);
        	list.addAll(list3);
        	list.addAll(list4);
        	list.addAll(list5);
        	list.addAll(list6);
        	
        	Collections.sort(list, new Comparator<HashMap<String, Object>>(){

    			@Override
    			public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
    				if(o1.get("createtime")==null||o2.get("createtime")==null){
    					return -1;
    				}
    				return -(int) ((Long)o1.get("createtime")-(Long)o2.get("createtime"));
    			}
        		
        	});
    	}
		
    	
		resp.setData(list);
		return resp;
	}
    
	/**
	 * 跳转到登录界面
	 * @return
	 */
    @RequestMapping(value = "/toLogin")
    public String toLogin() { 	
        return "home/toLogin";
    }   
    
    @RequestMapping(value = "/notfound")
    public ModelAndView notfound() { 
    	
    	ModelAndView mv = new ModelAndView();  
    	mv.setViewName("404");  
    	
    	return mv;  
    }
    
    /**
     * 跳转到登录界面
     * @param model
     * @return
     */
    @RequestMapping(value="/login", method = {RequestMethod.GET})
    public String login(Model model){
		if(!model.containsAttribute("contentModel"))
            model.addAttribute("contentModel", new AccountUser());
    	return "home/login";
    }
    
    /**
     * 登录
     * @param request
     * @param model
     * @param accountUser
     * @param result
     * @return
     * @throws Exception 
     */
    @RequestMapping(value="/login", method = {RequestMethod.POST})
	public String login(HttpServletRequest request, Model model, @Valid @ModelAttribute("contentModel") AccountUser accountUser, BindingResult result) throws Exception{
		//如果有验证错误 返回到form页面
        if(result.hasErrors())
            return login(model);
        UserInfo userInfo = this.homeService.login(accountUser);
        if(userInfo.isEnable()){
			AuthHelper.setSessionUserAuth(request, userInfo);
			//AuthHelper.setSessionCommunityrAuth(request, userInfo.getCommunity());
		}else{
			//result.addError(new FieldError("contentModel","communityPassword",userInfo.getError()));
			result.addError(new FieldError("contentModel","userPassword",userInfo.getError()));
			return login(model);
		}
        String returnUrl = ServletRequestUtils.getStringParameter(request, "returnUrl", null);
        if(returnUrl==null)
        	returnUrl="/home/index";
    	return "redirect:/home/index"; 	
	}
}  
