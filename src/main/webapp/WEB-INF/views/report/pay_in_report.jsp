<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收入报表</title>
</head>
<body>
<div style="margin-top: 20px;margin-left: 10px;">

	<select id="pay_in_report_account_unit" style="height: 28px;width: 120px;">
	</select>

	<div class="btn-group" role="group" id="pay_in_btn_group">
	  <button id="monthPayInBtn"  type="button" class="btn btn-default btn-sm active">逐月收入</button>
	  <button id="typePayInBtn" type="button" class="btn btn-default btn-sm">类别收入</button>
	  <button id="accountPayInBtn" type="button" class="btn btn-default btn-sm">账户收入</button>
	</div>
	
	<div style="display: inline-block;margin-left: 10px;display: none;" id="pay_in_report_search_part">
		<select style="height: 28px;width: 130px;" id="pay_in_report_search_info">
		</select>
	</div>
	
	<div style="display: inline-block;display: none;" id="pay_in_report_search_part2">
		<input id="pay_in_start_time" type="date" style="width: 140px;height: 27px;margin-left: 10px;" /> 
		- 
		<input id="pay_in_end_time" type="date" style="width: 140px;height: 27px;" />
		
		<select style="height: 28px;" id="pay_in_time">
			<option value="">自定义</option>
			<option value="thisWeek">本周</option>
			<option value="lastWeek">上周</option>
			<option value="thisMonth">本月</option>
			<option value="lastMonth">上月</option>
			<option value="thisQuerter">本季</option>
			<option value="lastQuerter">上季</option>
			<option value="thisYear">今年</option>
			<option value="lastYear">去年</option>
		</select>
		
		<button id="pay_in_report_search_btn" type="button" style="margin-left: 10px;">确定</button>
	</div>
	
	<div id="pay_in_report_search_part3"  style="display: inline-block;margin-left: 30px;">
		<button id="pay_in_report_last_year_btn" >&lt;</button>
		<span id="pay_in_report_monthPayIn_year" style="margin-left: 10px;margin-right: 10px;"></span>
		<button id="pay_in_report_next_year_btn" >&gt;</button>
	</div>
	
