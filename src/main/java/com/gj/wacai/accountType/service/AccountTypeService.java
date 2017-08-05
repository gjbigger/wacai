package com.gj.wacai.accountType.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gj.wacai.accountType.dao.AccountTypeDao;
import com.gj.wacai.accountType.pojo.AccountType;

@Service
public class AccountTypeService {

	@Resource
	private AccountTypeDao accountTypeDao;
	
	
	/**
	 * 根据pid查询账户类型
	 * @param pid
	 * @return
	 */
	public List<AccountType> selectByPid(Integer pid) {
		return accountTypeDao.selectByPid(pid);
	}
	
}
