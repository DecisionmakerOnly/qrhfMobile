<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>定额详情</title>
<script type="text/javascript">
function zsy(){
	var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
	return yScroll;
}
function byQuota(){
	location.reload();
}
$(function() {	initQuotaLinkage();
	var h=zsy();
	initBtn(<%=userId%>,<%=pageId%>);
	var companyId = <%=companyId%>;
	$("#data-table").bootstrapTable('destroy'); 
	$('#data-table').bootstrapTable({
    	url: '<%=basePath%>/quota/findList.action',
		method: 'post',
		contentType: "application/x-www-form-urlencoded",
		//【查询设置】
		/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
		 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
        queryParamsType:'', 
        queryParams: function queryParams(params) { 
          var param = {  
              pageNumber: params.pageNumber,    
              pageSize: params.pageSize,
              companyId:<%=companyId%>
          }; 
          return param; 
        }, 
		locale:'zh-CN',//中文支持
		pagination: true,//是否开启分页（*）
        pageNumber:1,//初始化加载第一页，默认第一页
        pageSize: 10,//每页的记录行数（*）
        pageList: [20,50,100],//可供选择的每页的行数（*）
        sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
		clickToSelect: true, // 单击行即可以选中
		silent : true, //刷新事件必须设置
		striped : true,// 隔行加亮
        height:h-200,//table的高度
        //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
		rowStyle: 'success',
		 columns:[
				  	[
						 {  
							title: '序号',//标题  可不加 
							valign : 'middle', 
							align: "center",
							colspan: 1,
							rowspan: 2,
							formatter: function (value, row, index) {
								var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
								var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
								return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
							}  
				     		 }, 
					     {
						        field: 'linkageName',
						        title: "项目分类",
						        valign:"middle",
						        align:"center",
						        colspan: 1,
						        rowspan: 2
					      },
					      {
						        field : 'name',
						        title : '项目描述',
						        valign : 'middle',
						        align: "center",
						        sortable : "true",
						        colspan: 1,
						        rowspan: 2
					       },
					       {
						        field : 'region',
						        title : '施工地址',
						        align: "center",
						        valign : 'middle',
						        sortable : "true",
						        colspan: 1,
						        rowspan: 2
					        },
				            {
				            	title: "工人",
				                valign:"middle",
				                align:"center",
				                colspan: 3,
				                rowspan: 1
				             },
				              {
				          		field : 'workloadUnit',
				          		title : '完成工程量',
				          		align: "center",
				          		valign : 'middle',
				          		sortable : "true",
				          		colspan: 1,
				                rowspan: 2
				               },
				                {
					          		 field : 'organicQuota',
					          		 title : '有机定额',
					          		 align: "center",
					          		 valign : 'middle',
					          		 sortable : "true",
					          		 colspan: 1,
					                 rowspan: 2
					             },
					             {
					            	 field : 'unitPrice',
					          		 field : 'unitPrice',
					          		 title : '单价',
					          		 align: "center",
					          		 valign : 'middle',
					          		 sortable : "true",
					          		 colspan: 1,
					                 rowspan: 2
					                },
				                {
					          		 field : 'num',
					          		 title : '工程使用率(次)',
					          		 align: "center",
					          		 valign : 'middle',
					          		 sortable : "true",
					          		 colspan: 1,
					                 rowspan: 2
					                },
				                {
					          		  field: 'operate',
					          		  title: '操作',
					          		  align: 'center',
					          		  valign: 'middle',
					          		  colspan: 1,
					                  rowspan: 2,
					          		  events: window.operateEvents,
					          		  formatter: function (value, row, index) {
					          			 return initOperationButtons(operationButtons,row,operationButtonsSelection);
					          			 }
				                }
				           ],
				           [
				                  {
				                          field: 'seniorWorker',
				                          title: '技工人数',
				                          valign : 'middle',
				          				  align: "center",
				          				  sortable : "true"
				                   },
				                   {
				                          field: 'primaryWorker',
				                          title: '普工人数',
				                          valign:"middle",
				                          align:"center",
					          			  sortable : "true"
				                      },
				                      {
				                          field: 'mechanics',
				                          title: '机械',
				                          valign:"middle",
				                          align:"center",
					          			  sortable : "true"
				                      }
						]
		 ]
	  })
    $("#listBody").height(h-100);
	//取到窗口的高度 
	var winH = $(window).height();
	//取到页面的高度 `
	var bodyH = $(document).height();
	if(bodyH > winH){ 
		window.parent.document.getElementById("mainFrame").height=bodyH;
	}else{ 
		window.parent.document.getElementById("mainFrame").height=winH; 
	} 
})
function quotaList(){
	$("#test-table").bootstrapTable('destroy'); 
	var h=zsy();
	$('#test-table').bootstrapTable({
		url: '<%=basePath%>quota/findListAll.action',
		method: 'post',
		contentType: "application/x-www-form-urlencoded",
        queryParamsType:'', 
        queryParams: function queryParams(params) {  
			var param = {  
			    pageNumber: params.pageNumber,    
			    pageSize: params.pageSize,
			    quotaName:$("#quotaName").val()
// 			    workload:$("#workload").val()
			}; 
			return param;
        }, 
        locale:'zh-CN',//中文支持
		pagination: true,//是否开启分页（*）
        pageNumber:1,//初始化加载第一页，默认第一页
        pageSize: 20,//每页的记录行数（*）
        pageList: [20,50,100],//可供选择的每页的行数（*）
        sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
		clickToSelect: true, // 单击行即可以选中
		silent : true, //刷新事件必须设置
		striped : true,// 隔行加亮
		height:h-370,//table的高度
        //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
		rowStyle: 'success',
		columns : [
			[
			{  
				  title: '序号',//标题  可不加 
				  valign : 'middle', 
				  align: "center",
				  colspan: 1,
                  rowspan: 2,
				  formatter: function (value, row, index) {
					 var pageSize=$('#test-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
					 var pageNumber=$('#test-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
					 return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
				}  
     		 	},
			{
			      field: 'linkageName',
			      title: "项目分类",
			      valign:"middle",
			      align:"center",
			      colspan: 1,
			      rowspan: 2
			},
		    {
	    	  	  field : 'name',
		          title : '项目描述',
		          valign : 'middle',
		          align: "center",
		          colspan: 1,
		          rowspan: 2
	       	},
	        {
		          field : 'region',
		          title : '施工地址',
		          align: "center",
		          valign : 'middle',
		          sortable : "true",
		          colspan: 1,
		          rowspan: 2
	        },
	        {
            	   title: "工人",
                   valign:"middle",
                   align:"center",
                   colspan: 3,
                   rowspan: 1
             },
	         {
	          	   field : 'workloadUnit',
	          	   title : '完成工程量',
	          	   align: "center",
	          	   valign : 'middle',
	          	   sortable : "true",
	          	   colspan: 1,
	               rowspan: 2
	          },
	          {
	          	   field : 'organicQuota',
	          	   title : '有机定额',
	          	   align: "center",
	          	   valign : 'middle',
	          	   sortable : "true",
	          	   colspan: 1,
	               rowspan: 2
	          },
	          {
	          		 field : 'num',
	          		 title : '工程使用率(次)',
	          		 align: "center",
	          		 valign : 'middle',
	          		 sortable : "true",
	          		 colspan: 1,
	                 rowspan: 2
	             },
	          {
	               field: 'operate',
	               title: '操作',
	               align: 'center',
	               valign: 'middle',
	               colspan: 1,
		           rowspan: 2,
	               formatter: operateFormatter,
	               events: window.operateEvents,
	           }
	        ],
	        [
	           {
                 	field: 'seniorWorker',
                 	title: '技工人数',
                 	valign : 'middle',
          		 	align: "center",
          		 	sortable : "true" 
	           },
	           {
                    field: 'primaryWorker',
                    title: '普工人数',
                    valign:"middle",
                    align:"center",
        			sortable : "true"
	           },
	           {
                    field: 'mechanics',
                    title: '机械',
                    valign:"middle",
                    align:"center",
     			  	sortable : "true"
	           }
	       ]
		]
	})
}
function operateFormatter(value, row, index) {
    return [
    	'<a class="edit" title="详情" href="javascript:details('+row.id+')">详情</a>',
        '&nbsp;&nbsp;',
    ].join('');
}
function del(obj) {
		if(confirm('您确定要删除？')){
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>quota/del?id="+obj.attr('value'),
				success : function(data) {
					$('#data-table').bootstrapTable('refresh');
				}
			});
		} else {
			return false;
		}
	}
