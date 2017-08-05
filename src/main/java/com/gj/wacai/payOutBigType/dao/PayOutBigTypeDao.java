package com.gj.wacai.payOutBigType.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.payOutBigType.pojo.PayOutBigType;

@Repository
public interface PayOutBigTypeDao {
	
	//添加大类型
	public int insert(PayOutBigType payOutBigType);
	
	//根据name和userId查询支出大类型
	public PayOutBigType selectByUserIdAndName(@Param("userId")Integer userId, @Param("name")String name);
	
	//根据id删除大类型
	public int delete(Integer id);
	
	//根据id查询
	public PayOutBigType selectById(@Param("id")Integer id);
	
	//根据id和userId查询支出大类型
	public PayOutBigType selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

	//根据用户id查询收入类型
	public List<PayOutBigType> selectByUserId(@Param("userId")Integer userId);
}
