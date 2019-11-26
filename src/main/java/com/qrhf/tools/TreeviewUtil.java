package com.qrhf.tools;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.qrhf.vo.Node;

import net.sf.json.JSONObject;

public class TreeviewUtil {
	/**
	 * 把list转化为bootstrap-view所需的JSON字符串
	 * 
	 * @param List<Node>
	 *            list
	 */
	public static JSONObject conversionDataFromList(List<Node> list) {
		JSONObject obj = new JSONObject();
		obj.put("id", "-1");
		obj.put("text", "无数据");
		Node root = null; // 根节点
		if (list != null && list.size() != 0) {
			LinkedHashMap <String, Node> nodeMap = new LinkedHashMap <String, Node>();// 节点树，用于临时存放节点
			for (Node node : list) {// 把node放到map中以便获取node并设置子节点
				if (node.getParentId() == null || node.getParentId().equals("")) {
					root = node;
				}
				nodeMap.put(node.getId(), node);
			}
			if (root != null) {
				// 构造无序的多叉树
				Set entrySet = nodeMap.entrySet();
				List<Node> nodes;
				for (Iterator it = entrySet.iterator(); it.hasNext();) {
					Node node = (Node) ((Map.Entry) it.next()).getValue();
					if (node.getParentId() != null && !node.getParentId().equals("")) {
						if (((Node) nodeMap.get(node.getParentId())) != null) {
							if (((Node) nodeMap.get(node.getParentId())).getNodes() == null) {
								nodes = new ArrayList<Node>();
								((Node) nodeMap.get(node.getParentId())).setNodes(nodes);
							}
							((Node) nodeMap.get(node.getParentId())).getNodes().add(node);
						}
					}
				}
				return JSONObject.fromObject(JSONObject.fromObject(JSONObject.fromObject(root).toString().replaceAll("\"nodes\":\\[\\],", "")).toString().replaceAll(",\"state\":null",""));
			}
		}
		
		return obj;
	}

	/**
	 * 没有根节点的树
	 * 
	 * @param list
	 * @param treeName
	 * @return
	 */
	public static JSONObject conversionDataFromListNoRoot(List<Node> list, String treeName) {
		JSONObject obj = new JSONObject();
		obj.put("id", "-1");
		obj.put("text", "无数据");
		Node root = new Node();
		if (list != null && list.size() != 0) {
			root.setId("");
			root.setText(treeName);
			root.setNodes(list);
			HashMap<String, Node> nodeMap = new HashMap<String, Node>();// 节点树，用于临时存放节点
			for (Node node : list) {// 把node放到map中以便获取node并设置子节点
				nodeMap.put(node.getId(), node);
			}
			if (root != null) {
				// 构造无序的多叉树
				Set entrySet = nodeMap.entrySet();
				List<Node> nodes;
				for (Iterator it = entrySet.iterator(); it.hasNext();) {
					Node node = (Node) ((Map.Entry) it.next()).getValue();
					if (node.getParentId() != null && !node.getParentId().equals("")) {
						if (((Node) nodeMap.get(node.getParentId())) != null) {
							if (((Node) nodeMap.get(node.getParentId())).getNodes() == null) {
								nodes = new ArrayList<Node>();
								((Node) nodeMap.get(node.getParentId())).setNodes(nodes);
							}
							((Node) nodeMap.get(node.getParentId())).getNodes().add(node);
						}
					}
				}
				return JSONObject.fromObject(JSONObject
						.fromObject(JSONObject.fromObject(root).toString().replaceAll("\"nodes\":\\[\\],", "")));
			}
		}
		return obj;
	}
}
