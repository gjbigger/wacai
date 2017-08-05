package com.gj.wacai.payOut.service;

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
import com.gj.wacai.payOut.dao.PayOutDao;
import com.gj.wacai.payOut.dto.PayOutDto;
import com.gj.wacai.payOut.pojo.PayOut;
import com.gj.wacai.payOut.query.PayOutQuery;
import com.gj.wacai.payOutBigType.dao.PayOutBigTypeDao;
import com.gj.wacai.payOutSmallType.dao.PayOutSmallTypeDao;

@Service
public class PayOutService {

	@Resource
	private PayOutDao payOutDao;
	@Resource
	private AccountDao accountDao;
	@Resource
	private PayOutBigTypeDao payOutBigTypeDao;
	@Resource
	private PayOutSmallTypeDao payOutSmallTypeDao;

	/**
	 * 添加一条支出
	 */
	@Transactional
	public void insert(PayOut payOut) {
		// 非空校验
		AssertUtil.isTrue(payOut.getMoney() == null, "金额不能为空");
		AssertUtil.isTrue(payOut.getBigTypeId() == null, "支出大类型不能为空");
		AssertUtil.isTrue(payOut.getSmallTypeId() == null, "支出小类型不能为空");
		AssertUtil.isTrue(payOut.getAccountId() == null, "所属账户不能为空");
		AssertUtil.isTrue(payOut.getTime() == null, "时间不能为空");
		// 合法性校验,类型存在，账户存在
		AssertUtil.isTrue(payOutBigTypeDao.selectByIdAndUserId(payOut.getBigTypeId(), payOut.getUserId()) == null, "支出大类型不存在");
		AssertUtil.isTrue(payOutSmallTypeDao.selectByIdAndUserId(payOut.getSmallTypeId(), payOut.getUserId()) == null, "支出小类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(payOut.getAccountId(), payOut.getUserId()) == null, "所属账户不存在");
		// 执行逻辑代码
		// 设置创建时间，更新时间， is_valid
		payOut.setCreateTime(new Date());
		payOut.setUpdateTime(new Date());
		payOut.setIsValid(1);

		AssertUtil.isTrue(accountDao.moneyOut(payOut.getMoney(), payOut.getAccountId(), payOut.getUserId()) < 1,"更新相应账户失败");
		AssertUtil.isTrue(payOutDao.insert(payOut) < 1, "添加支出失败");
	}
	
	
	/**
	 * 根据参数查询支出
	 * @param payOutQuery
	 * @return
	 */
	public PageModel<PayOutDto> selectByParams(PayOutQuery payOutQuery) {
		PageHelper.startPage(payOutQuery.getPage(), payOutQuery.getRows());
		List<PayOutDto> list = payOutDao.selectByParams(payOutQuery);
		PageInfo<PayOutDto> pageInfo = new PageInfo<PayOutDto>(list);
		
		PageModel<PayOutDto> pm = new PageModel<PayOutDto>(payOutQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		
		return pm;
	}

	
	/**
	 * 更新支出
	 * @param payOut
	 */
	@Transactional
	public void update(PayOut payOut) {
		//非空校验
		AssertUtil.isTrue(payOut.getId()==null, "待更新的支出不能为空");
		AssertUtil.isTrue(payOut.getMoney() == null, "金额不能为空");
		AssertUtil.isTrue(payOut.getBigTypeId() == null, "支出大类型不能为空");
		AssertUtil.isTrue(payOut.getSmallTypeId() == null, "支出小类型不能为空");
		AssertUtil.isTrue(payOut.getAccountId() == null, "所属账户不能为空");
		AssertUtil.isTrue(payOut.getTime() == null, "时间不能为空");
		//合法性校验,类型存在，账户存在,记录存在
		PayOut oldPayOut = payOutDao.selectByIdAndUserId(payOut.getId(), payOut.getUserId());
		AssertUtil.isTrue(oldPayOut==null, "待更新记录不存在");
		AssertUtil.isTrue(payOutBigTypeDao.selectByIdAndUserId(payOut.getBigTypeId(), payOut.getUserId()) == null, "支出大类型不存在");
		AssertUtil.isTrue(payOutSmallTypeDao.selectByIdAndUserId(payOut.getSmallTypeId(), payOut.getUserId()) == null, "支出小类型不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(payOut.getAccountId(), payOut.getUserId()) == null, "所属账户不存在");
		//执行逻辑代码
		//更新老帐户,老帐户加上老钱
		AssertUtil.isTrue(accountDao.moneyIn(oldPayOut.getMoney(), oldPayOut.getAccountId(), oldPayOut.getUserId())<1, "更新相应账户失败");
		//更新新账户，新账户減去新钱
		AssertUtil.isTrue(accountDao.moneyOut(payOut.getMoney(), payOut.getAccountId(), payOut.getUserId())<1, "更新相应账户失败");
		//更新支出,设置更新时间
		payOut.setUpdateTime(new Date());
		AssertUtil.isTrue(payOutDao.update(payOut)<1, "更新支出失败");
	}
	
	
	/**
	 * 删除支出
	 * @param id
	 * @param userId
	 */
	@Transactional
	public void deleteByIdAndUserId(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "支出id不能为空");
		//合法性校验
		PayOut oldPayOut = payOutDao.selectByIdAndUserId(id, userId);
		AssertUtil.isTrue(oldPayOut==null, "待删除的记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(accountDao.moneyIn(oldPayOut.getMoney(), oldPayOut.getAccountId(), oldPayOut.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(payOutDao.deleteByIdAndUserId(id, userId)<1, "删除失败");
	}
}
