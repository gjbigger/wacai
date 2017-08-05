package com.gj.wacai.payOutSmallType.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.gj.utils.AssertUtil;
import com.gj.wacai.payOutBigType.dao.PayOutBigTypeDao;
import com.gj.wacai.payOutBigType.pojo.PayOutBigType;
import com.gj.wacai.payOutSmallType.dao.PayOutSmallTypeDao;
import com.gj.wacai.payOutSmallType.pojo.PayOutSmallType;

@Service
public class PayOutSmallTypeService {
	
	@Resource
	private PayOutSmallTypeDao payOutSmallTypeDao;
	@Resource
	private PayOutBigTypeDao payOutBigTypeDao;
	
	

	/**
	 * 添加支出小类型
	 */
	public void insert(PayOutSmallType payOutSmallType) {
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(payOutSmallType.getName()), "支出小类型名称不能为空");
		AssertUtil.isTrue(payOutSmallType.getPid() == null, "所属支出大类型不能为空");
		
		//合法性校验
		PayOutBigType bigType = payOutBigTypeDao.selectById(payOutSmallType.getPid());
		AssertUtil.isTrue(bigType==null, "所属支出大类型不存在");
		AssertUtil.isTrue(!bigType.getUserId().equals(0) && !bigType.getUserId().equals(payOutSmallType.getUserId()), "所属支出大类型不存在");
		AssertUtil.isTrue(payOutSmallTypeDao.selectByUserIdAndNameAndPid(payOutSmallType.getUserId(), payOutSmallType.getName(), payOutSmallType.getPid())!=null, "支出小类型已经存在");
		
		payOutSmallType.setIsValid(1);
		AssertUtil.isTrue(payOutSmallTypeDao.insert(payOutSmallType)<1, "添加支出小类型失败");
		
	}
	
	
	
	/**
	 * 删除支出小类型
	 */
	public void delete(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "支出小类型id不能为空");
		//合法性检验
		AssertUtil.isTrue(payOutSmallTypeDao.selectByIdAndUserId(id, userId)==null, "待删除记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(payOutSmallTypeDao.delete(id)<1, "删除支出大类型失败");
	}
	

	/**
	 * 根据pid和userId查询支出小类型
	 * @param pid
	 * @param userId
	 * @return
	 */
	public List<PayOutSmallType> selectByPidAndUserId(Integer pid, Integer userId) {
		return payOutSmallTypeDao.selectByPidAndUserId(pid, userId);
	}

}
