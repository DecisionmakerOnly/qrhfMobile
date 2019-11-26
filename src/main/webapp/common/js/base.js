
document.onkeydown = function(e) { //IE浏览器下禁止删除键页面回退的问题
	e = e || window.event;
	var keyCode = e.keyCode || e.charCode;
	if (keyCode == 8) {
		var elem = e.srcElement || e.target;
		var name = elem.nodeName.toUpperCase();
		if ((name != 'INPUT' || (name == 'INPUT' && $(elem).attr("readonly") != undefined && $(elem).attr("readonly").toLowerCase() == "readonly") || (name == 'INPUT' && $(elem).attr("type") != undefined && ($(elem).attr("type").toUpperCase() == "CHECKBOX" || $(elem).attr("type").toUpperCase() == "RADIO")))
			&& name != 'TEXTAREA' && $(elem).attr("contenteditable") != true && $(elem).attr("contenteditable") != 'true') {
			if (e.preventDefault) {
				e.preventDefault();
			}
			e.returnValue = false;
			return;
		}
	}
}

function checkLoginStr(str,num){
	$.ajax({
		type : "post",
		url : "<%=basePath%>user/checkLoginEmail",
		data : {
			"chare" : str,
			"loginType":num
		},
		dataType : "json",
		async: false,
		success : function(data) {
			return data;
		}
	});
}

