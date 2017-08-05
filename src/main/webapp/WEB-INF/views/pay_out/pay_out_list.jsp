<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>支出管理</title>
    <style>
	    #pay_out_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #pay_out_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #pay_out_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_out_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #pay_out_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	    }
	
	    #pay_out_list_table tr th {
	        height: 30px;
	    }
	
	    #pay_out_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	
	    #pay_out_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #pay_out_list_table tr td:last-child, th:last-child {
	        width: 122px;
	    }
	
	    #pay_out_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #pay_out_list_tool_bar {
	        margin-top: 10px;
	    }
	    
	    <!--模态框-->
	    #pay_out_update_form {
	        margin-top: 25px;
	    }
	
	    #pay_out_update_form .input_info {
	        witdh: 210px;
	        margin-top: 10px;
	        margin-left: 10px;
	    }
	
	    #pay_out_update_form label {
	        font-weight: normal;
	        margin-right: 10px;
	    }
	
	    #pay_out_update_form .input_info select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_out_update_form .input_info input[type="date"] {
	        width: 175px;
	        height: 27px;
	    }
	
	    #pay_out_update_form .input_info textarea {
	        resize: none;
	        overflow: auto;
	        width: 300px;
	        height: 70px;
	        vertical-align: top;
	    }
</style>
</head>
<body>


<div id="pay_out_list_tool_bar">
    <form id="pay_out_search_form">
        <label>所属账户：</label><select name="queryPayOutAccountId" id="queryPayOutAccountId"></select>

        <label>支出类型：</label><select name="queryPayOutBigTypeId" id="queryPayOutBigTypeId"></select>

        <label>时间：</label><input type="date" name="queryPayOutTime" id="queryPayOutTime"/>

        <button type="button" class="btn btn-success" id="pay_out_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="pay_out_list_table" class="table table-striped table-hover table-condensed">
</table>

<nav id="pay_out_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="pay_out_update_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="payOutCloseBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="pay_out_update_modal_title">编辑支出</h4>
            </div>
            <div class="modal-body">
                <form id="pay_out_update_form">

                    <input type="hidden" name="id" id="payOutId" />

					 <div class="input_info">
                        <label for="payOutMoney">金额</label>
                        <input name="money" id="payOutMoney" type="number" data-placement="right" data-trigger="manual">
                    </div>

                    <div class="input_info">
                        <label for="payOutBigType">类别</label>
                        <select name="bigTypeId" id="payOutBigType" data-placement="right" data-trigger="manual">
                        </select>
                        
                        <select id="payOutSmallType" name="smallTypeId" data-placement="right" data-trigger="manual">
        				</select>
                    </div>

					<hr />
                   
					<div class="input_info">
			            <label for="payOutAccount">账户</label>
			            <select id="payOutAccount" name="accountId" data-placement="right" data-trigger="manual">
			            </select>
			        </div>

                    <div class="input_info">
			            <label for="payOutTime">时间</label>
			            <input id="payOutTime" type="date" name="time" data-placement="right" data-trigger="manual">
			        </div>

                    <hr />

                    <div class="input_info">
                        <label for="payOutRemark">备注</label>
                        <textarea name="remark" id="payOutRemark"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="payOutCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="payOutSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	payOutDeleteBtnClick();
	payOutEditBtnClick();
	loadPayOutAccount();
	loadPayOutBigType();
	searchPayOut(1);
	payOutSearchBtnClick();
	payOutSaveBtnClick();
	payOutPopoverHide();
	payOutBigTypeChange();
});

//加载账户
function loadPayOutAccount() {
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
			$("#queryPayOutAccountId").html($op);
			$("#payOutAccount").html($op);
		}
	});
}

//加载支出类型
function loadPayOutBigType() {
	$.ajax({
		type:'post',
		url:'payOutBigType/selectByUserIdForSelectOption',
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#queryPayOutBigTypeId").html($op);
			$("#payOutBigType").html($op);
		}
	});
}

//模态框的支出大类型改变，改变相应的小类型
function payOutBigTypeChange() {
	$("#payOutBigType").change(function(){
		var $bigTypeId = $(this).val();
		if($bigTypeId == "") {
			$("#payOutSmallType").html("");
			return;
		}
		loadPayOutSmallType($bigTypeId);
	});
}

//加载小类型
function loadPayOutSmallType($bigTypeId) {
	$.ajax({
		type:'post',
		url:'payOutSmallType/selectByPidAndUserIdForSelectOption',
		async:false,
		data:'pid='+$bigTypeId,
		dataType:"json",
		success:function(list) {
			var $op = "<option value=''>请选择</option>";
			if(list==null || list.length<1) {
				return;
			}
			for(var i=0; i<list.length; i++) {
				$op += '<option value="'+list[i].id+'">'+list[i].name+'</option>'
			}
			$("#payOutSmallType").html($op);
		}
	});
}

//编辑按钮点击事件
function payOutEditBtnClick() {
	$(".pay_out_edit_btn").click(function(){
		var $tr = $(this).parent().parent();
		
		var $id = $($tr.children("td").get(0)).attr("value");
        var $accountId = $($tr.children("td").get(1)).attr("value");
        var $bigTypeId = $($tr.children("td").get(2)).attr("value");
        var $smallTypeId = $($tr.children("td").get(3)).attr("value");
        var $money = $($tr.children("td").get(4)).attr("value");
        var $remark = $($tr.children("td").get(5)).attr("value");
        var $time = $($tr.children("td").get(6)).html();
        
        loadPayOutSmallType($bigTypeId);
        
        
        $("#payOutId").val($id);
        $("#payOutMoney").val($money);
        $("#payOutBigType").val($bigTypeId);
        $("#payOutSmallType").val($smallTypeId);
        $("#payOutAccount").val($accountId);
        $("#payOutRemark").html($remark);
        $("#payOutTime").val($time);
        
        $('#pay_out_update_modal').modal('show');
	});
}

