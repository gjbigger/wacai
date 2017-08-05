<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>转账管理</title>
    <style>
	    #transfer_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #transfer_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #transfer_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #transfer_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #transfer_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	    }
	
	    #transfer_list_table tr th {
	        height: 30px;
	    }
	
	    #transfer_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	
	    #transfer_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #transfer_list_table tr td:last-child, th:last-child {
	        width: 122px;
	    }
	
	    #transfer_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #transfer_list_tool_bar {
	        margin-top: 10px;
	    }
	    
	    <!--模态框-->
	    #transfer_update_form {
	        margin-top: 25px;
	    }
	
	    #transfer_update_form .input_info {
	        witdh: 210px;
	        margin-top: 10px;
	        margin-left: 10px;
	    }
	
	    #transfer_update_form label {
	        font-weight: normal;
	        margin-right: 10px;
	    }
	
	    #transfer_update_form .input_info select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #transfer_update_form .input_info input[type="date"] {
	        width: 175px;
	        height: 27px;
	    }
	
	    #transfer_update_form .input_info textarea {
	        resize: none;
	        overflow: auto;
	        width: 300px;
	        height: 70px;
	        vertical-align: top;
	    }
</style>
</head>
<body>


<div id="transfer_list_tool_bar">
    <form id="transfer_search_form">
        <label>转出账户：</label><select name="queryTransferSrcAccountId" id="queryTransferSrcAccountId"></select>

        <label>转入类型：</label><select name="queryTransferDestAccountId" id="queryTransferDestAccountId"></select>

        <label>时间：</label><input type="date" name="queryTransferTime" id="queryTransferTime"/>

        <button type="button" class="btn btn-success" id="transfer_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="transfer_list_table" class="table table-striped table-hover table-condensed">
</table>

<nav id="transfer_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="transfer_update_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="transferCloseBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="transfer_update_modal_title">编辑转账</h4>
            </div>
            <div class="modal-body">
                <form id="transfer_update_form">

                    <input type="hidden" name="id" id="transferId" />

					<div class="input_info">
			            <label for="transfer_src_account">账户</label>
			            <select id="transfer_src_account" name="srcAccountId" data-placement="right" data-trigger="manual">
			            </select>
			
			            <span class="glyphicon glyphicon-arrow-right" style="margin-left: 20px;margin-right: 20px;"></span>
			
			            <select id="transfer_dest_account" name="destAccountId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>
			
			        <div class="input_info">
			            <label for="transfer_src_money">金额</label>
			            <input id="transfer_src_money" type="number" name="srcMoney" data-placement="right" data-trigger="manual">
			
			            <span class="glyphicon glyphicon-arrow-right" style="margin-left: 20px;margin-right: 20px;"></span>
			
			            <input id="transfer_dest_money" type="number" readonly name="destMoney" data-placement="right" data-trigger="manual">
			        </div>
			
			        <hr />
			
			        <div class="input_info">
			            <label for="transfer_time">时间</label>
			            <input id="transfer_time" type="date" name="time" data-placement="right" data-trigger="manual">
			        </div>
			
			        <hr />
			
			        <div class="input_info">
			            <label for="transfer_remark">备注</label>
			            <textarea id="transfer_remark" name="remark"></textarea>
			        </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="transferCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="transferSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	loadTransferAccount();
	transferEditBtnClick();
	transferSearchBtnClick();
	transferDeleteBtnClick();
	transferSrcAccountChange();
	transferDestAccountChange();
	transferSrcMoneyBlur();
	transferSaveBtnClick();
	searchTransfer(1);
	transferPopoverHide();
});

//加载账户
function loadTransferAccount() {
	$.ajax({
		type:'post',
		url:'account/selectByUserIdAndTypeIdIsNot8ForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#transfer_src_account").html($op);
			$("#transfer_dest_account").html($op);
			
			$("#queryTransferSrcAccountId").html($op);
			$("#queryTransferDestAccountId").html($op);
		}
	});
}



