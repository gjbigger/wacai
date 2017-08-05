package com.gj.wacai.message.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.message.pojo.Message;
import com.gj.wacai.message.query.MessageQuery;
import com.gj.wacai.message.service.MessageService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("message")
public class MessageController {

	@Resource
	private MessageService messageService;
	
	
	/**
	 * 更新，设置是否为新到0
	 * @return
	 */
	@IsLogin
	@RequestMapping("updateSetIsNew0")
	@ResponseBody
	public MessageModel updateSetIsNew0(Integer id) {
		messageService.updateSetIsNew0(id);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("设置新消息为已读状态成功");
		return mm;
	}
	
	
	/**
	 * 根据messageQuery查询
	 * @param messageQuery
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParam")
	@ResponseBody
	public PageModel<Message> selectByParam(MessageQuery messageQuery, HttpServletRequest req) {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();
		
		messageQuery.setQueryUserId(userId);
		return messageService.selectByParam(messageQuery);
	}
}
