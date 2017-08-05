<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>账户管理</title>
    <style>
	    #account_search_form {
	        margin-left: -8px;
	        display: inline-block;
	    }
	
	    #account_search_form label {
	        font-weight: normal;
	        margin-left: 20px;
	    }
	
	    #account_search_form select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #account_add_modal_open_btn {
	        height: 26px;
	        margin-top: -2px;
	        padding-top: 2px;
	        margin-right: 10px;
	    }
	
	    #account_search_btn {
	        margin-top: -2px;
	        height: 26px;
	        padding-top: 2px;
	        margin-left: 20px;
	    }
	
	    #account_list_table {
	        table-layout: fixed;
	        font-size: 14px;
	    }
	
	    #account_list_table tr th {
	        height: 30px;
	    }
	
	    #account_list_table tr td {
	        white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        padding-top: 10px;
	    }
	
	    #account_list_table tr td:first-child, th:first-child {
	        width: 50px;
	    }
	
	    #account_list_table tr td:last-child, th:last-child {
	        width: 118px;
	    }
	
	    #account_list_table tr td button {
	        margin-top: -7px;
	        margin-right: 5px;
	    }
	
	    #account_list_tool_bar {
	        margin-top: 10px;
	    }
	    
	    <!--模态框-->
	    #account_add_update_form {
	        margin-top: 25px;
	    }
	
	    #account_add_update_form .input_info {
	        witdh: 210px;
	        margin-top: 10px;
	        margin-left: 10px;
	    }
	
	    #account_add_update_form label {
	        font-weight: normal;
	        margin-right: 10px;
	    }
	
	    #account_add_update_form .input_info select {
	        width: 175px;
	        height: 27px;
	    }
	
	    #account_add_update_form .input_info input[type="date"] {
	        width: 175px;
	        height: 27px;
	    }
	
	    #account_add_update_form .input_info textarea {
	        resize: none;
	        overflow: auto;
	        width: 300px;
	        height: 70px;
	        vertical-align: top;
	    }
</style>
</head>
<body>


<div id="account_list_tool_bar">
    <button type="button" class="btn btn-primary" id="account_add_modal_open_btn">新增</button>

    <span style="height:26px;border: 1px solid lightgray;"></span>

    <form id="account_search_form">
        <label>账户名：</label><input type="text" name="queryAccountName" id="queryAccountName"/>

        <label>账户类型：</label><select name="queryAccountTypeId" id="queryAccountTypeId"></select>

        <label>创建时间：</label><input type="date" name="queryAccountCreateTime" id="queryAccountCreateTime"/>

        <button type="button" class="btn btn-success" id="account_search_btn">
            <span class="glyphicon glyphicon-search"></span>
        </button>
    </form>
</div>

<table id="account_list_table" class="table table-striped table-hover table-condensed">
	
</table>

<nav id="account_pagination" style="position: absolute;bottom: 0px;margin-left: 35%;">
    <ul class="pagination">
    </ul>
</nav>

