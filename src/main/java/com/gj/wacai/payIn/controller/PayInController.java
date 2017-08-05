package com.gj.wacai.payIn.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.payIn.dto.PayInDto;
import com.gj.wacai.payIn.pojo.PayIn;
import com.gj.wacai.payIn.query.PayInQuery;
import com.gj.wacai.payIn.service.PayInService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("payIn")
public class PayInController {

	@Resource
	private PayInService payInService;
	
	
	/**
	 * 添加一条收入
	 * @param req
	 * @param payIn
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(HttpServletRequest req, PayIn payIn){
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payIn.setUserId(userId);
		payInService.insert(payIn);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 根据参数查询收入
	 * @param req
	 * @param payInQuery
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParams")
	@ResponseBody
	public PageModel<PayInDto> selectByParams(HttpServletRequest req, PayInQuery payInQuery) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payInQuery.setUserId(userId);
		
		return payInService.selectByParams(payInQuery);
	}
	
	
	/**
	 * 更新一条收入
	 */
	@IsLogin
	@RequestMapping("update")
	@ResponseBody
	public MessageModel update(HttpServletRequest req, PayIn payIn) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payIn.setUserId(userId);
		payInService.update(payIn);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 删除一条收入记录
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
		payInService.deleteByIdAndUserId(id, userId);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
}
