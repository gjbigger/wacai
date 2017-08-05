package com.gj.wacai.message.task;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gj.wacai.message.service.MessageService;

@Component
public class MessageTask {

	@Resource
	private MessageService messageService;
	
	/**
	 * 设置账单日的相关信息
	 */
	//@Scheduled(cron="0/3 * * * * ?")
	@Scheduled(cron="0 30 23 * * ?")
	public void setBillMessage() {
		messageService.setBillMessage();
	}
	
	
	/**
	 * 设置还款日相关嘻嘻
	 */
	//@Scheduled(cron="0/3 * * * * ?")
	@Scheduled(cron="0 30 23 * * ?")
	public void setRepayMessage() {
		messageService.setRepayMessage();
	}
}
