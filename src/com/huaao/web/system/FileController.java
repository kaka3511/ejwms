package com.huaao.web.system;

import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DefaultFileItem;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemHeaders;
import org.apache.commons.lang.StringUtils;
import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Rotation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.huaao.common.extension.DateTimeUtil;
import com.huaao.common.extension.OSSUtil;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.web.home.AuthHelper;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("file")
public class FileController {

	
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
    		String originalName = file.getOriginalFilename();
    		String fileName = "nanhu/images/"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+originalName.substring(originalName.indexOf("."));
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
            String fileName = "C_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
    		String rotateParam = request.getParameter("rotate");
    		if(StringUtils.isNotEmpty(rotateParam)){
    			BufferedImage im = ImageIO.read(file.getInputStream());
	       		 double rotate = Double.parseDouble(rotateParam);
	       		 int x =(int)Math.round(Double.parseDouble(request.getParameter("x")));
	       		 int y = (int)Math.round(Double.parseDouble(request.getParameter("y")));
	       		 int width = (int)Math.round(Double.parseDouble(request.getParameter("width")));
	       		 int height = (int)Math.round(Double.parseDouble(request.getParameter("height")));
	       		 if(rotate>0){
	       			 im = Scalr.rotate(im, Rotation.CW_90);
	       		 }
	       		 im = Scalr.crop(im, x, y, width, height);
	       		 flag = OSSUtil.uploadFile(im, fileName, file.getContentType());
    		}else{
    			flag = OSSUtil.uploadFile(file, fileName);
    		}
    		
    		
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
