<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String companyId = request.getParameter("companyId");
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
	session.setAttribute("pageId",projectPageId);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'addDepartment.jsp' starting page</title>
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
		  //获得所要回显的值
          var checkeds = $("#buyerId").val();
            //拆分为字符串数组
          var checkArray =checkeds.split(",");
           //获得所有的复选框对象
          var checkBoxAll = $("input[name='buyer']");
           //获得所有复选框的value值，然后，用checkArray中的值和他们比较，如果有，则说明该复选框被选中
          for(var i=0;i<checkArray.length;i++){
              //获取所有复选框对象的value属性，然后，用checkArray[i]和他们匹配，如果有，则说明他应被选中
              $.each(checkBoxAll,function(j,checkbox){
                  //获取复选框的value属性
                   var checkValue=$(checkbox).val();
                  if(checkArray[i]==checkValue){
                       $(checkbox).attr("checked",true);
                  }
             })
          } 
	})  
	
	
	function updatProjectDuty(){
		var chk_value =[]; 
		var departmentId = $("#department").val();
		if(departmentId == -1){
			alert("请选择部门!");
			return;
		}
	    $('input[name="buyer"]:checked').each(function(){ 
	        chk_value.push($(this).val()); 
	    }); 
	    if(chk_value.length==0){
	    	alert('请选择材料员！');
	    	return;
	    }
	    var buyerId = chk_value.join();		//数组转字符串
		var dutyUser=$("#dutyUser").val();
		if(dutyUser==null){
			alert("请在部门管理中添加项目经理！")
		}else{
			$.ajax({
				url:'project/updateProject.action',
				dataType:'json',
				type:'post',
				traditional:true,
				data:{
					id:<%=projectId%>,
					dutyUser:dutyUser,
					buyerId:buyerId,
					departmentId:departmentId
				},
				success:function(data){
					if(data){
						alert("保存成功！");
					}else{
						alert("保存失败！");
					}
					window.location.href="<%=basePath%>main.jsp";
				}
			})
		} 
	 }
	
	function selectManager(){
		selectBuyer();
 		var departmentId = $("#department").val();
		$.ajax({
			url:'user/selectManager',
			dataType:'json',
			type:'post',
			traditional:true,
			data:{
				companyId:<%=companyId%>,departmentId:departmentId
			},
			success:function(data){
				$("#dutyUser").empty();
				for(var i in data){
					var id = data[i].id;
					var name = data[i].userName;
					var str = "<option value=" + id + ">" + name + "</option>";
                    $("#dutyUser").append(str);
				}
			}
		})
	}
	
	
	function selectBuyer() {
		 $.ajax({
			url:'user/selectBuyer',
			dataType:'json',
			type:'post',
			traditional:true,
			data:{
				companyId:<%=companyId%>,departmentId:$("#department").val()
			},
			success:function(data){
				if(data.length==0){
					$("#buyer").html("请在该部门加入材料员");
				}else{
					$("#buyer").empty();
					var str = "";
					for(var i in data){
						var id = data[i].id;
						var name = data[i].userName;
						str+='<table class="table" style="margin-bottom:0px">';
						str += "<td><input type='checkbox' value=" + id + " name='buyer'>" + name + "</td>";
						str +='</table>';
	                    $("#buyers").html(str);
					}
				}
			}
		}) 
		
	}

</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">选择部门和项目经理</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="dutyForm" method="post">
					<div class="form-group">
						<label class="col-md-2 control-label">部门：</label>
						<div class="col-md-3 ">
							<input type="hidden" id="id" name="id">
							<c:set  var="departmentId" value="${pro.departmentId}" scope="request"/>
							<select style="width: 280px" id="department" name="department" class="form-control form-control-static " onchange="selectManager()">
								<option value="-1">==请选择==</option>
	                            <c:forEach items="${list}" var="var" varStatus="vs">
	                                <option value="${var.id}" <c:if test="${var.id==departmentId}">selected</c:if> > ${var.name}</option>
	                            </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">项目经理：</label>
						<div class="col-md-3 ">
							<input type="hidden" id="id" name="id">
							<c:set  var="dutyUserId" value="${pro.dutyUser}" scope="request"/>
							<select style="width: 280px" id="dutyUser" name="dutyUser" class="form-control form-control-static ">
								<c:forEach items="${userList}" var="var" varStatus="vs">
	                                <option value="${var.id}" <c:if test="${var.id==dutyUserId}">selected</c:if> > ${var.userName}</option>
	                            </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" >材料员：</label>
						<div style="padding-left: 210px">
						<input type="hidden" id="buyerId" value="${pro.buyerId}">
							<div  id="buyers" class="col-md-3 " style="height: 138px; width:280px;overflow: scroll;border: 1px solid #cccccc;">
								<%-- c:set  var="buyerId" value="${pro.buyerId}" scope="request"/> --%>
								<c:forEach items="${buyerList }" var="var">
									<table class="table" style="margin-bottom:0px">
										<td><input type="checkbox" name="buyer" id="buyer"  class="buyer" value="${var.id}">${var.userName}</td>
									</table>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" onclick="updatProjectDuty()" class="btn btn-primary">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
