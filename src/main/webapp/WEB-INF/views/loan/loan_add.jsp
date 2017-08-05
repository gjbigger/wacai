<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加借贷</title>

    <link href="static/css/loan.css" rel="stylesheet">
</head>
<body>
    <form id="loan_add_form">
        <div class="input_info">
            <label for="loan_money">金额</label>
            <input id="loan_money" type="number" name="money" data-placement="right" data-trigger="manual">
        </div>

        <div class="input_info">
            <label for="loan_type">类别</label>
            <select id="loan_type" name="typeId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <hr />

        <div class="input_info">
            <label for="loan_body_account" id="loan_body_label">债权人</label>
            <select id="loan_body_account" name="loanBodyAccountId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <div class="input_info">
            <label for="loan_account" id="loan_account_label">借入账户</label>
            <select id="loan_account" name="accountId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <div class="input_info">
            <label for="loan_time">时间</label>
            <input id="loan_time" type="date" name="time" data-placement="right" data-trigger="manual">
        </div>

        <hr />

        <div class="input_info">
            <label for="loan_remark">备注</label>
            <textarea id="loan_remark" name="remark"></textarea>
        </div>

        <div  class="input_info" style="margin-left: 52px;margin-top: 20px;">
            <button id="loan_add_button" type="button" class="btn btn-success">保存</button>
        </div>
    </form>
    
<script>
$(function() {
	loanTypeChange();
	loadLoanAccountIsNot8();
	loadLoanAccountIs8();
	loadLoanType();
	loanAddButtonClick();
	loanPopoverHide();
});

//借贷类型改变，提示信息随之改变
function loanTypeChange() {
	$("#loan_type").change(function() {
		var $loanTypeId = $(this).val();
		var $loanTypeText = $(this).find("option:selected").text();

		$("#loan_account_label").html($loanTypeText + "账户");

		if ($loanTypeId === '1' || $loanTypeId === '4') {
			$("#loan_body_label").html("债权人 ");
		} else if ($loanTypeId === '2' || $loanTypeId === '3') {
			$("#loan_body_label").html("债务人 ");
		}
	});
}

//加载账户
function loadLoanAccountIsNot8() {
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
			$("#loan_account").html($op);
		}
	});
}

//加载债权人债务人账户
function loadLoanAccountIs8() {
	$.ajax({
		type:'post',
		url:'account/selectByUserIdAndTypeIdIs8ForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#loan_body_account").html($op);
		}
	});
}

//加载借贷类型
function loadLoanType() {
	$.ajax({
		type:'post',
		url:'loanType/selectAllForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#loan_type").html($op);
		}
	});
}


//借贷保存按钮点击事件
function loanAddButtonClick() {
	$("#loan_add_button").click(function(){
		//非空校验
		if($.trim($("#loan_money").val()) == "") {
   			$("#loan_money").attr("data-content", "金额不能为空");
   			$("#loan_money").popover("show");
   			return;
    	}
		if($.trim($("#loan_type").val()) == "") {
   			$("#loan_type").attr("data-content", "收入类型不能为空");
   			$("#loan_type").popover("show");
   			return;
    	}
		if($.trim($("#loan_account").val()) == "") {
   			$("#loan_account").attr("data-content", "账户不能为空");
   			$("#loan_account").popover("show");
   			return;
    	}
		if($.trim($("#loan_body_account").val()) == "") {
   			$("#loan_body_account").attr("data-content", "债权/债务人不能为空");
   			$("#loan_body_account").popover("show");
   			return;
    	}
    	if($.trim($("#loan_time").val()) == "") {
   			$("#loan_time").attr("data-content", "时间不能为空");
   			$("#loan_time").popover("show");
   			return;
    	}
    	//判断账户币种
    	var $loanAccountUnit = $("#loan_account").find("option:selected").text().split(/ -- /)[1];
    	var $loanBodyAccountUnit = $("#loan_body_account").find("option:selected").text().split(/ -- /)[1];
    	if($loanAccountUnit != $loanBodyAccountUnit) {
    		$("#loan_body_account").attr("data-content", "账户币种不一致，不能借贷");
   			$("#loan_body_account").popover("show");
   			return;
    	}
    	//异步发送请求
		$.ajax({
			type:'post',
			url:'loan/insert',
			data:$('#loan_add_form').serialize(),
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
							$(':input',"#loan_add_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
						}
					}
				);
			}
		});
	});
}

//输入框得到焦点，提示框隐藏
function loanPopoverHide() {
	$("#loan_add_form input,#loan_add_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>