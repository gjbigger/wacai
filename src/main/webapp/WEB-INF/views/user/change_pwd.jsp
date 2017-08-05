<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>

    <link href="static/css/user.change.pwd.css" rel="stylesheet">
</head>
<body>
    <form id="change_pwd_form">
        <div class="input_info">
            <label for="change_pwd_old_pwd">原密码</label>
            <input id="change_pwd_old_pwd" type="password" name="old_pwd" data-placement="right" data-trigger="manual">
        </div>

		<div class="input_info">
            <label for="change_pwd_new_pwd">新密码</label>
            <input id="change_pwd_new_pwd" type="password" name="new_pwd" data-placement="right" data-trigger="manual">
        </div>
        
        <div class="input_info">
            <label for="change_pwd_new_pwd_confirm">新密码确认</label>
            <input id="change_pwd_new_pwd_confirm" type="password" name="new_pwd_confirm" data-placement="right" data-trigger="manual">
        </div>
        
        <div  class="input_info" style="margin-left: 52px;margin-top: 20px;">
            <button id="change_pwd_save_btn" type="button" class="btn btn-success">保存</button>
        </div>
    </form>

<script>
$(function(){
	changePwdSaveBtnClick();
	popoverHide();
});


function changePwdSaveBtnClick() {
	$("#change_pwd_save_btn").click(function(){
		//去前后空格
		var $oldPwd = $.trim($("#change_pwd_old_pwd").val());
		var $newPwd = $.trim($("#change_pwd_new_pwd").val());
		var $newPwdConfirm = $.trim($("#change_pwd_new_pwd_confirm").val());
		//非空校验
		if($oldPwd == "") {
			$("#change_pwd_old_pwd").attr("data-content", "旧密码不能为空");
			$("#change_pwd_old_pwd").popover("show");
			return;
		}
		if($newPwd == "") {
			$("#change_pwd_new_pwd").attr("data-content", "新密码不能为空");
			$("#change_pwd_new_pwd").popover("show");
			return;
		}
		if($newPwdConfirm == "") {
			$("#change_pwd_new_pwd_confirm").attr("data-content", "确认密码不能为空");
			$("#change_pwd_new_pwd_confirm").popover("show");
			return;
		}
		//合法性校验,两次密码输入相同,输入的内容符合规范
		if($newPwd != $newPwdConfirm) {
			$("#change_pwd_new_pwd_confirm").attr("data-content", "两次输入密码不一致");
			$("#change_pwd_new_pwd_confirm").popover("show");
			return;
		}
		//ajax
		$.ajax({
			type:'post',
			url:'user/userChangePwd',
			data:'oldPwd='+$oldPwd+"&newPwd="+$newPwd+"&newPwdConfirm="+$newPwdConfirm,
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
						//清空表单
						$(':input',"#change_pwd_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
						window.location.href="user/userLogout";
					}
				}
			);
			}
		});
	});
}


//input框获得焦点，提示隐藏
function popoverHide() {
	$("#change_pwd_form>input").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>
</html>