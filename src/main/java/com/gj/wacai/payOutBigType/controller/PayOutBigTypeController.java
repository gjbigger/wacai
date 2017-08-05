package com.gj.wacai.payOutBigType.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.wacai.payOutBigType.pojo.PayOutBigType;
import com.gj.wacai.payOutBigType.service.PayOutBigTypeService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("payOutBigType")
public class PayOutBigTypeController {

	@Resource
	private PayOutBigTypeService payOutBigTypeService;
	
	
	/**
	 * 添加支出大类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(PayOutBigType payOutBigType, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payOutBigType.setUserId(userId);
		payOutBigTypeService.insert(payOutBigType);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	

	/**
	 * 删除支出大类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("delete")
	@ResponseBody
	public MessageModel delete(Integer id, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payOutBigTypeService.delete(id, userId);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
	
	
	/**
	 * 根据用户id 查询支出大类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByUserIdForSelectOption")
	@ResponseBody
	public List<PayOutBigType> selectByUserIdForSelectOption(HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		return payOutBigTypeService.selectByUserId(userId);
	}
}
