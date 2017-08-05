<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息中心</title>
<style>
	    #notification_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #notification_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #notification_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #notification_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #notification_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	        width:900px;
	        margin-left: 10px;
	    }
	
	    #notification_list_table tr th {
	        height: 30px;
	    }
	
	    #notification_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	    
	 
	
	    #notification_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #notification_list_table tr td:last-child, th:last-child {
	        width: 118px;
	    }
	
	    #notification_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #notification_list_tool_bar {
	        margin-top: 10px;
	    }
</style>
</head>

<body>

<div id="notification_list_tool_bar">
    <form id="notification_search_form">
        <label>消息类型：</label>
        <select name="queryIsNew" id="queryIsNew">
        	<option value=''>请选择</option>
        	<option value="0">已读</option>
        	<option value="1">未读</option>
        </select>

        <label>日期：</label><input type="month" name="queryCreateTime" id="queryCreateTime"/>

        <button type="button" class="btn btn-success" id="notification_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="notification_list_table" class="table table-striped table-hover table-condensed">
	
</table>

<nav id="notification_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="notification_modal" class="modal fade" tabindex="-1" role="dialog" style="margin-top: 50px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="closeBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="notification_modal_title"></h4>
            </div>
            <div class="modal-body">
                <div id="notification_part" style="width:500px;height:200px;">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelBtn">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(function(){
	searchMessage(1);
	closeBtnClick();
	cancelBtnClick();
	notificationSearchBtnClick();
});

//搜索按钮单击事件
function notificationSearchBtnClick() {
	$("#notification_search_btn").click(function(){
		searchMessage(1);
	});
}


//取消按钮点击事件
function cancelBtnClick() {
    $("#cancelBtn").click(function(){
    	 $("#notification_part").html("");
    	 loadMessageNum();
    	 searchMessage(1);
    });
}


//x点击事件
function closeBtnClick(){
    $("#closeBtn").click(function(){
        $("#notification_part").html("");
        loadMessageNum();
        searchMessage(1);
    });
}


//消息详情
function messageDetail(msg, isNew, id) {
	msg = msg.replace(/。/g,"。<br /><br />");
	if(isNew == 1) {
		$.ajax({
			type:'post',
			url:'message/updateSetIsNew0',
			data:'id='+id,
			dataType:'json',
			success:function(mm) {
				if(mm.code == 200) {
					$("#notification_part").html(msg);
					$("#notification_modal").modal("show");
				}
			}
		});
	}
	$("#notification_part").html(msg);
	$("#notification_modal").modal("show");
}

//查询账户
function searchMessage(page) {
	$.ajax({
		type:'post',
		url:'message/selectByParam?page='+page,
		data:$("#notification_search_form").serialize(),
		dataType:'json',
		success:function(pm) {
			if(pm==null || pm.recordsCount<=0) {
				$("#notification_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
				$("#notification_pagination").css("display", "none");
				return;
			}
			$("#notification_pagination").css("display", "block");
			//表格部分
			var $tableContent = "<tbody>";
		    for(var i=0; i<pm.records.length; i++) {
		    	if(pm.records[i].isNew==1) {
		    		$tableContent += '<tr><td style="width:1px;"><span class="badge" style="background-color: red;">新</span></td>';
		    	} else {
		    		$tableContent += '<tr><td style="width:1px;"></td>';
		    	}
		    	
		    	$tableContent += 
		        	"<td><a href='javascript:messageDetail(\""+pm.records[i].content+"\","+pm.records[i].isNew+","+pm.records[i].id+")'>"+pm.records[i].content+"</a></td>"+
		  		"</tr>";
		    }
		    $tableContent +="</tbody>";
			$("#notification_list_table").html($tableContent);
			
			//分页部分
			var $fenYeContent = "";
			if(pm.hasPrePage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchMessage('+(pm.currPage-1)+');">&laquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&laquo;</span>'+
	            	'</li>';
			}
			for(var i=pm.startPage; i<=pm.endPage; i++) {
				if(i == pm.currPage) {
    				$fenYeContent += 
    					'<li class="active">'+
    	               		'<span>'+i+'</span>'+
       	            	'</li>';
				} else {
					$fenYeContent += 
    					'<li>'+
    	               		'<a href="javascript:searchMessage('+i+');">'+i+'</a>'+
       	            	'</li>';
				}
				
			}
			if(pm.hasNextPage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchMessage('+(pm.currPage+1)+');">&raquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&raquo;</span>'+
	            	'</li>';
			}
			$($("#notification_pagination").children("ul").get(0)).html($fenYeContent);
		}
	})
}
</script>
</body>
</html>