package com.gj.wacai.transfer.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.utils.PageModel;
import com.gj.wacai.transfer.dto.TransferDto;
import com.gj.wacai.transfer.pojo.Transfer;
import com.gj.wacai.transfer.query.TransferQuery;
import com.gj.wacai.transfer.service.TransferService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("transfer")
public class TransferController {

	@Resource
	private TransferService transferService;
	
	/**
	 * 添加一条转账
	 * @param req
	 * @param transfer
	 * @return
	 */
	@IsLogin
	@RequestMapping("insert")
	@ResponseBody
	public MessageModel insert(HttpServletRequest req, Transfer transfer){
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		transfer.setUserId(userId);
		transferService.insert(transfer);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 根据参数查询转账
	 * @param req
	 * @param transferQuery
	 * @return
	 */
	@IsLogin
	@RequestMapping("selectByParams")
	@ResponseBody
	public PageModel<TransferDto> selectByParams(HttpServletRequest req, TransferQuery transferQuery) {
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		transferQuery.setUserId(userId);
		
		return transferService.selectByParams(transferQuery);
	}
	
	
	/**
	 * 更新一条转账
	 */
	@IsLogin
	@RequestMapping("update")
	@ResponseBody
	public MessageModel update(HttpServletRequest req, Transfer transfer) {
		MessageModel mm = new MessageModel();
		
		Integer userId = ((User)req.getSession().getAttribute("user")).getId();
		transfer.setUserId(userId);
		transferService.update(transfer);

		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("保存成功");
		return mm;
	}
	
	
	/**
	 * 删除一条转账记录
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
		transferService.deleteByIdAndUserId(id, userId);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("删除成功");
		return mm;
	}
}
