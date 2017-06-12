package com.huaao.model.system;

import java.util.Date;

/**
 * 角色类
 * @author Zhangyu
 * @date 2016/08/23 14:12
 */
public class Role {

	private int role_id;
	private String role_code;
	private String role_name;
	private int is_valid;
	private int cuser;
	private long createtime;
	private String description;
	
	public int getRole_id() {
		return role_id;
	}
	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}
	public String getRole_code() {
		return role_code;
	}
	public void setRole_code(String role_code) {
		this.role_code = role_code;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	public int getIs_valid() {
		return is_valid;
	}
	public void setIs_valid(int is_valid) {
		this.is_valid = is_valid;
	}
	public int getCuser() {
		return cuser;
	}
	public void setCuser(int cuser) {
		this.cuser = cuser;
	}
	public long getCreatetime() {
		return createtime;
	}
	public void setCreatetime(long createtime) {
		this.createtime = createtime;
	}
	public Role() {
		super();
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Role(int role_id, String role_code, String role_name, int is_valid, int cuser, long createtime,
			String description) {
		super();
		this.role_id = role_id;
		this.role_code = role_code;
		this.role_name = role_name;
		this.is_valid = is_valid;
		this.cuser = cuser;
		this.createtime = createtime;
		this.description = description;
	}

	
	
	
}
