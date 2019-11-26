package com.qrhf.vo;

import java.util.List;

import com.qrhf.tools.Trees;

public class Node {
	
	private String id;
	
	private String text;
	
	private String parentId;
	
	private String grade; 
	
	private Trees state;
	
	private List<Node> nodes;

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public List<Node> getNodes() {
		return nodes;
	}

	public void setNodes(List<Node> nodes) {
		this.nodes = nodes;
	}

	public Trees getState() {
		return state;
	}

	public void setState(Trees state) {
		this.state = state;
	}

}
