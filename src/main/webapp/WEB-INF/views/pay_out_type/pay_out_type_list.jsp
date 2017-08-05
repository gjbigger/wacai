<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支出类别管理</title>
<style>

select option{
	padding-left: 20px;
	padding-top: 5px;
	padding-bottom: 5px;
}

</style>
</head>
<body>
	<!-- 左边 -->
	<div style="margin-left:20px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">支出大类别(预设)</p>
			<select id="sysPayOutType" multiple="multiple" style="display: block;width:200px;height:200px;">
			</select>
		
			<p align="center" style="margin-top: 20px;">支出大类别(自定义)</p>
			<select id="ziDingYiPayOutType" multiple="multiple" style="display: block;width:200px;height:200px;">
			</select>
			
			<button id="delBigTypeBtn" style="margin-top: 15px;margin-left: 30px;" type="button" class="btn btn-danger">删除自定义大类别</button>
	</div>
	
	<!-- 中间 -->
	<div style="margin-left:100px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">支出小类别(预设)</p>
			<select id="sysPayOutTypeSmall" multiple="multiple" style="display: block;width:200px;height:200px;">
			</select>
		
			<p align="center" style="margin-top: 20px;">支出小类别(自定义)</p>
			<select id="ziDingYiPayOutTypeSmall" multiple="multiple" style="display: block;width:200px;height:200px;">
			</select>
			
			<button id="delSmallTypeBtn" style="margin-top: 15px;margin-left: 30px;" type="button" class="btn btn-danger">删除自定义小类别</button>
	</div>
	
	
	<!-- 右边 -->
	<div style="margin-left:100px;margin-top:25px;display: inline-block;float: left;">
			<p align="center">添加自定义大类别</p>
			<form id="addBigTypeForm" style="display: block;width:200px;height:200px;border:1px solid lightgrey;">
				<label for="myBigType" style="margin-left:10px;margin-top:10px;font-weight: normal;margin-right: 10px;">类别名：</label>
				<input id="myBigType" type="text" style="margin-left: 10px;" data-placement="right" data-trigger="manual"/>
				
				<button id="saveBigTypeBtn" class="btn btn-success" type="button" style="margin-top: 10px;margin-left: 10px;">保存</button>
				<button class="btn btn-warning" type="reset" style="margin-top: 10px;margin-left: 10px;">重置</button>
			</form>
		
			<p align="center" style="margin-top: 20px;">添加自定义小类别</p>
			<form id="addSmallTypeForm" style="display: block;width:200px;height:200px;border:1px solid lightgrey;">
				<label for="mySmallType" style="margin-left:10px;margin-top:10px;font-weight: normal;margin-right: 10px;">类别名：</label>
				<input id="mySmallType" type="text" style="margin-left: 10px;" data-placement="right" data-trigger="manual"/>
				
				<label for="mySmallTypePid" style="margin-left:10px;margin-top:10px;font-weight: normal;margin-right: 10px;">所属大类别：</label>
				<select id="mySmallTypePid" type="text" style="margin-left: 10px;width: 175px;height: 27px;" data-placement="right" data-trigger="manual">
				</select>
				
				<button id="saveSmallTypeBtn" class="btn btn-success" type="button" style="margin-top: 10px;margin-left: 10px;">保存</button>
				<button class="btn btn-warning" type="reset" style="margin-top: 10px;margin-left: 10px;">重置</button>
			</form>
	</div>
	
	
<script>
$(function(){
	loadPayOutBigType();
	sysPayOutTypeSelect();
	ziDingYiPayOutSelect();
	popoverHide2();
	saveBigTypeBtnClick();
	delBigTypeBtnClick();
	delSmallTypeBtnClick();
	saveSmallTypeBtnClick();
	sysPayOutTypeSmallSelect();
	ziDingYiPayOutSmallSelect();
});


//支出小类别选择事件,系统
function sysPayOutTypeSmallSelect() {
	$("#sysPayOutTypeSmall").click(function(){
		//清空自定义的小类型的选中
		$("#ziDingYiPayOutTypeSmall").val("");
		
	});
}

//支出小类别选择事件，自定义
function ziDingYiPayOutSmallSelect() {
	$("#ziDingYiPayOutTypeSmall").click(function(){
		//清空预设的小类型的选中
		$("#sysPayOutTypeSmall").val("");
		
	});
}




//小类别保存按钮单击事件
function saveSmallTypeBtnClick() {
	$("#saveSmallTypeBtn").click(function(){
		//非空校验
		if($.trim($("#mySmallType").val()) == "") {
			$("#mySmallType").attr("data-content", "小类别名不能为空");
			$("#mySmallType").popover("show");
			return;
		}
		if($("#mySmallTypePid").val() == "" || $("#mySmallTypePid").val() == null) {
			$("#mySmallTypePid").attr("data-content", "所属大类别不能为空");
			$("#mySmallTypePid").popover("show");
			return;
		}
		//Ajax 
		$.ajax({
			type:'post',
			url:'payOutSmallType/insert',
			data:'name='+$.trim($("#mySmallType").val())+"&pid="+$("#mySmallTypePid").val(),
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
							//中空
							$("#sysPayOutTypeSmall").html("");
							$("#ziDingYiPayOutTypeSmall").html("");
							//重新查询一遍 
							loadPayOutBigType();
							//清空表单
							$("#addSmallTypeForm")[0].reset();
						}
					}
				);
			}
		});
	});
}