//编辑按钮点击事件
function transferEditBtnClick() {
	$(".transfer_edit_btn").click(function(){
		var $tr = $(this).parent().parent();
		
		var $id = $($tr.children("td").get(0)).attr("value");
        var $srcAccountId = $($tr.children("td").get(1)).attr("value");
        var $srcMoney = $($tr.children("td").get(2)).attr("value");
        var $destAccountId = $($tr.children("td").get(3)).attr("value");
        var $destMoney = $($tr.children("td").get(4)).attr("value");
        var $remark = $($tr.children("td").get(5)).attr("value");
        var $time = $($tr.children("td").get(6)).html();
        
        $("#transferId").val($id);
        $("#transfer_src_account").val($srcAccountId);
        $("#transfer_src_money").val($srcMoney);
        $("#transfer_dest_account").val($destAccountId);
        $("#transfer_dest_money").val($destMoney);
        $("#transfer_remark").html($remark);
        $("#transfer_time").val($time);
        
        $('#transfer_update_modal').modal('show');
	});
}

//查询按钮点击事件
function transferSearchBtnClick() {
	$("#transfer_search_btn").click(function(){
		searchTransfer(1);
	});
}

//删除按钮点击事件
function transferDeleteBtnClick() {
	$(".transfer_delete_btn").click(function(){
		var $tr = $(this).parent().parent();
        var $id = $($tr.children("td").get(0)).attr("value");
    	swal({
    			title:'确定删除记录['+$id+']吗？',
    			text:'删除之后不可恢复',
    			type: "warning",
    			showCancelButton: true,
    			confirmButtonColor: "#DD6B55",
    			confirmButtonText: "删除！",
    			cancelButtonText: "取消",
    			closeOnConfirm: false,
    			closeOnCancel: false
			},
				function(isConfirm) {
				if(isConfirm) {
					$.ajax({
			        	  type:'post',
			        	  url:'transfer/deleteById',
			        	  data:'id='+$id,
			        	  dataType:'json',
			        	  success:function(mm) {
			        		  if(mm.code == 300) {
			        			swal('删除失败', mm.msg, "error");  
			        			return;  
			        		  } 
			        		  swal({
									title:mm.msg,
									type:'success'
		    					},
		    					function(isConfirm) {
		    						if(isConfirm) {
		    							//重新查询一遍 
		    							searchTransfer(1);
		    						}
		    					}
		    				);
			        	  }
			           });
				} else {
					swal("取消", "已经取消删除", "error");
				}
			}	  	
		);
	});
}

//查询转账
function searchTransfer(page) {
	$.ajax({
		type:'post',
		url:'transfer/selectByParams?page='+page,
		data:$("#transfer_search_form").serialize(),
		dataType:'json',
		success:function(pm) {
			if(pm==null || pm.recordsCount<=0) {
				$("#transfer_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
				$("#transfer_pagination").css("display", "none");
				return;
			}
			$("#transfer_pagination").css("display", "block");
			//表格部分
			var $tableContent = "<tbody><tr>"+
		        "<th>id</th>"+
		        "<th>转出账户</th>"+
		        "<th>转出金额</th>"+
		        "<th>转入账户</th>"+
		        "<th>转入金额</th>"+
		        "<th>备注</th>"+
		        "<th>时间</th>"+
		        "<th>操作</th>"+
		    "</tr>";
		    for(var i=0; i<pm.records.length; i++) {
		    	$tableContent += "<tr>"+
		        "<td value='"+pm.records[i].id+"'>"+pm.records[i].id+"</td>"+
		        "<td value='"+pm.records[i].srcAccountId+"' title='"+pm.records[i].srcAccountName+"'>"+pm.records[i].srcAccountName+"</td>"+
		        "<td value='"+pm.records[i].srcMoney+"' title='"+pm.records[i].srcMoney+"'>"+pm.records[i].srcMoney+"</td>"+
		        "<td value='"+pm.records[i].destAccountId+"' title='"+pm.records[i].destAccountName+"'>"+pm.records[i].destAccountName+"</td>"+
		        "<td value='"+pm.records[i].destMoney+"' title='"+pm.records[i].destMoney+"'>"+pm.records[i].destMoney+"</td>"+
		        "<td value='"+pm.records[i].remark+"' title='"+pm.records[i].remark+"'>"+pm.records[i].remark+"</td>"+
		        "<td value='"+pm.records[i].time+"' title='"+pm.records[i].time+"'>"+pm.records[i].time+"</td>"+
		        "<td>"+
		            "<button class='btn btn-warning transfer_edit_btn'>编辑</button>"+
		            "<button class='btn btn-danger transfer_delete_btn'>删除</button>"+
		        "</td>"+
		    "</tr>";
		    }
		    $tableContent +="</tbody>";
			$("#transfer_list_table").html($tableContent);
			transferEditBtnClick();
			transferDeleteBtnClick();
			
			//分页部分
			var $fenYeContent = "";
			if(pm.hasPrePage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchTransfer('+(pm.currPage-1)+');">&laquo;</a>'+
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
    	               		'<a href="javascript:searchTransfer('+i+');">'+i+'</a>'+
       	            	'</li>';
				}
				
			}
			if(pm.hasNextPage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchTransfer('+(pm.currPage+1)+');">&raquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&raquo;</span>'+
	            	'</li>';
			}
			$($("#transfer_pagination").children("ul").get(0)).html($fenYeContent);
		}
	})
}