<!-- 模态框 -->
<div id="account_add_update_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button id="closeBtn" type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title" id="account_add_update_modal_title"></h4>
            </div>
            <div class="modal-body">
                <form id="account_add_update_form">

                    <input type="hidden" name="id" id="accountId" />

                    <div class="input_info">
                        <label for="accountType">类别</label>
                        <select id="accountType" data-placement="right" data-trigger="manual">
                            <option value="1">现金</option>
                            <option value="2">信用卡</option>
                            <option value="3">储蓄卡</option>
                            <option value="4">投资账户</option>
                            <option value="5">储值卡</option>
                            <option value="6">网络账户</option>
                            <option value="7">虚拟账户</option>
                            <option value="8">债权/债务人</option>
                        </select>

                        <select id="accountType2" style="display:none;" data-placement="right" data-trigger="manual">
                            <option value="9">购物卡</option>
                            <option value="10">美容美发</option>
                            <option value="11">公交卡</option>
                            <option value="12">饭卡</option>
                            <option value="13">储值卡</option>
                        </select>
                        
                        <input type="hidden" name="typeId" id="trueAccountType">
                    </div>

                    <div class="input_info">
                        <label for="accountName">名称</label>
                        <input name="name" id="accountName" type="text" data-placement="right" data-trigger="manual" />
                    </div>

                    <div class="input_info">
                        <label for="balance">余额</label>
                        <input name="balance" id="balance" type="number" data-placement="right" data-trigger="manual">
                    </div>

                    <div class="input_info">
                        <label for="unitId">币种</label>
                        <select id="unitId" name="unitId" data-placement="right" data-trigger="manual">
                        </select>
                    </div>

                    <div id="creditPart" style="display: none;">
                        <hr />

                        <div class="input_info">
                            <label for="limits">信用额度</label>
                            <input name="limits" id="limits" type="number" data-placement="right" data-trigger="manual">
                        </div>

                        <div class="input_info">
                            <label for="billDay">账单日</label>
                            <select id="billDay" name="billDay" data-placement="right" data-trigger="manual">
                            </select>
                        </div>

                        <div class="input_info">
                            <label for="repayDay">还款日</label>
                            <select id="repayDay" name="repayDay" data-placement="right" data-trigger="manual">
                            </select>
                        </div>

                    </div>

                    <hr />

                    <div class="input_info">
                        <label for="remark">备注</label>
                        <textarea name="remark" id="remark"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
    $(function(){
    	popoverHide();
    	searchAccount(1);
    	accountSearchBtnClick();
    	loadAccountUnit();
    	loadAccountType();
    	saveBtnClick();
        loadBillDayAndRepayDay();
        accountAddModalOpenBtnClick();
        accountTypeSelect();
        cancelBtnClick();
        accountDeleteBtnClick();
        accountEditBtnClick();
        closeBtnClick();
        accountType2Select();
    });

    //加载账单日和还款日
    function loadBillDayAndRepayDay() {
        var op = "";
        for(var i=1; i<=28; i++) {
            op += "<option val='"+i+"'>"+i+"</option>";
        }
        $("#billDay,#repayDay").html(op);
    }
    
    //加载账户类型
    function loadAccountType() {
    	$.ajax({
    		type:'post',
    		url:'accountType/selectByPidForSelectOption',
    		data:'pid=0',
    		dataType:"json",
    		success:function(list) {
    			if(list == null || list.length <=0) {
    				return;
    			}
    			var op = "<option value=''>请选择</option>";
    			for(var i=0; i<list.length; i++) {
    				op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
    			}
    			$("#queryAccountTypeId").html(op);
    			$("#accountType").html(op);
    		}
    	});
    	$.ajax({
    		type:'post',
    		url:'accountType/selectByPidForSelectOption',
    		data:'pid=5',
    		dataType:"json",
    		success:function(list) {
    			if(list == null || list.length <=0) {
    				return;
    			}
    			var op = "<option value=''>请选择</option>";
    			for(var i=0; i<list.length; i++) {
    				op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
    			}
    			$("#accountType2").html(op);
    		}
    	});
    }

    //加载账户币种
    function loadAccountUnit() {
    	$.ajax({
    		type:'post',
    		url:'accountUnit/selectAllForSelectOption',
    		dataType:"json",
    		success:function(list) {
    			if(list == null || list.length <=0) {
    				return;
    			}
    			var op = "<option value=''>请选择</option>";
    			for(var i=0; i<list.length; i++) {
    				op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
    			}
    			$("#unitId").html(op);
    		}
    	});
    }
    
    //新增按钮点击事件，打开模态框
    function accountAddModalOpenBtnClick() {
        $("#account_add_modal_open_btn").click(function(){
            $("#account_add_update_modal_title").html("新增账户");
            $('#account_add_update_modal').modal('show');
        });
    }

    //账户类型选择事件
    function accountTypeSelect() {
        $("#accountType").change(function(){
           var $accountType = $(this).val();
           if($accountType == "2") {
               $("#creditPart").css("display", "block");
           } else {
               $("#creditPart").css("display", "none");
           }

            if($accountType == "5") {
                $("#accountType2").css("display", "inline-block");
            } else {
                $("#accountType2").css("display", "none");
                $("#accountType2").val("");
            }
            
            $("#trueAccountType").val($accountType);
        });
    }
    
    //账户类型2级的选择事件
    function accountType2Select() {
    	$("#accountType2").change(function(){
    		$("#trueAccountType").val($(this).val());
    	});
    }
    

    //取消按钮点击事件
    function cancelBtnClick() {
        $("#cancelBtn").click(function(){
            $(':input',"#account_add_update_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
            $("#creditPart").css("display", "none");
            $("#accountType2").css("display", "none");
        });
    }

    //x点击事件
    function closeBtnClick(){
        $("#closeBtn").click(function(){
            $(':input',"#account_add_update_form").not(":button,:submit,:reset").val("").removeAttr("checked").removeAttr("selected");
            $("#creditPart").css("display", "none");
            $("#accountType2").css("display", "none");
        });
    }

    //删除按钮点击事件
    function accountDeleteBtnClick() {
        $(".account_delete_btn").click(function(){
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
    			        	  url:'account/deleteById',
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
    		    							searchAccount(1);
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

    //编辑按钮点击事件
    function accountEditBtnClick() {
        $(".account_edit_btn").click(function(){
            var $tr = $(this).parent().parent();
            var $accountId = $($tr.children("td").get(0)).attr("value");
            var $accountName = $($tr.children("td").get(1)).attr("value");
            var $typeId = $($tr.children("td").get(2)).attr("value");
            var $balance = $($tr.children("td").get(3)).attr("value");
            var $unitId = $($tr.children("td").get(4)).attr("value");
            var $limits = $($tr.children("td").get(5)).html();
            var $billDay = $($tr.children("td").get(6)).html();
            var $repayDay = $($tr.children("td").get(7)).html();
            var $remark = $($tr.children("td").get(8)).attr("value");
            var $createTime = $($tr.children("td").get(9)).html();

            $("#accountId").val($accountId);
            $("#accountName").val($accountName);
            $("#accountType").val($typeId);
            $("#balance").val($balance);
            $("#unitId").val($unitId);
            $("#remark").html($remark);
            $("#trueAccountType").val($typeId);

            if($typeId == 2) {
                $("#creditPart").css("display", "block");
                $("#limits").val($limits);
                $("#billDay").val($billDay);
                $("#repayDay").val($repayDay);
            }
            if($typeId > 8) {
                $("#accountType2").css("display", "inline-block");
                $("#accountType").val("5");
                $("#accountType2").val($typeId);
            }

            $("#account_add_update_modal_title").html("编辑账户");
            $('#account_add_update_modal').modal('show');
        });
    }
    
    //保存按钮点击事件
    function saveBtnClick() {
    	$("#saveBtn").click(function(){
    		//非空校验
    		if($.trim($("#accountName").val()) == "") {
    			$("#accountName").attr("data-content", "账户名称不能为空");
    			$("#accountName").popover("show");
    			return;
    		}
    		if($.trim($("#balance").val()) == "") {
    			$("#balance").attr("data-content", "余额不能为空");
    			$("#balance").popover("show");
    			return;
    		}
    		if($.trim($("#unitId").val()) == "") {
    			$("#unitId").attr("data-content", "币种不能为空");
    			$("#unitId").popover("show");
    			return;
    		}
    		
    		
    		if($.trim($("#accountType").val()) == "") {
    			$("#accountType").attr("data-content", "账户类型不能为空");
    			$("#accountType").popover("show");
    			return;
    		}
    		if($.trim($("#trueAccountType").val()) == "") {
    			swal("错误", "账户类型发生异常，请重新选择", "error");
    			return;
    		}
    		if($.trim($("#accountType").val()) == "5") {
    			if($.trim($("#accountType2").val()) == "") {
        			$("#accountType2").attr("data-content", "账户类型不能为空");
        			$("#accountType2").popover("show");
        			return;
        		}
    		}
    		if($.trim($("#accountType").val()) == "2") {
    			if($.trim($("#limits").val()) == "") {
        			$("#limits").attr("data-content", "信用额度不能为空");
        			$("#limits").popover("show");
        			return;
        		}
    			if($.trim($("#billDay").val()) == "") {
        			$("#billDay").attr("data-content", "账单日不能为空");
        			$("#billDay").popover("show");
        			return;
        		}
    			if($.trim($("#repayDay").val()) == "") {
        			$("#repayDay").attr("data-content", "还款日不能为空");
        			$("#repayDay").popover("show");
        			return;
        		}
    		}
    		//异步请求
    		$.ajax({
    			type:'post',
    			url:'account/insertOrUpdate',
    			data:$('#account_add_update_form').serialize(),
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
    							$("#closeBtn")[0].click();
    							//重新查询一遍 
    							searchAccount(1);
    						}
    					}
    				);
    			}
    		});
    	});
    }
    
    //搜索按钮点击事件
    function accountSearchBtnClick() {
    	$("#account_search_btn").click(function(){
    		searchAccount(1);
    	});
    }
    
    //查询账户
    function searchAccount(page) {
    	$.ajax({
    		type:'post',
    		url:'account/selectByParams?page='+page,
    		data:$("#account_search_form").serialize(),
    		dataType:'json',
    		success:function(pm) {
    			if(pm==null || pm.recordsCount<=0) {
    				$("#account_list_table").html("<tr><td style='text-align:center;'><h3>暂无记录</h3></td></tr>");
    				$("#account_pagination").css("display", "none");
    				return;
    			}
    			$("#account_pagination").css("display", "block");
    			//表格部分
    			var $tableContent = "<tbody><tr>"+
    		        "<th>id</th>"+
    		        "<th>账户名</th>"+
    		        "<th>账户类型</th>"+
    		        "<th>余额</th>"+
    		        "<th>货币种类</th>"+
    		        "<th>信用额度</th>"+
    		        "<th>账单日</th>"+
    		        "<th>还款日</th>"+
    		        "<th>备注</th>"+
    		        "<th>创建时间</th>"+
    		        "<th>操作</th>"+
    		    "</tr>";
    		    for(var i=0; i<pm.records.length; i++) {
    		    	$tableContent += "<tr>"+
    		        "<td value='"+pm.records[i].id+"'>"+pm.records[i].id+"</td>"+
    		        "<td value='"+pm.records[i].name+"' title='"+pm.records[i].name+"'>"+pm.records[i].name+"</td>"+
    		        "<td value='"+pm.records[i].typeId+"'>"+pm.records[i].typeName+"</td>"+
    		        "<td value='"+pm.records[i].balance+"' title='"+pm.records[i].balance+"'>"+pm.records[i].balance+"</td>"+
    		        "<td value='"+pm.records[i].unitId+"'>"+pm.records[i].unitName+"</td>";
    		        
    		        if(pm.records[i].limits != null) {
    		        	$tableContent += "<td value='"+pm.records[i].limits+"' title='"+pm.records[i].limits+"'>"+pm.records[i].limits+"</td>"+
        		        "<td>"+pm.records[i].billDay+"</td>"+
        		        "<td>"+pm.records[i].repayDay+"</td>";
    		        } else {
    		        	$tableContent += "<td></td><td></td><td></td>";
    		        }
    		        
    		        $tableContent += "<td value='"+pm.records[i].remark+"' title='"+pm.records[i].remark+"'>"+pm.records[i].remark+"</td>"+
    		        "<td value='"+pm.records[i].createTime+"' title='"+pm.records[i].createTime+"'>"+pm.records[i].createTime+"</td>"+
    		        "<td>"+
    		            "<button class='btn btn-warning account_edit_btn'>编辑</button>"+
    		            "<button class='btn btn-danger account_delete_btn'>删除</button>"+
    		        "</td>"+
    		    "</tr>";
    		    }
    		    $tableContent +="</tbody>";
    			$("#account_list_table").html($tableContent);
    			accountEditBtnClick();
    			accountDeleteBtnClick();
    			
    			//分页部分
    			var $fenYeContent = "";
    			if(pm.hasPrePage == true) {
    				$fenYeContent += 
    					'<li>'+
    	            		'<a href="javascript:searchAccount('+(pm.currPage-1)+');">&laquo;</a>'+
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
	    	               		'<a href="javascript:searchAccount('+i+');">'+i+'</a>'+
	       	            	'</li>';
    				}
    				
    			}
    			if(pm.hasNextPage == true) {
    				$fenYeContent += 
    					'<li>'+
    	            		'<a href="javascript:searchAccount('+(pm.currPage+1)+');">&raquo;</a>'+
    	            	'</li>';
    			} else {
    				$fenYeContent += 
    					'<li class="disabled">'+
    	            		'<span>&raquo;</span>'+
    	            	'</li>';
    			}
    			$($("#account_pagination").children("ul").get(0)).html($fenYeContent);
    		}
    	})
    }
    
    //输入框得到焦点，提示框隐藏
    function popoverHide() {
		$("#account_add_update_form input,#account_add_update_form select").on("focus", function(){
			$(this).popover("hide");
		});	
	}
</script>
</body>
</html>