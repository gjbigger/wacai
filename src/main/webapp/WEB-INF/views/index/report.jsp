<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>报表</title>
    <link href="static/css/report.tablist.css" rel="stylesheet">
</head>
<body>

<div>
    <!-- Nav tabs -->
    <ul id="report-tablist" class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#account_report"  role="tab" data-toggle="tab">账户</a>
        </li>
        <li role="presentation">
            <a href="#pay_in_report"  role="tab" data-toggle="tab">收入</a>
        </li>
        <li role="presentation">
            <a href="#pay_out_report"  role="tab" data-toggle="tab">支出</a>
        </li>
        <li role="presentation">
            <a href="#pay_in_out_cha_report"  role="tab" data-toggle="tab">收支差</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="account_report">
        	<jsp:include page="/WEB-INF/views/report/account_report.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="pay_in_report">
        	<jsp:include page="/WEB-INF/views/report/pay_in_report.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="pay_out_report">
        	<jsp:include page="/WEB-INF/views/report/pay_out_report.jsp"></jsp:include>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="pay_in_out_cha_report">
        	<jsp:include page="/WEB-INF/views/report/pay_in_out_cha_report.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>