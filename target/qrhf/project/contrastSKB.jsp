<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String sysFlowId = request.getParameter("sysFlowId");
//  	String rejectReason = request.getParameter("rejectReason");
	String rejectReason=new String(request.getParameter("rejectReason").getBytes("ISO-8859-1"),"utf-8"); 
	String projectId = request.getParameter("projectId");
	String projectUpdateId = request.getParameter("projectUpdateId");
	User user = (User)request.getSession().getAttribute("user");
	Integer companyId=user.getCompanyId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/plugin/layer/layer.js"></script>
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-110;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>project/findListForUpdate.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>,
				    projectUpdateId:<%=projectUpdateId%>,
				    sysFlowId:<%=sysFlowId%>
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            showRefresh:false,//刷新按钮
            height:tableHeight-100,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称',
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
						if(row.status == 1){
							return "<span style='color:green;'>"+row.name + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.name + "(删除)</span>";
						}else{
							return row.name;
						}
					} 
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle'
				},
				{
					field : 'code',
					title : '商品编码',
					valign : 'middle'
				},
				{
					field : 'type',
					title : '规格',
					valign : 'middle'
				},
				{
					field : 'unit',
					title : '单位',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'amount',
					title : '数量(控制表数量 +/- 修改数量)',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){
					    if(row.editAmount!=null){
							if (row.editStatus ==1) {
							    if(row.editAmount==0){
                                    return row.pgAmount;
                                }else{
                                    var a = '<span style="color:green">'+row.amount+"("+row.pgAmount+"+"+row.editAmount+")"+'</span>';
                                    return a;
                                }
							}else if (row.editStatus ==2) {
								if(row.editAmount>0){
									var a = '<span style="color:red">'+row.amount+"("+row.pgAmount+"-"+row.editAmount+")"+'</span>';
								}else if(row.editAmount<0){
									var a = '<span style="color:red">'+row.amount+"("+row.pgAmount+""+row.editAmount+")"+'</span>';
								}else if(row.editAmount==0){
								    var a = row.pgAmount;
                                }
								return a;
							}
						}else{
					        return row.pgAmount;
						}
					}
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){ 
						if (row.editStatus ==3) {
							var a = '<span style="color:red">'+row.price+'</span>';   
							return a;
						}else{
							return row.price;
						}
					} 
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle',
                    formatter:function(value,row,index) {
                        if (row.editAmount != null) {
							return row.total.toFixed(2);
                        }else{
                            var result = row.pgAmount*row.price;
                            return result.toFixed(2);
						}
                    }
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	               formatter: operateFormatter
	            }
			]
        })
        
        //取到窗口的高度 
		var winH = $(window).height(); 
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH; 
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		}
	})


    function toDecimal(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return;
        }
        f = Math.round(x*100)/100;
        return f;
    }

    function operateFormatter(value, row, index) {
	    return [
	        '<a class="edit" href="javascript:edit('+row.id+','+row.project+','+row.goodsId+','+row.editAmount+','+row.pgAmount+','+row.editStatus+')">修改</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	        '<a class="del" href="javascript:del('+row.id+')">删除</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	    ].join('');
	} 
	
	function edit(id,project,goodsId,editAmount,pgAmount,editStatus) {
		window.location.href="<%=basePath%>project/edit.jsp?projectUpdateGoodsId="+id+"&projectId="+project+"&goodsId="+goodsId+"&editAmount="+editAmount+"&pgAmount="+pgAmount+"&editStatus="+editStatus;
	}

	function del(id) {
		$.post(
				"<%=basePath%>project/selectCount",
				{projectId:<%=projectId%>, projectUpdateId:<%=projectUpdateId%>},
				function(data) {
					if(data==1){
						if(confirm("如删除此项数据该申请将自动通过！")){
							$.post(
								"<%=basePath%>project/projectUpdateGoodsDel",
								{projectUpdateGoodsId:id},
								function(data) {
									if(data==1){
										alert("删除成功！");
// 										pass2();
										toProjectList();
									}
								}
							)
						}
					}else{
						if(confirm("确定删除此项数据吗？")){
							$.post(
								"<%=basePath%>project/projectUpdateGoodsDel",
								{projectUpdateGoodsId:id},
								function(data) {
									if(data==1){
										alert("删除成功！");
										location.reload();
									}
								}
							)
						}
					}
				}
			)
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/detail.jsp?projectId="+<%=projectId%>+"&projectPageId="+2;
	}
	
	/*function pass() {
		if(confirm("确定通过此项目采购控制表么?")){
            var index = layer.msg('处理中，请稍后', {
				  icon: 16,
				  shade: 0.1,
				  time: -1
				});
			pass2();
		} 
	}*/
	
	function pass() {
        if(confirm("确定通过此项目采购控制表么?")){
            var index = layer.msg('处理中，请稍后', {
                icon: 16,
                shade: 0.1,
                time: false
            });
        $.post(
				"<%=basePath%>project/updateProjectGoodsByProjectUpdateGoods",
				{companyId:<%=companyId%>,projectId:<%=projectId%>,projectUpdateId:<%=projectUpdateId%>},
				function(data) {
					if(data>=1){
						confirmed();
                        layer.close(index);
                        /*layer.confirm('提交成功！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){
							toProjectList();
                        });*/
                        layer.msg('提交成功！', {icon: 1});
                        toProjectList();
					}
				}
			)
        }
	}
	
	function pass2() {
		$.post(
				"<%=basePath%>project/updateProjectGoodsByProjectUpdateGoods",
				{companyId:<%=companyId%>,projectId:<%=projectId%>,projectUpdateId:<%=projectUpdateId%>},
				function(data) {
					if(data>=1){
						confirmed();
						toProjectList()
					}
				}
			)
	}
	
	function confirmed(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>sysFlow/confirmed.action?sysFlowId=<%=sysFlowId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}
	
	function reject() {
		var rejectReason = $('#rejectReason').val();
		if(rejectReason==""||rejectReason==null){
			alert("退回原因不能为空！");
			return false;
		}else{
            var index = layer.msg('处理中，请稍后', {
                icon: 16,
                shade: 0.1,
                time: false
            });
			$.post(
				"<%=basePath%>sysFlow/reject",
				{id:<%=sysFlowId%>,rejectReason:rejectReason},	
				function(data){
					if(data==1){
                        layer.close(index);
                        layer.confirm('退回成功！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){
							parent.top.location.href = "<%=basePath%>/main.jsp";
                        });
					}else if(data==0){
                        layer.close(index);
                        layer.confirm('退回失败！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){
                            layer.close(index);
                        });
					}
				}
			)
		}
	} 
	
	function submit() {
		$.post(
			"<%=basePath%>sysFlow/submitAgain",
			{sysFlowId:<%=sysFlowId%>},
			function(data) {
				if(data==1){
					alert("提交成功！")
					toProjectList();
				}
			}
		)
	}
	
	function selectUser(){
		window.location.href="<%=basePath%>project/selectUser.jsp?projectId=<%=projectId%>&sysFlowId=<%=sysFlowId%>";
	}
	
