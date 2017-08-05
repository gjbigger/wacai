package com.gj.wacai.payInType.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.wacai.payInType.pojo.PayInType;
import com.gj.wacai.payInType.service.PayInTypeService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("payInType")
public class PayInTypeController {

	@Resource
	private PayInTypeService payInTypeService;
	
	
	/**
	 * 添加收入类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(PayInType payInType, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payInType.setUserId(userId);
		payInTypeService.insert(payInType);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	
	
	/**
	 * 删除收入类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("delete")
	@ResponseBody
	public MessageModel delete(Integer id, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payInTypeService.delete(id, userId);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
	
	
	
	
	/**
	 * 根据用户id查收入类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByUserIdForSelectOption")
	@ResponseBody
	public List<PayInType> selectByUserIdForSelectOption(HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		return payInTypeService.selectByUserId(userId);
	}
}
