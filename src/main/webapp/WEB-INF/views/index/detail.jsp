<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>明细</title>
    <link href="static/css/detail.tablist.css" rel="stylesheet">
</head>
<body>

<div>
    <!-- Nav tabs -->
    <ul id="detail-tablist" class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#pay_out_search"  role="tab" data-toggle="tab">支出</a>
        </li>
        <li role="presentation">
            <a href="#pay_in_search"  role="tab" data-toggle="tab">收入</a>
        </li>
        <li role="presentation">
            <a href="#transfer_search"  role="tab" data-toggle="tab">转账</a>
        </li>
        <li role="presentation">
            <a href="#loan_search"  role="tab" data-toggle="tab">借贷</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="pay_out_search">
        	<jsp:include page="/WEB-INF/views/pay_out/pay_out_list.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="pay_in_search">
        	<jsp:include page="/WEB-INF/views/pay_in/pay_in_list.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="transfer_search">
        	<jsp:include page="/WEB-INF/views/transfer/transfer_list.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="loan_search">
        	<jsp:include page="/WEB-INF/views/loan/loan_list.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>