<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String projectId = request.getParameter("projectId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<base href="<%=basePath%>">
<title>项目列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/echarts.js"></script>

<script>
function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

$(function(){
	findProjectDate();
	/* function selectData(startDate,endDate,goodsName) { */
		$("#data-table").bootstrapTable('destroy'); 
		var h=zsy();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>statistics/findList',
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
				    startDate:$("#startDate").val(),
				    endDate:$("#endDate").val(),
				    name:$("#name").val(),
				    projectId:<%=projectId%>
				}; 
				return param;                   
            }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            showRefresh:false,//刷新按钮
            height:h-170,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
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
					title : '名称',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'controlAmount',
					title : '动态控制量',
					align: "center",
					valign : 'left',
				},
				{
					field : 'orderAmount',
					title : '已采购量',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'quantityGap',
					title : '数量差',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'quantityRatio',
					title : '数量比',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'controlTotal',
					title : '动态控制合价',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'orderTotal',
					title : '采购合价',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'totalGap',
					title : '合价差',
					align: "center",
					valign : 'middle',
				},
				{
					field : 'capitalRatio',
					title : '合价比',
					align: "center",
					valign : 'middle',
				},
				{
				    title: '查看',
				    align: 'center',
				    valign: 'middle',
				   formatter: operateFormatter,
				   events: window.operateEvents
				}
			]
        })
		
        $("#listBody").height(h-80);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		}  
	//}
})
	function findProjectDate() {
		$.post(
			"<%=basePath%>project/selectProject",
			{id:<%=projectId%>},
			function (project) {
				$("#startDate").val(changeDateFormat(project.createdate));
				$("#endDate").val(changeDateFormat(new Date().getTime()));
			}
		)
	}
	
	function changeDateFormat(cellval) {
		var dateVal = cellval + "";
		if (cellval != null) {
		    var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
		    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
		    var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
		    return date.getFullYear() + "-" + month + "-" + currentDate + " ";
		}
	}
	
	function operateFormatter(value, row, index) {
        return [
        	'<a class="edit" title="价格走向图" href="javascript:trendView('+row.goodsId+')">价格走向</a>&nbsp;&nbsp;&nbsp;&nbsp;',
        	'<a class="edit" title="价格统计数据" href="javascript:priceStatisticalData('+row.goodsId+')">价格统计数据</a>'
        ].join('');
    }
	
	function trendView(id) {
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		if(startDate == null || startDate == "" || endDate == null || endDate == ""){
			alert("请选择统计截止日期！");
			return false;
		}else if(endDate<startDate){
			alert("统计截至日期不可大于控制表上传日期！");
			return false;
		}else{
			priceTrend(startDate,endDate,id);
			$("#dataModel").modal('show');
		}
	}

	function priceStatisticalData(id) {
		$.post("statistics/midAndAvg",{goodsId:id,projectId:<%=projectId%>},function (result) {
		    $("#middlePrice").text(result.middlePrice.toFixed(2));
			$("#averagePrice").text(result.averagePrice.toFixed(2));
        })
        $("#priceModel").modal('show');
    }

	function findTotal() {
		var endDate = String($("#endDate").val());
		if($.trim(endDate).length>0){
			$("#totalPrice").empty();
			$("#stockTotal").empty();
			$("#lastTotal").empty();
			$.post(
				"<%=basePath%>statistics/fundsStatistics",
				{startDate:$("#startDate").val(),
				    endDate:$("#endDate").val(),
				    projectId:<%=projectId%>},
				 function(data) {
					$("#totalPrice").html(data.controlTotal);
					$("#stockTotal").html(data.orderTotal);
					$("#lastTotal").html(data.totalGap);
				}
			)
			$("#totalModel").modal('show');
		}else{
			alert("请选择统计截止日期！");
			return false;
		}
	}

	
	
</script>
</head>


