<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>收入管理</title>
    <style>
	    #pay_in_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #pay_in_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #pay_in_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_in_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #pay_in_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	    }
	
	    #pay_in_list_table tr th {
	        height: 30px;
	    }
	
	    #pay_in_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	
	    #pay_in_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #pay_in_list_table tr td:last-child, th:last-child {
	        width: 122px;
	    }
	
	    #pay_in_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #pay_in_list_tool_bar {
	        margin-top: 10px;
	    }
	    
	    <!--模态框-->
	    #pay_in_update_form {
	        margin-top: 25px;
	    }
	
	    #pay_in_update_form .input_info {
	        witdh: 210px;
	        margin-top: 10px;
	        margin-left: 10px;
	    }
	
	    #pay_in_update_form label {
	        font-weight: normal;
	        margin-right: 10px;
	    }
	
	    #pay_in_update_form .input_info select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_in_update_form .input_info input[type="date"] {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_in_update_form .input_info textarea {
	        resize: none;
	        overflow: auto;
	        width: 300px;
	        height: 70px;
	        vertical-align: top;
	    }
</style>
</head>
<body>


<div id="pay_in_list_tool_bar">
    <form id="pay_in_search_form">
        <label>所属账户：</label><select name="queryPayInAccountId" id="queryPayInAccountId"></select>

        <label>收入类型：</label><select name="queryPayInTypeId" id="queryPayInTypeId"></select>

        <label>时间：</label><input type="date" name="queryPayInTime" id="queryPayInTime"/>

        <button type="button" class="btn btn-success" id="pay_in_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="pay_in_list_table" class="table table-striped table-hover table-condensed">
</table>

<nav id="pay_in_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="pay_in_update_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="payInCloseBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="pay_in_update_modal_title">编辑收入</h4>
            </div>
            <div class="modal-body">
                <form id="pay_in_update_form">

                    <input type="hidden" name="id" id="payInId" />

					 <div class="input_info">
                        <label for="payInMoney">金额</label>
                        <input name="money" id="payInMoney" type="number" data-placement="right" data-trigger="manual">
                    </div>

                    <div class="input_info">
                        <label for="payInType">类别</label>
                        <select name="typeId" id="payInType" data-placement="right" data-trigger="manual">
                        </select>
                    </div>

					<hr />
                   
					<div class="input_info">
			            <label for="payInAccount">账户</label>
			            <select id="payInAccount" name="accountId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>

                    <div class="input_info">
			            <label for="payInTime">时间</label>
			            <input id="payInTime" type="date" name="time" data-placement="right" data-trigger="manual">
			        </div>

                    <hr />

                    <div class="input_info">
                        <label for="payInRemark">备注</label>
                        <textarea name="remark" id="payInRemark"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="payInCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="payInSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	payInDeleteBtnClick();
	payInEditBtnClick();
	loadPayInAccount();
	loadPayInType();
	searchPayIn(1);
	payInSearchBtnClick();
	payInSaveBtnClick();
	payInPopoverHide();
});

//加载账户
function loadPayInAccount() {
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
			$("#queryPayInAccountId").html($op);
			$("#payInAccount").html($op);
		}
	});
}

//加载收入类型
function loadPayInType() {
	$.ajax({
		type:'post',
		url:'payInType/selectByUserIdForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#queryPayInTypeId").html($op);
			$("#payInType").html($op);
		}
	});
}

//编辑按钮点击事件
function payInEditBtnClick() {
	$(".pay_in_edit_btn").click(function(){
		var $tr = $(this).parent().parent();
		
		var $id = $($tr.children("td").get(0)).attr("value");
        var $accountId = $($tr.children("td").get(1)).attr("value");
        var $typeId = $($tr.children("td").get(2)).attr("value");
        var $money = $($tr.children("td").get(3)).attr("value");
        var $remark = $($tr.children("td").get(4)).attr("value");
        var $time = $($tr.children("td").get(5)).html();
        
        $("#payInId").val($id);
        $("#payInMoney").val($money);
        $("#payInType").val($typeId);
        $("#payInAccount").val($accountId);
        $("#payInRemark").html($remark);
        $("#payInTime").val($time);
        
        $('#pay_in_update_modal').modal('show');
	});
}

