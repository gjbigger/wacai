package com.gj.wacai.user.service;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gj.utils.AssertUtil;
import com.gj.utils.Md5Util;
import com.gj.wacai.accountUnit.dao.AccountUnitDao;
import com.gj.wacai.user.dao.UserDao;
import com.gj.wacai.user.pojo.User;

@Service
public class UserService {

	@Resource
	private UserDao userDao;
	@Resource
	private AccountUnitDao accountUnitDao;
	
	
	/**
	 * 用户登录
	 * @param userName
	 * @param userPwd
	 */
	public User userLogin(String userName, String userPwd) {
		//去除前后空格
		userName = userName.trim();
		userPwd = userPwd.trim();
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(userName), "用户名不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(userPwd), "密码不能为空");
		//合法校验
		AssertUtil.isTrue(!userName.matches("^\\w+$"), "用户名只能包含字母数字下划线");
		AssertUtil.isTrue(!userPwd.matches("^\\w+$"), "密码只能包含字母数字下划线");
		User user = userDao.selectByUserName(userName);
		AssertUtil.isTrue(user==null, "用户名不存在");
		//登录逻辑代码
		AssertUtil.isTrue(!Md5Util.encoding(userPwd).equals(user.getUserPwd()), "密码不匹配");
		//返回结果
		return user;
	}
	
	
	
	
	
	/**
	 * 用户注册
	 * @param userName
	 * @param userPwd
	 * @param confirmPwd
	 */
	@Transactional
	public void userRegister(String userName, String userPwd, String confirmPwd) {
		//去除前后空格
		userName = userName.trim();
		userPwd = userPwd.trim();
		confirmPwd = confirmPwd.trim();
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(userName), "用户名不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(userPwd), "密码不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(confirmPwd), "确认密码不能为空");
		//合法性校验
		AssertUtil.isTrue(!userName.matches("^\\w+$"), "用户名只能包含字母数字下划线");
		AssertUtil.isTrue(!userPwd.matches("^\\w+$"), "密码只能包含字母数字下划线");
		AssertUtil.isTrue(!confirmPwd.matches("^\\w+$"), "确认密码只能包含字母数字下划线");
		AssertUtil.isTrue(!userPwd.equals(confirmPwd), "两次输入密码不一致");
		User user = userDao.selectByUserName(userName);
		AssertUtil.isTrue(user!=null, "用户名已存在");
		//注册逻辑代码
		AssertUtil.isTrue(userDao.insert(userName, Md5Util.encoding(userPwd))<1, "注册失败");
	}
	
	
	
	/**
	 * 改密码
	 * @param id
	 * @param oldPwd
	 * @param newPwd
	 * @param newPwdConfirm
	 */
	@Transactional
	public void userChangePwd(Integer id, String oldPwd, String newPwd, String newPwdConfirm) {
		//去除前后空格
		oldPwd = oldPwd.trim();
		newPwd = newPwd.trim();
		newPwdConfirm = newPwdConfirm.trim();
		//非空校验
		AssertUtil.isTrue(StringUtils.isBlank(oldPwd), "旧密码不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(newPwd), "新密码不能为空");
		AssertUtil.isTrue(StringUtils.isBlank(newPwdConfirm), "确认新密码不能为空");
		//合法性校验
		AssertUtil.isTrue(!oldPwd.matches("^\\w+$"), "旧密码只能包含字母数字下划线");
		AssertUtil.isTrue(!newPwd.matches("^\\w+$"), "新密码只能包含字母数字下划线");
		AssertUtil.isTrue(!newPwdConfirm.matches("^\\w+$"), "确认新密码只能包含字母数字下划线");
		AssertUtil.isTrue(!newPwd.equals(newPwdConfirm), "两次输入密码不一致");
		User user = userDao.selectById(id);
		AssertUtil.isTrue(!user.getUserPwd().equals(Md5Util.encoding(oldPwd)), "旧密码错误");
		//修改密码逻辑代码
		int result = userDao.updateUserPwd(id, Md5Util.encoding(newPwd), new Date());
		AssertUtil.isTrue(result < 1, "修改密码失败");
	}
	
	
	/**
	 * 更新默认币种
	 */
	@Transactional
	public void userChangeDefaultAccountUnit(Integer id, Integer defaultAccountUnitId) {
		//非空校验
		AssertUtil.isTrue(defaultAccountUnitId==null, "默认币种不能为空");
		
		//查询币种是否存在
		AssertUtil.isTrue(accountUnitDao.selectById(defaultAccountUnitId) == null, "选择的币种不存在");
		
		//执行逻辑操作
		AssertUtil.isTrue(userDao.updateDefaultAccountUnitId(id, defaultAccountUnitId) < 1, "修改默认币种失败");
	}
}
