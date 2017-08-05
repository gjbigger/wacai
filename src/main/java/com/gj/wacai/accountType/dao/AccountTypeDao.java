package com.gj.wacai.accountType.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.gj.wacai.accountType.pojo.AccountType;

@Repository
public interface AccountTypeDao {

	//根据pid查询账户类型
	public List<AccountType> selectByPid(@Param("pid")Integer pid);
	
	//根据id查询账户类型
	@Select("select id,name,pid from t_account_type where id = #{id}")
	public AccountType selectById(@Param("id")Integer id);
}