</script>
</head>
<body height="95%">
	<c:set var="rejectReason" value="<%=rejectReason%>"></c:set>
	<c:choose>
		<c:when test="${rejectReason==null || rejectReason eq ''}">
			<div id="title">
				<div align="center">
					<h1>项目采购控制表审批</h1>
				</div>
			</div>
			<ul id="myTab" class="nav nav-tabs">
				<li class="active">
					<a href="#successful" data-toggle="tab">
						 导入成功
					</a>
				</li>
				<div align="right">
					<button class="btn" onClick="selectUser()">会商</button>
					<button class="btn" onClick="pass()" id="certain">确认</button>
					<button class="btn" data-toggle="modal" data-target="#myModal">退回</button>
					<button class="btn" onClick="toProjectList()">返回项目列表</button>
				</div>
			</ul>
		</c:when>
		<c:otherwise>
			<div id="title">
				<div align="center">
					<h1>项目采购控制表修改后的未通过项</h1>
				</div>
			</div>
			<ul id="myTab" class="nav nav-tabs">
				<div align="right">
					<button class="btn" onClick="submit()">提交</button>
<!-- 					<button class="btn" onClick="delALl()">全部删除</button> -->
					<button class="btn" onClick="toProjectList()">返回采购列表</button>
				</div>
			</ul>
			<div>
				<font color="red">
					退回原因：${rejectReason}
				</font>
			</div>
		</c:otherwise>
	</c:choose>
	<table id="data-table"></table>
				
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">
						请填写退回项目采购控制表的原因
					</h4>
				</div>
				<div class="modal-body">
					<textarea class="form-control" rows="3" name="rejectReason" id="rejectReason" placeholder="退回原因"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="reject()" id="reject">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>