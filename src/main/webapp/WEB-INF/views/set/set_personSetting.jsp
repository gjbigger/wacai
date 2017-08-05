<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个性化设置</title>
</head>
<body>

<div style="margin-left: 20px;">
  
  	<span id="defaultAccountUnitId" style="display: none;">${user.defaultAccountUnitId }</span>
  
	<div style="font-weight:bold;border-bottom: 1px #CAD0D8 solid;height:50px;line-height:50px ;">币种设置</div>
	
	<div style="margin-top: 20px;margin-left: 60px;width: 600px;">
		<span>默认币种</span>
		<select id="defaultAccountUnit" style="margin-left: 20px;width: 125px;height: 27px;"></select>
		<span style="color: #787A89;margin-left: 20px;">修改后, 将会影响报表以及统计汇总中数据的默认统计币种</span>
		<button id="defaultAccountUnitSaveBtn" type="button" style="margin-top: 20px;width:100px;" class="btn btn-success btn-sm">保存</button>
	</div>
</div>

<script>
$(function(){
	loadDefaultAccountUnit();
	defaultAccountUnitSaveBtnClick();
});


//加载默认账户币种
function loadDefaultAccountUnit() {
	$.ajax({
		type:'post',
		url:'accountUnit/selectAllForSelectOption',
		async:false,
		dataType:"json",
		success:function(list) {
			if(list == null || list.length <=0) {
				return;
			}
			var op = "<option value=''>请选择</option>";
			for(var i=0; i<list.length; i++) {
				op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
			}
			$("#defaultAccountUnit").html(op);
			var $sessionUserDefaultAccountUnitId = $("#defaultAccountUnitId").html();
			$("#defaultAccountUnit").val($sessionUserDefaultAccountUnitId);
		}
	});
}


//默认账户币种保存按钮单击事件
function defaultAccountUnitSaveBtnClick() {
	$("#defaultAccountUnitSaveBtn").click(function(){
		var $defaultAccountUnit = $("#defaultAccountUnit").val();
		
		if($defaultAccountUnit == '') {
			swal("错误","默认币种不能为空","error");
			return;
		}
		
		$.ajax({
			type:'post',
			url:'user/userChangeDefaultAccountUnit',
			data:"defaultAccountUnitId="+$defaultAccountUnit,
			dataType:'json',
			success:function(mm) {
				if(mm.code == 0) {
					return;
				}
				if(mm.code == 300) {
					swal("保存失败",mm.msg,"error");
					return;
				}
				swal({
					title:mm.msg,
					type:'success'
				});

			}
		});
	});
}
</script>
</body>
</html>