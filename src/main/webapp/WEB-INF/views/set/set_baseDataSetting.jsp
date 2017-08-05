<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基础数据设置</title>

	<style>
    	#set_base_data_setting-tablist li a {
			font-size: 15px;
			color: black;
			font-weight: bold;
		}
    </style>
</head>
<body>
<div>
    <!-- Nav tabs -->
    <ul id="set_base_data_setting-tablist" class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#pay_out_type"  role="tab" data-toggle="tab">支出类别</a>
        </li>
        <li role="presentation">
            <a href="#pay_in_type"  role="tab" data-toggle="tab">收入类别</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="pay_out_type">
        	<jsp:include page="/WEB-INF/views/pay_out_type/pay_out_type_list.jsp"></jsp:include>
        </div>
         <div role="tabpanel" class="tab-pane fade in " id="pay_in_type">
        	<jsp:include page="/WEB-INF/views/pay_in_type/pay_in_type_list.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>