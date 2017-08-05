package com.gj.wacai.payOut.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.payOut.dto.PayOutDto;
import com.gj.wacai.payOut.pojo.PayOut;
import com.gj.wacai.payOut.query.PayOutQuery;
import com.gj.wacai.payOut.service.PayOutService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("payOut")
public class PayOutController {

	@Resource
	private PayOutService payOutService;
	

	/**
	 * 添加一条支出
	 * @param req
	 * @param payOut
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(HttpServletRequest req, PayOut payOut){
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payOut.setUserId(userId);
		payOutService.insert(payOut);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 根据参数查询支出
	 * @param req
	 * @param payOutQuery
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParams")
	@ResponseBody
	public PageModel<PayOutDto> selectByParams(HttpServletRequest req, PayOutQuery payOutQuery) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payOutQuery.setUserId(userId);
		
		return payOutService.selectByParams(payOutQuery);
	}
	
	
	/**
	 * 更新一条支出
	 */
	@IsLogin
	@RequestMapping("update")
	@ResponseBody
	public MessageModel update(HttpServletRequest req, PayOut payOut) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		payOut.setUserId(userId);
		payOutService.update(payOut);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 删除一条支出记录
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
		payOutService.deleteByIdAndUserId(id, userId);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
}
