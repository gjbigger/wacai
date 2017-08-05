package com.gj.wacai.loanType.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.gj.wacai.loanType.pojo.LoanType;

@Repository
public interface LoanTypeDao {

	//查询所有借贷类型
	@Select("select id,name from t_loan_type")
	public List<LoanType> selectAll();

	//根据id查询借贷类型
	@Select("select id,name from t_loan_type where id = #{id}")
	public LoanType selectById(@Param("id")Integer id);
}
