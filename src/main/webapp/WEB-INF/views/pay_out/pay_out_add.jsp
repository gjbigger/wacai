<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加支出</title>
    
    <link href="static/css/pay.out.css" rel="stylesheet">
</head>
<body>
<form id="pay_out_add_form">
    <div class="input_info">
        <label for="pay_out_money">金额</label>
        <input id="pay_out_money" type="number" name="money" data-placement="right" data-trigger="manual">
    </div>

    <div class="input_info">
        <label for="pay_out_big_type">类别</label>
        <select id="pay_out_big_type" name="bigTypeId" data-placement="right" data-trigger="manual">
        </select>

        <select id="pay_out_small_type" name="smallTypeId" data-placement="right" data-trigger="manual">
        </select>
    </div>

    <hr/>

    <div class="input_info">
        <label for="pay_out_account">账户</label>
        <select id="pay_out_account" name="accountId" data-placement="right" data-trigger="manual">
        </select>
    </div>

    <div class="input_info">
        <label for="pay_out_time">时间</label>
        <input id="pay_out_time" type="date" name="time" data-placement="right" data-trigger="manual">
    </div>

    <hr/>

    <div class="input_info">
        <label for="pay_out_remark">备注</label>
        <textarea id="pay_out_remark" name="remark"></textarea>
    </div>

    <div class="input_info" style="margin-left: 52px;margin-top: 20px;">
        <button id="pay_out_add_button" type="button" class="btn btn-success">保存</button>
    </div>
</form>

<script>
$(function(){
	loadPayOutAccount();
	loadPayOutBigType();
	payOutBigTypeChange();
	payOutPopoverHide();
	payOutAddButtonClick();
});

//加载账户
function loadPayOutAccount() {
	$.ajax({
		type:'post',
		url:'account/selectByUserIdAndTypeIdIsNot8ForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#pay_out_account").html($op);
		}
	});
}

//加载支出大类型
function loadPayOutBigType() {
	$.ajax({
		type:'post',
		url:'payOutBigType/selectByUserIdForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#pay_out_big_type").html($op);
		}
	});
}

//支出大类型选择了，加载相应的小类型
function payOutBigTypeChange() {
	$("#pay_out_big_type").change(function(){
		var $bigTypeId = $(this).val();
		if($bigTypeId == "") {
			$("#pay_out_small_type").html("");
			return;
		}
		$.ajax({
			type:'post',
			url:'payOutSmallType/selectByPidAndUserIdForSelectOption',
			data:'pid='+$bigTypeId,
			dataType:"json",
			success:function(list) {
				var $op = "<option value=''>请选择</option>";
				if(list==null || list.length<1) {
					return;
				}
				for(var i=0; i<list.length; i++) {
					$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
				}
				$("#pay_out_small_type").html($op);
			}
		});
	});
}

//收入的保存按钮点击事件
function payOutAddButtonClick() {
	$("#pay_out_add_button").click(function(){
		//非空校验
		if($.trim($("#pay_out_money").val()) == "") {
   			$("#pay_out_money").attr("data-content", "金额不能为空");
   			$("#pay_out_money").popover("show");
   			return;
    	}
		if($.trim($("#pay_out_big_type").val()) == "") {
   			$("#pay_out_big_type").attr("data-content", "支出大类型不能为空");
   			$("#pay_out_big_type").popover("show");
   			return;
    	}
		if($.trim($("#pay_out_small_type").val()) == "") {
   			$("#pay_out_small_type").attr("data-content", "支出小类型不能为空");
   			$("#pay_out_small_type").popover("show");
   			return;
    	}
		if($.trim($("#pay_out_account").val()) == "") {
   			$("#pay_out_account").attr("data-content", "所属账户不能为空");
   			$("#pay_out_account").popover("show");
   			return;
    	}
    	if($.trim($("#pay_out_time").val()) == "") {
   			$("#pay_out_time").attr("data-content", "时间不能为空");
   			$("#pay_out_time").popover("show");
   			return;
    	}
    	//异步发送请求
		$.ajax({
			type:'post',
			url:'payOut/insert',
			data:$('#pay_out_add_form').serialize(),
			dataType:'json',
			success:function(mm){
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
							//清空表单
							$(':input',"#pay_out_add_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
							$("#pay_out_small_type").html("");
						}
					}
				);
			}
		});
	});
}

//输入框得到焦点，提示框隐藏
function payOutPopoverHide() {
	$("#pay_out_add_form input,#pay_out_add_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>