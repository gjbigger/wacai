package com.gj.wacai.report.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.report.dao.ReportDao;
import com.gj.wacai.report.dto.PayInReportDto;
import com.gj.wacai.report.dto.PayOutReportDto;

@Service
public class ReportService {

	@Resource
	private ReportDao reportDao;
	
	
	
	
	/**
	 * 根据userId查询这个用户的账户数据
	 * @param userId
	 * @return
	 */
	public List<AccountDto> selectAccountForReport(Integer userId) {
		return reportDao.selectAccountForReport(userId);
	}
	
	
	/**
	 * 收入：
	 * 		所有账户的收入情况 group by account
	 * 		所有类别的收入情况group by type_id
	 * 		一个账户的所有类别的收入情况 group by type_id where account = ?
	 * 		一个类别所有账户的收入情况 group by account where type_id = ?
	 * 		所有收入情况全年按月group by date_format(time, '%Y-%m')
	 */
	public List<PayInReportDto> selectPayInGroupByAccountId(Integer userId,String startTime, String endTime, Integer typeId, Integer unitId) {
		return reportDao.selectPayInGroupByAccountId(userId, startTime, endTime, typeId,  unitId);
	}
	public List<PayInReportDto> selectPayInGroupByTypeId(Integer userId,String startTime, String endTime, Integer accountId, Integer unitId) {
		return reportDao.selectPayInGroupByTypeId(userId, startTime, endTime, accountId,  unitId);
	}
	public List<PayInReportDto> selectPayInGroupByMonth(Integer userId, String year, Integer unitId) {
		return reportDao.selectPayInGroupByMonth(userId, year,  unitId);
	}
	
	
	
	
	/**
	 * 支出：
	 * 		所以账户的支出情况 group by account_id
	 * 		所有大类别的支出情况 group by big_type_id
	 * 		一个账户的所有大类别的支出情况 group by big_type_id where account_id = ?
	 * 		一个大类别的所有账户的支出情况 group by account_id where big_type_id = ? 
	 * 		所有支出情况全年按月
	 */
	public List<PayOutReportDto> selectPayOutGroupByAccountId(Integer userId,String startTime, String endTime, Integer typeId, Integer unitId) {
		return reportDao.selectPayOutGroupByAccountId(userId, startTime, endTime, typeId,  unitId);
	}
	public List<PayOutReportDto> selectPayOutGroupByTypeId(Integer userId,String startTime, String endTime, Integer accountId, Integer unitId) {
		return reportDao.selectPayOutGroupByTypeId(userId, startTime, endTime, accountId,  unitId);
	}
	public List<PayOutReportDto> selectPayOutGroupByMonth(Integer userId, String year, Integer unitId) {
		return reportDao.selectPayOutGroupByMonth(userId, year,  unitId);
	}
	
	
	
	/**
	 * 获得全年的收支金额
	 * @param userId
	 * @param year
	 * @param unitId
	 * @return
	 */
	public Double selectPayInAllYear(Integer userId, String year, Integer unitId) {
		return reportDao.selectPayInAllYear(userId, year, unitId);
	}
	public Double selectPayOutAllYear(Integer userId, String year, Integer unitId) {
		return reportDao.selectPayOutAllYear(userId, year, unitId);
	}
	
	
	/**
	 * 获得某一天的支出
	 * @param userId
	 * @param date
	 * @param unitId
	 * @return
	 */
	public Double selectPayOutAllDate (Integer userId, String date, Integer unitId) {
		return reportDao.selectPayOutAllDate(userId, date, unitId);
	}
	/**
	 * 获得某一月的支出
	 * @param userId
	 * @param month
	 * @param unitId
	 * @return
	 */
	public Double selectPayOutAllMonth (Integer userId, String month, Integer unitId) {
		return reportDao.selectPayOutAllMonth(userId, month, unitId);
	}
}
