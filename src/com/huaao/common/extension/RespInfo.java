/**
 * 
 */
package com.huaao.common.extension;

/** 
* @ClassName: RespInfo 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月4日 下午3:55:13 
* 
* 
*/
public class RespInfo {

	private int code;
	private String message;
	private Object data;
	/**
	 * @param code
	 * @param message
	 */
	public RespInfo(int code, String message) {
		super();
		this.code = code;
		this.message = message;
	}
	/**
	 * @param code
	 * @param message
	 * @param data
	 */
	public RespInfo(int code, String message, Object data) {
		this(code, message);
		this.data = data;
	}
	/**
	 * @return the code
	 */
	public int getCode() {
		return code;
	}
	/**
	 * @param code the code to set
	 */
	public void setCode(int code) {
		this.code = code;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the data
	 */
	public Object getData() {
		return data;
	}
	/**
	 * @param data the data to set
	 */
	public void setData(Object data) {
		this.data = data;
	}
}
