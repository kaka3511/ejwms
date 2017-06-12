package com.huaao.model.system;

import java.util.List;
/**
 * 组织
 * @author Administrator
 *
 */
public class Subject {
 
	private int xh;
	private int id;
	private String name;
	private String img;
	private String subject_order;
	private int parent_id;
	private int dept_id;
	private int createtime;
	private String cuser;
	private int status;
	private String dept_type_no;
	public int getXh() {
		return xh;
	}
	public void setXh(int xh) {
		this.xh = xh;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSubject_order() {
		return subject_order;
	}
	public void setSubject_order(String subject_order) {
		this.subject_order = subject_order;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public int getDept_id() {
		return dept_id;
	}
	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}
	public int getCreatetime() {
		return createtime;
	}
	public void setCreatetime(int createtime) {
		this.createtime = createtime;
	}
	public String getCuser() {
		return cuser;
	}
	public void setCuser(String cuser) {
		this.cuser = cuser;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDept_type_no() {
		return dept_type_no;
	}
	public void setDept_type_no(String dept_type_no) {
		this.dept_type_no = dept_type_no;
	}
	
}
