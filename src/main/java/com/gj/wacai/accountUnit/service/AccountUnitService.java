package com.gj.wacai.accountUnit.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gj.wacai.accountUnit.dao.AccountUnitDao;
import com.gj.wacai.accountUnit.pojo.AccountUnit;

@Service
public class AccountUnitService {
	
	@Resource
	private AccountUnitDao accountUnitDao;

	/**
	 * 查询所有的币种
	 * @return
	 */
	public List<AccountUnit> selectAll() {
		List<AccountUnit> list = accountUnitDao.selectAll();
		for(AccountUnit accountUnit : list) {
			String abbreviation = accountUnit.getAbbreviation();
			String name = accountUnit.getName();
			accountUnit.setName(name +"\t--\t" + abbreviation);
		}
		return list;
	}
	
	
	/**
	 * 根据id查询币种
	 * @param id
	 * @return
	 */
	public AccountUnit selectById(Integer id) {
		return accountUnitDao.selectById(id);
	}
}
