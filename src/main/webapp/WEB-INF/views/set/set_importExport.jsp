<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>导入导出</title>
</head>
<body>

<div style="margin-top: 20px;margin-left: 20px;">
    <form method="get" action="excel/getWorkbook" enctype="multipart/form-data">
    	<button class="btn btn-success btn-mid" style="width:100px;">导出</button>
	</form>
</div>


</body>
</html>