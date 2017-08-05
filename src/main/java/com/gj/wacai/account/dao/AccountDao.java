package com.gj.wacai.account.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.account.pojo.Account;
import com.gj.wacai.account.query.AccountQuery;

@Repository
public interface AccountDao {

	//根据查询条件查询账户信息
	public List<AccountDto> selectByParams(AccountQuery accountQuery);
	
	//根据账户名和用户id查询账户信息
	public Account selectByNameAndUserId(@Param("name")String name, @Param("userId")Integer userId);
	
	//添加账户数据
	public int insert(Account account);
	
	//更新账户数据
	public int update(Account account);
	
	//根据id和用户id查询账户
	public Account selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
	
	//根据id和用户id删除账户信息，实质为更新is_valid字段
	public int deleteByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);
	
	//钱进来
	public int moneyIn(@Param("money")Double money, @Param("id")Integer id, @Param("userId")Integer userId);
	
	//钱出去
	public int moneyOut(@Param("money")Double money, @Param("id")Integer id, @Param("userId")Integer userId);
	
	//根据用户id，查询这个用户下的账户，同时附带是否是债权债务人
	public List<AccountDto> selectByUserId(@Param("userId")Integer userId);
	public List<AccountDto> selectByUserIdAndTypeIdIs8(@Param("userId")Integer userId);
	public List<AccountDto> selectByUserIdAndTypeIdIsNot8(@Param("userId")Integer userId);
}
