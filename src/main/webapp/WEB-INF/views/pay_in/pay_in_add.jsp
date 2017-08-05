<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加收入</title>

    <link href="static/css/pay.in.css" rel="stylesheet">
</head>
<body>
    <form id="pay_in_add_form">
        <div class="input_info">
            <label for="pay_in_money">金额</label>
            <input id="pay_in_money" type="number" name="money" data-placement="right" data-trigger="manual">
        </div>

        <div class="input_info">
            <label for="pay_in_type">类别</label>
            <select id="pay_in_type" name="typeId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <hr />

        <div class="input_info">
            <label for="pay_in_account">账户</label>
            <select id="pay_in_account" name="accountId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <div class="input_info">
            <label for="pay_in_time">时间</label>
            <input id="pay_in_time" type="date" name="time" data-placement="right" data-trigger="manual">
        </div>

        <hr />

        <div class="input_info">
            <label for="pay_in_remark">备注</label>
            <textarea id="pay_in_remark" name="remark"></textarea>
        </div>

        <div  class="input_info" style="margin-left: 52px;margin-top: 20px;">
            <button id="pay_in_add_button" type="button" class="btn btn-success">保存</button>
        </div>
    </form>

<script>
$(function(){
	loadPayInAccount();
	loadPayInType();
	payInAddButtonClick();
	payInPopoverHide();
});

//加载账户
function loadPayInAccount() {
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
			$("#pay_in_account").html($op);
		}
	});
}

//加载收入类型
function loadPayInType() {
	$.ajax({
		type:'post',
		url:'payInType/selectByUserIdForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#pay_in_type").html($op);
		}
	});
}

//收入的保存按钮点击事件
function payInAddButtonClick() {
	$("#pay_in_add_button").click(function(){
		//非空校验
		if($.trim($("#pay_in_money").val()) == "") {
   			$("#pay_in_money").attr("data-content", "金额不能为空");
   			$("#pay_in_money").popover("show");
   			return;
    	}
		if($.trim($("#pay_in_type").val()) == "") {
   			$("#pay_in_type").attr("data-content", "收入类型不能为空");
   			$("#pay_in_type").popover("show");
   			return;
    	}
		if($.trim($("#pay_in_account").val()) == "") {
   			$("#pay_in_account").attr("data-content", "所属账户不能为空");
   			$("#pay_in_account").popover("show");
   			return;
    	}
    	if($.trim($("#pay_in_time").val()) == "") {
   			$("#pay_in_time").attr("data-content", "时间不能为空");
   			$("#pay_in_time").popover("show");
   			return;
    	}
    	//异步发送请求
    	//异步请求
		$.ajax({
			type:'post',
			url:'payIn/insert',
			data:$('#pay_in_add_form').serialize(),
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
							$(':input',"#pay_in_add_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
						}
					}
				);
			}
		});
	});
}

//输入框得到焦点，提示框隐藏
function payInPopoverHide() {
	$("#pay_in_add_form input,#pay_in_add_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>