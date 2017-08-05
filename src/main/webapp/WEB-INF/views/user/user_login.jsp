<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <style>
        #user_login_form input,#user_login_form button {
            margin-top: 30px;
            height: 35px;
            width: 250px;
            padding-left: 10px;
            margin-left: 50px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-default" style="background-color: white;">
    <div class="container-fluid">

        <!--  导航头  -->
        <div class="navbar-header" style="margin-left: 65px;height:70px;">
            <!--  品牌logo  -->
            <a class="navbar-brand" href="#" style="margin-left: 50px;border-right: 1px solid #ccc;margin-top: 10px;">
                <img src="static/images/logo.png" style="height: 30px;margin-top: -5px;"/>
            </a>
            <span style="margin-left: 20px;font-size: 18px;line-height: 70px;color: #666;">
                欢迎来到挖财
            </span>

            <button id="registerNewUserBtn" class="btn btn-warning" style="margin-left: 650px;">注册新用户</button>
        </div>
    </div>
</nav>


<div style="float: left;margin-left: 200px;">
    <img src="static/images/c04cd69543d1009f_540x450.png" />
</div>


<div style="float: right;border: 1px solid #ccc;height: 400px;width: 350px;margin-right: 200px;margin-top: 30px;">
    <span style="font-size: 22px;margin-left: 130px;margin-top: 20px;display: block;">登录挖财</span>
    <form id="user_login_form">
        <input value="${loginUserName}" id="userName" name="userName" placeholder="用户名" type="text" data-placement="right" data-trigger="manual"/>
        <input id="userPwd" name="userPwd" placeholder="您的密码" type="password" data-placement="right" data-trigger="manual"/>
        <div>
            <input name="autoLogin" value="1" type="checkbox" style="width:15px;height:15px;">
            <span style="font-size: 12px;margin-top:10px;position:relative;top:-3px;">7天内自动登录</span>
            <a href="#" style="font-size: 12px;position: relative;top: -3px;right: -90px;">忘记密码？</a>
        </div>
        <button id="userLoginBtn" type="button" class="btn btn-danger" style="height: 35px;">登录</button>
    </form>
</div>

<script>
$(function(){
	registerNewUserBtnClick();
	userLoginBtnClick();
});

//注册新账号按钮点击事件
function registerNewUserBtnClick() {
	$("#registerNewUserBtn").click(function(){
		window.location.href="user/toUserRegisterJsp";
	});
}
	
//登录按钮点击事件	
function userLoginBtnClick() {
	$("#userLoginBtn").click(function(){
		//去除前后空格
		var $userName = $.trim($("#userName").val());
		var $userPwd = $.trim($("#userPwd").val());
		//非空校验
		if($userName == "") {
			$("#userName").attr("data-content", "用户名不能为空");
			$("#userName").popover("show");
			return;
		}
		if($userPwd == "") {
			$("#userPwd").attr("data-content", "密码不能为空");
			$("#userPwd").popover("show");
			return;
		}
		//合法性校验,输入的内容符合规范
		if(!$userName.match(/^\w+$/)) {
				$("#userName").attr("data-content", "只能包含字母数字下划线");
				$("#userName").popover("show");
				return;
		}
		if(!$userPwd.match(/^\w+$/)) {
			$("#userPwd").attr("data-content", "只能包含字母数字下划线");
			$("#userPwd").popover("show");
			return;
		}
		//异步发送请求
		$.ajax({
			type:'post',
			url:'user/userLogin',
			data:$("#user_login_form").serialize(),
			dataType:'json',
			success:function(mm) {
				if(mm.code == 300) {
					swal("错误码："+mm.code, mm.msg);
					return;
				}
				window.location.href="index/toIndexJsp";
			}
		});
	});
}	
</script>
</html>