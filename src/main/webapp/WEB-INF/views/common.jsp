<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<base href="<%=basePath%>">  
<link href="static/bootstrap-3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="static/sweetalert-master/dist/sweetalert.css">

<script src="static/js/jquery-3.1.1.min.js"></script>
<script src="static/bootstrap-3.3.7/dist/js/bootstrap.min.js"></script>
<script src="static/bootstrap-3.3.7/js/dropdown.js"></script>
<script src="static/bootstrap-3.3.7/js/button.js"></script>
<script src="static/bootstrap-3.3.7/js/modal.js"></script>
<script src="static/sweetalert-master/dist/sweetalert.min.js"></script>
<script src="static/js/echarts.min.js"></script>

<script src="static/js/base.js"></script>
<script src="static/js/money.min.js"></script>


</head>
<script>
$(function(){
	setHuiLv();
});
</script>