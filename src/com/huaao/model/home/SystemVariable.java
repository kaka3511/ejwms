package com.huaao.model.home;

import com.aliyun.oss.OSSClient;

/**
 * 系统变量
 * @author du
 *
 */
public class SystemVariable {

	/**
	 * 开放存储（阿里云OSS，含CDN服务）
	 */
	public static final String BucketName_OSS = "huaao2016";
	public static final String AccessKeyID_OSS = "Q9rw7HZreYDkbRs6";
	public static final String AccessKeySecret_OSS = "P0Kdn2bvG8x3mg7eM1YEvinmSCB0fk";
	public static final String Endpoint_OSS = "http://oss-cn-hangzhou.aliyuncs.com";
	public static final String EndpointIntranet_OSS = "http://oss-cn-hangzhou-internal.aliyuncs.com";   //内网
	public static final String DomainName_OSS = "huaao2016.oss-cn-hangzhou.aliyuncs.com";          //域名绑定
	
	public static OSSClient createOSSClient(){
		return new OSSClient(Endpoint_OSS,AccessKeyID_OSS, AccessKeySecret_OSS);
	}
	
}
