package com.gj.wacai.accountUnit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.gj.wacai.accountUnit.pojo.AccountUnit;

@Repository
public interface AccountUnitDao {
	
	//查询所有的币种
	@Select("select id,name,abbreviation from t_account_unit")
	public List<AccountUnit> selectAll();
	
	//根据id查币种
	@Select("select id,name,abbreviation from t_account_unit where id = #{id}")
	public AccountUnit selectById(@Param("id")Integer id);
}
