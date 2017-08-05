package com.gj.wacai.payInType.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.gj.utils.AssertUtil;
import com.gj.wacai.payInType.dao.PayInTypeDao;
import com.gj.wacai.payInType.pojo.PayInType;

@Service
public class PayInTypeService {

	@Resource
	private PayInTypeDao payInTypeDao;
	
	
	
	/**
	 * 添加收入大类型
	 */
	public void insert(PayInType payInType) {
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(payInType.getName()), "收入类型名称不能为空");
		
		//合法性校验
		AssertUtil.isTrue(payInTypeDao.selectByUserIdAndName(payInType.getName(), payInType.getUserId())!=null, "收入类型已经存在");
		
		payInType.setIsValid(1);
		AssertUtil.isTrue(payInTypeDao.insert(payInType)<1, "添加支出大类型失败");
		
	}
	
	
	
	/**
	 * 删除支出大类型
	 */
	public void delete(Integer id, Integer userId) {
		//非空校验
		AssertUtil.isTrue(id==null, "收入类型id不能为空");
		//合法性检验
		AssertUtil.isTrue(payInTypeDao.selectByIdAndUserId(id, userId)==null, "待删除记录不存在");
		//执行逻辑代码
		AssertUtil.isTrue(payInTypeDao.delete(id)<1, "删除支出大类型失败");
	}
	
	
	
	/**
	 * 根据用户id查询收入类型
	 * @param userId
	 * @return
	 */
	public List<PayInType> selectByUserId(Integer userId) {
		return payInTypeDao.selectByUserId(userId);
	}
}