//查询按钮点击事件
function payOutSearchBtnClick() {
	$("#pay_out_search_btn").click(function(){
		searchPayOut(1);
	});
}

//删除按钮点击事件
function payOutDeleteBtnClick() {
	$(".pay_out_delete_btn").click(function(){
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
			        	  url:'payOut/deleteById',
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
		    							searchPayOut(1);
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

//查询支出
function searchPayOut(page) {
	$.ajax({
		type:'post',
		url:'payOut/selectByParams?page='+page,
		data:$("#pay_out_search_form").serialize(),
		dataType:'json',
		success:function(pm) {
			if(pm==null || pm.recordsCount<=0) {
				$("#pay_out_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
				$("#pay_out_pagination").css("display", "none");
				return;
			}
			$("#pay_out_pagination").css("display", "block");
			//表格部分
			var $tableContent = "<tbody><tr>"+
		        "<th>id</th>"+
		        "<th>所属账户</th>"+
		        "<th>大类型</th>"+
		        "<th>小类型</th>"+
		        "<th>金额</th>"+
		        "<th>备注</th>"+
		        "<th>时间</th>"+
		        "<th>操作</th>"+
		    "</tr>";
		    for(var i=0; i<pm.records.length; i++) {
		    	$tableContent += "<tr>"+
		        "<td value='"+pm.records[i].id+"'>"+pm.records[i].id+"</td>"+
		        "<td value='"+pm.records[i].accountId+"' title='"+pm.records[i].accountName+"'>"+pm.records[i].accountName+"</td>"+
		        "<td value='"+pm.records[i].bigTypeId+"' title='"+pm.records[i].bigTypeName+"'>"+pm.records[i].bigTypeName+"</td>"+
		        "<td value='"+pm.records[i].smallTypeId+"' title='"+pm.records[i].smallTypeName+"'>"+pm.records[i].smallTypeName+"</td>"+
		        "<td value='"+pm.records[i].money+"' title='"+pm.records[i].money+"'>"+pm.records[i].money+"</td>"+
		        "<td value='"+pm.records[i].remark+"' title='"+pm.records[i].remark+"'>"+pm.records[i].remark+"</td>"+
		        "<td value='"+pm.records[i].time+"' title='"+pm.records[i].time+"'>"+pm.records[i].time+"</td>"+
		        "<td>"+
		            "<button class='btn btn-warning pay_out_edit_btn'>编辑</button>"+
		            "<button class='btn btn-danger pay_out_delete_btn'>删除</button>"+
		        "</td>"+
		    "</tr>";
		    }
		    $tableContent +="</tbody>";
			$("#pay_out_list_table").html($tableContent);
			payOutEditBtnClick();
			payOutDeleteBtnClick();
			
			//分页部分
			var $fenYeContent = "";
			if(pm.hasPrePage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchPayOut('+(pm.currPage-1)+');">&laquo;</a>'+
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
    	               		'<a href="javascript:searchPayOut('+i+');">'+i+'</a>'+
       	            	'</li>';
				}
				
			}
			if(pm.hasNextPage == true) {
				$fenYeContent += 
					'<li>'+
	            		'<a href="javascript:searchPayOut('+(pm.currPage+1)+');">&raquo;</a>'+
	            	'</li>';
			} else {
				$fenYeContent += 
					'<li class="disabled">'+
	            		'<span>&raquo;</span>'+
	            	'</li>';
			}
			$($("#pay_out_pagination").children("ul").get(0)).html($fenYeContent);
		}
	})
}

//保存按钮点击事件
function payOutSaveBtnClick() {
	$("#payOutSaveBtn").click(function(){
		//非空校验
		if($.trim($("#payOutId").val()) == "") {
   			swal("待保存记录异常","请重新编辑","error");
   			return;
    	}
		if($.trim($("#payOutMoney").val()) == "") {
   			$("#payOutMoney").attr("data-content", "金额不能为空");
   			$("#payOutMoney").popover("show");
   			return;
    	}
		if($.trim($("#payOutBigType").val()) == "") {
   			$("#payOutBigType").attr("data-content", "支出大类别不能为空");
   			$("#payOutBigType").popover("show");
   			return;
    	}
		if($.trim($("#payOutSmallType").val()) == "") {
   			$("#payOutSmallType").attr("data-content", "支出小类别不能为空");
   			$("#payOutSmallType").popover("show");
   			return;
    	}
		if($.trim($("#payOutAccount").val()) == "") {
   			$("#payOutAccount").attr("data-content", "所属账户不能为空");
   			$("#payOutAccount").popover("show");
   			return;
    	}
		if($.trim($("#payOutTime").val()) == "") {
   			$("#payOutTime").attr("data-content", "时间不能为空");
   			$("#payOutTime").popover("show");
   			return;
    	}
		//异步请求
		$.ajax({
			type:'post',
			url:'payOut/update',
			data:$('#pay_out_update_form').serialize(),
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
							$("#payOutCloseBtn")[0].click();
							//重新查询一遍 
							searchPayOut(1);
						}
					}
				);
			}
		});
	});
}


//输入框得到焦点，提示框隐藏
function payOutPopoverHide() {
	$("#pay_out_update_form input,#pay_out_update_form select").on("focus", function(){
		$(this).popover("hide");
	});	
}
</script>
</body>