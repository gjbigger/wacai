package com.gj.wacai.message.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.message.dto.BillDto;
import com.gj.wacai.message.dto.RepayDto;
import com.gj.wacai.message.pojo.Message;
import com.gj.wacai.message.query.MessageQuery;

@Repository
public interface MessageDao {

	//根据messageQuery查询
	public List<Message> selectByParam(MessageQuery messageQuery);
	
	//增加消息
	public int insert(Message message);
	
	//查询符合条件的  账户
	public List<BillDto> selectBill();
	
	//查询符合条件的 账户
	public List<RepayDto> selectRepay();
	
	//查询开始结束日期之间的总支出额
	public Double selectSumMoney(@Param("accountId")Integer accountId, @Param("startTime")String startTime, @Param("endTime")String endTime);
	
	//设置是否为新到0
	public int updateSetIsNew0(@Param("id")Integer id);
}
