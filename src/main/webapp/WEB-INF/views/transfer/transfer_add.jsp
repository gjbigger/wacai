<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>添加转账</title>

    <link href="static/css/transfer.css" rel="stylesheet">
</head>
<body>
    <form id="transfer_add_form">
        <div class="input_info">
            <label for="transfer_src_account">账户</label>
            <select id="transfer_src_account" name="srcAccountId" data-placement="right" data-trigger="manual">
            </select>

            <span class="glyphicon glyphicon-arrow-right" style="margin-left: 20px;margin-right: 20px;"></span>

            <select id="transfer_dest_account" name="destAccountId" data-placement="right" data-trigger="manual">
            </select>
        </div>

        <div class="input_info">
            <label for="transfer_src_money">金额</label>
            <input id="transfer_src_money" type="number" name="srcMoney" data-placement="right" data-trigger="manual">

            <span class="glyphicon glyphicon-arrow-right" style="margin-left: 20px;margin-right: 20px;"></span>

            <input id="transfer_dest_money" type="number" readonly name="destMoney" data-placement="right" data-trigger="manual">
        </div>

        <hr />

        <div class="input_info">
            <label for="transfer_time">时间</label>
            <input id="transfer_time" type="date" name="time" data-placement="right" data-trigger="manual">
        </div>

        <hr />

        <div class="input_info">
            <label for="transfer_remark">备注</label>
            <textarea id="transfer_remark" name="remark"></textarea>
        </div>

        <div  class="input_info" style="margin-left: 52px;margin-top: 20px;">
            <button id="transfer_add_button" type="button" class="btn btn-success">保存</button>
        </div>
    </form>
    

<script>
$(function(){
	loadTransferAccount();
	transferPopoverHide();
	transferAddButtonClick();
	transferSrcAccountChange();
	transferDestAccountChange();
	transferSrcMoneyBlur();
});

//转出账户改变事件
function transferSrcAccountChange() {
	$("#transfer_src_account").change(function(){
		calculateTransferDestMoney();
	});
}

//转入账户改变事件
function transferDestAccountChange() {
	$("#transfer_dest_account").change(function(){
		calculateTransferDestMoney();
	});
}

//转出金额失去焦点事件
function transferSrcMoneyBlur() {
	$("#transfer_src_money").blur(function(){
		calculateTransferDestMoney();
	});
}

//计算转入金额
function calculateTransferDestMoney() {
	var $srcAccount = $("#transfer_src_account").val();
	var $destAccount = $("#transfer_dest_account").val();
	var $srcMoney = $("#transfer_src_money").val();
	if($srcAccount == "" || $destAccount == "" || $srcMoney == "") {
		$("#transfer_dest_money").val("");
		return;
	}
	var $srcUnit = $("#transfer_src_account").find("option:selected").text().split(/ -- /)[1];
	var $destUnit = $("#transfer_dest_account").find("option:selected").text().split(/ -- /)[1];
	var $destMoney = fx($srcMoney).from($srcUnit).to($destUnit);
	$("#transfer_dest_money").val($destMoney);
}

//加载账户
function loadTransferAccount() {
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
			$("#transfer_src_account").html($op);
			$("#transfer_dest_account").html($op);
		}
	});
}




//收入的保存按钮点击事件
function transferAddButtonClick() {
	$("#transfer_add_button").click(function(){
		//非空校验
		if($.trim($("#transfer_src_account").val()) == "") {
   			$("#transfer_src_account").attr("data-content", "转出账户不能为空");
   			$("#transfer_src_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
		if($.trim($("#transfer_dest_account").val()) == "") {
   			$("#transfer_dest_account").attr("data-content", "转入账户不能为空");
   			$("#transfer_dest_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
		if($.trim($("#transfer_src_money").val()) == "") {
   			$("#transfer_src_money").attr("data-content", "转出金额不能为空");
   			$("#transfer_src_money").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
    	if($.trim($("#transfer_time").val()) == "") {
   			$("#transfer_time").attr("data-content", "转账时间不能为空");
   			$("#transfer_time").popover("show");
   			return;
    	}
    	//判断转入账户和转出账户是否是一个账户
    	if($.trim($("#transfer_src_account").val()) == $.trim($("#transfer_dest_account").val())) {
   			$("#transfer_dest_account").attr("data-content", "转出账户与转入账户不能为同一账户");
   			$("#transfer_dest_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
    	//得到转入金额
    	calculateTransferDestMoney();
    	//异步发送请求
		$.ajax({
			type:'post',
			url:'transfer/insert',
			data:$('#transfer_add_form').serialize(),
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
							$(':input',"#transfer_add_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
						}
					}
				);
			}
		});
	});
}

//输入框得到焦点，提示框隐藏
function transferPopoverHide() {
	$("#transfer_add_form input,#transfer_add_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>    
</body>
</html>