</div>	

	<div id="pay_in_report_main" style="width: 850px;height:450px;margin-left: 20px;margin-top: 20px;"></div>

	<script>
	
	$(function(){
		monthPayInBtnClick();
		typePayInBtnClick();
		accountPayInBtnClick();
		payInTimeChange();
		payInReportLastYearBtnClick();
		payInReportNextYearBtnClick();
		payInReportSearchBtnClick();
		loadPayInReportAccountUnit();
		PayInReportAccountUnitChange();
		payInStartTimeChange();
		payInEndTimeChange();
		
		$("#pay_in_start_time").val(getThisWeekStartDate());
		$("#pay_in_end_time").val(getThisWeekEndDate());
		$("#pay_in_report_monthPayIn_year").html(nowYear);
		monthPayInSearch($("#pay_in_report_monthPayIn_year").html(), 1);
	});
	
	
	//开始时间改变，选择栏置为自定义
	function payInStartTimeChange() {
		$("#pay_in_start_time").change(function(){
			$("#pay_in_time").val("");
		});
	}
	
	//结束时间改变，选择栏置为自定义
	function payInEndTimeChange() {
		$("#pay_in_end_time").change(function(){
			$("#pay_in_time").val("");
		});
	}
	
	
	
	//加载账户币种
	function loadPayInReportAccountUnit() {
		$.ajax({
    		type:'post',
    		url:'accountUnit/selectAllForSelectOption',
    		dataType:"json",
    		success:function(list) {
    			if(list == null || list.length <=0) {
    				return;
    			}
    			var op = "";
    			for(var i=0; i<list.length; i++) {
    				op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
    			}
    			$("#pay_in_report_account_unit").html(op);
    		}
    	});
	}
	
	//币种改变，调用重新查询
	function PayInReportAccountUnitChange() {
		$("#pay_in_report_account_unit").change(function(){
			$("#pay_in_report_search_btn")[0].click();
		});
	}
	
	//逐月收入按钮单击事件
	function monthPayInBtnClick() {
		$("#monthPayInBtn").click(function(){
			$("#pay_in_btn_group>button.active").removeClass("active");
			$(this).addClass("active");
			
			$("#pay_in_report_search_part3").css("display","inline-block");	//年份选择
			$("#pay_in_report_search_part2").css("display", "none");	//时间选择
			$("#pay_in_report_search_part").css("display", "none");	//条件选择
			
			$("#pay_in_report_search_btn")[0].click();
		});
	}
	
	//类别收入按钮单击事件
	function typePayInBtnClick() {
		$("#typePayInBtn").click(function(){
			$("#pay_in_btn_group>button.active").removeClass("active");
			$(this).addClass("active");
			
			var op = "<option value=''>请选择账户</option>"
			$.ajax({
				type:'post',
				url:'account/selectByUserIdAndTypeIdIsNot8ForSelectOption',
				async:false,
				dataType:'json',
				success:function(list) {
					if(list.length > 0) {
						for(var i=0; i<list.length; i++) {
							op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>"
						}
					}
				}
			});
			$("#pay_in_report_search_info").html(op);
			$("#pay_in_report_search_part").css("display", "inline-block");
			$("#pay_in_report_search_part3").css("display","none");	
			$("#pay_in_report_search_part2").css("display", "inline-block");
			
			$("#pay_in_report_search_btn")[0].click();
		});
	}
	
	//账户收入按钮单击事件
	function accountPayInBtnClick() {
		$("#accountPayInBtn").click(function(){
			$("#pay_in_btn_group>button.active").removeClass("active");
			$(this).addClass("active");
			
			var op = "<option value=''>请选择类别</option>"
				$.ajax({
					type:'post',
					url:'payInType/selectByUserIdForSelectOption',
					async:false,
					dataType:'json',
					success:function(list) {
						if(list.length > 0) {
							for(var i=0; i<list.length; i++) {
								op += "<option value='"+list[i].id+"'>"+list[i].name+"</option>"
							}
						}
					}
				});
			
			$("#pay_in_report_search_info").html(op);
			$("#pay_in_report_search_part").css("display", "inline-block");
			$("#pay_in_report_search_part3").css("display","none");	
			$("#pay_in_report_search_part2").css("display", "inline-block");
			
			$("#pay_in_report_search_btn")[0].click();
		});
	}
	
	//上一年按钮单击事件
	function payInReportLastYearBtnClick() {
		$("#pay_in_report_last_year_btn").click(function(){
			var $currYear = parseInt($("#pay_in_report_monthPayIn_year").html());
			if($currYear > 1900) {
				$("#pay_in_report_monthPayIn_year").html($currYear-1);
				$("#pay_in_report_search_btn")[0].click();
			}
		});
	}
	
	//上一年按钮单击事件
	function payInReportNextYearBtnClick() {
		$("#pay_in_report_next_year_btn").click(function(){
			var $currYear = parseInt($("#pay_in_report_monthPayIn_year").html());
			if($currYear < nowYear) {
				$("#pay_in_report_monthPayIn_year").html($currYear+1);
				$("#pay_in_report_search_btn")[0].click();
			}
		});
	}
	
	//预设时间选择事件
	function payInTimeChange() {
		$("#pay_in_time").change(function(){
			var setTime = $(this).val();
			if(setTime == "thisWeek") {
				$("#pay_in_start_time").val(getThisWeekStartDate());
				$("#pay_in_end_time").val(getThisWeekEndDate());
				
			} else if (setTime == "lastWeek") {
				$("#pay_in_start_time").val(getLastWeekStartDate());
				$("#pay_in_end_time").val(getLastWeekEndDate());
				
			} else if (setTime == "thisMonth") {
				$("#pay_in_start_time").val(getThisMonthStartDate());
				$("#pay_in_end_time").val(getThisMonthEndDate());
				
			} else if (setTime == "lastMonth") {
				$("#pay_in_start_time").val(getLastMonthStartDate());
				$("#pay_in_end_time").val(getLastMonthEndDate());
				
			} else if (setTime == "thisQuerter") {
				$("#pay_in_start_time").val(getThisQuarterStartDate());
				$("#pay_in_end_time").val(getThisQuarterEndDate());
				
			} else if (setTime == "lastQuerter") {
				$("#pay_in_start_time").val(getLastQuarterStartDate());
				$("#pay_in_end_time").val(getLastQuarterEndDate());
				
			} else if (setTime == "thisYear") {
				$("#pay_in_start_time").val(getThisYearStartDate());
				$("#pay_in_end_time").val(getThisYearEndDate());
				
			} else if (setTime == "lastYear") {
				$("#pay_in_start_time").val(getLastYearStartDate());
				$("#pay_in_end_time").val(getLastYearEndDate());
				
			} else if (setTime == '' || setTime == null) {
				$("#pay_in_start_time").val("");
				$("#pay_in_end_time").val("");
			}
		});
	}
	
	//确定按钮单击事件
	function payInReportSearchBtnClick() {
		$("#pay_in_report_search_btn").click(function(){
			var $startTime = $("#pay_in_start_time").val();
			var $endTime = $("#pay_in_end_time").val();
			var $unitId = $("#pay_in_report_account_unit").val();
			
			var $activeBtnId = $("#pay_in_btn_group>button.active").attr("id");
			if($activeBtnId == 'typePayInBtn') {
				var $accountId = $("#pay_in_report_search_info").val();
				var $accountName = $("#pay_in_report_search_info>option:selected").html();
				typePayInSearch($accountName ,$accountId, $startTime, $endTime, $unitId);
				
			} else if($activeBtnId == 'accountPayInBtn') {
				var $typeId = $("#pay_in_report_search_info").val();
				var $typeName = $("#pay_in_report_search_info>option:selected").html();
				accountPayInSearch($typeName, $typeId, $startTime, $endTime, $unitId);
				
			} else if ($activeBtnId == 'monthPayInBtn') {
				var $year = $("#pay_in_report_monthPayIn_year").html();
				monthPayInSearch($year, $unitId);
			}
		});
	}
	
	
	//逐年收入查询
	function monthPayInSearch(year, unitId) {
		$.ajax({
			type:'post',
			url:'report/selectPayInGroupByMonthForReport',
			data:'year='+year+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				var legendData = ['收入'];
				var xAxisData = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
				var data1 = [];
				for(var i=1,j=0; i<13; i++) {
					if(j<list.length && list[j].month == i) {
						data1[i-1] = list[j].money;
						j++;
					} else {
						data1[i-1] = 0;
					}
				}
				var seriesArray = [];
				var seriesObject = {
						name:'收入',
			            type:'line',
			            stack: '总量',
			            data: data1
				};
				seriesArray.push(seriesObject);
				makeZheXianTu(year+"年收入情况", legendData, xAxisData, seriesArray);
			}
		});
	}
	
	//类别收入查询
	function typePayInSearch(accountName, accountId, startTime, endTime, unitId) {
		$.ajax({
			type:'post',
			url:'report/selectPayInGroupByTypeIdForReport',
			data:'accountId='+accountId+"&startTime="+startTime+"&endTime="+endTime+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				if(list.length <= 0) {
					$("#pay_in_report_main").html("<h2 align='center' style='margin-top:50px;'>暂无数据</h2>");
					return;
				}
				var titleText = '类别收入';
				var titleSubText = '';
				if(accountName == '请选择账户') {
					titleSubText = '所有账户';
				} else {
					titleSubText = accountName;
				}
				var seriesName = "类别收入";
				var legendDataArray = [];
				var seriesDataArray = [];
				for(var i=0; i<list.length; i++) {
					legendDataArray[i] = list[i].typeName;
					var temp = {
							value:list[i].money,
							name:list[i].typeName
					}
					seriesDataArray[i] = temp;
				}
				makeBingTu(titleText, titleSubText, legendDataArray, seriesName, seriesDataArray);
			}
		});
	}
	
	//账户收入查询
	function accountPayInSearch(typeName, typeId, startTime, endTime, unitId) {
		$.ajax({
			type:'post',
			url:'report/selectPayInGroupByAccountIdForReport',
			data:'typeId='+typeId+"&startTime="+startTime+"&endTime="+endTime+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				if(list.length <= 0) {
					$("#pay_in_report_main").html("<h2 align='center' style='margin-top:50px;'>暂无数据</h2>");
					return;
				}
				var titleText = '账户收入';
				var titleSubText = '';
				if(typeName == '请选择类别') {
					titleSubText = '所有类别';
				} else {
					titleSubText = typeName;
				}
				var seriesName = "账户收入";
				var legendDataArray = [];
				var seriesDataArray = [];
				for(var i=0; i<list.length; i++) {
					legendDataArray[i] = list[i].accountName;
					var temp = {
							value:list[i].money,
							name:list[i].accountName
					}
					seriesDataArray[i] = temp;
				}
				makeBingTu(titleText, titleSubText, legendDataArray, seriesName, seriesDataArray);
			}
		});
	}
	
	
	//制作折线图
	function makeZheXianTu(titleText, legendData, xAxisData, seriesArray) {
		var myChart = echarts.init(document.getElementById('pay_in_report_main'));
		var option = {
			    title: {
			        //text: '折线图堆叠'
			        text: titleText
			    },
			    tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        //data:['邮件营销','联盟广告','视频广告','直接访问','搜索引擎']
			    	data: legendData
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    toolbox: {
			        feature: {
			            saveAsImage: {}
			        }
			    },
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        //data: ['周一','周二','周三','周四','周五','周六','周日']
			    	data: xAxisData
			    },
			    yAxis: {
			        type: 'value'
			    },
			    series: seriesArray
			};
		myChart.setOption(option);
	}	
	
	
	//制作饼图
	function makeBingTu(titleText, titleSubText, legendDataArray, seriesName, seriesDataArray) {
		var myChart = echarts.init(document.getElementById('pay_in_report_main'));
		var option = {
			    title : {
			        //text: '某站点用户访问来源',
			        text: titleText,
			        //subtext: '纯属虚构',
			        subText : titleSubText,
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        //data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
			    	data:legendDataArray
			    },
			    series : [
			        {
			            //name: '访问来源',
			            name: seriesName,
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            /* data:[
			                {value:335, name:'直接访问'},
			                {value:310, name:'邮件营销'},
			                {value:234, name:'联盟广告'},
			                {value:135, name:'视频广告'},
			                {value:1548, name:'搜索引擎'}
			            ], */
			            data:seriesDataArray,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
		 	myChart.setOption(option);
	}
	</script>
</body>
</html>