/**
 * 
 */
package com.huaao.web.goods;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.common.utilities.Page;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.common.utilities.TwoDimensionCode;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.content.Content;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.content.ContentService;
import com.huaao.service.goods.MallService;
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
@Controller@RequestMapping("/mall")
public class MallController {

	
	@Autowired
	private MallService mallService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("menuSession","YES");
		return "goods/mall/index";
	}
	@AuthPassport@RequestMapping("/publish")
	public String publish(){
		return "goods/mall/publish";
	}
	
	@AuthPassport@RequestMapping("/edit/{id}")
	public String edit(@PathVariable Integer id,HttpServletRequest request){
		
		SqlRowSet content = mallService.queryWith(id);
		request.setAttribute("id", id);
		request.setAttribute("goods", content);
		return "goods/mall/edit";
	}
	@AuthPassport@RequestMapping("/list")
	@ResponseBody
	public RespInfo  list(HttpServletRequest request){
		RespInfo respInfo = new RespInfo(RespCode.Success.code, "");
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		Page pager = new Page(request);
		HttpSession session = request.getSession(true);
		String o= (String) session.getAttribute("menuSession");
		if(o.equals("YES")){
			PramaStrHelper.removeAllPramaStrMap();
			session.setAttribute("menuSession","NO");
		}
		else{
			session.setAttribute("menuSession","NO");
			if(pager.getPramaStr() != null){
				PramaStrHelper.pramaStrMap.put("mallPramaStrMap", pager.getPramaStr());
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("mallPramaStrMap"));
			}
			else
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("mallPramaStrMap"));
		}
		HashMap<String, Object> map=new HashMap<String, Object>();
		mallService.queryForMallListPage(cuser.getCommunityId(),pager);
		map.put("records", pager.getTotalRows());
		map.put("pages", pager.getTotalPages());
		map.put("rows", pager.getResultList());
		respInfo.setData(map);
		return respInfo;
	}
	
	@AuthPassport@RequestMapping("/add")
	@ResponseBody
	public RespInfo  add(HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		Integer points = Integer.parseInt(request.getParameter("points"));
		Integer stocks = Integer.parseInt(request.getParameter("stocks"));
		Integer sortby = Integer.parseInt(request.getParameter("sortby"));
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		String inform = request.getParameter("inform");
		String image = request.getParameter("image");
		
		mallService.insert(new Object[]{cuser.getCommunityId(),points,name,description,image,cuser.getId(),inform,stocks,sortby});
		LogUtils.saveLog(request, "积分商品-发布商品");
		return resp;
	}
	@AuthPassport@RequestMapping("/update")
	@ResponseBody
	public RespInfo  update(HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		Integer id = Integer.parseInt(request.getParameter("id"));
		Integer points = Integer.parseInt(request.getParameter("points"));
		Integer stocks = Integer.parseInt(request.getParameter("stocks"));
		Integer sortby = Integer.parseInt(request.getParameter("sortby"));
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		String image = request.getParameter("image");
		String inform = request.getParameter("inform");
		//Integer status = Integer.parseInt(request.getParameter("status"));
		
		//mallService.update(new Object[]{points,name,description,image,inform,id,stocks,sortby});
		mallService.updateNew(points,name,description,image,inform,id,stocks,sortby);
		LogUtils.saveLog(request, "积分商品-修改商品");
		return resp;
	}
	
	@AuthPassport@RequestMapping("/del/{id}")
	@ResponseBody
	public RespInfo  del(@PathVariable Integer id,HttpServletRequest request){
		
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		mallService.del(new Object[]{id});
		LogUtils.saveLog(request, "积分商品-删除商品");
		resp.setData(id);
		return resp;
	}
	
	/**
	 * 图片上传
	 * @throws IOException 
	 */
    @AuthPassport@RequestMapping(value = "/uploadImg", method = {RequestMethod.POST})
	public void uploadImg(@RequestParam(value = "file") CommonsMultipartFile file,HttpServletRequest request,HttpServletResponse response) throws IOException{
		UserInfo user =AuthHelper.getSessionUserAuth(request);
		String img ="";
		String flag = "";
		JSONObject jo = new JSONObject();
    	if (!file.isEmpty()) {
    		String pathName=file.getFileItem().getName();
            String prefix=pathName.substring(pathName.lastIndexOf(".")+1);
            String fileName = "Q_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
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
	//下载慈善活动的二维码
	/*@AuthPassport@RequestMapping("/downloadQRCode/{id}")
	public void downloadQRCode(@PathVariable int id,HttpServletResponse resp) throws IOException{
		
		TwoDimensionCode qrCode = new TwoDimensionCode();
		resp.setContentType(ContentType.APPLICATION_OCTET_STREAM.getMimeType());
		resp.setHeader("Content-disposition", "attachment; filename=qrCode.png");
		qrCode.encoderQRCode(id+"", resp.getOutputStream());
		
		
	}*/
    
    @AuthPassport
   	@RequestMapping("/downloadQRCode/{id}/{name}.png")
   	public void downloadQRCode(@PathVariable int id, @PathVariable String name, HttpServletResponse resp) throws IOException {
   		String pName = name.substring(0,name.lastIndexOf("-"));

   		TwoDimensionCode qrCode = new TwoDimensionCode();
   		ByteArrayOutputStream outByteArr = new ByteArrayOutputStream();
   		qrCode.encoderQRCode(id + "", pName, outByteArr, "png", 1);
   		resp.setHeader("Content-Disposition","form-data; name=\"attachment\"; filename=\""+URLEncoder.encode(name,"utf-8")+".png\"");
//   		resp.setHeader("Content-Disposition","form-data; name=\"attachment\"; filename=\"bbb.png\"");
   		resp.setHeader("Content-Type",MediaType.APPLICATION_OCTET_STREAM_VALUE);
//   		resp.setHeader("Content-Length",outByteArr.toByteArray().length+"");
   		ServletOutputStream outputStream = resp.getOutputStream();
   		outputStream.write(outByteArr.toByteArray());
//   		outputStream.flush();


   	}
}
