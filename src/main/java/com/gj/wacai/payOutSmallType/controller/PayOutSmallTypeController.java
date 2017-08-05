package com.gj.wacai.payOutSmallType.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.wacai.payOutSmallType.pojo.PayOutSmallType;
import com.gj.wacai.payOutSmallType.service.PayOutSmallTypeService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("payOutSmallType")
public class PayOutSmallTypeController {

	@Resource
	private PayOutSmallTypeService payOutSmallTypeService;
	
	
	/**
	 * 添加支出小类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(PayOutSmallType payOutSmallType, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payOutSmallType.setUserId(userId);
		payOutSmallTypeService.insert(payOutSmallType);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	

	/**
	 * 删除支出小类型
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("delete")
	@ResponseBody
	public MessageModel delete(Integer id, HttpServletRequest req) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		payOutSmallTypeService.delete(id, userId);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
	
	
	

	/**
	 * 根据pid和userId查询支出小类型
	 * @param req
	 * @param pid
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByPidAndUserIdForSelectOption")
	@ResponseBody
	public List<PayOutSmallType> selectByPidAndUserIdForSelectOption(HttpServletRequest req, Integer pid) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		
		return payOutSmallTypeService.selectByPidAndUserId(pid, userId);
	}
}
