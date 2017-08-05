package com.gj.wacai.loan.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.loan.dto.LoanDto;
import com.gj.wacai.loan.pojo.Loan;
import com.gj.wacai.loan.query.LoanQuery;

@Repository
public interface LoanDao {

	//添加借贷
	public int insert(Loan loan);

	//根据参数查询借贷
	public List<LoanDto> selectByParams(LoanQuery loanQuery);

	//根据id和userId查询借贷
	public Loan selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

	//更新借贷
	public int update(Loan loan);

	//删除借贷
	public int deleteByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

}
