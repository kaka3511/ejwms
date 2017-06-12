/**
 * 
 */
package com.huaao.web.goods;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.huaao.common.extension.LogUtils;
import com.huaao.common.extension.OSSUtil;
import com.huaao.common.extension.RespCode;
import com.huaao.common.extension.RespInfo;
import com.huaao.common.utilities.Page;
import com.huaao.common.utilities.PramaStrHelper;
import com.huaao.common.utilities.TwoDimensionCode;
import com.huaao.dao.base.BaseDao;
import com.huaao.model.business.AuditRecord;
import com.huaao.model.content.Content;
import com.huaao.model.home.AuthPassport;
import com.huaao.model.home.SystemVariable;
import com.huaao.model.home.UserInfo;
import com.huaao.service.content.ContentService;
import com.huaao.service.goods.GoodsSaleService;
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
@Controller@RequestMapping("/goodsSale")
public class GoodsSaleController {

	
	@Autowired
	private GoodsSaleService goodsSaleService;
	
	@AuthPassport@RequestMapping("/index")
	public String index(HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("menuSession","YES");
		return "goods/goodsSale/index";
	}
	
	@AuthPassport@RequestMapping("/view")
	public String audit(String oper,int id,HttpServletRequest request){
		SqlRowSet goods = goodsSaleService.queryWith(id);
		request.setAttribute("goods", goods);
		
		return "goods/goodsSale/audit";
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
				PramaStrHelper.pramaStrMap.put("goodSalePramaStrMap", pager.getPramaStr());
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("goodSalePramaStrMap"));
			}
			else
				pager.setPramaStr(PramaStrHelper.pramaStrMap.get("goodSalePramaStrMap"));
		}
		HashMap<String, Object> map=new HashMap<String, Object>();
		goodsSaleService.queryForGoodSaleListPage(cuser.getCommunityId(),pager);
		map.put("records", pager.getTotalRows());
		map.put("pages", pager.getTotalPages());
		map.put("rows", pager.getResultList());
		respInfo.setData(map);
		return respInfo;
	}
	
	//更新表状态
	@AuthPassport@RequestMapping("/auditing")
	@ResponseBody
	public RespInfo  auditing(int applyId, boolean reject,HttpServletRequest request) throws ParseException{
		UserInfo cuser = AuthHelper.getSessionUserAuth(request);
		RespInfo resp = new RespInfo(RespCode.Success.code, "");
		
		SqlRowSet apply = goodsSaleService.queryWith(applyId);
		apply.next();
		
		int status = reject?3:2;
		int count = goodsSaleService.updateStatus(new Object[]{status,applyId,1});
		LogUtils.saveLog(request, "爱心义卖-审核");
		if(count>0){
			//获取上一条审核记录
			Map preRecord = goodsSaleService.queryPreAuditRecord(applyId);
			Integer preId = preRecord==null?null:(Integer)preRecord.get("id");
			
			//插入新的审核记录
			AuditRecord auditRecord = new AuditRecord();
			auditRecord.setApplyId(applyId);
			auditRecord.setType(3);//爱心义卖
			auditRecord.setAudit(cuser.getName());
			auditRecord.setStatus(status);
			auditRecord.setAuditDate(new Date().getTime()/1000);
			auditRecord.setCommunityId(cuser.getCommunityId());
			auditRecord.setPreId(preId);
			
			goodsSaleService.insertAuditRecord(new Object[]{auditRecord.getCommunityId(),auditRecord.getType(),auditRecord.getApplyId(),auditRecord.getAudit(),auditRecord.getStatus(),auditRecord.getAuditDate(),auditRecord.getRemark(),auditRecord.getPreId()});
			
		}
		
		
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
            String fileName = "G_"+DateTimeUtil.getCurrentDate("yyyyMMddHHmmssSSS")+"."+prefix;
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
}