function checkLoginType(str){//检查字符串：1 手机号，2 邮箱，0 非手机号/邮箱
	var myregEmail = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
	var myregPhone=/^[1][3,4,5,7,8][0-9]{9}$/;
	if(myregPhone.test(str)){
		return 1;
	}else if(myregEmail.test(str)){
		return 2;
	}else{
		return 0;
	}
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

function checkUserDepartmentIsCorrect(projectDepartmentId,userDepartmentId,projectUserId,userId,roleCode){
	if((roleCode == "GSCBKZR") || (roleCode == "TZRDB") || (roleCode == "TZR") ||(roleCode == "GSCWZG") || (projectDepartmentId == userDepartmentId) || (projectUserId == userId)){
		return true;
	}
	return false;
}

function saveLog(companyId,buyerId,roleType,title,rejectReason){
	$.post("/sysLog/saveLog.action",{companyId:companyId,buyerId:buyerId,roleType:roleType,title:title,rejectReason:rejectReason}) 
}

function initBtn(userId,pageId){
	findButtons("/sysResource/findButtons.action?userId="+userId+"&pageId="+pageId,pageId);
}

function findButtons(url,pageId){
	$.ajax({
		dataType : "json",
		type : "post",
		url : url,
		success : function(data) {
			initButtons(data,pageId);
		}
	});
}

var operationButtons = new Array();
var operationButtonsSelection = new Array();
function initButtons(data,pageId){
	var buttonsHtml='';
	for(var i=0,j=0,s=0;i<data.length;i++){
		if(data[i].status == 1 || data[i].status == 3){
			operationButtons[j] = data[i];
			j++;
		}else if(data[i].status == 2){
			buttonsHtml += '<button class="btn"  pageId="'+data[i].id+'" onclick="'+data[i].method+';ceshi($(this))">'+data[i].name+'</button>';
			buttonsHtml += '&nbsp;';
		}else if(data[i].status == 4){
			operationButtonsSelection[s] = data[i];
			s++;
		}
	}
	$("#buttons"+pageId).html(($("#buttons").html()=="undefined"||$("#buttons").html()==undefined?"":$("#buttons").html())+buttonsHtml);
}


function initOperationButtons(data,row,selectionData){
	var buttonsHtml = '';
	for(var i=0;i<data.length;i++){	
		if(row.code != 'TZRDB'&& data[i].name=="变更投资人代表"){
		}else if((row.code == 'TZRDB' || row.code == 'TZR') && data[i].name=="配置一次性权限范围"){
		}else if(data[i].name=="绑定项目" && row.status =='1'){
			if(row.isProject >0){
				buttonsHtml += '<a href="javascript:void(0)" role="button" filePath="'+row.filePath+'" pageId="'+data[i].id+'" title="去解绑项目" isProject="1" value="'+row.id+'" onclick="'+data[i].method+';ceshi($(this))" >已绑定项目</a>';
				buttonsHtml += '&nbsp;&nbsp;&nbsp;&nbsp;';
			}else{
				buttonsHtml += '<a href="javascript:void(0)" role="button" filePath="'+row.filePath+'" pageId="'+data[i].id+'" title="去绑定项目" isProject="0" value="'+row.id+'" onclick="'+data[i].method+';ceshi($(this))" >未绑定项目</a>';
				buttonsHtml += '&nbsp;&nbsp;&nbsp;&nbsp;';
			}
		}else if(data[i].recordId == "0" || data[i].recordId == null || data[i].recordId == undefined || data[i].recordId == "" || data[i].recordId==row.id){
			if(data[i].status == "3"){
				var rHtml = "";
				for(var j=0;j<selectionData.length;j++){
					if(selectionData[j].sysResource == data[i].id){
						if(selectionData[j].recordId == "0" || selectionData[j].recordId == null || selectionData[j].recordId == undefined || selectionData[j].recordId == "" || selectionData[j].recordId == row.id){
							rHtml += '<li><a href="javascript:void(0)" role="button" filePath="'+row.filePath+'" pageId="'+selectionData[j].id+'" title="'+selectionData[j].alias+'" value="'+row.id+'" onclick="'+selectionData[j].method+';ceshi($(this))" >'+selectionData[j].name+'</a></li>';
						}
					}
				}
				if(rHtml.length>0){
					buttonsHtml += '<div class="btn-group">';
					buttonsHtml += '<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">'+data[i].name+'<span class="caret"></span></button>';
					buttonsHtml += '<ul class="dropdown-menu" role="menu" style="min-width: 100px;">';
					buttonsHtml += rHtml;
					buttonsHtml += '</ul>';
					buttonsHtml += '</div>';
					buttonsHtml += '&nbsp;&nbsp;&nbsp;&nbsp;';
				}
			}else if(data[i].name!="绑定项目"){
				buttonsHtml += '<a href="javascript:void(0)" role="button" filePath="'+row.filePath+'" pageId="'+data[i].id+'" title="'+data[i].alias+'" value="'+row.id+'" onclick="'+data[i].method+';ceshi($(this))" >'+data[i].name+'</a>';
				buttonsHtml += '&nbsp;&nbsp;&nbsp;&nbsp;';
			}
		} 
	}
	return buttonsHtml;
}

function liCount(obj) {
	alert($(obj).html());
//	alert(id);
//	if(id==57&&document.getElementsByTagName("ul")[0].getElementsByTagName("li").length==0){
//		document.getElementsByTagName("button")[0].setAttribute("disabled", true);
//	}else if (id==45&&document.getElementsByTagName("ul")[1].getElementsByTagName("li").length==0) {
//		document.getElementsByTagName("button")[1].setAttribute("disabled", true);
//	}else if (id==56&&document.getElementsByTagName("ul")[2].getElementsByTagName("li").length==0) {
//		document.getElementsByTagName("button")[2].setAttribute("disabled", true);
//	}else if (id==46&&document.getElementsByTagName("ul")[3].getElementsByTagName("li").length==0) {
//		document.getElementsByTagName("button")[3].setAttribute("disabled", true);
//	}
}

function ceshi(obj){
	$.ajax({
		dataType : "json",
		type : "post",
		url : "/sysResource/deleteTemporaryAuthority.action?sysResourceId="+obj.attr('pageId')
	});
}

//选中节点时级联选中方法
function treeOncheck(treeid, node) {
	if (node.nodes != undefined) {
		$.each(node.nodes, function(j, n) {
			if (!n.state.checked) {
				$('#' + treeid).treeview('checkNode', n.nodeId);
			}
		})
	}
}
//取消选中节点时级联取消选中方法	
function treeOnUncheck(treeid, node) {
	if (node.nodes != undefined) {
		$.each(node.nodes, function(j, n) {
			if (n.state.checked) {
				$('#' + treeid).treeview('uncheckNode', n.nodeId);
			}
		})
	}
}
var delObjId = "";
function delObj(id, callback, delId) {
	BootstrapDialog.confirm({
		title : '警告',
		message : '是否删除所选项？',
		type : BootstrapDialog.TYPE_WARNING, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
		closable : true, // <-- Default value is false
		draggable : true, // <-- Default value is false
		btnCancelLabel : '取消', // <-- Default value is 'Cancel',
		btnOKLabel : '确定', // <-- Default value is 'OK',
		btnOKClass : 'btn-warning', // <-- If you didn't specify it, dialog type will be used,
		callback : function(result) {
			if (result) {
				$("#" + id).remove();
				if (delId != undefined) {
					delObjId += delId + ",";
				}
				if (callback != undefined) {
					if (typeof callback == 'function') {
						callback();
					} else if (typeof callback == 'string') {
						callback = callback.replace(/&apos;/g, "'"); //IE8BUG修复
						eval(callback);
					}
				}
			}
		}
	});
}
function setH(key, h) {
	if (key != undefined && h != undefined) {
		var $obj = $("#" + key);
		if ($obj == undefined || $obj == null || $obj.length == 0) {
			$obj = $("." + key);
		}
		if ($obj == undefined || $obj == null || $obj.length == 0) {
			$obj = $("*[name='" + key + "']");
		}
		if ($obj != undefined) {
			var interval = window.setInterval(function() {
				if (document.body.clientHeight > 0) {
					$obj.height((document.body.clientHeight - h) + "px");
					var style = $obj.attr("style");
					if (style == undefined) {
						style = "";
					}
					if (style.toLowerCase().indexOf("width") < 0) {
						style += ";width:100%;";
					}
					if (style.toLowerCase().indexOf("overflow") < 0) {
						style += ";overflow:auto;";
					}
					$obj.attr("style", style);
					window.onresize = function() {
						$obj.height((document.body.clientHeight - h) + "px");
						var style = $obj.attr("style");
						if (style == undefined) {
							style = "";
						}
						if (style.toLowerCase().indexOf("width") < 0) {
							style += ";width:100%;";
						}
						if (style.toLowerCase().indexOf("overflow") < 0) {
							style += ";overflow:auto;";
						}
						$obj.attr("style", style);
					};
					clearInterval(interval);
				}
			}, 200);
		}
	}
}


//打开模态框
function openModal(url){
    var fatherBody = $(window.top.document.body);
    var id = 'pages';
    var dialog = $('#' + id);
    if (dialog.length == 0) {
        dialog = $('<div class="modal fade" role="dialog" id="' + id + '"/>');
        dialog.appendTo(fatherBody);
    }
    dialog.load(url, function() {
        dialog.modal({
          backdrop: false
        });
    });
    fatherBody.append("<div id='backdropId' class='modal-backdrop fade in'></div>");
}

//关闭模态框
function closeModal(){
    var fatherBody = $(window.top.document.body);
    fatherBody.find("#pages").remove();
    fatherBody.find("#backdropId").remove();
//    fatherBody.find("#pages").on('hidden.bs.modal', function (e) {
//        fatherBody.find("#backdropId").remove();
//    });
}

//var openedModal;
////打开模态框
//function openModal(url, width, height) {
//	var win = window;
//	var body = $(win.top.document.body);
//	var modalId = 'commonModal';
//	var frameId = 'commonFrame';
//	var bw = body.width();
//	var bh = body.height() * 0.98;
//	var w = bw * 0.96;
//	var h = bh * 0.96;
//	if (width != undefined) {
//		w = width;
//	}
//	if (height != undefined) {
//		h = height;
//	}
//	alert(bh+":"+h);
//	var margin = parseInt((bh - h) / 2);
//	body.find("#" + modalId).remove();
//	body.append("<div id='" + modalId + "' class='modal fade' role='dialog' aria-hidden='true' style='width:100%;height:100%;'>" +
//		"<div class='modal-dialog' role='document' style='width:" + w + "px;height:" + h + "px;margin:" + margin + "px auto;'>" +
//		"<div class='modal-content' style='height:100%;width:100%;'>" +
//		"<iframe id='" + frameId + "' width='100%' height='100%' name='" + frameId + "' src='' frameborder='0' scrolling='no' marginwidth='0px' marginheight='0px'></iframe>" +
//		"</div>" +
//		"</div>" +
//		"</div>");
//	body.find("#" + frameId).attr("src", url);
//	openedModal = body.find("#" + modalId).modal();
//	body.find("#" + modalId).removeAttr("tabindex");
//}
//
////关闭模态框
//function closeModal(callback) {
//	if (window.parent.openedModal != undefined) {
//		window.parent.openedModal.modal("hide");
//	}
//	if (typeof callback == 'function') {
//		callback();
//	} else if (typeof callback == 'string') {
//		callback = callback.replace(/&apos;/g, "'"); //IE8BUG修复
//		eval(callback);
//	}
//}