package com.gj.wacai.payOutBigType.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.gj.utils.AssertUtil;
import com.gj.wacai.payOutBigType.dao.PayOutBigTypeDao;
import com.gj.wacai.payOutBigType.pojo.PayOutBigType;

@Service
public class PayOutBigTypeService {

	@Resource
	private PayOutBigTypeDao payOutBigTypeDao;
	
	
	
	/**
	 * 添加支出大类型
	 */
	public void insert(PayOutBigType payOutBigType) {
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(payOutBigType.getName()), "支出大类型名称不能为空");
		
		//合法性校验
		AssertUtil.isTrue(payOutBigTypeDao.selectByUserIdAndName(payOutBigType.getUserId(), payOutBigType.getName())!=null, "支出大类型已经存在");
		
		payOutBigType.setIsValid(1);
		AssertUtil.isTrue(payOutBigTypeDao.insert(payOutBigType)<1, "添加支出大类型失败");
		
	}
	
	
	
	/**
	 * 删除支出大类型
	 */
	public void delete(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "支出大类型id不能为空");
		//合法性检验
		AssertUtil.isTrue(payOutBigTypeDao.selectByIdAndUserId(id, userId)==null, "待删除记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(payOutBigTypeDao.delete(id)<1, "删除支出大类型失败");
	}
	
	
	/**
	 * 根据用户id查询收入类型
	 * @param userId
	 * @return
	 */
	public List<PayOutBigType> selectByUserId(Integer userId) {
		return payOutBigTypeDao.selectByUserId(userId);
	}
}
