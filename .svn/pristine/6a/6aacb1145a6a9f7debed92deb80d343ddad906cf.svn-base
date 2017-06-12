package com.huaao.common.extension;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;

import org.apache.http.entity.ContentType;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ListObjectsRequest;
import com.aliyun.oss.model.OSSObjectSummary;
import com.aliyun.oss.model.ObjectListing;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.huaao.model.content.Content;
import com.huaao.model.home.SystemVariable;

/**
 * 阿里云对象存储类
 * @author Administrator
 *
 */
public class OSSUtil {

	/**
	 * OSSClient是OSS服务的Java客户端，它为调用者提供了一系列的方法，用于和OSS服务进行交互
	 * @return
	 */
	public static OSSClient createOSSClient(){
		return new OSSClient(SystemVariable.Endpoint_OSS,SystemVariable.AccessKeyID_OSS, SystemVariable.AccessKeySecret_OSS);
	}
	
	/**
	 * 上传文件
	 * @param file
	 * @param fileName
	 * @return
	 * @throws IOException
	 */
	public static String uploadFile(CommonsMultipartFile file,String fileName) throws IOException{
		OSSClient client = createOSSClient();
		InputStream content = file.getInputStream();			// 获取指定文件的输入流
	    ObjectMetadata meta = new ObjectMetadata();  	
	    meta.setContentType(file.getContentType());// 创建上传Object的Metadata
	    meta.setContentLength(file.getSize());			// 必须设置ContentLength
	    String flag = "";
	    if(client.doesBucketExist(SystemVariable.BucketName_OSS)){
	    	PutObjectResult result = client.putObject(SystemVariable.BucketName_OSS,fileName, content, meta);// // 上传Object.	
	    	flag=result.getETag();
	    }
	    return flag;
	}
	
	public static String uploadFile(BufferedImage im,String fileName,String contentType) throws IOException{
		OSSClient client = createOSSClient();
		 ByteArrayOutputStream os = new ByteArrayOutputStream();
		 ImageIO.write(im, "png", os);
		 byte[] bytes = os.toByteArray();
		 ByteArrayInputStream content = new ByteArrayInputStream(bytes);
	    ObjectMetadata meta = new ObjectMetadata();  	
	    meta.setContentType(contentType);// 创建上传Object的Metadata
	    meta.setContentLength(bytes.length);			// 必须设置ContentLength
	    String flag = "";
	    if(client.doesBucketExist(SystemVariable.BucketName_OSS)){
	    	PutObjectResult result = client.putObject(SystemVariable.BucketName_OSS,fileName, content, meta);// // 上传Object.	
	    	flag=result.getETag();
	    }
	    return flag;
	}
	
	/**
	 * 删除图片
	 * @param key
	 * @throws IOException
	 */
	public static void deleteFile(String key) throws IOException{
		OSSClient client = createOSSClient();
	    client.deleteObject(SystemVariable.BucketName_OSS, key);		// 删除Object
	}
	
	/**
	 * 删除图片
	 * @param key
	 * @throws IOException
	 */
	public static void listObjects() throws IOException{
		OSSClient client = createOSSClient();
		ListObjectsRequest listObjectsRequest = new ListObjectsRequest(SystemVariable.BucketName_OSS);

		// List Objects
		ObjectListing listing = client.listObjects(listObjectsRequest);

		// 遍历所有Object
		System.out.println("Objects:");
		for (OSSObjectSummary objectSummary : listing.getObjectSummaries()) {
		    System.out.println(objectSummary.getKey());
		}
	}
}
