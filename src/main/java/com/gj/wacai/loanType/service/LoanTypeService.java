package com.gj.wacai.loanType.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gj.wacai.loanType.dao.LoanTypeDao;
import com.gj.wacai.loanType.pojo.LoanType;

@Service
public class LoanTypeService {

	@Resource
	private LoanTypeDao loanTypeDao;
	
	
	/**
	 * 查询所有借贷类型
	 * @return
	 */
	public List<LoanType> selectAll() {
		return loanTypeDao.selectAll();
	}
}
