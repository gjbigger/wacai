package com.gj.wacai.payInType.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.payInType.pojo.PayInType;

@Repository
public interface PayInTypeDao {
	
	//添加
	public int insert(PayInType payInType);
	
	//根据name和userId查询
	public PayInType selectByUserIdAndName(@Param("name")String name, @Param("userId")Integer userId);
	
	//根据id删除
	public int delete(@Param("id")Integer id);
	
	
	//根据用户id查询收入类型
	public List<PayInType> selectByUserId(@Param("userId")Integer userId);
	
	//根据id和用户id查询收入类型
	public PayInType selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
}
