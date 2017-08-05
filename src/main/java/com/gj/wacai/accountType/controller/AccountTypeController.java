package com.gj.wacai.accountType.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.IsLogin;
import com.gj.wacai.accountType.pojo.AccountType;
import com.gj.wacai.accountType.service.AccountTypeService;

@Controller
@RequestMapping("accountType")
public class AccountTypeController {

	@Resource
	private AccountTypeService accountTypeService;
	
	@IsLogin
	@RequestMapping("selectByPidForSelectOption")
	@ResponseBody
	public List<AccountType> selectByPidForSelectOption(Integer pid) {
		return accountTypeService.selectByPid(pid);
	}
}
