package com.gj.wacai.loanType.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.wacai.loanType.pojo.LoanType;
import com.gj.wacai.loanType.service.LoanTypeService;

@Controller
@RequestMapping("loanType")
public class LoanTypeController {

	@Resource
	private LoanTypeService loanTypeService;
	
	
	/**
	 * 查询所有的借贷类型
	 * @return
	 */
	@RequestMapping("selectAllForSelectOption")
	@ResponseBody
	public List<LoanType> selectAllForSelectOption() {
		return loanTypeService.selectAll();
	}
}
