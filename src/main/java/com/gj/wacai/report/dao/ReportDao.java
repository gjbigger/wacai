package com.gj.wacai.report.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.report.dto.PayInReportDto;
import com.gj.wacai.report.dto.PayOutReportDto;

@Repository
public interface ReportDao {

	//根据userId，查询这个用户下的所有账户
	public List<AccountDto> selectAccountForReport(@Param("userId")Integer userId);
	
	
	//所有账户的收入情况 group by account,一个类别所有账户的收入情况 group by account where type_id = ?
	public List<PayInReportDto> selectPayInGroupByAccountId(@Param("userId")Integer userId,@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("typeId")Integer typeId, @Param("unitId")Integer unitId);
	//所有类别的收入情况group by type_id,一个账户的所有类别的收入情况 group by type_id where account = ?
	public List<PayInReportDto> selectPayInGroupByTypeId(@Param("userId")Integer userId,@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("accountId")Integer accountId,  @Param("unitId")Integer unitId);
	//所有收入情况全年按月group by date_format(time, '%Y-%m'),起始日期和结束日期是一年的第一天和这一年的最后一天
	public List<PayInReportDto> selectPayInGroupByMonth(@Param("userId")Integer userId,@Param("year")String year,  @Param("unitId")Integer unitId);
	
	
	
	
	//所有账户的支出情况 group by account,一个类别所有账户的支出情况 group by account where type_id = ?
	public List<PayOutReportDto> selectPayOutGroupByAccountId(@Param("userId")Integer userId,@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("typeId")Integer typeId, @Param("unitId")Integer unitId);
	//所有类别的支出情况group by type_id,一个账户的所有类别的支出情况 group by type_id where account = ?
	public List<PayOutReportDto> selectPayOutGroupByTypeId(@Param("userId")Integer userId,@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("accountId")Integer accountId,  @Param("unitId")Integer unitId);
	//所有支出情况全年按月group by date_format(time, '%Y-%m'),起始日期和结束日期是一年的第一天和这一年的最后一天
	public List<PayOutReportDto> selectPayOutGroupByMonth(@Param("userId")Integer userId,@Param("year")String year,  @Param("unitId")Integer unitId);
	
	
	//得到特定年的全年收支金额
	public Double selectPayInAllYear(@Param("userId")Integer userId,@Param("year")String year,  @Param("unitId")Integer unitId);
	public Double selectPayOutAllYear(@Param("userId")Integer userId,@Param("year")String year,  @Param("unitId")Integer unitId);
	
	//得到特定日的支出总金额
	public Double selectPayOutAllDate(@Param("userId")Integer userId,@Param("date")String date,  @Param("unitId")Integer unitId);
	//得到特定月的支出总金额
	public Double selectPayOutAllMonth(@Param("userId")Integer userId,@Param("month")String month,  @Param("unitId")Integer unitId);
}
