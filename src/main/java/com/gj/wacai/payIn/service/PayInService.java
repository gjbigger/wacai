package com.gj.wacai.payIn.service;

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
import com.gj.wacai.payIn.dao.PayInDao;
import com.gj.wacai.payIn.dto.PayInDto;
import com.gj.wacai.payIn.pojo.PayIn;
import com.gj.wacai.payIn.query.PayInQuery;
import com.gj.wacai.payInType.dao.PayInTypeDao;

@Service
public class PayInService {

	@Resource
	private PayInDao payInDao;
	@Resource
	private PayInTypeDao payInTypeDao;
	@Resource
	private AccountDao accountDao;
	
	//AssertUtil.isTrue(, "");
	
	/**
	 * 添加一条收入记录
	 */
	@Transactional
	public void insert(PayIn payIn){
		//非空校验
		AssertUtil.isTrue(payIn.getMoney()==null, "金额不能为空");
		AssertUtil.isTrue(payIn.getTypeId()==null, "收入类型不能为空");
		AssertUtil.isTrue(payIn.getAccountId()==null, "所属账户不能为空");
		AssertUtil.isTrue(payIn.getTime()==null, "时间不能为空");
		//合法性校验,类型存在，账户存在
		AssertUtil.isTrue(payInTypeDao.selectByIdAndUserId(payIn.getTypeId(), payIn.getUserId())==null, "收入类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(payIn.getAccountId(), payIn.getUserId())==null, "所属账户不存在");
		//执行逻辑代码
		//设置创建时间，更新时间， is_valid
		payIn.setCreateTime(new Date());
		payIn.setUpdateTime(new Date());
		payIn.setIsValid(1);
		
		AssertUtil.isTrue(accountDao.moneyIn(payIn.getMoney(), payIn.getAccountId(), payIn.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(payInDao.insert(payIn)<1, "添加收入失败");
	}
	
	
	/**
	 * 根据参数查询收入
	 * @param payInQuery
	 * @return
	 */
	public PageModel<PayInDto> selectByParams(PayInQuery payInQuery) {
		PageHelper.startPage(payInQuery.getPage(), payInQuery.getRows());
		List<PayInDto> list = payInDao.selectByParams(payInQuery);
		PageInfo<PayInDto> pageInfo = new PageInfo<PayInDto>(list);
		
		PageModel<PayInDto> pm = new PageModel<PayInDto>(payInQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		
		return pm;
	}


	/**
	 * 更新收入
	 * @param payIn
	 */
	@Transactional
	public void update(PayIn payIn) {
		//非空校验
		AssertUtil.isTrue(payIn.getId()==null, "待更新的收入不能为空");
		AssertUtil.isTrue(payIn.getMoney()==null, "金额不能为空");
		AssertUtil.isTrue(payIn.getTypeId()==null, "收入类型不能为空");
		AssertUtil.isTrue(payIn.getAccountId()==null, "所属账户不能为空");
		AssertUtil.isTrue(payIn.getTime()==null, "时间不能为空");
		//合法性校验,类型存在，账户存在,记录存在
		PayIn oldPayIn = payInDao.selectByIdAndUserId(payIn.getId(), payIn.getUserId());
		AssertUtil.isTrue(oldPayIn==null, "待更新记录不存在");
		AssertUtil.isTrue(payInTypeDao.selectByIdAndUserId(payIn.getTypeId(), payIn.getUserId())==null, "收入类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(payIn.getAccountId(), payIn.getUserId())==null, "所属账户不存在");
		//执行逻辑代码
		//更新老帐户,老帐户减去老钱
		AssertUtil.isTrue(accountDao.moneyOut(oldPayIn.getMoney(), oldPayIn.getAccountId(), oldPayIn.getUserId())<1, "更新相应账户失败");
		//更新新账户，新账户加上新钱
		AssertUtil.isTrue(accountDao.moneyIn(payIn.getMoney(), payIn.getAccountId(), payIn.getUserId())<1, "更新相应账户失败");
		//更新收入,设置更新时间
		payIn.setUpdateTime(new Date());
		AssertUtil.isTrue(payInDao.update(payIn)<1, "更新收入失败");
	}


	/**
	 * 删除收入
	 * @param id
	 * @param userId
	 */
	@Transactional
	public void deleteByIdAndUserId(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "收入id不能为空");
		//合法性校验
		PayIn oldPayIn = payInDao.selectByIdAndUserId(id, userId);
		AssertUtil.isTrue(oldPayIn==null, "待删除的记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(accountDao.moneyOut(oldPayIn.getMoney(), oldPayIn.getAccountId(), oldPayIn.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(payInDao.deleteByIdAndUserId(id, userId)<1, "删除失败");
	}
}
