package com.gj.wacai.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.accountUnit.pojo.AccountUnit;
import com.gj.wacai.accountUnit.service.AccountUnitService;
import com.gj.wacai.report.dto.PayInReportDto;
import com.gj.wacai.report.dto.PayOutReportDto;
import com.gj.wacai.report.service.ReportService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("report")
public class ReportController {

	@Resource
	private ReportService reportService;
	@Resource
	private AccountUnitService accountUnitService;
	
	
	/**
	 * 查询账户数据用于制作报表
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectAccountForReport")
	@ResponseBody
	public MessageModel selectAccountForReport(HttpServletRequest req) {
		User user = (User) req.getSession().getAttribute("user");
		
		List<AccountDto> list = reportService.selectAccountForReport(user.getId());
		AccountUnit defaultAccountUnit = accountUnitService.selectById(user.getDefaultAccountUnitId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("defaultAccountUnit", defaultAccountUnit);
		map.put("accountDtoList", list);
		
		MessageModel mm = new MessageModel();
		mm.setObj(map);
		
		return mm;
	}
	
	
	/**
	 * 收入部分
	 * @param req
	 * @param typeId
	 * @param startTime
	 * @param endTime
	 * @param unitId
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectPayInGroupByAccountIdForReport")
	@ResponseBody
	public List<PayInReportDto> selectPayInGroupByAccountIdForReport(HttpServletRequest req, Integer typeId, String startTime, String endTime, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayInGroupByAccountId(userId, startTime, endTime, typeId, unitId);
	}
	@IsLogin
	@RequestMapping("selectPayInGroupByTypeIdForReport")
	@ResponseBody
	public List<PayInReportDto> selectPayInGroupByTypeIdForReport(HttpServletRequest req, String startTime, String endTime, Integer accountId, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayInGroupByTypeId(userId, startTime, endTime, accountId, unitId);
	}
	@IsLogin
	@RequestMapping("selectPayInGroupByMonthForReport")
	@ResponseBody
	public List<PayInReportDto> selectPayInGroupByMonthForReport(HttpServletRequest req, String year, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayInGroupByMonth(userId, year, unitId);
	}
	
	
	
	
	/**
	 * 支出部分
	 * @param req
	 * @param typeId
	 * @param startTime
	 * @param endTime
	 * @param unitId
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectPayOutGroupByAccountIdForReport")
	@ResponseBody
	public List<PayOutReportDto> selectPayOutGroupByAccountIdForReport(HttpServletRequest req, Integer typeId, String startTime, String endTime, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayOutGroupByAccountId(userId, startTime, endTime, typeId, unitId);
	}
	@IsLogin
	@RequestMapping("selectPayOutGroupByTypeIdForReport")
	@ResponseBody
	public List<PayOutReportDto> selectPayOutGroupByTypeIdForReport(HttpServletRequest req, String startTime, String endTime, Integer accountId, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayOutGroupByTypeId(userId, startTime, endTime, accountId, unitId);
	}
	@IsLogin
	@RequestMapping("selectPayOutGroupByMonthForReport")
	@ResponseBody
	public List<PayOutReportDto> selectPayOutGroupByMonthForReport(HttpServletRequest req, String year, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return reportService.selectPayOutGroupByMonth(userId, year, unitId);
	}
	
	
	
	/**
	 * 查询收支差
	 */
	@IsLogin
	@RequestMapping("selectPayInOutChaGroupByMonthForReport")
	@ResponseBody
	public Map<String, Object> selectPayInOutChaGroupByMonthForReport(HttpServletRequest req, String year, Integer unitId) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		
		List<PayOutReportDto> payOutList = reportService.selectPayOutGroupByMonth(userId, year, unitId);
		List<PayInReportDto> payInList = reportService.selectPayInGroupByMonth(userId, year, unitId);
		Double payInAllYearMoney = reportService.selectPayInAllYear(userId, year, unitId);
		Double payOutAllYearMoney = reportService.selectPayOutAllYear(userId, year, unitId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("payOutList", payOutList);
		map.put("payInList", payInList);
		map.put("payInAllYearMoney", payInAllYearMoney);
		map.put("payOutAllYearMoney", payOutAllYearMoney);
		return map;
	}
	
	
	
	
	/**
	 * 概览的时候，得到全年的支出，默认查询默认币种的支出
	 * @param req
	 * @param year
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectPayOutAllYear")
	@ResponseBody
	public Double selectPayOutAllYear(HttpServletRequest req, String year) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		Integer unitId = user.getDefaultAccountUnitId();
		
		return reportService.selectPayOutAllYear(userId, year, unitId);
		
	}
	//得到全日的支出
	@IsLogin
	@RequestMapping("selectPayOutAllDate")
	@ResponseBody
	public Double selectPayOutAllDate(HttpServletRequest req, String date) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		Integer unitId = user.getDefaultAccountUnitId();
		
		return reportService.selectPayOutAllDate(userId, date, unitId);
	}
	//得到全月的支出
	@IsLogin
	@RequestMapping("selectPayOutAllMonth")
	@ResponseBody
	public Double selectPayOutAllMonth(HttpServletRequest req, String month) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		Integer unitId = user.getDefaultAccountUnitId();
		
		return reportService.selectPayOutAllMonth(userId, month, unitId);
	}
	
	
	/**
	 * 同时得到以上三者支出金额
	 * @param req
	 * @param date
	 * @param month
	 * @param year
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectPayOutThree")
	@ResponseBody
	public Map<String, Double> selectPayOutThree(HttpServletRequest req, String date, String month, String year) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		Integer unitId = user.getDefaultAccountUnitId();
		
		Double yearPayOut = reportService.selectPayOutAllYear(userId, year, unitId);
		Double monthPayOut = reportService.selectPayOutAllMonth(userId, month, unitId);
		Double datePayOut = reportService.selectPayOutAllDate(userId, date, unitId);
		
		Map<String, Double> map = new HashMap<String, Double>();
		map.put("yearPayOut", yearPayOut);
		map.put("monthPayOut", monthPayOut);
		map.put("datePayOut", datePayOut);
		return map;
	}
}
