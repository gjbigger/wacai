package com.gj.wacai.account.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.account.dto.AccountDto;
import com.gj.wacai.account.pojo.Account;
import com.gj.wacai.account.query.AccountQuery;
import com.gj.wacai.account.service.AccountService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("account")
public class AccountController {

	@Resource
	private AccountService accountService;
	
	
	/**
	 * 根据参数查询账户数据
	 * @param req
	 * @param accountQuery
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParams")
	@ResponseBody
	public PageModel<AccountDto> selectByParams(HttpServletRequest req, AccountQuery accountQuery) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		accountQuery.setUserId(userId);
		
		return accountService.selectByParams(accountQuery);
	}
	
	
	/**
	 * 添加或者更新一个账户数据
	 * @return
	 */
	@IsLogin
	@RequestMapping("insertOrUpdate")
	@ResponseBody
	public MessageModel insertOrUpdate(HttpServletRequest req, Account account) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		account.setUserId(userId);
		accountService.insertOrUpdate(account);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 删除账户
	 * @param req
	 * @param id
	 * @return
	 */
	@IsLogin
	@RequestMapping("deleteById")
	@ResponseBody
	public MessageModel deleteById(HttpServletRequest req, Integer id) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		accountService.deleteByIdAndUserId(id, userId);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
	
	
	/**
	 * 根据用户id查询账户，用于下拉框
	 * @return
	 */
	//查询所有账户
	@IsLogin
	@RequestMapping("selectByUserIdForSelectOption")
	@ResponseBody
	public List<AccountDto> selectByUserIdForSelectOption(HttpServletRequest req) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return accountService.selectByUserId(userId);
	}
	//查询所有债权债务人类型的账户
	@IsLogin
	@RequestMapping("selectByUserIdAndTypeIdIs8ForSelectOption")
	@ResponseBody
	public List<AccountDto> selectByUserIdAndTypeIdIs8ForSelectOption(HttpServletRequest req) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return accountService.selectByUserIdAndTypeIdIs8(userId);
	}
	//查询除了债权债务人的所有账户
	@IsLogin
	@RequestMapping("selectByUserIdAndTypeIdIsNot8ForSelectOption")
	@ResponseBody
	public List<AccountDto> selectByUserIdAndTypeIdIsNot8ForSelectOption(HttpServletRequest req) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		return accountService.selectByUserIdAndTypeIdIsNot8(userId);
	}
}
