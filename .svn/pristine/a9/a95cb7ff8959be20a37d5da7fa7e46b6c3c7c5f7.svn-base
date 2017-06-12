/**
 * 
 */
package com.huaao.web.business;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.business.PupilService;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

/** 
* @ClassName: ContentController 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月8日 下午3:43:41 
* 
* 
*/
@Controller@RequestMapping("/pupil")
public class PupilController {

	
	@Autowired
	private PupilService pupilService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(){
		return "business/pupil/index";
	}
	@AuthPassport@RequestMapping("/publish")
	public String publish(){
		return "business/pupil/publish";
	}
	
	@AuthPassport@RequestMapping("/edit/{id}")
	public String edit(@PathVariable Integer id,HttpServletRequest request){
		
		SqlRowSet content = pupilService.queryWith(id);
		request.setAttribute("id", id);
		request.setAttribute("business", content);
		return "business/pupil/edit";
	}
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		List  list = pupilService.queryForList(cuser.getCommunityId());
		resp.setData(list);
		return resp;
	}
	
	@AuthPassport@RequestMapping("/add")
	@ResponseBody
	public RespInfo  add(HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		

		String head_img=request.getParameter("head_img");
		String keeperid= String.valueOf(cuser.getId());
		String name=request.getParameter("name");
		String score=StringUtils.isEmpty(request.getParameter("score"))?null:request.getParameter("score");
		String cellphone=request.getParameter("cellphone");
		String idcard=request.getParameter("idcard");
		String type=request.getParameter("type");
		String illness=request.getParameter("illness");
		String gender=request.getParameter("gender");
		String age=StringUtils.isEmpty(request.getParameter("age"))?null:request.getParameter("age");
		String communityid= cuser.getCommunityId()+"";
		String curaddr=request.getParameter("curaddr");
		String addr=request.getParameter("addr");
		String nums=request.getParameter("nums");
		
//		String imgs1=request.getParameter("idcard_img1")==null?"":request.getParameter("idcard_img1");
//		String imgs2=request.getParameter("idcard_img2")==null?"":request.getParameter("idcard_img2");
//		String imgs3=request.getParameter("idcard_img3")==null?"":request.getParameter("idcard_img3");
		
		String imgs = request.getParameter("imgs")==null?"":request.getParameter("imgs");
		pupilService.insert(head_img,keeperid,name,score,cellphone,idcard,type,illness,gender,age,communityid,curaddr,addr,imgs,nums);
		
		return resp;
	}
	@AuthPassport@RequestMapping("/update")
	@ResponseBody
	public RespInfo  update(HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		String id=request.getParameter("id");
		String head_img=request.getParameter("head_img");
		String name=request.getParameter("name");
		String score=request.getParameter("score");
		String cellphone=request.getParameter("cellphone");
		String idcard=request.getParameter("idcard");
		String type=request.getParameter("type");
		String illness=request.getParameter("illness");
		String gender=request.getParameter("gender");
		String age=request.getParameter("age");
		String curaddr=request.getParameter("curaddr");
		String addr=request.getParameter("addr");
		String imgs1=request.getParameter("idcard_img1")==null?"":request.getParameter("idcard_img1");
		String imgs2=request.getParameter("idcard_img2")==null?"":request.getParameter("idcard_img2");
		String imgs3=request.getParameter("idcard_img3")==null?"":request.getParameter("idcard_img3");
		
		String imgs = imgs1+","+imgs2+","+imgs3;
		String nums=request.getParameter("nums");
		
		pupilService.update(head_img,name,score,cellphone,idcard,type,illness,gender,age,curaddr,addr,imgs,nums,id);
		return resp;
	}
	
	@AuthPassport@RequestMapping("/del/{id}")
	@ResponseBody
	public RespInfo  del(@PathVariable Integer id){
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		pupilService.del(new Object[]{id});
		resp.setData(id);
		return resp;
	}
	
	/**
	 * 图片上传
	 * @throws IOException 
	 */
	@AuthPassport
    @RequestMapping(value = "/uploadImg", method = {RequestMethod.POST})
	public void uploadImg(@RequestParam(value = "file") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws IOException{
		UserInfo user =AuthHelper.getSessionUserAuth(request);
		String img ="";
		String flag = "";
		JSONObject jo = new JSONObject();
    	if (!file.isEmpty()) {
    		String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "Mg_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
    		flag = OSSUtil.uploadFile(file, fileName);
    	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
		}
    	jo.element("flag", flag);
    	jo.element("img", img);
    	response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jo);
		pw.flush();
    }
	
	/**
	 * 图片上传
	 * @throws IOException 
	 */
    @AuthPassport@RequestMapping(value = "/uploadImgJson", method = {RequestMethod.POST})
	@ResponseBody
	public HashMap<String, Object> uploadImgJson(@RequestParam(value = "file[]") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws IOException{
		UserInfo user =AuthHelper.getSessionUserAuth(request);
		String img ="";
		String flag = "";
    	if (!file.isEmpty()) {
    		String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "Mg_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
    		flag = OSSUtil.uploadFile(file, fileName);
    	    img = "http://"+SystemVariable.DomainName_OSS+"/"+fileName;
		}
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	
    	ArrayList<HashMap<String, String>> files = new ArrayList<HashMap<String, String>>();
    	HashMap<String, String> item = new HashMap<String, String>(); 
    	
    	item.put("thumbnailUrl", img);
    	item.put("url", img);
    	item.put("name", file.getOriginalFilename());
    	item.put("size", file.getSize()+"");
    	item.put("deleteUrl", "local");
    	
    	files.add(item);
    	map.put("files", files);
    	
    	return map;
    }
}
