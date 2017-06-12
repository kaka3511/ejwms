/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.huaao.common.extension;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.DispatcherServlet;

import com.huaao.model.home.UserInfo;
import com.huaao.model.system.Log;
import com.huaao.service.system.LogService;
import com.huaao.web.home.AuthHelper;


public class LogUtils {
	
	private static LogService logDao = ContextLoader.getCurrentWebApplicationContext().getBean(LogService.class);
	private static Logger logger = Logger.getLogger(LogUtils.class);
	private static Properties logMapping = null;
	/**
	 * 保存日志
	 */
	
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, Object handler, Exception ex, String title){
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		if(logMapping==null){
			logMapping = new Properties();
			DefaultResourceLoader resourceLoader = new DefaultResourceLoader();
			Resource logMappingResource = resourceLoader.getResource("classpath:logMapping.properties");
			try {
				logMapping.load(logMappingResource.getInputStream());
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}
		
		UserInfo user = AuthHelper.getSessionUserAuth(request);
		if (user != null){
			Log log = new Log();
			log.setTitle(title);
			log.setType(ex == null ? Log.TYPE_ACCESS : Log.TYPE_EXCEPTION);
			log.setRemoteAddr(StringUtil.getRemoteAddr(request));
			log.setUserAgent(request.getHeader("user-agent"));
			
			String reqName = null;
			RequestMapping methodAnotation = handlerMethod.getMethodAnnotation(RequestMapping.class);
			RequestMapping beanAnotation = handlerMethod.getBeanType().getAnnotation(RequestMapping.class);
			String[] beanURIArr = beanAnotation.value();
			String[] requestURIArr = methodAnotation.value();
			for (String beanURI : beanURIArr) {
				for (String requestURI : requestURIArr) {
					reqName = logMapping.getProperty(beanURI+requestURI);
					if(reqName!=null)break;
				}
			}
			if(reqName==null)return;
			
			log.setRequestUri(reqName);
			
			
			
			log.setParams(request.getParameterMap());
			log.setMethod(request.getMethod());
			log.setCreateId(String.valueOf(user.getId()));
			log.setCreateCellphone(user.getCellphone());
			log.setCreateName(user.getName());
			log.setCreateDate(new Date());
			logger.info(log.toString());
			// 异步保存日志
			new SaveLogThread(log, handler, ex).start();
		}
	}
	
	public static void saveLog(HttpServletRequest request, String title){
		
		UserInfo user = AuthHelper.getSessionUserAuth(request);
		if (user != null){
			Log log = new Log();
			log.setTitle(title);
			log.setType( Log.TYPE_ACCESS );
			log.setRemoteAddr(StringUtil.getRemoteAddr(request));
			log.setUserAgent(request.getHeader("user-agent"));
			
			
			log.setRequestUri(request.getRequestURI());
			
			
			
			log.setParams(request.getParameterMap());
			log.setMethod(request.getMethod());
			log.setCreateId(String.valueOf(user.getId()));
			log.setCreateCellphone(user.getCellphone());
			log.setCreateName(user.getName());
			log.setCreateDate(new Date());
			logger.info(log.toString());
			logDao.insert(Integer.parseInt(log.getType()), log.getTitle(), log.getCreateId(), log.getCreateCellphone(), log.getCreateName(), log.getCreateDate(), log.getRemoteAddr(), log.getUserAgent(), log.getRequestUri(), log.getMethod(), log.getParams(), log.getException());
		}
	}

	/**
	 * 保存日志线程
	 */
	public static class SaveLogThread extends Thread{
		
		private Log log;
		private Object handler;
		private Exception ex;
		
		public SaveLogThread(Log log, Object handler, Exception ex){
			super(SaveLogThread.class.getSimpleName());
			this.log = log;
			this.handler = handler;
			this.ex = ex;
		}
		@Override
		public void run() {
			// 获取日志标题
			// 如果有异常，设置异常信息
			log.setException(Exceptions.getStackTraceAsString(ex));
			// 如果无标题并无异常日志，则不保存信息
			/*if (StringUtils.isBlank(log.getTitle()) && StringUtils.isBlank(log.getException())){
				return;
			}*/
			// 保存日志信息
			
			logDao.insert(1, "", log.getCreateId(), log.getCreateCellphone(), log.getCreateName(), log.getCreateDate(), log.getRemoteAddr(), log.getUserAgent(), log.getRequestUri(), log.getMethod(), log.getParams(), log.getException());
		}
	}


	
}