function add(obj){
	var id = obj==null?"":obj.attr('value');
	window.location.href="<%=basePath%>quota/add.jsp?quotaPageId=<%=pageId%>&id="+id;
}
function statistics(){
	window.location.href = "<%=basePath%>quota/quotaAll?quotaPageId=<%=pageId%>";	
}
function details(id) {
<%-- 	openModal("<%=basePath%>quota/detail?quotaPageId=<%=pageId%>&id="+id+"&linkageName="+linkageName); --%>
	openModal("<%=basePath%>quota/detail?quotaPageId=<%=pageId%>&id="+id);
}
function initQuotaLinkage(){
	$.ajax({
		dataType : "json",
		type : "post",
		async: false,//同步
		url : "<%=basePath%>linkage/findByLinkage.action",
		success : function(data) {
			var html = '';
			for(var i=0;i<data.length;i++){
				html +='<option value="'+data[i].id+'">'+data[i].name+'</option>'
			}
			$("#quotaName").append(html);
		}
	});
}
//查询按钮执行查询方法
function quotaQuery(){
	$('#test-table').bootstrapTable("refresh",{silent: true});
}
</script>
</head>

<body id="listBody">
<div align="center">
		<h1>工程列表</h1>
	</div>
<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#successful" onclick="byQuota()"  data-toggle="tab">
				 公司工程
			</a>
		</li>
		<li>
			<a href="#failure" onclick="quotaList()" data-toggle="tab">
				其他工程
			</a>
		</li>
	<div align="right" id="buttons<%=pageId%>"></div>
</ul>
<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="successful" style="padding: 0">
		<table id="data-table"></table> 
	</div>
	<div class="tab-pane fade" id="failure"  style="padding: 0">
		<div align="right" class="form-inline" >
			工程名称：<select id="quotaName" name="quotaName" class="form-control">
						<option value="">==所有工程==</option>
					 </select>
<!-- 			完成工程量：<input type="text" name="workload" id="workload" class="form-control input-sm" style="width:80px;" value=""> -->
<!-- 		完成工程量单位：<select id="unit" name="unit" class="form-control"> -->
<!-- 						<option value="">==所有单位==</option> -->
<!-- 					  </select> -->
					  <button class="btn" onclick="quotaQuery()">查询</button>
					  <button class="btn" onClick="statistics()">统计</button>
		</div>
		<table id="test-table"></table> 
	</div>
</div>
</body>
</html>