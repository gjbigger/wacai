package com.gj.wacai.accountUnit.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.IsLogin;
import com.gj.wacai.accountUnit.pojo.AccountUnit;
import com.gj.wacai.accountUnit.service.AccountUnitService;

@Controller
@RequestMapping("accountUnit")
public class AccountUnitController {

	@Resource
	private AccountUnitService accountUnitService;
	
	@IsLogin
	@RequestMapping("selectAllForSelectOption")
	@ResponseBody
	public List<AccountUnit> selectAllForSelectOption() {
		return accountUnitService.selectAll();
	}
}
