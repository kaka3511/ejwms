package com.huaao.model.home;

/**
 * 接口返回pojo
 * @author du
 *
 */
public class ResponseResult {

	private int code;			  //结果编码 0为成功其余为失败
	private String message ;      //错误信息
	private Object data;		  		//结果
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
