<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link href="static/css/index.top.css" rel="stylesheet">
<link href="static/css/index.middle.left.css" rel="stylesheet">
</head>
<body>
<!-- 顶部：导航区，标题区 -->
<div id="top">
		<!-- 标题区： -->
		<div class="site-nav">
    		<ul class="site-map">
        		<li><a href="#" target="_blank" class="home">挖财</a></li>
       			<li class="last"><a href="#" target="_blank">帮助中心</a></li>
    		</ul>
		</div>
		<!-- 导航区 -->
		<nav class="navbar navbar-default">
   			 <div class="container-fluid">
   			 
		        <div class="navbar-header" style="margin-left: 65px;">
		            <!--  品牌logo  -->
		            <a class="navbar-brand" href="#">
		                <img src="static/images/logo.png" style="height: 30px;margin-top: -5px;"/>
		            </a>
		        </div>

        		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            		<ul class="nav navbar-nav">
                		<li><a href="#">首页</a></li>
                		<li class="dropdown">
                			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                        		我要赚钱<span class="caret"></span>
                    		</a>
			                    <ul class="dropdown-menu" style="margin-top: -10px;">
			                        <li><a href="#">投资理财</a></li>
			                        <li><a href="#">我的理财</a></li>
			                    </ul>
                		</li>
		                <li><a href="#">钱堂社区</a></li>
		                <li><a href="#">我的挖财</a></li>
            		</ul>
            		<ul class="nav navbar-nav" style="float:right;margin-right: -150px;">
               			 <li class="dropdown">
                    		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                        		${user.userName}<span id="messageNum0" class="badge" style="margin-left: 20px;background-color: red;"></span>
                    		</a>
			                    <ul class="dropdown-menu" style="margin-top: -10px;margin-left: -5px;">
			                        <li><a href="javascript:set_notification()">消息 <i id="messageNum1" style="color: red;"></i></a></li>
			                        <li><a href="#">我的挖财</a></li>
			                        <li><a href="javascript:record();">记一笔</a></li>
			                        <li><a href="#">个人信息</a></li>
			                        <li><a href="#">安全设置</a></li>
			                        <li><a href="user/userLogout">退出</a></li>
			                    </ul>
                		</li>
            		</ul>
        		</div>

    		</div>
		</nav>
</div>




