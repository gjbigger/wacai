<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>财务概况</title>
</head>
<body>
	<div style="position:absolute;height: 225px;width:900px;padding-top:20px;margin-left:20px;margin-top:20px;">
		<div style="display:inline-block;top:-120px;position: relative;">
			<p>
				<span>本日支出</span>
				<span id="currDayPayOut" style="margin-left: 5px;"></span>
			</p>
			<p>
				<span>本月支出</span>
				<span id="currMonthPayOut" style="margin-left: 5px;"></span>
			</p>
			<p>
				<span>本年支出</span>
				<span id="currYearPayOut" style="margin-left: 5px;"></span>
			</p>
		</div>
		<div id="pay_out_month_report_main" style="width:700px;height:200px;margin-left: 80px;display: inline-block;"></div>
	</div>
	
	
	
	
	<span id="userDefaultAccountUnitId" style="display: none;">${user.defaultAccountUnitId}</span>
	<div style="border:1px solid lightgrey;width: 945px;margin-top: 260px;"></div>
	
	
	
	
	
	<div style="position:absolute;height: 325px;width:900px;margin-left:20px;margin-top:20px;">
		<div style="position:relative;top:-186px;padding-top: 20px;display: inline-block;">
			<span style="font-weight: bold;">本月支出</span>
			<p>
				<span style="border-top-left-radius:3px;border-bottom-left-radius:3px;background-color:#FFF8E3;border:1px solid #E1C9B3;padding: 5px;color:#AC7B50;display:inline-block ;">金额</span>
				<span id="currMonthPayOut2" style="border-top-right-radius:3px;border-bottom-right-radius:3px;background-color:#FFF8E3;border:1px solid #E1C9B3;color:#AC7B50;padding: 5px;margin-left: -5px;display:inline-block;width:100px;height: 32px;margin-top: 2px;padding-left:10px;">300</span>
			</p>
		</div>
		
		<div style="position:relative;display: inline-block;width:365px;height:325px;">
			<div style="position:relative;margin-left:130px;top: 25px;">本月支出(账户)</div>
			<div id="pay_out_account_report_main" style="width:270px;height:230px;left:40px;top:25px ;"></div>
		</div>
		
		<div style="position:relative;display: inline-block;width:365px;height:325px;">
			<span style="position:relative;margin-left:130px;top: 25px;">本月支出(类型)</span>
			<div id="pay_out_type_report_main" style="width:270px;height:230px;left:40px;top:25px ;"></div>
		</div>
	</div>
	
	<script>
	$(function(){
		loadPayOutMoneyNumber();
		loadPayOutReportCurrYear();
		loadPayOutReportCurrMonthGroupByAccountId();
		loadPayOutReportCurrMonthGroupByTypeId();
	});
	
	
	//加载支出的金额
	function loadPayOutMoneyNumber() {
		var date = formatDate(now);
		var month = date.substring(0, 7);
		var year = nowYear;
		$.ajax({
			type:'post',
			url:'report/selectPayOutThree',
			data:'date='+date+"&month="+month+"&year="+year,
			dataType:'json',
			success: function(map) {
				if(map.datePayOut == null) {
					map.datePayOut = 0;
				}
				if(map.monthPayOut == null) {
					map.monthPayOut = 0;
				}
				if(map.yearPayOut == null) {
					map.yearPayOut = 0;
				}
				$("#currDayPayOut").html(map.datePayOut);
				$("#currMonthPayOut").html(map.monthPayOut);
				$("#currYearPayOut").html(map.yearPayOut);
				$("#currMonthPayOut2").html(map.monthPayOut);
			}
		}); 
	}
	
	//加载今年的指出金额，按月显示
	function loadPayOutReportCurrYear() {
		var year = nowYear;
		var unitId = $("#userDefaultAccountUnitId").html();
		$.ajax({
			type:'post',
			url:'report/selectPayOutGroupByMonthForReport',
			data:'year='+year+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				var legendData = ['支出'];
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
						name:'支出',
			            type:'line',
			            stack: '总量',
			            data: data1
				};
				seriesArray.push(seriesObject);
				makeZheXianTu2(year+"年支出情况", legendData, xAxisData, seriesArray);
			}
		});
	}
	
	
	//本月支出 账户
	function loadPayOutReportCurrMonthGroupByAccountId() {
		var startTime = getThisMonthStartDate();
		var endTime = getThisMonthEndDate();
		var unitId = $("#userDefaultAccountUnitId").html();
		var hoverAnimationData = true;
		var labelNormalShowData = false;
		
		/* startTime = "2017-4-1";
		endTime = "2017-4-31";  */
		
		var accountChart = echarts.init(document.getElementById('pay_out_account_report_main'));
		
		$.ajax({
			type:'post',
			url:'report/selectPayOutGroupByAccountIdForReport',
			data:"startTime="+startTime+"&endTime="+endTime+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				var seriesName = "支出详情";
				var seriesDataArray = [];
				
				if(list.length <= 0) {
					seriesDataArray[0] = {
							value:0,
							name:'暂无数据'
					};
					hoverAnimationData = false;
					labelNormalShowData = true;
				}
				
				for(var i=0; i<list.length; i++) {
					var temp = {
							value:list[i].money,
							name:list[i].accountName
					}
					seriesDataArray[i] = temp;
				}
				var titleText = "本月支出(账户)";
				var option = makeHuanTu(seriesName, seriesDataArray,hoverAnimationData, labelNormalShowData); 
				accountChart.setOption(option);
			}
		});
	}
	
	//本月支出 类型
	function loadPayOutReportCurrMonthGroupByTypeId() {
		var startTime = getThisMonthStartDate();
		var endTime = getThisMonthEndDate();
		var unitId = $("#userDefaultAccountUnitId").html();
		var hoverAnimationData = true;
		var labelNormalShowData = false;
		
		var typeChart = echarts.init(document.getElementById('pay_out_type_report_main'));
		
		$.ajax({
			type:'post',
			url:'report/selectPayOutGroupByTypeIdForReport',
			data:"startTime="+startTime+"&endTime="+endTime+"&unitId="+unitId,
			dataType:'json',
			success:function(list) {
				var seriesDataArray = [];
				
				if(list.length <= 0) {
					seriesDataArray[0] = {
							value:0,
							name:'暂无数据'
					};
					hoverAnimationData = false;
					labelNormalShowData = true;
				}
				
				for(var i=0; i<list.length; i++) {
					var temp = {
							value:list[i].money,
							name:list[i].typeName
					}
					seriesDataArray[i] = temp;
				}
				var seriesName = "支出详情";
				var titleText = "本月支出(类型)";
				var option = makeHuanTu(seriesName, seriesDataArray, hoverAnimationData, labelNormalShowData); 
				typeChart.setOption(option);
			}
		});
	}
	
	
	//制作折线图
	function makeZheXianTu2(titleText, legendData, xAxisData, seriesArray) {
		var myChart = echarts.init(document.getElementById('pay_out_month_report_main'));
		var option = {
			    title: {
			        //text: '折线图堆叠'
			        text: titleText,
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
	
	
	//制作环图
	function makeHuanTu(seriesName, seriesDataArray,  hoverAnimationData, labelNormalShowData) {
		var option = {
		    tooltip: {
		        trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		    series: [
		        {
		        	 hoverAnimation:hoverAnimationData,
		            //name:'访问来源',
		            name:seriesName,
		            type:'pie',
		            radius: ['50%', '70%'],
		            avoidLabelOverlap: false,
		            label: {
		                normal: {
		                    show: labelNormalShowData,
		                    position: 'center'
		                },
		                emphasis: {
		                    show: true,
		                    textStyle: {
		                        fontSize: '20',
		                        fontWeight: 'bold'
		                    }
		                }
		            },
		            labelLine: {
		                normal: {
		                    show: false
		                }
		            },
		            data:seriesDataArray
		            	/* [
		                {value:335, name:'直接访问'},
		                {value:310, name:'邮件营销'},
		                {value:234, name:'联盟广告'},
		                {value:135, name:'视频广告'},
		                {value:1548, name:'搜索引擎'}
		            ] */
		        }
		    ]
		};
		return option;
	}
	</script>
</body>
</html>