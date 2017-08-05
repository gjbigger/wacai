package com.gj.wacai.account.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.gj.utils.AssertUtil;
import com.gj.utils.PageModel;
import com.gj.wacai.account.dao.AccountDao;
import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.account.pojo.Account;
import com.gj.wacai.account.query.AccountQuery;
import com.gj.wacai.accountType.dao.AccountTypeDao;
import com.gj.wacai.accountUnit.dao.AccountUnitDao;

@Service
public class AccountService {

	@Resource
	private AccountDao accountDao;
	@Resource
	private AccountTypeDao accountTypeDao;
	@Resource
	private AccountUnitDao accountUnitDao;
	
	
	/**
	 * 根据查询条件查询账户
	 * @param accountQuery
	 * @return
	 */
	public PageModel<AccountDto> selectByParams(AccountQuery accountQuery) {
		PageHelper.startPage(accountQuery.getPage(), accountQuery.getRows());
		List<AccountDto> list = accountDao.selectByParams(accountQuery);
		PageInfo<AccountDto> pageInfo = new PageInfo<AccountDto>(list);
		
		PageModel<AccountDto> pm = new PageModel<AccountDto>(accountQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		
		return pm;
	}
	
	
	/**
	 * 添加或者更新账户
	 * @param account
	 */
	@Transactional
	public void insertOrUpdate(Account account) {
		//非空校验
		AssertUtil.isTrue(account.getTypeId()==null, "账户类型不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(account.getName()), "账户名称不能为空");
		AssertUtil.isTrue(account.getBalance()==null, "余额不能为空");
		AssertUtil.isTrue(account.getUnitId()==null, "币种不能为空");
		//判断账户类型然后置空
		if(account.getTypeId().equals(2)) {
			AssertUtil.isTrue(account.getLimits()==null, "信用额度不能为空");
			AssertUtil.isTrue(account.getBillDay()==null, "账单日不能为空");
			AssertUtil.isTrue(account.getRepayDay()==null, "还款日不能为空");
		} else {
			account.setLimits(null);
			account.setBillDay(null);
			account.setRepayDay(null);
		}
		//合法性校验,账户名称添加时不能重复更新时不能重复其他，账户类型存在，币种存在,账户类型不能是5
		AssertUtil.isTrue(account.getTypeId().equals(5), "账户类型异常,请重新选择");
		AssertUtil.isTrue(accountTypeDao.selectById(account.getTypeId())==null, "账户类型不存在");
		AssertUtil.isTrue(accountUnitDao.selectById(account.getUnitId())==null, "币种不存在");
		//分流
		if(account.getId()==null) {
			insert(account);
		} else {
			update(account);
		}
	}
	//具体的添加方法
	private void insert(Account account) {
		//校验账户名是否存在
		AssertUtil.isTrue(accountDao.selectByNameAndUserId(account.getName(), account.getUserId())!=null, "账户名称不能重复");
		
		//设置创建时间和更新时间,以及是否有效
		account.setCreateTime(new Date());
		account.setUpdateTime(new Date());
		account.setIsValid(1);
		
		AssertUtil.isTrue(accountDao.insert(account)<1, "添加失败");
	}
	//具体的更新方法
	private void update(Account account) {
		//校验用户名是否存在
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(account.getId(), account.getUserId())==null, "待更新的账户不存在");
		Account selectResult = accountDao.selectByNameAndUserId(account.getName(), account.getUserId());
		AssertUtil.isTrue(selectResult!=null && !selectResult.getId().equals(account.getId()), "账户名称不能重复");
		
		//设置更新时间
		account.setUpdateTime(new Date());
		
		AssertUtil.isTrue(accountDao.update(account)<1, "更新失败");
	}


	/**
	 * 根据id和用户id删除一条账户记录，其实更新is_valid字段
	 * @param id
	 * @param userId
	 */
	@Transactional
	public void deleteByIdAndUserId(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "账户id不能为空");
		//合法性校验
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(id, userId)==null, "待删除的记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(accountDao.deleteByIdAndUserId(id, userId)<1, "删除失败");
	}
	
	
	/**
	 * 根据用户id查询账户
	 * @return
	 */
	public List<AccountDto> selectByUserId(Integer userId) {
		List<AccountDto> list = accountDao.selectByUserId(userId);
		for(AccountDto dto : list) {
			String name = dto.getName();
			String unitAbbreviation = dto.getUnitAbbreviation();
			dto.setName(name+" -- "+unitAbbreviation);
		}
		return list;
	}
	public List<AccountDto> selectByUserIdAndTypeIdIs8(Integer userId) {
		List<AccountDto> list = accountDao.selectByUserIdAndTypeIdIs8(userId);
		for(AccountDto dto : list) {
			String name = dto.getName();
			String unitAbbreviation = dto.getUnitAbbreviation();
			dto.setName(name+" -- "+unitAbbreviation);
		}
		return list;
	}
	public List<AccountDto> selectByUserIdAndTypeIdIsNot8(Integer userId) {
		List<AccountDto> list = accountDao.selectByUserIdAndTypeIdIsNot8(userId);
		for(AccountDto dto : list) {
			String name = dto.getName();
			String unitAbbreviation = dto.getUnitAbbreviation();
			dto.setName(name+" -- "+unitAbbreviation);
		}
		return list;
	}
}
