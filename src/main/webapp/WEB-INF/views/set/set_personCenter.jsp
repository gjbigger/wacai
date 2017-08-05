<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    
    <style>
    	#set_person_center-tablist li a {
			font-size: 15px;
			color: black;
			font-weight: bold;
		}
    </style>
</head>
<body>

<div>
    <!-- Nav tabs -->
    <ul id="set_person_center-tablist" class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#change_pwd"  role="tab" data-toggle="tab">修改密码</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="change_pwd">
        	<jsp:include page="/WEB-INF/views/user/change_pwd.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>