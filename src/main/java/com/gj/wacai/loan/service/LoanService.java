package com.gj.wacai.loan.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.gj.utils.AssertUtil;
import com.gj.utils.PageModel;
import com.gj.wacai.account.dao.AccountDao;
import com.gj.wacai.loan.dao.LoanDao;
import com.gj.wacai.loan.dto.LoanDto;
import com.gj.wacai.loan.pojo.Loan;
import com.gj.wacai.loan.query.LoanQuery;
import com.gj.wacai.loanType.dao.LoanTypeDao;

@Service
public class LoanService {

	@Resource
	private LoanDao loanDao;
	@Resource
	private LoanTypeDao loanTypeDao;
	@Resource
	private AccountDao accountDao;

	/**
	 * 添加一条借贷
	 */
	@Transactional
	public void insert(Loan loan) {
		// 非空校验
		AssertUtil.isTrue(loan.getMoney() == null, "金额不能为空");
		AssertUtil.isTrue(loan.getTypeId() == null, "借贷类型不能为空");
		AssertUtil.isTrue(loan.getAccountId() == null, "使用账户不能为空");
		AssertUtil.isTrue(loan.getLoanBodyAccountId() == null, "债权/债务人不能为空");
		AssertUtil.isTrue(loan.getTime() == null, "时间不能为空");
		// 合法性校验,类型存在，账户存在,债权债务人存在
		AssertUtil.isTrue(loanTypeDao.selectById(loan.getTypeId()) == null, "借贷类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(loan.getAccountId(), loan.getUserId()) == null, "使用账户不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(loan.getLoanBodyAccountId(), loan.getUserId())==null, "债权/债务人不存在");
		// 执行逻辑代码
		//更新使用账户
		if(loan.getTypeId().equals(1) || loan.getTypeId().equals(3)) {
			//借入，收款,使用账户加钱,债权人债务人账户减钱
			AssertUtil.isTrue(accountDao.moneyIn(loan.getMoney(), loan.getAccountId(), loan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyOut(loan.getMoney(), loan.getLoanBodyAccountId(), loan.getUserId())<1, "更新相应账户失败");
		} else {
			//借出，还款，使用账户减钱, 债权人债务人账户加钱
			AssertUtil.isTrue(accountDao.moneyOut(loan.getMoney(), loan.getAccountId(), loan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyIn(loan.getMoney(), loan.getLoanBodyAccountId(), loan.getUserId())<1, "更新相应账户失败");
		}
		// 设置创建时间，更新时间， is_valid,添加借贷记录
		loan.setCreateTime(new Date());
		loan.setUpdateTime(new Date());
		loan.setIsValid(1);
		AssertUtil.isTrue(loanDao.insert(loan) < 1, "添加借贷失败");
	}
	
	
	/**
	 * 根据参数查询借贷
	 * @param loanQuery
	 * @return
	 */
	public PageModel<LoanDto> selectByParams(LoanQuery loanQuery) {
		PageHelper.startPage(loanQuery.getPage(), loanQuery.getRows());
		List<LoanDto> list = loanDao.selectByParams(loanQuery);
		PageInfo<LoanDto> pageInfo = new PageInfo<LoanDto>(list);
		
		PageModel<LoanDto> pm = new PageModel<LoanDto>(loanQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		
		return pm;
	}

	
	/**
	 * 更新借贷
	 * @param loan
	 */
	@Transactional
	public void update(Loan loan) {
		// 非空校验
		AssertUtil.isTrue(loan.getId()==null, "待更新的记录不能为空");
		AssertUtil.isTrue(loan.getMoney() == null, "金额不能为空");
		AssertUtil.isTrue(loan.getTypeId() == null, "借贷类型不能为空");
		AssertUtil.isTrue(loan.getAccountId() == null, "使用账户不能为空");
		AssertUtil.isTrue(loan.getLoanBodyAccountId() == null, "债权/债务人不能为空");
		AssertUtil.isTrue(loan.getTime() == null, "时间不能为空");
		//合法性校验,类型存在，账户存在,记录存在
		Loan oldLoan = loanDao.selectByIdAndUserId(loan.getId(), loan.getUserId());
		AssertUtil.isTrue(oldLoan==null, "待更新记录不存在");
		AssertUtil.isTrue(loanTypeDao.selectById(loan.getTypeId()) == null, "借贷类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(loan.getAccountId(), loan.getUserId()) == null, "使用账户不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(loan.getLoanBodyAccountId(), loan.getUserId())==null, "债权/债务人不存在");
		// 执行逻辑代码
		//判断老的借贷类型，并还原相应的账户
		if(oldLoan.getTypeId().equals(1) || oldLoan.getTypeId().equals(3)) {
			//借入，收款,使用账户减钱,债权人债务人账户加钱
			AssertUtil.isTrue(accountDao.moneyOut(oldLoan.getMoney(), oldLoan.getAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyIn(oldLoan.getMoney(), oldLoan.getLoanBodyAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
		} else {
			//借出，还款，使用账户加钱, 债权人债务人账户减钱
			AssertUtil.isTrue(accountDao.moneyIn(oldLoan.getMoney(), oldLoan.getAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyOut(oldLoan.getMoney(), oldLoan.getLoanBodyAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
		}
		//判断新的借贷类型，并更新相应账户
		if(loan.getTypeId().equals(1) || loan.getTypeId().equals(3)) {
			//借入，收款,使用账户加钱,债权人债务人账户减钱
			AssertUtil.isTrue(accountDao.moneyIn(loan.getMoney(), loan.getAccountId(), loan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyOut(loan.getMoney(), loan.getLoanBodyAccountId(), loan.getUserId())<1, "更新相应账户失败");
		} else {
			//借出，还款，使用账户减钱, 债权人债务人账户加钱
			AssertUtil.isTrue(accountDao.moneyOut(loan.getMoney(), loan.getAccountId(), loan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyIn(loan.getMoney(), loan.getLoanBodyAccountId(), loan.getUserId())<1, "更新相应账户失败");
		}
		// 设置更新时间,更新借贷记录
		loan.setUpdateTime(new Date());
		AssertUtil.isTrue(loanDao.update(loan) < 1, "更新借贷失败");
		
	}
	
	
	/**
	 * 删除借贷
	 * @param id
	 * @param userId
	 */
	@Transactional
	public void deleteByIdAndUserId(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "借贷id不能为空");
		//合法性校验
		Loan oldLoan = loanDao.selectByIdAndUserId(id, userId);
		AssertUtil.isTrue(oldLoan==null, "待删除的记录不存在");
		//执行逻辑代码
		//判断老的借贷类型，并还原相应的账户
		if(oldLoan.getTypeId().equals(1) || oldLoan.getTypeId().equals(3)) {
			//借入，收款,使用账户减钱,债权人债务人账户加钱
			AssertUtil.isTrue(accountDao.moneyOut(oldLoan.getMoney(), oldLoan.getAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyIn(oldLoan.getMoney(), oldLoan.getLoanBodyAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
		} else {
			//借出，还款，使用账户加钱, 债权人债务人账户减钱
			AssertUtil.isTrue(accountDao.moneyIn(oldLoan.getMoney(), oldLoan.getAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
			AssertUtil.isTrue(accountDao.moneyOut(oldLoan.getMoney(), oldLoan.getLoanBodyAccountId(), oldLoan.getUserId())<1, "更新相应账户失败");
		}
		AssertUtil.isTrue(loanDao.deleteByIdAndUserId(id, userId)<1, "删除失败");
	}
}
