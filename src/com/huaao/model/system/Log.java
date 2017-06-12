/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.huaao.model.system;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;


/**
 * 日志Entity
 * @author ThinkGem
 * @version 2014-8-19
 */
public class Log  {

	private static final long serialVersionUID = 1L;
	private String type; 		// 日志类型（1：接入日志；2：错误日志）
	private String title;		// 日志标题
	private String remoteAddr; 	// 操作用户的IP地址
	private String requestUri; 	// 操作的URI
	private String method; 		// 操作的方式
	private String params; 		// 操作提交的数据
	private String userAgent;	// 操作用户代理信息
	private String exception; 	// 异常信息
	
	private Date beginDate;		// 开始日期
	private Date endDate;		// 结束日期
	
	private String createId;
	private String createCellphone;
	private String createName;
	
	private Date createDate;
	
	// 日志类型（1：接入日志；2：错误日志）
	public static final String TYPE_ACCESS = "1";
	public static final String TYPE_EXCEPTION = "2";
	
	public Log(){
		super();
	}
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRemoteAddr() {
		return remoteAddr;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}
	
	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	/**
	 * 设置请求参数
	 * @param paramMap
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setParams(Map paramMap){
		if (paramMap == null){
			return;
		}
		StringBuilder params = new StringBuilder();
		for (Map.Entry<String, String[]> param : ((Map<String, String[]>)paramMap).entrySet()){
			params.append(("".equals(params.toString()) ? "" : "&") + param.getKey() + "=");
			String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
			params.append(StringUtils.endsWithIgnoreCase(param.getKey(), "password") ? "" : paramValue);
		}
		this.params = params.toString();
	}
	
	@Override
	public String toString() {
		return (new ReflectionToStringBuilder(this){
			@Override
			protected boolean accept(Field field) {
				// TODO Auto-generated method stub
				boolean returnFlag = true;
				if(field.getName().equalsIgnoreCase("type")){
					returnFlag = false;
				}else if(field.getName().equalsIgnoreCase("title")){
					returnFlag = false;
				}else if(field.getName().equalsIgnoreCase("userAgent")){
					returnFlag = false;
				}else if(field.getName().equalsIgnoreCase("beginDate")){
					returnFlag = false;
				}else if(field.getName().equalsIgnoreCase("endDate")){
					returnFlag = false;
				}else if(field.getName().equalsIgnoreCase("createDate")){
					returnFlag = false;
				}
				return super.accept(field)&&returnFlag;
			}
		}).toString();
	}


	public String getCreateId() {
		return createId;
	}


	public void setCreateId(String createId) {
		this.createId = createId;
	}


	public String getCreateName() {
		return createName;
	}


	public void setCreateName(String createName) {
		this.createName = createName;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public String getCreateCellphone() {
		return createCellphone;
	}


	public void setCreateCellphone(String createCellphone) {
		this.createCellphone = createCellphone;
	}
}