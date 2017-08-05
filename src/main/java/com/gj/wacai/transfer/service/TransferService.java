package com.gj.wacai.transfer.service;

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
import com.gj.wacai.transfer.dao.TransferDao;
import com.gj.wacai.transfer.dto.TransferDto;
import com.gj.wacai.transfer.pojo.Transfer;
import com.gj.wacai.transfer.query.TransferQuery;

@Service
public class TransferService {

	@Resource
	private TransferDao transferDao;
	@Resource
	private AccountDao accountDao;
	
	/**
	 * 添加转账
	 * @param transfer
	 * @return
	 */
	@Transactional
	public void insert(Transfer transfer) {
		//非空校验
		AssertUtil.isTrue(transfer.getSrcAccountId()==null, "转出账户不能为空");
		AssertUtil.isTrue(transfer.getDestAccountId()==null, "转入账户不能为空");
		AssertUtil.isTrue(transfer.getSrcMoney()==null, "转出金额不能为空");
		AssertUtil.isTrue(transfer.getDestMoney()==null, "转入金额不能为空");
		AssertUtil.isTrue(transfer.getTime()==null, "时间不能为空");
		//转入转出的账户不能是同一个
		AssertUtil.isTrue(transfer.getSrcAccountId().equals(transfer.getDestAccountId()), "转入与转出账户不能是同一个账户");
		//合法性校验,转入转出的账户存在,
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(transfer.getSrcAccountId(), transfer.getUserId())==null, "转出账户不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(transfer.getDestAccountId(), transfer.getUserId())==null, "转入账户不存在");
		//执行逻辑代码
		//转出账户减去转出的钱
		AssertUtil.isTrue(accountDao.moneyOut(transfer.getSrcMoney(), transfer.getSrcAccountId(), transfer.getUserId())<1, "更新相应账户失败");
		//转入账户加上转入的钱
		AssertUtil.isTrue(accountDao.moneyIn(transfer.getDestMoney(), transfer.getDestAccountId(), transfer.getUserId())<1, "更新相应账户失败");
		//添加转账记录,设置创建时间，更新时间，isValid
		transfer.setCreateTime(new Date());
		transfer.setUpdateTime(new Date());
		transfer.setIsValid(1);
		AssertUtil.isTrue(transferDao.insert(transfer)<1, "添加转账失败");
	}
	
	
	/**
	 * 更新转账
	 * @param transfer
	 */
	@Transactional
	public void update(Transfer transfer) {
		//非空校验
		AssertUtil.isTrue(transfer.getId()==null, "待更新的转账不能为空");
		AssertUtil.isTrue(transfer.getSrcAccountId()==null, "转出账户不能为空");
		AssertUtil.isTrue(transfer.getDestAccountId()==null, "转入账户不能为空");
		AssertUtil.isTrue(transfer.getSrcMoney()==null, "转出金额不能为空");
		AssertUtil.isTrue(transfer.getDestMoney()==null, "转入金额不能为空");
		AssertUtil.isTrue(transfer.getTime()==null, "时间不能为空");
		//转入转出的账户不能是同一个
				AssertUtil.isTrue(transfer.getSrcAccountId().equals(transfer.getDestAccountId()), "转入与转出账户不能是同一个账户");
		//合法性校验,转入转出的账户存在,记录存在
		Transfer oldTransfer = transferDao.selectByIdAndUserId(transfer.getId(), transfer.getUserId());
		AssertUtil.isTrue(oldTransfer==null, "待更新的转账不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(transfer.getSrcAccountId(), transfer.getUserId())==null, "转出账户不存在");
		AssertUtil.isTrue(accountDao.selectByIdAndUserId(transfer.getDestAccountId(), transfer.getUserId())==null, "转入账户不存在");
		//执行逻辑代码
		//老转出账户加上老转出的钱，新转出账户减去新转出的钱
		AssertUtil.isTrue(accountDao.moneyIn(oldTransfer.getSrcMoney(), oldTransfer.getSrcAccountId(), oldTransfer.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(accountDao.moneyOut(transfer.getSrcMoney(), transfer.getSrcAccountId(), transfer.getUserId())<1, "更新相应账户失败");
		//老转入账户减去老转入的钱，新转入账户加上新转入的钱
		AssertUtil.isTrue(accountDao.moneyOut(oldTransfer.getDestMoney(), oldTransfer.getDestAccountId(), oldTransfer.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(accountDao.moneyIn(transfer.getDestMoney(), transfer.getDestAccountId(), transfer.getUserId())<1, "更新相应账户失败");
		//更新转账记录,设置更新时间
		transfer.setUpdateTime(new Date());
		AssertUtil.isTrue(transferDao.update(transfer)<1, "添加转账失败");
	}
	
	
	/**
	 * 根据id和userId删除转账
	 * @param id
	 * @param userId
	 */
	@Transactional
	public void deleteByIdAndUserId(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "转账id不能为空");
		//合法性校验
		Transfer oldTransfer = transferDao.selectByIdAndUserId(id, userId);
		AssertUtil.isTrue(oldTransfer==null, "待删除的记录不存在");
		//执行逻辑代码,老转出账户加上老钱，老转入账户减去老钱
		AssertUtil.isTrue(accountDao.moneyIn(oldTransfer.getSrcMoney(), oldTransfer.getSrcAccountId(), oldTransfer.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(accountDao.moneyOut(oldTransfer.getDestMoney(), oldTransfer.getDestAccountId(), oldTransfer.getUserId())<1, "更新相应账户失败");
		AssertUtil.isTrue(transferDao.deleteByIdAndUserId(id, userId)<1, "删除失败");
	}
	
	
	/**
	 * 根据参数查询转账记录
	 * @param transferQuery
	 * @return
	 */
	public PageModel<TransferDto> selectByParams(TransferQuery transferQuery) {
		PageHelper.startPage(transferQuery.getPage(), transferQuery.getRows());
		List<TransferDto> list = transferDao.selectByParams(transferQuery);
		PageInfo<TransferDto> pageInfo = new PageInfo<TransferDto>(list);
		
		PageModel<TransferDto> pm = new PageModel<TransferDto>(transferQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		
		return pm;
	}
}
