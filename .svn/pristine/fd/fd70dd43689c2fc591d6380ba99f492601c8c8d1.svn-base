package com.huaao.common.extension;

import java.text.DecimalFormat;
import org.apache.commons.lang.StringUtils;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class StringUtil extends StringUtils{
	public static boolean isEmpty(String szString ){
		if ( szString == null || szString.equals("") ){
			return true;
		}
		else
			return false;
	}
	public static String doWithNull(String szString){
		if(szString == null)
			return "";
		else return szString;
	}
	
	public static String addSqlSetStr(String szSrc, String szDest ){
		String szReturn = szSrc;
		if ( !isEmpty(szDest) ){
			szReturn = szSrc + ", " + szDest;
		}
		return szReturn;
	}
	
	public static String formatID(int nValue , String szFmt) {
		DecimalFormat df = new DecimalFormat(szFmt);
		String szValue = df.format(nValue);
		return szValue;
	}

	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if( !isNum.matches() )
		{
			return false;
		}
		return true;
	} 
 

	/**
	 * 
	 * @param str ԭ�ַ�
	 * @param sFormat  �����ַ�
	 * @param length  �޶�����
	 * @param buQiType  1���룬0�Ҳ���
	 * @return
	 */
		public static String FormatString(String str, String sFormat, int length,
				int buQiType) {
			int curLength = str.length();
			int cutLength = length - curLength;
			String newString = "";
			for (int i = 0; i < cutLength; i++)
				newString += sFormat;
			if (1 == buQiType) {
				return newString + str;
			} else {
				return str + newString;
			}
		}
		/// 插入SQL时替换字符
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static String Encode(String str)
        {
            str = str.replace("'", "''");
            str = str.replace("\"", "&quot;");
            str = str.replace("<", "&lt;");
            str = str.replace(">", "&gt;");
            str = str.replace("\n", "<br>");
            str = str.replace("“", "&ldquo;");
            str = str.replace("”", "&rdquo;");
            return str;
        }
 
        /// <summary>
        /// 取SQL值时还原字符
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static String Decode(String str)
        {
            str = str.replace("&rdquo;", "”");
            str = str.replace("&ldquo;", "“");
            str = str.replace("<br>", "\n");
            str = str.replace("&gt;", ">");
            str = str.replace("&lt;", "<");
            str = str.replace("&quot;", "\"");
            str = str.replace("''", "'");
            return str;
        }
        
        /**
    	 * 获得用户远程地址
    	 */
    	public static String getRemoteAddr(HttpServletRequest request){
    		String remoteAddr = request.getHeader("X-Real-IP");
            if (isNotBlank(remoteAddr)) {
            	remoteAddr = request.getHeader("X-Forwarded-For");
            }else if (isNotBlank(remoteAddr)) {
            	remoteAddr = request.getHeader("Proxy-Client-IP");
            }else if (isNotBlank(remoteAddr)) {
            	remoteAddr = request.getHeader("WL-Proxy-Client-IP");
            }
            return remoteAddr != null ? remoteAddr : request.getRemoteAddr();
    	}

}

