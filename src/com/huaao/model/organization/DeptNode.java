package com.huaao.model.organization;

import java.util.List;
/**
 * 菜单
 * @author Administrator
 *
 */
public class DeptNode {

	private int id;
	private String text;
	private String icon;
	private int role;
	private int code;
	private int communityid;
	private List<DeptNode> children;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public int getCommunityid() {
		return communityid;
	}
	public void setCommunityid(int communityid) {
		this.communityid = communityid;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<DeptNode> getChildren() {
		return children;
	}
	public void setChildren(List<DeptNode> children) {
		this.children = children;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	
}