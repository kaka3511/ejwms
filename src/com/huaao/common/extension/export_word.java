package com.huaao.common.extension;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class export_word {
	private Configuration configuration = null;

	public export_word() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("utf-8");
	}

	public File createDoc(Map<String, Object> map,String filePath,String Filename,String spth,String spthName) throws Exception { // 要填入模本的数据文件
//		Map dataMap = new HashMap();
		// getData(dataMap,dlb);
		// //设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
		// 这里我们的模板是放在com.cist.bayonet.mainstat.service.impl包下面
//		setClassForTemplateLoading(this.getClass(), "/");
		configuration.setDirectoryForTemplateLoading(new File(filePath+"/"));
		Template t = null;
		try { // sgxxb_info.ftl为要装载的模板
			t = configuration.getTemplate(Filename);
		} catch (IOException e) {
			e.printStackTrace();
		} // 输出文档路径及名称
		File outFile = new File(spth+"/"+spthName+".doc");
		Writer out = null;
		try {
			FileOutputStream fos = new FileOutputStream(outFile);
			OutputStreamWriter oWriter = new OutputStreamWriter(fos, "UTF-8");// 这个地方对流的编码不可或缺，
			// 使用main（）单独调用时，应该可以，但是如果是web请求导出时导出后word文档就会打不开，并且包XML文件错误。主要是编码格式不正确，无法解析。
			out = new BufferedWriter(oWriter);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			t.process(map, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return outFile;
	}


	public static void main(String args[]) {
		export_word word = new export_word();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("Patient", "张三");
		map.put("Gender", "男");
		map.put("Identity", "421081199812085612");
		map.put("PresentAddress", "现住址");
		map.put("IdentityAdderss", "户籍地详址");
		map.put("yibaoHao", "否");
		map.put("dibaohao", "否");
		map.put("jName", "监护人Name");
		map.put("jhGen", "男");
		map.put("jIdentity", "421081199812085612");
		map.put("adderss", "住址");
		map.put("cellPhone", "1550000000");
		map.put("TextCoent", "这里是申请人的意见");
		map.put("jNametow", "监护人Name");
		map.put("time", "2016年9月1日");
		map.put("yijian", "我是社区意见");
		map.put("qungan", "社区签名");
		map.put("guanganTime", "2016年9月1日");
		map.put("paichusuo", "派出所无任何意见");
		map.put("mingjing", "监护人Name");
		map.put("jcTime", "2016年9月1日");
		map.put("gonganfenju", "区公安无任何意见");
		map.put("mingjing", "监护人Name");
		map.put("mingjingTime", "2016年9月1日");
//		try {
////			word.createDoc(map,"D:/win7我的文档-桌面-收藏夹/Desktop/文件备份");
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
	}

}