//转出账户改变事件
function transferSrcAccountChange() {
	$("#transfer_src_account").change(function(){
		calculateTransferDestMoney();
	});
}

//转入账户改变事件
function transferDestAccountChange() {
	$("#transfer_dest_account").change(function(){
		calculateTransferDestMoney();
	});
}

//转出金额失去焦点事件
function transferSrcMoneyBlur() {
	$("#transfer_src_money").blur(function(){
		calculateTransferDestMoney();
	});
}

//计算转入金额
function calculateTransferDestMoney() {
	var $srcAccount = $("#transfer_src_account").val();
	var $destAccount = $("#transfer_dest_account").val();
	var $srcMoney = $("#transfer_src_money").val();
	if($srcAccount == "" || $destAccount == "" || $srcMoney == "") {
		$("#transfer_dest_money").val("");
		return;
	}
	var $srcUnit = $("#transfer_src_account").find("option:selected").text().split(/ -- /)[1];
	var $destUnit = $("#transfer_dest_account").find("option:selected").text().split(/ -- /)[1];
	var $destMoney = fx($srcMoney).from($srcUnit).to($destUnit);
	$("#transfer_dest_money").val($destMoney);
}

//保存按钮点击事件
function transferSaveBtnClick() {
	$("#transferSaveBtn").click(function(){
		//非空校验
		if($.trim($("#transferId").val()) == "") {
			swal("待保存记录异常","请重新编辑","error");
   			return;
    	}
		if($.trim($("#transfer_src_account").val()) == "") {
   			$("#transfer_src_account").attr("data-content", "转出账户不能为空");
   			$("#transfer_src_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
		if($.trim($("#transfer_dest_account").val()) == "") {
   			$("#transfer_dest_account").attr("data-content", "转入账户不能为空");
   			$("#transfer_dest_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
		if($.trim($("#transfer_src_money").val()) == "") {
   			$("#transfer_src_money").attr("data-content", "转出金额不能为空");
   			$("#transfer_src_money").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
    	if($.trim($("#transfer_time").val()) == "") {
   			$("#transfer_time").attr("data-content", "转账时间不能为空");
   			$("#transfer_time").popover("show");
   			return;
    	}
    	//判断转入账户和转出账户是否是一个账户
    	if($.trim($("#transfer_src_account").val()) == $.trim($("#transfer_dest_account").val())) {
   			$("#transfer_dest_account").attr("data-content", "转出账户与转入账户不能为同一账户");
   			$("#transfer_dest_account").popover("show");
   			$("#transfer_dest_money").val("");
   			return;
    	}
    	//得到转入金额
    	calculateTransferDestMoney();
		//异步请求
		$.ajax({
			type:'post',
			url:'transfer/update',
			data:$('#transfer_update_form').serialize(),
			dataType:'json',
			success:function(mm){
				if(mm.code == 300) {
					swal("保存失败",mm.msg,"error");
					return;
				}
				swal({
						title:mm.msg,
						type:'success'
					},
					function(isConfirm) {
						if(isConfirm) {
							//关闭模态框
							$("#transferCloseBtn")[0].click();
							//重新查询一遍 
							searchTransfer(1);
						}
					}
				);
			}
		});
	});
}


//输入框得到焦点，提示框隐藏
function transferPopoverHide() {
	$("#transfer_update_form input,#transfer_update_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>