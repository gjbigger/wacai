<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>借贷管理</title>
    <style>
	    #loan_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #loan_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #loan_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #loan_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #loan_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	    }
	
	    #loan_list_table tr th {
	        height: 30px;
	    }
	
	    #loan_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	
	    #loan_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #loan_list_table tr td:last-child, th:last-child {
	        width: 122px;
	    }
	
	    #loan_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #loan_list_tool_bar {
	        margin-top: 10px;
	    }
	    
	    <!--模态框-->
	    #loan_update_form {
	        margin-top: 25px;
	    }
	
	    #loan_update_form .input_info {
	        witdh: 210px;
	        margin-top: 10px;
	        margin-left: 10px;
	    }
	
	    #loan_update_form label {
	        font-weight: normal;
	        margin-right: 10px;
	    }
	
	    #loan_update_form .input_info select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #loan_update_form .input_info input[type="date"] {
	        width: 175px;
	        height: 27px;
	    }
	
	    #loan_update_form .input_info textarea {
	        resize: none;
	        overflow: auto;
	        width: 300px;
	        height: 70px;
	        vertical-align: top;
	    }
</style>
</head>
<body>


<div id="loan_list_tool_bar">
    <form id="loan_search_form">
        <label>债权/债务人：</label><select name="queryLoanBodyAccountId" id="queryLoanBodyAccountId"></select>

        <label>借贷类型：</label><select name="queryLoanTypeId" id="queryLoanTypeId"></select>

        <label>时间：</label><input type="date" name="queryLoanTime" id="queryLoanTime"/>

        <button type="button" class="btn btn-success" id="loan_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="loan_list_table" class="table table-striped table-hover table-condensed">
</table>

<nav id="loan_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="loan_update_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="loanCloseBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="loan_update_modal_title">编辑借贷</h4>
            </div>
            <div class="modal-body">
                <form id="loan_update_form">

                    <input type="hidden" name="id" id="loanId" />

					 <div class="input_info">
			            <label for="loan_money">金额</label>
			            <input id="loan_money" type="number" name="money" data-placement="right" data-trigger="manual">
			        </div>
			
			        <div class="input_info">
			            <label for="loan_type">类别</label>
			            <select id="loan_type" name="typeId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>
			
			        <hr />
			
			        <div class="input_info">
			            <label for="loan_body_account" id="loan_body_label">债权人</label>
			            <select id="loan_body_account" name="loanBodyAccountId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>
			
			        <div class="input_info">
			            <label for="loan_account" id="loan_account_label">借入账户</label>
			            <select id="loan_account" name="accountId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>
			
			        <div class="input_info">
			            <label for="loan_time">时间</label>
			            <input id="loan_time" type="date" name="time" data-placement="right" data-trigger="manual">
			        </div>
			
			        <hr />
			
			        <div class="input_info">
			            <label for="loan_remark">备注</label>
			            <textarea id="loan_remark" name="remark"></textarea>
			        </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="loanCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="loanSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	searchLoan(1);	
	loanTypeChange();
	loadLoanAccountIsNot8();
	loadLoanAccountIs8();
	loadLoanType();
	loanEditBtnClick();
	loanSearchBtnClick();
	loanDeleteBtnClick();
	loanSaveBtnClick();
	loanPopoverHide();
});

//借贷类型改变，提示信息随之改变
function loanTypeChange() {
	$("#loan_type").change(function() {
		var $loanTypeId = $(this).val();
		var $loanTypeText = $(this).find("option:selected").text();

		$("#loan_account_label").html($loanTypeText + "账户");

		if ($loanTypeId === '1' || $loanTypeId === '4') {
			$("#loan_body_label").html("债权人 ");
		} else if ($loanTypeId === '2' || $loanTypeId === '3') {
			$("#loan_body_label").html("债务人 ");
		}
	});
}

//加载账户
function loadLoanAccountIsNot8() {
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
			$("#loan_account").html($op);
		}
	});
}

//加载债权人债务人账户
function loadLoanAccountIs8() {
	$.ajax({
		type:'post',
		url:'account/selectByUserIdAndTypeIdIs8ForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#loan_body_account").html($op);
			$("#queryLoanBodyAccountId").html($op);
		}
	});
}

//加载借贷类型
function loadLoanType() {
	$.ajax({
		type:'post',
		url:'loanType/selectAllForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#loan_type").html($op);
			$("#queryLoanTypeId").html($op);
		}
	});
}


//编辑按钮点击事件
function loanEditBtnClick() {
	$(".loan_edit_btn").click(function(){
		var $tr = $(this).parent().parent();
		
		var $id = $($tr.children("td").get(0)).attr("value");
        var $accountId = $($tr.children("td").get(1)).attr("value");
        var $loanBodyAccountId = $($tr.children("td").get(2)).attr("value");
        var $typeId = $($tr.children("td").get(3)).attr("value");
        var $money = $($tr.children("td").get(4)).attr("value");
        var $remark = $($tr.children("td").get(5)).attr("value");
        var $time = $($tr.children("td").get(6)).html();
        
        $("#loanId").val($id);
        $("#loan_money").val($money);
        $("#loan_type").val($typeId);
        $("#loan_account").val($accountId);
        $("#loan_remark").html($remark);
        $("#loan_body_account").val($loanBodyAccountId);
        $("#loan_time").val($time);
        
        $('#loan_update_modal').modal('show');
	});
}

