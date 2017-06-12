package com.huaao.common.extension;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTimeUtil {
	
	public static final int YEAR = 0;
	public static final int MONTH = 1;
	public static final int DAY = 2;
	public static final int SEC = 5;
	public static final int TIME_MIN = 3;
	public static final int TIME_SEC = 4;
	
	public static String getCurrentDate(String format){
		return new SimpleDateFormat(format).format(new Date());
	}
	
	public static String getAppNow(){
		Calendar now = Calendar.getInstance();
		return formatNow( now );
	}
	
	public static String formatNow(Calendar ObjDate){
		String szDate = "";
		
		szDate = szDate + ObjDate.get(Calendar.YEAR);
		
		DecimalFormat df = new DecimalFormat("00");
		  
		String szTemp = df.format(ObjDate.get(Calendar.MONTH) + 1);
		  
		szDate = szDate + "-" + szTemp;
		
		szTemp = df.format(ObjDate.get(Calendar.DATE));
			
		szDate = szDate + "-" + szTemp;
		
		szTemp = df.format(ObjDate.get(Calendar.HOUR_OF_DAY));
		
		szDate = szDate + " " + szTemp;
		
		szTemp = df.format(ObjDate.get(Calendar.MINUTE));
		
		szDate = szDate + ":" + szTemp;
		
		szTemp = df.format(ObjDate.get(Calendar.SECOND));
		
		szDate = szDate + ":" + szTemp;
		return szDate;
	}
	
	public static String getYYYYMMDDHHMMSS(){
		Calendar now = Calendar.getInstance();
		String szDate = "";		
		szDate = szDate + now.get(Calendar.YEAR);		
		DecimalFormat df = new DecimalFormat("00");	  
		String szTemp = df.format(now.get(Calendar.MONTH) + 1);		  
		szDate = szDate + szTemp;		
		szTemp = df.format(now.get(Calendar.DATE));			
		szDate = szDate + szTemp;		
		szTemp = df.format(now.get(Calendar.HOUR_OF_DAY));		
		szDate = szDate + szTemp;		
		szTemp = df.format(now.get(Calendar.MINUTE));		
		szDate = szDate + szTemp;		
		szTemp = df.format(now.get(Calendar.SECOND));		
		szDate = szDate + szTemp;
		return szDate;
	}
	
	public static String getNow() throws Exception {
		return getServerNow();
	}
	
	public static String getNow(int nType) throws Exception{
		
		String szNow = getServerNow();
		switch( nType ){
			case YEAR:
				return szNow.substring(0,4);
			case MONTH:
				return szNow.substring(0,7);
			case DAY:
				return szNow.substring(0,10);
			case TIME_MIN:
				return szNow.substring(11,16);
			case TIME_SEC:
				return szNow.substring(11,19);
			case SEC:
				return szNow;
			default:
				return szNow;	
		}
	}
	public static String getDateFromObject(Object object){
		String result="";
		if(object!=null){
			String time=object.toString();
			if(time.length()==13){
				time=time.substring(0,10);
			}
			result = StringHelper.toGenTime(time, "yyyy-MM-dd HH:mm:ss");
		}
		return result;
	}
	//@SuppressWarnings("finally")
	public static String getServerNow( ) throws Exception{
		return getAppNow();
		/*
		String szNow = "";
		DoradoDBManager dbManager = new DoradoDBManager();
		
		try{
			// get server type from db setup		
			String szServerType =
				SysFuncManager.getSysParameter("SYS_DBSERVER_TYPE", dbManager );		
			
			if ( StringUtil.isEmpty(szServerType) )
				szServerType = "";
			
			if ( szServerType.length() > 3 )
				szServerType = szServerType.substring(0, 3);
			
			String szSql = "";
			ResultSet rs;
			if ( szServerType.equalsIgnoreCase("ORA") ){
				szSql = "select to_char(sysdate,'YYYY'||'-'||'MM'||" +
						"'-'||'DD HH24:MI:SS') from dual ";
				rs = dbManager.executeQuery(szSql);
				if ( rs.next() )
					szNow = rs.getString( 1 );
				rs.close();
				
			}else if (szServerType.equalsIgnoreCase("SYB") || szServerType.equalsIgnoreCase("SQL")){
				szSql = "select max(getdate()) from user_file";
				rs = dbManager.executeQuery(szSql);
				Date t = new Date(0);
				if ( rs.next() )
					t = rs.getDate(1);
				rs.close();
				Calendar now = Calendar.getInstance();
				now.setTime(t);
				szNow = formatNow( now );
			}else{
				szNow = getAppNow();
			}
		}catch( Exception e ){
			szNow = "";
			throw e;
		}finally{
			dbManager.close();
			return szNow;
		}		
		*/
	}
	
	public static String formatDateTime(long timeMillis){
		long day = timeMillis/(24*60*60*1000);
		long hour = (timeMillis/(60*60*1000)-day*24);
		long min = ((timeMillis/(60*1000))-day*24*60-hour*60);
		long s = (timeMillis/1000-day*24*60*60-hour*60*60-min*60);
		long sss = (timeMillis-day*24*60*60*1000-hour*60*60*1000-min*60*1000-s*1000);
		return (day>0?day+",":"")+hour+":"+min+":"+s+"."+sss;
    }

}
