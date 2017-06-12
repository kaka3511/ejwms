package com.huaao.model.system;

import java.util.List;
/**
 * 菜单
 * @author Administrator
 *
 */
public class Menu {

	private int id;
	private String menuName;
	private String menuImgCls;
	private int menuOrder;
	private int menuParentId;
	private String status;
	private String menuHref;
	private List<Menu> children;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
	public String getMenuImgCls() {
		return menuImgCls;
	}
	public void setMenuImgCls(String menuImgCls) {
		this.menuImgCls = menuImgCls;
	}
	public int getMenuOrder() {
		return menuOrder;
	}
	public void setMenuOrder(int menuOrder) {
		this.menuOrder = menuOrder;
	}
	public int getMenuParentId() {
		return menuParentId;
	}
	public void setMenuParentId(int menuParentId) {
		this.menuParentId = menuParentId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMenuHref() {
		return menuHref;
	}
	public void setMenuHref(String menuHref) {
		this.menuHref = menuHref;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	
}
