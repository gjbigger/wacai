<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账户报表</title>
</head>
<body>
	<div id="account_report_main" style="width: 900px;height:500px;margin-left: 20px;margin-top: 20px;"></div>
	
	<script>
	$(function(){
		loadAccountReport();
	});
	
	//加载账户报表
	function loadAccountReport() {
		$.ajax({
			type:'post',
			url:'report/selectAccountForReport',
			dataType:'json',
			success:function(mm) {
				var defaultAccountUnit = mm.obj.defaultAccountUnit;
				var accountDtoList = mm.obj.accountDtoList;
				makeReport(defaultAccountUnit, accountDtoList);
			}
		});
	}
	
	//制作报表
	function makeReport(defaultAccountUnit, accountDtoList) {
		var accountNameArray = [];
		var accountBalanceArray = [];
		for(var i=0; i<accountDtoList.length; i++) {
			accountNameArray[i] = accountDtoList[i].name+'--'+accountDtoList[i].unitName;
			
			if(defaultAccountUnit.abbreviation == accountDtoList[i].unitAbbreviation) {
				accountBalanceArray[i] = accountDtoList[i].balance;
			} else {
				accountBalanceArray[i] = fx(accountDtoList[i].balance).from(accountDtoList[i].unitAbbreviation).to(defaultAccountUnit.abbreviation);
			}
		}
		
		// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('account_report_main'));

        // 指定图表的配置项和数据
		var option = {
			title: {
                text: '账户余额(默认币种：'+defaultAccountUnit.name+')'
            },
		    color: ['#3398DB'],
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : accountNameArray,
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'余额',
		            type:'bar',
		            barWidth: '60%',
		            data:accountBalanceArray
		        }
		    ]
		};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
	}
	</script>
</body>
</html>