package com.huaao.model.organization;

import java.util.ArrayList;
import java.util.List;

public class Node {
	/** 
	* @ClassName: Node 
	* @Description: 树节点模型 
	* @author libi
	* @date 2016年6月12日 上午8:24:13 
	*/
	
	private String id;
	private String text;
	private String data;
	private String icon;
	private List<Node> children = new ArrayList<Node>();
	
	
	
	public Node() {
		// TODO Auto-generated constructor stub
	}
	
	public Node(String id, String text, String data, List<Node> children) {
		// TODO Auto-generated constructor stub
		this.id = id;
		this.text = text;
		this.data = data;
		this.children = children;
	}
	
	public Node(Object id, Object text, Object data, List<Node> children) {
		// TODO Auto-generated constructor stub
		this.id = String.valueOf(id);
		this.text = String.valueOf(text);
		this.data = String.valueOf(data);
		this.children = children;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public List<Node> getChildren() {
		return children;
	}

	public void setChildren(List<Node> children) {
		this.children = children;
	}
	
	
	
}