<body id="listBody">
<div id="title">
		<div align="center">
			<h3>项目统计</h3>
		</div>
		
		<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#datas" data-toggle="tab">
				数据统计
			</a>
		</li>
		<li>
			<a href="#amount" data-toggle="tab">
				数量对比
			</a>
		</li>
		<li>
			<a href="#price" data-toggle="tab">
				价格对比
			</a>
		</li>
		<li>
			<a href="#calculation" data-toggle="tab">
				核算对比
			</a>
		</li>
		
		<div class="form-inline" align="right">
			<input type="hidden" class="form-control input-sm Wdate" style="width:10%;" id="startDate" placeholder="开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>
			<input type="text" class="form-control input-sm Wdate" style="width:10%;" id="endDate" placeholder="统计截止日期" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>
			<input type="text" class="form-control" style="width:10%;" id="name" placeholder="商品名称">
			<button class="btn" type="button" name="searchAmount" onclick="searchAmount()">查询</button>
			<button class="btn" type="button" name="searchAmount" onclick="findTotal()">资金查询</button>
			<button class="btn" onClick="toProjectList()">返回项目列表</button>
		</div>
		
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="datas" style="padding: 0">
			<table id="data-table"></table> 
		</div>
		<div class="tab-pane fade" id="amount" style="padding: 0">
		
			<div id="amountMain" style="width: 1530px;height:580px;"></div>
		</div>
		<div class="tab-pane fade" id="price"  style="padding: 0">
			
			<div id="priceMain" style="width: 1530px;height:580px;"></div>
		</div>
		<div class="tab-pane fade" id="priceSta"  style="padding: 0">
			<table id="data-tables">
				
			</table> 
		</div>
		<div class="tab-pane fade" id="calculation" style="padding: 0">
			<div id="calMain" style="width: 1530px;height:580px;">
				<h2>该功能正在开发，敬请期待...</h2>
			</div>
		</div>
	</div>
	</div>
	
 <script type="text/javascript">

 var myAmount = echarts.init(document.getElementById('amountMain'));
 var myPrice = echarts.init(document.getElementById('priceMain'));

 // 指定图表的配置项和数据
 var option = {
	    title : {
	        text: '动态控制量和已采购量对比',
	    },
	    tooltip : {
	        trigger: 'axis' //坐标轴触发提示框，多用于柱状、折线图中
	    },
	    legend: {
	        data:['动态控制量','已采购量']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            magicType : {show: true, type:'bar'}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : []
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'动态控制量',
	            type:'bar',
	            data:[]
	        },
	        {
	            name:'已采购量',
	            type:'bar',
	            data:[]
	        }
	    ]
	};
 
 var priceOption = {
	    title : {
	        text: '动态控制合价和采购合价对比',
	    },
	    tooltip : {
	        trigger: 'axis' //坐标轴触发提示框，多用于柱状、折线图中
	    },
	    legend: {
	        data:['动态控制合价','采购合价']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            magicType : {show: true, type:'bar'}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : []
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'动态控制合价',
	            type:'bar',
	            data:[]
	        },
	        {
	            name:'采购合价',
	            type:'bar',
	            data:[]
	        }
	    ]
	};

 // 使用刚指定的配置项和数据显示图表。
 myAmount.setOption(option); 
 myPrice.setOption(priceOption); 
 
	/* $("button[name='searchAmount']").on({
	    click: function () {
	    	var startDate = String($("#startDate").val());
			var endDate = String($("#endDate").val());
			var goodsName = $("#name").val();
			if((startDate == null || startDate == "" || endDate == null || endDate == "") && (goodsName == null || goodsName == "") ){
				alert("请选择开始时间及结束时间或填入需要查询的商品名称！");
				return false;
			}else if(endDate<startDate){
				alert("截至时间不可大于开始时间！");
				return false;
			}else{
		        compareAmount(startDate,endDate,goodsName);
		        comparePrice(startDate,endDate,goodsName);
		        selectData(startDate,endDate,goodsName);
			}
	    }
	
	}); */
	
	function searchAmount() {
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		var goodsName = $("#name").val();
		if((startDate == null || startDate == "" || endDate == null || endDate == "") && (goodsName == null || goodsName == "") ){
			alert("请选择统计截止日期或填入需要查询的商品名称！");
			return false;
		}else if(endDate<startDate){
			alert("截至日期不可大于控制表上传日期！");
			return false;
		}else{
			$('#data-table').bootstrapTable("refresh");
	        comparePrice(startDate,endDate,goodsName); 
			compareAmount(startDate,endDate,goodsName);
	        /* selectData(startDate,endDate,goodsName); */
		}
	}
	
	function compareAmount(startDate,endDate,goodsName) {
		
		// 基于准备好的dom，初始化echarts实例
        var myAmount = echarts.init(document.getElementById('amountMain'));

        // 指定图表的配置项和数据
        var option = {
		    title : {
		        text: '动态控制量和已采购量对比',
		    },
		    tooltip : {
		        trigger: 'axis' //坐标轴触发提示框，多用于柱状、折线图中
		    },
		    legend: {
		        data:['动态控制量','已采购量']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            magicType : {show: true, type:'bar'}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : [],
		            axisLabel: {  
		            	   interval:0,  
		            	   rotate:20  
		            	}  
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    dataZoom: [
	            {
	                type: 'slider',
	                show: true,
	                start: 94,
	                end: 100,
	                handleSize: 8
	            },
	            {
	                type: 'inside',
	                start: 94,
	                end: 100
	            },
	            {
	                type: 'slider',
	                show: true,
	                yAxisIndex: 0,
	                filterMode: 'empty',
	                width: 12,
	                height: '70%',
	                handleSize: 8,
	                showDataShadow: false,
	                left: '93%'
	            }
	        ],
		    series : [
		        {
		            name:'动态控制量',
		            type:'bar',
		            data:[],
		            itemStyle: {
						normal: {
							label: {
								show: true, //开启显示
								position: 'top', //在上方显示
								textStyle: { //数值样式
									color: 'black',
									fontSize: 16
								}
							}
						}
		            }
		        },
		        {
		            name:'已采购量',
		            type:'bar',
		            data:[],
		            itemStyle: {
						normal: {
							label: {
								show: true, //开启显示
								position: 'top', //在上方显示
								textStyle: { //数值样式
									color: 'black',
									fontSize: 16
								}
							}
						}
		            }
		        }
		    ]
		};

        // 使用刚指定的配置项和数据显示图表。
        myAmount.setOption(option); 
        myAmount.showLoading(); //数据加载完之前先显示一段简单的loading动画
			var name = [];
			var projectAmount = [];
			var orderAmount = [];
        
	         $.ajax({
	        	type:"post",
	        	async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	        	url : "<%=basePath%>statistics/amountStatistics",
	        	data:{projectId:<%=projectId%>,startDate:startDate,endDate:endDate,name:goodsName},
	        	 dataType : "json",        //返回数据形式为json
	        		success : function(data) {
	        		 for ( var i in data) {
						name.push(data[i].name);
						projectAmount.push(data[i].projectAmount);
						orderAmount.push(data[i].orderAmount);
					}
	        			myAmount.hideLoading(); //隐藏加载动画
	        			myAmount.setOption({ //加载数据图表
	        				xAxis : {
	        					data : name
	        				},
	        				series : [ {
	        					// 根据名字对应到相应的系列
	        					name : '动态控制量', 
	        					type:'bar',
	        					data : projectAmount
	        				}, 
	        				{
	        					// 根据名字对应到相应的系列
	        					name : '已采购量',
	        					type:'bar',
	        					data : orderAmount
	        				} 
	        				]
	        			});
	        		
	        	},
	        	error : function(errorMsg) {
	        		//请求失败时执行该函数
	        		alert("图表请求数据失败!");
	        		myAmount.hideLoading();
	        	}
	        })  
	}

	function comparePrice(startDate,endDate,goodsName) {
		
		// 基于准备好的dom，初始化echarts实例
        var myPrice = echarts.init(document.getElementById('priceMain'));

        // 指定图表的配置项和数据
        var priceOption = {
		    title : {
		        text: '动态控制合价和采购合价对比',
		        subtext: '单位：元'
		    },
		    tooltip : {
		        trigger: 'axis' //坐标轴触发提示框，多用于柱状、折线图中
		    },
		    legend: {
		        data:['动态控制合价','采购合价']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            magicType : {show: true, type:'bar'}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : [],
		            axisLabel: {  
		            	   interval:0,  
		            	   rotate:20  
		            	}  
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    dataZoom: [
	            {
	                type: 'slider',
	                show: true,
	                start: 94,
	                end: 100,
	                handleSize: 8
	            },
	            {
	                type: 'inside',
	                start: 94,
	                end: 100
	            },
	            {
	                type: 'slider',
	                show: true,
	                yAxisIndex: 0,
	                filterMode: 'empty',
	                width: 12,
	                height: '70%',
	                handleSize: 8,
	                showDataShadow: false,
	                left: '93%'
	            }
	        ],
		    series : [
		        {
		            name:'动态控制合价',
		            type:'bar',
		            data:[],
		            itemStyle: {
						normal: {
							label: {
								show: true, //开启显示
								position: 'top', //在上方显示
								textStyle: { //数值样式
									color: 'black',
									fontSize: 16
								}
							}
						}
		            }
		        },
		        {
		            name:'采购合价',
		            type:'bar',
		            data:[],
		            itemStyle: {
						normal: {
							label: {
								show: true, //开启显示
								position: 'top', //在上方显示
								textStyle: { //数值样式
									color: 'black',
									fontSize: 16
								}
							}
						}
		            }
		        }
		    ]
		};

        // 使用刚指定的配置项和数据显示图表。
        myPrice.setOption(priceOption); 
        myPrice.showLoading(); //数据加载完之前先显示一段简单的loading动画
			var name = [];
			var projectPrice = [];
			var orderPrice = [];
        
	         $.ajax({
	        	 type:"post",
	        	async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	        	url : "<%=basePath%>statistics/priceStatistics", 
	        	data:{projectId:<%=projectId%>,startDate:startDate,endDate:endDate,name:goodsName},
	        	dataType : "json",        //返回数据形式为json
	        		success : function(data) {
	        		 for ( var i in data) {
						name.push(data[i].name);
						projectPrice.push(data[i].projectPrice);
						orderPrice.push(data[i].orderPrice);
					}
	        		 myPrice.hideLoading(); //隐藏加载动画
	        		 myPrice.setOption({ //加载数据图表
	        				xAxis : {
	        					data : name
	        				},
	        				series : [ {
	        					// 根据名字对应到相应的系列
	        					name : '动态控制合价', 
	        					type:'bar',
	        					data : projectPrice
	        				}, 
	        				{
	        					// 根据名字对应到相应的系列
	        					name : '采购合价',
	        					type:'bar',
	        					data : orderPrice
	        				} 
	        				]
	        			});
	        		
	        	},
	        	error : function(errorMsg) {
	        		//请求失败时执行该函数
	        		alert("图表请求数据失败!");
	        		myAmount.hideLoading();
	        	}
	        })  
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=2";
	}
	
	

	function priceTrend(startDate,endDate,goodsId) {
		
		// 基于准备好的dom，初始化echarts实例
        var priceView = echarts.init(document.getElementById('priceView'));

        // 指定图表的配置项和数据
        var option = {
		    title : {
		        text: '价格走向',
		        subtext:'单位 ： 元'
		    },
		    tooltip : {
		        trigger: 'axis' //坐标轴触发提示框，多用于柱状、折线图中
		    },
		    legend: {
		        data:['价格']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            magicType : {show: true, type: ['line', 'bar']}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : [],
		            axisLabel: {  
		            	   interval:0,  
		            	   rotate:20  
		            	}  
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    /* 鼠标缩放
		    dataZoom: [
	            {
	                type: 'slider',
	                show: true,
	                start: 94,
	                end: 100,
	                handleSize: 8
	            },
	            {
	                type: 'inside',
	                start: 94,
	                end: 100
	            },
	            {
	                type: 'slider',
	                show: true,
	                yAxisIndex: 0,
	                filterMode: 'empty',
	                width: 12,
	                height: '70%',
	                handleSize: 8,
	                showDataShadow: false,
	                left: '93%'
	            }
	        ], */
		    series : [
		        {
		            name:'价格',
		            type:'line',
		            data:[],
		            itemStyle: {
						normal: {
							label: {
								show: true, //开启显示
								position: 'top', //在上方显示
								textStyle: { //数值样式
									color: 'black',
									fontSize: 16
								}
							}
						}
		            }
		        }
		    ]
		};

        // 使用刚指定的配置项和数据显示图表。
        priceView.setOption(option); 
        priceView.showLoading(); //数据加载完之前先显示一段简单的loading动画
			var createDate = [];
			var price = [];
	         $.ajax({
	        	async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	        	url : "<%=basePath%>statistics/priceTrend", 
	        	data:{projectId:<%=projectId%>,goodsId:goodsId,startDate:startDate,endDate:endDate},
	        	 dataType : "json",        //返回数据形式为json
	        		success : function(data) {
	        		 for ( var i in data) {
	        			 createDate.push(data[i].createDate);
	        			 price.push(data[i].price);
					}
	        		 priceView.hideLoading(); //隐藏加载动画
	        		 priceView.setOption({ //加载数据图表
	        				xAxis : {
	        					data : createDate
	        				},
	        				series : [ {
	        					// 根据名字对应到相应的系列
	        					name : '价格', 
	        					type:'line',
	        					data : price
	        				}
	        				]
	        			});
	        		
	        	},
	        	error : function(errorMsg) {
	        		//请求失败时执行该函数
	        		alert("图表请求数据失败!");
	        		myAmount.hideLoading();
	        	}
	        })  
	}
	
</script>

<%--价格走向模态框开始--%>
<div class="modal fade bs-example-modal-lg" id="dataModel" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >商品价格走向</h4>
				</div>
				<div class="modal-body" id="priceView" style="height: 500px;width: 900px"></div>
				
			</div>
		</div>
	</div>
<%--价格走向模态框结束--%>

<%--价格中位数、平均数模态框开始--%>
<div class="modal fade" tabindex="-1" role="dialog" id="priceModel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">价格统计数据</h4>
			</div>
			<div class="modal-body">
				<table class="table table-bordered" style="text-align: center">
					<tr>
						<td>价格中位数</td>
						<td>价格平均数</td>
					</tr>
					<tr>
						<td><span id="middlePrice"></span></td>
						<td><span id="averagePrice"></span></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<%--价格中位数、平均数模态框结束--%>

<div class="modal fade bs-example-modal-lg" id="totalModel" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-lg" role="document" style="height: 300px;width: 500px">
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">资金统计</h4>
				</div>
				<div class="modal-body" id="totalView" >
					<table class="table table-hover">
						<tr>
							<th>总预算价格</th>
							<td id="totalPrice">查询中，请稍后...</td>
						</tr>
						<tr>
							<th>已采购材料总价</th>
							<td id="stockTotal">查询中，请稍后...</td>
						</tr>
						<tr>
							<th>剩余预算</th>
							<td id="lastTotal">查询中，请稍后...</td>
						</tr>
					</table>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>