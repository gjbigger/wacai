package com.gj.wacai.payIn.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.payIn.dto.PayInDto;
import com.gj.wacai.payIn.pojo.PayIn;
import com.gj.wacai.payIn.query.PayInQuery;

@Repository
public interface PayInDao {

	//添加一条收入记录
	public int insert(PayIn payIn);

	//根据参数查询收入
	public List<PayInDto> selectByParams(PayInQuery payInQuery);
	
	//根据id和userId查询收入
	public PayIn selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
	
	//更新收入记录
	public int update(PayIn payIn);

	//删除收入记录
	public int deleteByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
}