//查询按钮点击事件
function payInSearchBtnClick() {
	$("#pay_in_search_btn").click(function(){
		searchPayIn(1);
	});
}

//删除按钮点击事件
function payInDeleteBtnClick() {
	$(".pay_in_delete_btn").click(function(){
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
			        	  url:'payIn/deleteById',
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
		    							searchPayIn(1);
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

//查询收入
function searchPayIn(page) {
	$.ajax({
		type:'post',
		url:'payIn/selectByParams?page='+page,
		data:$("#pay_in_search_form").serialize(),
		dataType:'json',
		success:function(pm) {
			if(pm==null || pm.recordsCount<=0) {
				$("#pay_in_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
				$("#pay_in_pagination").css("display", "none");
				return;
			}
			$("#pay_in_pagination").css("display", "block");
			//表格部分
			var $tableContent = "<tbody><tr>"+
		        "<th>id</th>"+
		        "<th>所属账户</th>"+
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
		        "<td value='"+pm.records[i].typeId+"' title='"+pm.records[i].typeName+"'>"+pm.records[i].typeName+"</td>"+
		        "<td value='"+pm.records[i].money+"' title='"+pm.records[i].money+"'>"+pm.records[i].money+"</td>"+
		        "<td value='"+pm.records[i].remark+"' title='"+pm.records[i].remark+"'>"+pm.records[i].remark+"</td>"+
		        "<td value='"+pm.records[i].time+"' title='"+pm.records[i].time+"'>"+pm.records[i].time+"</td>"+
		        "<td>"+
		            "<button class='btn btn-warning pay_in_edit_btn'>编辑</button>"+
		            "<button class='btn btn-danger pay_in_delete_btn'>删除</button>"+
		        "</td>"+
		    "</tr>";
		    }
		    $tableContent +="</tbody>";
			$("#pay_in_list_table").html($tableContent);
			payInEditBtnClick();
			payInDeleteBtnClick();
			
			//分页部分
			var $fenYeContent = "";
			if(pm.hasPrePage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchPayIn('+(pm.currPage-1)+');">&laquo;</a>'+
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
    	               		'<a href="javascript:searchPayIn('+i+');">'+i+'</a>'+
       	            	'</li>';
				}
				
			}
			if(pm.hasNextPage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchPayIn('+(pm.currPage+1)+');">&raquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&raquo;</span>'+
	            	'</li>';
			}
			$($("#pay_in_pagination").children("ul").get(0)).html($fenYeContent);
		}
	})
}

//保存按钮点击事件
function payInSaveBtnClick() {
	$("#payInSaveBtn").click(function(){
		//非空校验
		if($.trim($("#payInId").val()) == "") {
   			swal("待保存记录异常","请重新编辑","error");
   			return;
    	}
		if($.trim($("#payInMoney").val()) == "") {
   			$("#payInMoney").attr("data-content", "金额不能为空");
   			$("#payInMoney").popover("show");
   			return;
    	}
		if($.trim($("#payInType").val()) == "") {
   			$("#payInType").attr("data-content", "类别不能为空");
   			$("#payInType").popover("show");
   			return;
    	}
		if($.trim($("#payInAccount").val()) == "") {
   			$("#payInAccount").attr("data-content", "所属账户不能为空");
   			$("#payInAccount").popover("show");
   			return;
    	}
		if($.trim($("#payInTime").val()) == "") {
   			$("#payInTime").attr("data-content", "时间不能为空");
   			$("#payInTime").popover("show");
   			return;
    	}
		//异步请求
		$.ajax({
			type:'post',
			url:'payIn/update',
			data:$('#pay_in_update_form').serialize(),
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
							$("#payInCloseBtn")[0].click();
							//重新查询一遍 
							searchPayIn(1);
						}
					}
				);
			}
		});
	});
}


//输入框得到焦点，提示框隐藏
function payInPopoverHide() {
	$("#pay_in_update_form input,#pay_in_update_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>