//查询按钮点击事件
function loanSearchBtnClick() {
	$("#loan_search_btn").click(function(){
		searchLoan(1);
	});
}

//删除按钮点击事件
function loanDeleteBtnClick() {
	$(".loan_delete_btn").click(function(){
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
			        	  url:'loan/deleteById',
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
		    							searchLoan(1);
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

//查询借贷
function searchLoan(page) {
	$.ajax({
		type:'post',
		url:'loan/selectByParams?page='+page,
		data:$("#loan_search_form").serialize(),
		dataType:'json',
		success:function(pm) {
			if(pm==null || pm.recordsCount<=0) {
				$("#loan_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
				$("#loan_pagination").css("display", "none");
				return;
			}
			$("#loan_pagination").css("display", "block");
			//表格部分
			var $tableContent = "<tbody><tr>"+
		        "<th>id</th>"+
		        "<th>借贷账户</th>"+
		        "<th>债权/债务人</th>"+
		        "<th>类型</th>"+
		        "<th>金额</th>"+
		        "<th>备注</th>"+
		        "<th>时间</th>"+
		        "<th>操作</th>"+
		    "</tr>";
		    for(var i=0; i<pm.records.length; i++) {
		    	$tableContent += "<tr>"+
		        "<td value='"+pm.records[i].id+"'>"+pm.records[i].id+"</td>"+
		        "<td value='"+pm.records[i].accountId+"' title='"+pm.records[i].accountName+"'>"+pm.records[i].accountName+"</td>"+
		        "<td value='"+pm.records[i].loanBodyAccountId+"' title='"+pm.records[i].loanBodyAccountName+"'>"+pm.records[i].loanBodyAccountName+"</td>"+
		        "<td value='"+pm.records[i].typeId+"' title='"+pm.records[i].typeName+"'>"+pm.records[i].typeName+"</td>"+
		        "<td value='"+pm.records[i].money+"' title='"+pm.records[i].money+"'>"+pm.records[i].money+"</td>"+
		        "<td value='"+pm.records[i].remark+"' title='"+pm.records[i].remark+"'>"+pm.records[i].remark+"</td>"+
		        "<td value='"+pm.records[i].time+"' title='"+pm.records[i].time+"'>"+pm.records[i].time+"</td>"+
		        "<td>"+
		            "<button class='btn btn-warning loan_edit_btn'>编辑</button>"+
		            "<button class='btn btn-danger loan_delete_btn'>删除</button>"+
		        "</td>"+
		    "</tr>";
		    }
		    $tableContent +="</tbody>";
			$("#loan_list_table").html($tableContent);
			loanEditBtnClick();
			loanDeleteBtnClick();
			
			//分页部分
			var $fenYeContent = "";
			if(pm.hasPrePage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchLoan('+(pm.currPage-1)+');">&laquo;</a>'+
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
    	               		'<a href="javascript:searchLoan('+i+');">'+i+'</a>'+
       	            	'</li>';
				}
				
			}
			if(pm.hasNextPage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchLoan('+(pm.currPage+1)+');">&raquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&raquo;</span>'+
	            	'</li>';
			}
			$($("#loan_pagination").children("ul").get(0)).html($fenYeContent);
		}
	})
}

//保存按钮点击事件
function loanSaveBtnClick() {
	$("#loanSaveBtn").click(function(){
		//非空校验
		if($.trim($("#loanId").val()) == "") {
   			swal("待保存记录异常","请重新编辑","error");
   			return;
    	}
		if($.trim($("#loan_money").val()) == "") {
   			$("#loan_money").attr("data-content", "金额不能为空");
   			$("#loan_money").popover("show");
   			return;
    	}
		if($.trim($("#loan_type").val()) == "") {
   			$("#loan_type").attr("data-content", "收入类型不能为空");
   			$("#loan_type").popover("show");
   			return;
    	}
		if($.trim($("#loan_account").val()) == "") {
   			$("#loan_account").attr("data-content", "账户不能为空");
   			$("#loan_account").popover("show");
   			return;
    	}
		if($.trim($("#loan_body_account").val()) == "") {
   			$("#loan_body_account").attr("data-content", "债权/债务人不能为空");
   			$("#loan_body_account").popover("show");
   			return;
    	}
    	if($.trim($("#loan_time").val()) == "") {
   			$("#loan_time").attr("data-content", "时间不能为空");
   			$("#loan_time").popover("show");
   			return;
    	}
    	//判断账户币种
    	var $loanAccountUnit = $("#loan_account").find("option:selected").text().split(/ -- /)[1];
    	var $loanBodyAccountUnit = $("#loan_body_account").find("option:selected").text().split(/ -- /)[1];
    	if($loanAccountUnit != $loanBodyAccountUnit) {
    		$("#loan_body_account").attr("data-content", "账户币种不一致，不能借贷");
   			$("#loan_body_account").popover("show");
   			return;
    	}
		//异步请求
		$.ajax({
			type:'post',
			url:'loan/update',
			data:$('#loan_update_form').serialize(),
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
							$("#loanCloseBtn")[0].click();
							//重新查询一遍 
							searchLoan(1);
						}
					}
				);
			}
		});
	});
}


//输入框得到焦点，提示框隐藏
function loanPopoverHide() {
	$("#loan_update_form input,#loan_update_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>