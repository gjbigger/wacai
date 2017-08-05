<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <style>
        #user_register_form input,#user_register_form button {
            margin-top: 30px;
            height: 35px;
            width: 250px;
            padding-left: 10px;
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

            <button id="loginExistUserBtn" class="btn btn-warning" style="margin-left: 650px;">登录已有账号</button>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">

        <div class="col-md-10 col-md-offset-1" style="border:1px solid lightgrey;height: 500px;">
            <div style="width:910px;font-size: 22px;border-bottom: 1px solid #ccc;padding-bottom: 15px;margin-top: 20px;margin-left: 15px;">
                注册新用户
            </div>

            <div>

                <div style="float: left;width:270px;margin-left: 70px;margin-top: 20px;">
                    <form id="user_register_form">
                        <input id="userName" name="userName" placeholder="用户名" type="text" data-placement="right" data-trigger="manual"/>
                        <input id="userPwd" name="userPwd" placeholder="您的密码"  type="password" data-placement="right" data-trigger="manual"/>
                        <input id="confirmPwd" name="confirmPwd" placeholder="确认密码"  type="password" data-placement="right" data-trigger="manual"/>
                        <input id="kaptcha" name="kaptcha" placeholder="请输入图形验证码" type="text" style="width:150px;" data-placement="right" data-trigger="manual"/>
                        <img id="kaptchaImage" src="kaptcha.jpg" style="margin-top:-2px;margin-left:10px;width: 86px;height: 34px;" title="看不清，点击换一张"/>

                        <button id="userRegisterBtn" type="button" class="btn btn-danger" style="height: 35px;">注册</button>
                    </form>
                </div>

                <div style="padding-top: 10px;float: right;margin-right: 20px;">
                    <img src="static/images/c0d0367a4c1627bf_520x410.png"/>
                </div>

            </div>
        </div>

    </div>
</div>

<script>
	$(function(){
		kaptchaImageClick();
		loginExistUserBtnClick();
		userRegisterBtnClick();
		popoverHide();
	});
	
	//验证码图片点击事件，更换一张新图片
	function kaptchaImageClick() {
		$("#kaptchaImage").click(function(){
			$(this).attr("src", "kaptcha.jpg?" + Math.floor(Math.random() * 100));
		});
	}
	
	//登录已有账号按钮点击事件，跳到登录界面
	function loginExistUserBtnClick() {
		$("#loginExistUserBtn").click(function(){
			window.location.href="user/toUserLoginJsp";
		});
	}
	
	//注册按钮点击事件，执行注册
	function userRegisterBtnClick() {
		$("#userRegisterBtn").click(function(){
			//去前后空格
			var $userName = $.trim($("#userName").val());
			var $userPwd = $.trim($("#userPwd").val());
			var $confirmPwd = $.trim($("#confirmPwd").val());
			var $kaptcha = $.trim($("#kaptcha").val());
			$("#userName").val($userName);
			$("#userPwd").val($userPwd);
			$("#confirmPwd").val($confirmPwd);
			$("#kaptcha").val($kaptcha);
			//非空校验
			if(!blankCheck()) {
				return;
			}
			//合法性校验,两次密码输入相同,输入的内容符合规范
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
			if(!$confirmPwd.match(/^\w+$/)) {
				$("#confirmPwd").attr("data-content", "只能包含字母数字下划线");
				$("#confirmPwd").popover("show");
				return;
			}
			if($userPwd != $confirmPwd) {
				$("#confirmPwd").attr("data-content", "两次输入密码不一致");
				$("#confirmPwd").popover("show");
				return;
			}
			//异步发送请求
			$.ajax({
				type:'post',
				url:'user/userRegister',
				data:$("#user_register_form").serialize(),
				dataType:'json',
				success:function(mm) {
					if(mm.code == 300) {
						swal("错误码："+mm.code, mm.msg);
						$("#kaptcha").val("");
						$("#kaptchaImage").get(0).click();
						return;
					}
					swal({
							title:mm.msg,
							text:"点击OK跳转到登录页面",
							type:'success',
						},
						function(r) {
							if(r) {
								window.location.href="user/toUserLoginJsp?userName="+mm.obj;
							}
						}
					);
				}
			});
		});
	}
	
	//input框获得焦点，提示隐藏
	function popoverHide() {
		$("#user_register_form>input").on("focus", function(){
			$(this).popover("hide");
		});	
	}
	
	//空校验，空返回false，非空返回true
	function blankCheck() {
		if($("#userName").val() == "") {
			$("#userName").attr("data-content", "用户名不能为空");
			$("#userName").popover("show");
			return false;
		}
		if($("#userPwd").val() == "") {
			$("#userPwd").attr("data-content", "密码不能为空");
			$("#userPwd").popover("show");
			return false;
		}
		if($("#confirmPwd").val() == "") {
			$("#confirmPwd").attr("data-content", "确认密码不能为空");
			$("#confirmPwd").popover("show");
			return false;
		}
		if($("#kaptcha").val() == "") {
			$("#kaptcha").attr("data-content", "验证码不能为空");
			$("#kaptcha").popover("show");
			return false;
		}
		return true;
	}
</script>
</body>
</html>