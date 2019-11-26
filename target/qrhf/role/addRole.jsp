<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	
	String sysRoleId = request.getParameter("sysRoleId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>角色权限模态框</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script type="text/javascript">
	$(function(){
		getAuth();
	})
	
	function getAuth() {
		$.ajax({
			url : '<%=basePath%>sysRole/viewTree.action',
			dataType : 'json',
			type : 'post',
			data:{sysRole:<%=sysRoleId%>},
			success:function(data){
				console.log(data);
				$('#tree').treeview({
					data: [data],         // 数据源
					levels : 9,
					showCheckbox: true,   //是否显示复选框
					onhoverColor: "#F5F5DC",//鼠标悬浮颜色 
					borderColor: "red",//边框颜色 
					highlightSelected: true,//高亮选中 
					selectedColor: "red",//选中颜色 
					selectedBackColor: "#D3D3D3",//选中背景色 
					color: "#00BFFF", 
					selectable: false,
					multiSelect: false,//多选
					state: {
						checked: true,
						disabled: true,
						expanded: true,
						selected: true
					},
					onNodeChecked: function (event,node) {
						// 父级节点被选中，那么子级节点都要选中
						if (node.nodes != null) {
							$.each(node.nodes, function(index, value) {
								$('#tree').treeview('checkNode', value.nodeId, {
									silent : true
								});
							});
						} else {
							// 子级节点选中的时候，要根据情况判断父节点是否要全部选中
							// 父节点
							var parentNode =  $('#tree').treeview('getParent', node.nodeId);
							var isAllchecked =  $('#tree'); // 是否全部选中
							// 当前子级节点的所有兄弟节点，也就是获取父下面的所有子
							var siblings =  $('#tree').treeview('getSiblings', node.nodeId);
							for ( var i in siblings) {
								// 有一个没选中，则不是全选
								if (!siblings[i].state.checked) {
									isAllchecked = false;
									break;
								}
							}
							// 全选，则打钩
							if (isAllchecked) {
								$('#tree').treeview('checkNode', parentNode.nodeId, {
									silent : true
								});
							} else {// 非全选，则变红
								$('#tree').treeview('checkNode', node.nodeId, {
									silent : true
								});
							}        	  
						}
					},
					onNodeUnchecked : function(event, node) {
						silentByChild = true;
						// 选中的是父级节点
						if (node.nodes != null) {
							// 这里需要控制，判断是否是因为子级节点引起的父节点被取消选中
							// 如果是，则只管取消父节点就行了
							// 如果不是，则子节点需要被取消选中
							// var silentByChild=false;
							if (silentByChild) {
								$.each(node.nodes, function(index, value) {
									$('#tree').treeview('uncheckNode', value.nodeId, {
										silent : true
									});
								});
							}
						}
					},
				});
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}
	
	//保存权限
	function saveAuth(){
		var id=$("#sysRole").val();
		var ids=[];
		var obj=$('#tree').treeview('getChecked');
			$.each(obj,function(index,items){
				ids.push(items.id);
			});
		$.ajax({
			url:'<%=basePath%>sysRole/saveRoleResoure.action',
			dataType:'json',
			type:'post',
			traditional:true,
			data:{
				sysRole:id,
				sysResoure:ids
			},
			success:function(data){
				if(data){
					alert("保存成功！");
				}else{
					alert("保存失败！");
				}
				$("#data-table").bootstrapTable("refresh");
				closeModal(); 
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}
	
	function sysResourceDefault(){
		$.ajax({
			url : '<%=basePath%>sysRole/sysResourceDefault.action',
			dataType : 'json',
			type : 'post',
			data:{sysRoleId:<%=sysRoleId%>},
			success:function(data){
// 				console.log(data);
				$('#tree').treeview({
					data: [data],         // 数据源
					levels : 9,
					showCheckbox: true,   //是否显示复选框
					onhoverColor: "#F5F5DC",//鼠标悬浮颜色 
					borderColor: "red",//边框颜色 
					highlightSelected: true,//高亮选中 
					selectedColor: "red",//选中颜色 
					selectedBackColor: "#D3D3D3",//选中背景色 
					color: "#00BFFF", 
					selectable: false,
					multiSelect: false,//多选
					state: {
						checked: true,
						disabled: true,
						expanded: true,
						selected: true
					},
					onNodeChecked: function (event,node) {
						// 父级节点被选中，那么子级节点都要选中
						if (node.nodes != null) {
							$.each(node.nodes, function(index, value) {
								$('#tree').treeview('checkNode', value.nodeId, {
									silent : true
								});
							});
						} else {
							// 子级节点选中的时候，要根据情况判断父节点是否要全部选中
							// 父节点
							var parentNode =  $('#tree').treeview('getParent', node.nodeId);
							var isAllchecked =  $('#tree'); // 是否全部选中
							// 当前子级节点的所有兄弟节点，也就是获取父下面的所有子
							var siblings =  $('#tree').treeview('getSiblings', node.nodeId);
							for ( var i in siblings) {
								// 有一个没选中，则不是全选
								if (!siblings[i].state.checked) {
									isAllchecked = false;
									break;
								}
							}
							// 全选，则打钩
							if (isAllchecked) {
								$('#tree').treeview('checkNode', parentNode.nodeId, {
									silent : true
								});
							} else {// 非全选，则变红
								$('#tree').treeview('checkNode', node.nodeId, {
									silent : true
								});
							}        	  
						}
					},
					onNodeUnchecked : function(event, node) {
						silentByChild = true;
						// 选中的是父级节点
						if (node.nodes != null) {
							// 这里需要控制，判断是否是因为子级节点引起的父节点被取消选中
							// 如果是，则只管取消父节点就行了
							// 如果不是，则子节点需要被取消选中
							// var silentByChild=false;
							if (silentByChild) {
								$.each(node.nodes, function(index, value) {
									$('#tree').treeview('uncheckNode', value.nodeId, {
										silent : true
									});
								});
							}
						}
					},
				});
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}
	
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">分配权限</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="authForm" method="post">
					<div class="form-group">
						<label class="col-md-2 control-label">角色权限：</label>
						<div class="col-md-3 ">
							<input type="hidden" id="sysRole" name="sysRole" value="<%=sysRoleId%>">
							<div id="tree" style="height:450px;width:300px;overflow: auto;"></div>
						</div>
					</div>
					<div class="modal-footer col-md-6">
						<!--用来清空表单数据-->
						<input type="reset" name="reset" style="display: none;" />
						<button type="button" class="btn btn-default" onclick="sysResourceDefault()">默认权限</button>
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" onclick="saveAuth()" class="btn btn-primary">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>