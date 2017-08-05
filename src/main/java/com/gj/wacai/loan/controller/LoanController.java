package com.gj.wacai.loan.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.loan.service.LoanService;
import com.gj.wacai.loan.dto.LoanDto;
import com.gj.wacai.loan.pojo.Loan;
import com.gj.wacai.loan.query.LoanQuery;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("loan")
public class LoanController {

	@Resource
	private LoanService loanService;
	
	/**
	 * 添加一条借贷
	 * @param req
	 * @param loan
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(HttpServletRequest req, Loan loan){
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		loan.setUserId(userId);
		loanService.insert(loan);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 根据参数查询借贷
	 * @param req
	 * @param loanQuery
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParams")
	@ResponseBody
	public PageModel<LoanDto> selectByParams(HttpServletRequest req, LoanQuery loanQuery) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		loanQuery.setUserId(userId);
		
		return loanService.selectByParams(loanQuery);
	}
	
	
	/**
	 * 更新一条借贷
	 */
	@IsLogin
	@RequestMapping("update")
	@ResponseBody
	public MessageModel update(HttpServletRequest req, Loan loan) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		loan.setUserId(userId);
		loanService.update(loan);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 删除一条借贷记录
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
		loanService.deleteByIdAndUserId(id, userId);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
}
