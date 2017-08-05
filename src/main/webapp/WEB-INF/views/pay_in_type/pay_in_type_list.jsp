<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收入类别管理</title>
</head>
<body>

	<!-- 左边 -->
	<div style="margin-left:20px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">收入类别(预设)</p>
			<select id="sysPayInType" multiple="multiple" style="display: block;width:200px;height:450px;">
			</select>
	</div>
	
	<!-- 中间 -->
	<div style="margin-left:100px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">收入类别(自定义)</p>
			<select id="ziDingYiPayInType" multiple="multiple" style="display: block;width:200px;height:450px;">
			</select>
			
			<button id="delPayInTypeBtn" style="margin-top: 15px;margin-left: 30px;" type="button" class="btn btn-danger">删除自定义类别</button>
	</div>
	
	
	<!-- 右边 -->
	<div style="margin-left:100px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">添加自定义类别</p>
			<form id="addPayInTypeForm" style="display: block;width:200px;height:450px;border:1px solid lightgrey;">
				<label for="payInTypeName" style="margin-left:10px;margin-top:10px;font-weight: normal;margin-right: 10px;">类别名：</label>
				<input id="payInTypeName" type="text" style="margin-left: 10px;" data-placement="right" data-trigger="manual"/>
				
				<button id="savePayInTypeBtn" class="btn btn-success" type="button" style="margin-top: 10px;margin-left: 10px;">保存</button>
				<button class="btn btn-warning" type="reset" style="margin-top: 10px;margin-left: 10px;">重置</button>
			</form>
	</div>

<script>
$(function(){
	savePayInTypeBtnClick();
	loadPayInType();
	delPayInTypeBtnClick();
	popoverHide();
});


//删除类型按钮单击事件
function delPayInTypeBtnClick() {
	$('#delPayInTypeBtn').click(function(){
		var arr = $("#ziDingYiPayInType").val().toString().split(",");
		if(arr.length==1 && arr[0]=="") {
			return;
		}
		if(arr.length > 1) {
			swal("失败","只能选择一个自定义的收入类型","error");
			return;
		}
		
		var text =  $("#ziDingYiPayInType").find("option:selected").text();
		swal({
			title:'确定删除['+text+']吗？',
			text:'删除之后不可恢复',
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "删除！",
			cancelButtonText: "取消",
			closeOnConfirm: false,
			closeOnCancel: false
		},
			function(isConfirm) {
			if(isConfirm) {
				$.ajax({
		        	  type:'post',
		        	  url:'payInType/delete',
		        	  data:'id='+arr[0],
		        	  dataType:'json',
		        	  success:function(mm) {
		        		  if(mm.code == 300) {
		        			swal('删除失败', mm.msg, "error");  
		        			return;  
		        		  } 
		        		  swal({
								title:mm.msg,
								type:'success'
	    					},
	    					function(isConfirm) {
	    						if(isConfirm) {
	    							//左中空
	    							$("#sysPayInType").html("");
	    							$("#ziDingYiPayInType").html("");
	    							//重新查询一遍 
	    							loadPayInType();
	    						}
	    					}
	    				);
		        	  }
		           });
			} else {
				swal("取消", "已经取消删除", "error");
			}
		}	  	
	);
	});
}


//保存按钮单击事件
function savePayInTypeBtnClick() {
	$('#savePayInTypeBtn').click(function(){
		//非空校验
		if($.trim($("#payInTypeName").val()) == "") {
			$("#payInTypeName").attr("data-content", "类别名不能为空");
			$("#payInTypeName").popover("show");
			return;
		}
		//Ajax 
		$.ajax({
			type:'post',
			url:'payInType/insert',
			data:'name='+$.trim($("#payInTypeName").val()),
			dataType:'json',
			success:function(mm) {
				if(mm.code == 300) {
					swal("保存失败",mm.msg,"error");
					return;
				}
				swal({
						title:mm.msg,
						type:'success'
					},
					function(isConfirm) {
						if(isConfirm) {
							//左中空
							$("#sysPayInType").html("");
							$("#ziDingYiPayInType").html("");
							//重新查询一遍 
							loadPayInType();
							//清空表单
							$("#addPayInTypeForm")[0].reset();
						}
					}
				);
			}
		});
	});
}


//加载收入类别
function loadPayInType() {
	$.ajax({
		type:'post',
		url:'payInType/selectByUserIdForSelectOption',
		dataType:'json',
		success:function(list) {
			if(list == null) {
				return;
			}
			
			var sysPayInTypeOptions = "";
			var ziDingYiPayInTypeOptions = "";
			for(var i=0; i<list.length; i++) {
				if(list[i].userId == 0) {
					//系统的
					sysPayInTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				} else {
					//自定义的
					ziDingYiPayInTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				}
			}
			
			$("#sysPayInType").html(sysPayInTypeOptions);
			$("#ziDingYiPayInType").html(ziDingYiPayInTypeOptions);
			
		}
	});
}


//输入框得到焦点，提示框隐藏
function popoverHide() {
	$("#addPayInTypeForm input").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>