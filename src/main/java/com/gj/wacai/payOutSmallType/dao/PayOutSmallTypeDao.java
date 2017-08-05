package com.gj.wacai.payOutSmallType.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.payOutSmallType.pojo.PayOutSmallType;

@Repository
public interface PayOutSmallTypeDao {

	//根据id和userId查询支出小类型
	public PayOutSmallType selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

	//根据pid和userId查询支出小类型
	public List<PayOutSmallType> selectByPidAndUserId(@Param("pid")Integer pid, @Param("userId")Integer userId);

	
	//添加支出小类型
	public int insert(PayOutSmallType payOutSmallType);
	
	//根据userId和name查询
	public PayOutSmallType selectByUserIdAndNameAndPid(@Param("userId")Integer userId, @Param("name")String name, @Param("pid")Integer pid);
	
	//删除
	public int delete(@Param("id")Integer id);
	
}