//删除小类型按钮单击事件
function delSmallTypeBtnClick() {
	$('#delSmallTypeBtn').click(function(){
		var arr = $("#ziDingYiPayOutTypeSmall").val().toString().split(",");
		if(arr.length==1 && arr[0]=="") {
			return;
		}
		if(arr.length > 1) {
			swal("失败","只能选择一个自定义的支出小类型","error");
			return;
		}
		
		var text =  $("#ziDingYiPayOutTypeSmall").find("option:selected").text();
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
		        	  url:'payOutSmallType/delete',
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
	    							//中空
	    							$("#sysPayOutTypeSmall").html("");
	    							$("#ziDingYiPayOutTypeSmall").html("");
	    							//重新查询一遍 
	    							loadPayOutBigType();
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




//删除大类型按钮单击事件
function delBigTypeBtnClick() {
	$('#delBigTypeBtn').click(function(){
		var arr = $("#ziDingYiPayOutType").val().toString().split(",");
		if(arr.length==1 && arr[0]=="") {
			return;
		}
		if(arr.length > 1) {
			swal("失败","只能选择一个自定义的支出大类型","error");
			return;
		}
		
		var text =  $("#ziDingYiPayOutType").find("option:selected").text();
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
		        	  url:'payOutBigType/delete',
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
	    							//中空
	    							$("#sysPayOutTypeSmall").html("");
	    							$("#ziDingYiPayOutTypeSmall").html("");
	    							//重新查询一遍 
	    							loadPayOutBigType();
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


//大类别保存按钮单击事件
function saveBigTypeBtnClick() {
	$("#saveBigTypeBtn").click(function(){
		//非空校验
		if($.trim($("#myBigType").val()) == "") {
			$("#myBigType").attr("data-content", "大类别名不能为空");
			$("#myBigType").popover("show");
			return;
		}
		//Ajax 
		$.ajax({
			type:'post',
			url:'payOutBigType/insert',
			data:'name='+$.trim($("#myBigType").val()),
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
							//中空
							$("#sysPayOutTypeSmall").html("");
							$("#ziDingYiPayOutTypeSmall").html("");
							//重新查询一遍 
							loadPayOutBigType();
							//清空表单
							$("#addBigTypeForm")[0].reset();
						}
					}
				);
			}
		});
	});
}


//支出大类别选择事件,系统
function sysPayOutTypeSelect() {
	$("#sysPayOutType").click(function(){
		//清空小类型
		$("#sysPayOutTypeSmall").html("");
		$("#ziDingYiPayOutTypeSmall").html("");
		//清空自定义的大类型的选中
		$("#ziDingYiPayOutType").val("");
		//判断是否多选
		var arr = $(this).val().toString().split(",");
		if(arr.length > 1) {
			$("#sysPayOutType").val("");
			return;
		}
		$("#sysPayOutType").val($(this).val());
		
		loadPayOutSmallType($(this).val());
	});
}

//支出大类别选择事件，自定义
function ziDingYiPayOutSelect() {
	$("#ziDingYiPayOutType").click(function(){
		//清空小类型
		$("#sysPayOutTypeSmall").html("");
		$("#ziDingYiPayOutTypeSmall").html("");
		//清空预设的大类型的选中
		$("#sysPayOutType").val("");
		//判断是否多选
		var arr = $(this).val().toString().split(",");
		if(arr.length > 1) {
			$("#ziDingYiPayOutType").val("");
			return;
		}
		$("#ziDingYiPayOutType").val($(this).val());
		
		loadPayOutSmallType($(this).val());
	});
}

//根据大类别id加载支出小类别
function loadPayOutSmallType(bigTypeId) {
	$.ajax({
		type:'post',
		url:'payOutSmallType/selectByPidAndUserIdForSelectOption?pid='+bigTypeId,
		dataType:'json',
		success:function(list) {
			if(list == null) {
				return;
			}
			
			var sysPayOutTypeOptions = "";
			var ziDingYiPayOutTypeOptions = "";
			for(var i=0; i<list.length; i++) {
				if(list[i].userId == 0) {
					//系统的
					sysPayOutTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				} else {
					//自定义的
					ziDingYiPayOutTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				}
			}
			
			$("#sysPayOutTypeSmall").html(sysPayOutTypeOptions);
			$("#ziDingYiPayOutTypeSmall").html(ziDingYiPayOutTypeOptions);
			
			
		}
	});
}


//加载支出大类别
function loadPayOutBigType() {
	$.ajax({
		type:'post',
		url:'payOutBigType/selectByUserIdForSelectOption',
		dataType:'json',
		success:function(list) {
			if(list == null) {
				return;
			}
			
			var sysPayOutTypeOptions = "";
			var ziDingYiPayOutTypeOptions = "";
			for(var i=0; i<list.length; i++) {
				if(list[i].userId == 0) {
					//系统的
					sysPayOutTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				} else {
					//自定义的
					ziDingYiPayOutTypeOptions += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				}
			}
			
			$("#sysPayOutType").html(sysPayOutTypeOptions);
			$("#ziDingYiPayOutType").html(ziDingYiPayOutTypeOptions);
			
			//加载到添加form
			$("#mySmallTypePid").html("<option value=''>请选择</option>"+sysPayOutTypeOptions+ziDingYiPayOutTypeOptions);
		}
	});
}


//输入框得到焦点，提示框隐藏
function popoverHide2() {
	$("#addBigTypeForm input,#addSmallTypeForm select,#addSmallTypeForm input").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>