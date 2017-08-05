<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收支差报表</title>
</head>
<body>
<div style="margin-top: 20px;margin-left: 10px;">

	<select id="pay_in_out_cha_report_account_unit" style="height: 28px;width: 120px;">
	</select>
	
	<div id="pay_in_out_cha_report_search_part"  style="display: inline-block;margin-left: 30px;">
		<button id="pay_in_out_cha_report_last_year_btn" >&lt;</button>
		<span id="pay_in_out_cha_report_monthPayInOutCha_year" style="margin-left: 10px;margin-right: 10px;"></span>
		<button id="pay_in_out_cha_report_next_year_btn" >&gt;</button>
	</div>
	
</div>	

	<div id="pay_in_out_cha_report_main" style="width: 850px;height:450px;margin-left: 20px;margin-top: 20px;"></div>

	<script>
	
	$(function(){
		loadPayInOutChaReportAccountUnit();
		PayInOutChaReportAccountUnitChange();
		payInOutChaReportLastYearBtnClick();
		payInOutChaReportNextYearBtnClick();
		
		$("#pay_in_out_cha_report_monthPayInOutCha_year").html(nowYear);
		monthPayInOutChaSearch($("#pay_in_out_cha_report_monthPayInOutCha_year").html(), 1);
	});
	
	
	//加载账户币种
	function loadPayInOutChaReportAccountUnit() {
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
    			$("#pay_in_out_cha_report_account_unit").html(op);
    		}
    	});
	}
	
	//币种改变，调用重新查询
	function PayInOutChaReportAccountUnitChange() {
		$("#pay_in_out_cha_report_account_unit").change(function(){
			var year = $("#pay_in_out_cha_report_monthPayInOutCha_year").html();
			var unitId = $("#pay_in_out_cha_report_account_unit").val();
			monthPayInOutChaSearch(year, unitId);
		});
	}

	
	//上一年按钮单击事件
	function payInOutChaReportLastYearBtnClick() {
		$("#pay_in_out_cha_report_last_year_btn").click(function(){
			var $currYear = parseInt($("#pay_in_out_cha_report_monthPayInOutCha_year").html());
			if($currYear > 1900) {
				$("#pay_in_out_cha_report_monthPayInOutCha_year").html($currYear-1);
				var year = $("#pay_in_out_cha_report_monthPayInOutCha_year").html();
				var unitId = $("#pay_in_out_cha_report_account_unit").val();
				monthPayInOutChaSearch(year, unitId);
			}
		});
	}
	
	//下一年按钮单击事件
	function payInOutChaReportNextYearBtnClick() {
		$("#pay_in_out_cha_report_next_year_btn").click(function(){
			var $currYear = parseInt($("#pay_in_out_cha_report_monthPayInOutCha_year").html());
			if($currYear < nowYear) {
				$("#pay_in_out_cha_report_monthPayInOutCha_year").html($currYear+1);
				var year = $("#pay_in_out_cha_report_monthPayInOutCha_year").html();
				var unitId = $("#pay_in_out_cha_report_account_unit").val();
				monthPayInOutChaSearch(year, unitId);
			}
		});
	}
	
	
	//逐年收入查询
	function monthPayInOutChaSearch(year, unitId) {
		$.ajax({
			type:'post',
			url:'report/selectPayInOutChaGroupByMonthForReport',
			data:'year='+year+"&unitId="+unitId,
			dataType:'json',
			success:function(map) {
				var legendData = ['收入', '支出'];
				var yAxisData = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','全年'];
				
				var data1 = [];
				var data2 = [];
				for(var i=1,j=0; i<13; i++) {
					if(j<map.payInList.length && map.payInList[j].month == i) {
						data1[i-1] = map.payInList[j].money;
						j++;
					} else {
						data1[i-1] = 0;
					}
				}
				data1[12] = map.payInAllYearMoney;
				for(var i=1,j=0; i<13; i++) {
					if(j<map.payOutList.length && map.payOutList[j].month == i) {
						data2[i-1] = -map.payOutList[j].money;
						j++;
					} else {
						data2[i-1] = 0;
					}
				}
				data2[12] = -map.payOutAllYearMoney;
				var seriesArray = [];
				var payInObj = {
						name:'收入',
			            type:'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: false
			                }
			            },
			            data: data1
				};
				var payOutObj = {
						name:'支出',
			            type:'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: false,
			                    position: 'left'
			                }
			            },
			            data: data2
				};
				seriesArray[0] = payInObj;
				seriesArray[1] = payOutObj;
				makeZhengFuTu(legendData, yAxisData, seriesArray);
			}
		});
	}
	
	//制作正负图
	function makeZhengFuTu(legendData, yAxisData, seriesArray) {
		var myChart = echarts.init(document.getElementById('pay_in_out_cha_report_main'));
		var option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        //data:['利润', '支出', '收入']
		    	data: legendData
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		            axisTick : {show: false},
		            //data : ['周一','周二','周三','周四','周五','周六','周日']
		            data: yAxisData
		        }
		    ],
		    series : seriesArray
		    	/* [
		        {
		            name:'利润',
		            type:'bar',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'inside'
		                }
		            },
		            data:[200, 170, 240, 244, 200, 220, 210]
		        },
		        {
		            name:'收入',
		            type:'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true
		                }
		            },
		            data:[320, 302, 341, 374, 390, 450, 420]
		        },
		        {
		            name:'支出',
		            type:'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'left'
		                }
		            },
		            data:[-120, -132, -101, -134, -190, -230, -210]
		        }
		    ] */
		};
		myChart.setOption(option);
	}
	
	
	</script>
</body>
</html>