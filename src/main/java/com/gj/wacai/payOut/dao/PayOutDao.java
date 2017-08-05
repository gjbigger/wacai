package com.gj.wacai.payOut.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.payOut.dto.PayOutDto;
import com.gj.wacai.payOut.pojo.PayOut;
import com.gj.wacai.payOut.query.PayOutQuery;

@Repository
public interface PayOutDao {

	//添加一条支出记录
	public int insert(PayOut payOut);

	//根据参数查询支出
	public List<PayOutDto> selectByParams(PayOutQuery payOutQuery);
	
	//根据id和userId查询支出
	public PayOut selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
	
	//更新支出记录
	public int update(PayOut payOut);

	//删除支出记录
	public int deleteByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
}