<!-- 中部：菜单区，主显示区 -->
	<div id="middle">
		<div class="container">
    		<div class="row">
    		
    			<!--  左边栏  -->
    			<div class="col-md-2" id="middle_left">
		    		<!--  主菜单  -->
		            <ul>
		                <li>
		                    <a href="javascript:overview()" id="overview" <c:if test="${currentMenu=='overview'}">class="current"</c:if>>
		                        <span class="img_0 icon"></span> 账务概况
		                    </a>
		                </li>
		                <li>
		                    <a href="javascript:record()" id="record" <c:if test="${currentMenu=='record'}">class="current"</c:if>>
		                        <span class="img_1 icon"></span> 记账
		                    </a>
		                </li>
		                <li>
		                    <a href="javascript:detail()" id="detail" <c:if test="${currentMenu=='detail'}">class="current"</c:if>>
		                        <span class="img_2 icon"></span> 明细
		                    </a>
		                </li>
		                <li>
		                    <a href="javascript:report()" id="report" <c:if test="${currentMenu=='report'}">class="current"</c:if>>
		                        <span class="img_3 icon"></span> 报表
		                    </a>
		                </li>
		                <li>
		                    <a href="javascript:account()" id="account" <c:if test="${currentMenu=='account'}">class="current"</c:if>>
		                        <span class="img_4 icon"></span> 账户
		                    </a>
		                </li>
		                <%--  <li>
		                    <a href="javascript:budget()" id="budget" <c:if test="${currentMenu=='budget'}">class="current"</c:if>>
		                        <span class="img_6 icon"></span> 预算
		                    </a>
		                </li> --%>
		                <li>
		                    <a href="javascript:set()" id="set">
		                        <span class="img_5 icon"></span> 设置
		                        <span style="color: black;margin-left: 35px;" 
		                        	<c:choose>
					            		<c:when test="${set_detail_show=='on'}">class="glyphicon glyphicon-menu-up"</c:when>
					            		<c:otherwise>class="glyphicon glyphicon-menu-down"</c:otherwise>
		            				</c:choose>
		                        >
		                        </span>
		                    </a>
		                </li>
		            </ul>
	    			
	    			<!--  子菜单  -->
		            <ul id="set_detail"
		            	<c:choose>
		            		<c:when test="${set_detail_show=='on'}">style="display:block;"</c:when>
		            		<c:otherwise>style="display:none;"</c:otherwise>
		            	</c:choose>
		            >
		                <li><a href="javascript:set_personCenter()" id="personCenter" <c:if test="${currentMenu=='personCenter'}">class="current"</c:if>>个人中心</a></li>
		                <li><a href="javascript:set_notification()" id="notification" <c:if test="${currentMenu=='notification'}">class="current"</c:if>>消息中心
		                	<span id="messageNum2" class="badge" style="margin-left: 20px;background-color: red;"></span>
		                </a></li>
		                <li><a href="javascript:set_importExport()" id="importExport" <c:if test="${currentMenu=='importExport'}">class="current"</c:if>>导入导出</a></li>
		                <li><a href="javascript:set_baseDataSetting()" id="baseDataSetting" <c:if test="${currentMenu=='baseDataSetting'}">class="current"</c:if>>基础数据设置</a></li>
		                <%-- <li><a href="javascript:set_rssSetting()" id="rssSetting" <c:if test="${currentMenu=='rssSetting'}">class="current"</c:if>>订阅设置</a></li> --%>
		                <li><a href="javascript:set_personSetting()" id="personSetting" <c:if test="${currentMenu=='personSetting'}">class="current"</c:if>>个性化设置</a></li>
		                <li><a href="javascript:set_toolKit()" id="toolKit" <c:if test="${currentMenu=='toolKit'}">class="current"</c:if>>更多功能</a></li>
		            </ul>
		            
		            <!--  新闻咨询区  -->
		            <ul id="news">
		                <li>
		                    <a href="#" target="_blank">百万资产配置方案 一张图看明白</a>
		                </li>
		                <li>
		                    <a href="#" target="_blank">互联网金融时代，如何护钱</a>
		                </li>
		                <li>
		                    <a href="#" target="_blank">记账妙招三十六计，招招实用！</a>
		                </li>
		            </ul>
    			
    				<!--  文章区  -->
		            <ul id="article">
		                <li>
		                    <img width="32px" height="32px" alt="" src="static/images/icon-01.png">
		                    <div>
		                        <a href="#">
		                            <span>理财学院</span><br />
		                            <span>学懂理财会用理财</span>
		                        </a>
		                    </div>
		                </li>
		                <li>
		                    <img width="32px" height="32px" alt="" src="static/images/icon-02.png">
		                    <div>
		                        <a href="#">
		                            <span>投资攻略</span><br />
		                            <span>谈投资聊理财</span>
		                        </a>
		                    </div>
		                </li>
		                <li>
		                    <img width="32px" height="32px" alt="" src="static/images/icon-03.png">
		                    <div>
		                        <a href="#">
		                            <span>开源节流</span><br />
		                            <span>能消费也能薅的住</span>
		                        </a>
		                    </div>
		                </li>
		            </ul>
        		</div>
    		
    		
    			<!--  右边栏，主显示区  -->
    			<div class="col-md-10" style="border: 1px solid lightgrey;height: 635px;" id="middle_right">
    				<jsp:include page="${mainShow}"></jsp:include>
       			</div>
    			
    		</div>
    	</div>	
	</div>






<!-- 底部：鸣谢区，友情链接区 -->
	<div id="bottom"></div>
	
	
	
<script src="static/js/index.middle.left.menu.choose.js"></script>	
<script>
$(function(){
	loadMessageNum();
});





//加载消息数量
function loadMessageNum() {
	$.ajax({
		type:'post',
		url:'message/selectByParam',
		data:'queryIsNew='+1,
		dataType:'json',
		success:function(pm) {
			if(pm.recordsCount > 0) {
				$("#messageNum0").html(pm.recordsCount);
				$("#messageNum0").css("display", "inline-block");
				
				$("#messageNum1").html(pm.recordsCount);
				$("#messageNum1").css("display", "inline-block");
				
				$("#messageNum2").html(pm.recordsCount);
				$("#messageNum2").css("display", "inline-block");
			} else {
				$("#messageNum0").css("display", "none");
				$("#messageNum1").css("display", "none");
				$("#messageNum2").css("display", "none");
			};
		}
	});
}
</script>
</body>
</html>