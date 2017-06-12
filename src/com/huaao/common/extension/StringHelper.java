package com.huaao.common.extension;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * String 工具类
 * @author misswhen
 *
 */
public class StringHelper {

	/**
	 * 将String转换为Integer类型的List
	 * @param str
	 * @param split
	 * @return
	 */
	public final static List<Integer> toIntegerList(String str, String split){
		List<Integer> ret=new ArrayList<Integer>();	
		if(str!=null && !str.isEmpty()){
			String[] strArray=str.split(split);
			
			for(String item : strArray){
				if(!item.isEmpty())
					ret.add(Integer.parseInt(item));
			}
		}
		return ret;	
	}
	
	/**
	 * MD5字符串加密
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public final static String md5(String str) throws NoSuchAlgorithmException {
        final char[] hexDigits={'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};       
        byte[] btInput = str.getBytes();
        // 获得MD5摘要算法的 MessageDigest 对象
        MessageDigest md5Inst = MessageDigest.getInstance("MD5");
        // 使用指定的字节更新摘要
        md5Inst.update(btInput);
        // 获得密文
        byte[] bytes = md5Inst.digest();
        
        StringBuffer strResult=new StringBuffer();
        // 把密文转换成十六进制的字符串形式
        for(int i=0;i<bytes.length;i++){
			strResult.append(hexDigits[(bytes[i]>>4)&0x0f]);
			strResult.append(hexDigits[bytes[i]&0x0f]);
        }
        return strResult.toString();
    }
	
	/**
	 * SHA-1字符串加密
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public final static String sha1(String str) throws NoSuchAlgorithmException{
		final char[] hexDigits={'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
		byte[] btInput = str.getBytes();
		// 获得SHA-1摘要算法的 MessageDigest 对象
        MessageDigest sha1Inst = MessageDigest.getInstance("SHA-1");
        // 使用指定的字节更新摘要
        sha1Inst.update(btInput);
        // 获得密文
        byte[] bytes = sha1Inst.digest();
        
        StringBuffer strResult=new StringBuffer();
        // 把密文转换成十六进制的字符串形式
        for(int i=0;i<bytes.length;i++){
			strResult.append(hexDigits[(bytes[i]>>4)&0x0f]);
			strResult.append(hexDigits[bytes[i]&0x0f]);
        }
        return strResult.toString();
	}
	
	/**
	 * 将Unix时间戳转换为正常时间
	 * @param str
	 * @param split
	 * @return
	 */
	public final static String toGenTime(String timestampString){
		Long timestamp = Long.parseLong(timestampString)*1000;
		String time = new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date(timestamp));
		return time;	
	}
	
	/**
	 * 将Unix时间戳转换为正常时间
	 * @param str
	 * @param split
	 * @return
	 */
	public final static String toGenTime(String timestampString,String format){
		Long timestamp = Long.parseLong(timestampString)*1000;
		String time = new java.text.SimpleDateFormat(format).format(new java.util.Date(timestamp));
		return time;	
	}
	
	/**
	 * 将Unix时间戳转换为正常时间
	 * @param str
	 * @param split
	 * @return
	 * @throws ParseException 
	 */
	public final static String toUnixTime(String time) throws ParseException{
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
		return Long.toString((simpleDateFormat.parse(time)).getTime()/1000);	
	}
	
	/**
	 * 将时间转换成Unix时间
	 * @param time
	 * @param format   时间样式
	 * @return
	 * @throws ParseException
	 */
	public final static String toUnixTime(String time,String format) throws Exception{
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		return Long.toString((simpleDateFormat.parse(time)).getTime()/1000);	
	}
	
	/**
	 * 图片转化成base64字符串 
	 * @param src源图片地址
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
    public static String GetImageStr(String src) throws UnsupportedEncodingException  
    {//将图片文件转化为字节数组字符串，并对其进行Base64编码处理  
        InputStream in = null;  
        byte[] data = null;  
        //读取图片字节数组  
        try   
        {  
            in = new FileInputStream(src);          
            data = new byte[in.available()];  
            in.read(data);  
            in.close();  
        }   
        catch (IOException e)   
        {  
            e.printStackTrace();  
        }  
        //对字节数组Base64编码  
        //BASE64Encoder encoder = new BASE64Encoder();  
        //return encoder.encode(data);//返回Base64编码过的字节数组字符串 
        return new String(data,"UTF-8");
    }  
      
    //
    /**
     * base64字符串转化成图片  
     * @param imgStr   源图片base64字符串
     * @param imgAdr   新生成图片地址
     * @return
     */
    public static boolean GenerateImage(String imgStr,String imgAdr)  
    {   //对字节数组字符串进行Base64解码并生成图片  
        if (imgStr == null) //图像数据为空  
            return false;  
        BASE64Decoder decoder = new BASE64Decoder();  
        try   
        {  
            //Base64解码  
            byte[] b = decoder.decodeBuffer(imgStr);  
            for(int i=0;i<b.length;++i)  
            {  
                if(b[i]<0)  
                {//调整异常数据  
                    b[i]+=256;  
                }  
            }  
            //生成jpeg图片  
            //String imgFilePath = "d://222.jpg";//新生成的图片  
            OutputStream out = new FileOutputStream(imgAdr);      
            out.write(b);  
            out.flush();  
            out.close();  
            return true;  
        }   
        catch (Exception e)   
        {  
            return false;  
        }  
    } 
    
    /**
     * base64字符串转化成图片  
     * @param imgStr   源图片base64字符串
     * @param imgAdr   新生成图片地址
     * @return
     */
	public static void GeneratePic(String imgStr,String filePath) throws Exception  
    {   //对字节数组字符串进行Base64解码并生成图片  
        BASE64Decoder decoder = new BASE64Decoder();  
        //Base64解码  
        byte[] b = decoder.decodeBuffer(imgStr);  
        for(int i=0;i<b.length;++i)  
            {  
                if(b[i]<0)  
                {//调整异常数据  
                    b[i]+=256;  
                }  
            }  
            //生成jpeg图片  
            OutputStream out = new FileOutputStream(filePath);      
            out.write(b);  
            out.flush();  
            out.close();  
    }  
	
	/**
	 * 
	 * @param src
	 * @return
	 * @throws UnsupportedEncodingException
	 */
    public static String GetPicBase64(String src) throws UnsupportedEncodingException  
    {//将图片文件转化为字节数组字符串，并对其进行Base64编码处理  
        InputStream in = null;  
        byte[] data = null;  
        //读取图片字节数组  
        try   
        {  
            in = new FileInputStream(src);          
            data = new byte[in.available()];  
            in.read(data);  
            in.close();  
        }   
        catch (IOException e)   
        {  
            e.printStackTrace();  
        }  
        //对字节数组Base64编码  
        BASE64Encoder encoder = new BASE64Encoder();  
        return encoder.encode(data);//返回Base64编码过的字节数组字符串 
    } 
	
	/**
	 * 下载在线图片
	 * @param urlString
	 * @param filename
	 * @param savePath
	 * @throws Exception
	 */
	public static void downloadPic(String urlString, String filename,String savePath) throws Exception{
		// 构造URL  
        URL url = new URL(urlString);  
        // 打开连接  
        URLConnection con = url.openConnection();  
        //设置请求超时为5s  
        con.setConnectTimeout(5*1000);  
        // 输入流  
        InputStream is = con.getInputStream();  
      
        // 1K的数据缓冲  
        byte[] bs = new byte[1024];  
        // 读取到的数据长度  
        int len;  
        // 输出的文件流  
       File sf=new File(savePath);  
       if(!sf.exists()){  
           sf.mkdirs();  
       }  
       OutputStream os = new FileOutputStream(sf.getPath()+"\\"+filename);  
        // 开始读取  
        while ((len = is.read(bs)) != -1) {  
          os.write(bs, 0, len);  
        }  
        // 完毕，关闭所有链接  
        os.close();  
        is.close();  
	}
	
	/**
	 * 在线图片转换成base64编码
	 * @param urlString
	 * @return 
	 * @throws Exception
	 */
	public static String onlinePicToBase64(String urlString) throws Exception{
		// 构造URL  
        URL url = new URL(urlString);  
        // 打开连接  
        URLConnection con = url.openConnection();  
        //设置请求超时为5s  
        con.setConnectTimeout(5*1000);  
        // 输入流  
        InputStream is = con.getInputStream();  
        byte[] output = steamToByte(is);
        if(is!=null)
        	is.close();  
        //对字节数组Base64编码  
        BASE64Encoder encoder = new BASE64Encoder();  
        return encoder.encode(output);//返回Base64编码过的字节数组字符串 
	}
	
	public static byte[] steamToByte(InputStream input) throws IOException{
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int len = 0;
        byte[] b = new byte[1024];
        while ((len = input.read(b, 0, b.length)) != -1) {                     
            baos.write(b, 0, len);
        }
        byte[] buffer =  baos.toByteArray();
        return buffer;
    }
}
