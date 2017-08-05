var now = new Date(); // 当前日期
var nowDayOfWeek = now.getDay(); // 今天本周的第几天
var nowDay = now.getDate(); // 当前日
var nowMonth = now.getMonth(); // 当前月
var nowYear = now.getYear(); // 当前年
nowYear += (nowYear < 2000) ? 1900 : 0; //

var lastMonthDate = new Date(); // 上月日期
lastMonthDate.setDate(1);
lastMonthDate.setMonth(lastMonthDate.getMonth() - 1);
var lastYear = lastMonthDate.getYear();
var lastMonth = lastMonthDate.getMonth();

// 格式化日期：yyyy-MM-dd
function formatDate(date) {
	var myyear = date.getFullYear();
	var mymonth = date.getMonth() + 1;
	var myweekday = date.getDate();

	if (mymonth < 10) {
		mymonth = "0" + mymonth;
	}
	if (myweekday < 10) {
		myweekday = "0" + myweekday;
	}
	return (myyear + "-" + mymonth + "-" + myweekday);
}

// 获得某月的天数
function getMonthDays(myMonth) {
	var monthStartDate = new Date(nowYear, myMonth, 1);
	var monthEndDate = new Date(nowYear, myMonth + 1, 1);
	var days = (monthEndDate - monthStartDate) / (1000 * 60 * 60 * 24);
	return days;
}

// 获得本季度的开始月份
function getQuarterStartMonth() {
	var quarterStartMonth = 0;
	if (nowMonth < 3) {
		quarterStartMonth = 0;
	}
	if (2 < nowMonth && nowMonth < 6) {
		quarterStartMonth = 3;
	}
	if (5 < nowMonth && nowMonth < 9) {
		quarterStartMonth = 6;
	}
	if (nowMonth > 8) {
		quarterStartMonth = 9;
	}
	return quarterStartMonth;
}




// 获得本周的开始日期
function getThisWeekStartDate() {
	var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1);
	return formatDate(weekStartDate);
}
// 获得本周的结束日期
function getThisWeekEndDate() {
	var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek+1));
	return formatDate(weekEndDate);
}
//获得上周的开始日期
function getLastWeekStartDate() {
	var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1-7);
	return formatDate(weekStartDate);
}
//获得上周的结束日期
function getLastWeekEndDate() {
	var weekEndDate = new Date(nowYear, nowMonth, nowDay - 7 + (6 - nowDayOfWeek+1));
	return formatDate(weekEndDate);
}


// 获得本月的开始日期
function getThisMonthStartDate() {
	var monthStartDate = new Date(nowYear, nowMonth, 1);
	return formatDate(monthStartDate);
}
// 获得本月的结束日期
function getThisMonthEndDate() {
	var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
	return formatDate(monthEndDate);
}
// 获得上月开始时间
function getLastMonthStartDate() {
	var lastMonthStartDate = new Date(nowYear, lastMonth, 1);
	return formatDate(lastMonthStartDate);
}
// 获得上月结束时间
function getLastMonthEndDate() {
	var lastMonthEndDate = new Date(nowYear, lastMonth, getMonthDays(lastMonth));
	return formatDate(lastMonthEndDate);
}




// 获得本季度的开始日期
function getThisQuarterStartDate() {
	var quarterStartDate = new Date(nowYear, getQuarterStartMonth(), 1);
	return formatDate(quarterStartDate);
}
// 或的本季度的结束日期
function getThisQuarterEndDate() {
	var quarterEndMonth = getQuarterStartMonth() + 2;
	var quarterEndDate = new Date(nowYear, quarterEndMonth,
			getMonthDays(quarterEndMonth));
	return formatDate(quarterEndDate);
}
//获得上季度的开始日期
function getLastQuarterStartDate() {
	var quarterStartDate = new Date(nowYear, getQuarterStartMonth()-3, 1);
	return formatDate(quarterStartDate);
}
//或的上季度的结束日期
function getLastQuarterEndDate() {
	var quarterEndMonth = getQuarterStartMonth() - 1;
	var quarterEndDate = new Date(nowYear, quarterEndMonth,
			getMonthDays(quarterEndMonth));
	return formatDate(quarterEndDate);
}




//获得本年的开始日期
function getThisYearStartDate() {
	var thisYearStartDate = new Date(nowYear, 1-1, 31);
	return formatDate(thisYearStartDate);
}
//获得本年的结束日期
function getThisYearEndDate() {
	var thisYearEndDate = new Date(nowYear, 12-1, 31);
	return formatDate(thisYearEndDate);
}
//获得上年的开始日期
function getLastYearStartDate() {
	var lastYearStartDate = new Date(nowYear-1, 1-1, 31);
	return formatDate(lastYearStartDate);
}
//获得上年的结束日期
function getLastYearEndDate() {
	var lastYearEndDate = new Date(nowYear-1, 12-1, 31);
	return formatDate(lastYearEndDate);
}



$(function() {
	setHuiLv();
});

/**
 * 设置汇率
 */
function setHuiLv() {
	fx.base = "CNY";
	fx.rates = {
		"CNY" : 1, // 人民币
		"USD" : 0.1452, // 美元
		"EUR" : 0.1361, // 欧元
		"HKD" : 1.1269, // 港币
		"GBP" : 0.1162, // 英镑
		"NTD" : 4.5142, // 新台币
		"JPY" : 16.3149,// 日元
		"KRW" : 166.5030, // 韩元
		"MYR" : 0.6451, // 马来币
		"NZD" : 0.1992, // 新西兰元
		"ARS" : 2.2748, // 阿根廷比索
		"EGP" : 2.6507, // 埃及镑
		"AUD" : 0.1903, // 澳大利亚元
		"MOP" : 1.1595, // 澳门币
		"PRK" : 15.2264, // 巴基斯坦卢比
		"BRZ" : 0.4532, // 巴西雷亚尔
		"KPW" : 130.7988, // 朝鲜元
		"DEM" : 0.2581, // 德国马克
		"SUR" : 8.6340, // 俄罗斯卢布
		"FRF" : 0.8367, // 法郎
		"PHP" : 7.2410, // 菲律宾比索
		"NLG" : 0.2916, // 荷兰盾
		"CAD" : 0.1914, // 加拿大元
		"MVR" : 2.2163, // 马尔代夫卢非亚
		"MNT" : 359.4059, // 蒙古图格里格
		"BUK" : 198.5447, // 缅甸元
		"PTE" : 26.5274, // 葡萄牙埃斯库多
		"SAR" : 0.5446, // 沙特阿拉伯亚尔
		"THP" : 5.0878, // 泰铢
		"VEB" : 1.4496, // 委内瑞拉玻利瓦尔
		"ESP" : 16.6603, // 西班牙比塞塔
		"GRD" : 34.1196, // 希腊德拉马克
		"SGD" : 0.2060, // 新加坡元
		"ITL" : 193.8473, // 意大利里拉
		"INR" : 9.7753, // 印度卢比
		"IDR" : 1935.5307, // 印尼盾
		"VND" : 3288.8050, // 越南盾
		"KHR" : 579.2290, // 柬埔寨瑞尔
		"SEK" : 1.2900, // 瑞典克朗
		"HUF" : 42.0357, // 匈牙利福林
		"AED" : 0.5332, // 阿联酋迪拉姆
		"CHF" : 0.1450, // 瑞士法郎
		"XOF" : 89.5245, //西非法郎
	}
}
