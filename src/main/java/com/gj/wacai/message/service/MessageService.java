package com.gj.wacai.message.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.gj.utils.AssertUtil;
import com.gj.utils.PageModel;
import com.gj.wacai.message.dao.MessageDao;
import com.gj.wacai.message.dto.BillDto;
import com.gj.wacai.message.dto.RepayDto;
import com.gj.wacai.message.pojo.Message;
import com.gj.wacai.message.query.MessageQuery;

@Service
public class MessageService {

	@Resource
	private MessageDao messageDao;
	
	
	/**
	 * 设置是否为新0
	 * @param id
	 */
	public void updateSetIsNew0(Integer id) {
		AssertUtil.isTrue(id == null, "消息id不能为空");
		int result = 0;
		do{
			result = messageDao.updateSetIsNew0(id);
		}while(result < 1);
	}
	
	
	/**
	 * 根据messageQuery查询
	 * @param userId
	 * @param isNew
	 * @return
	 */
	public PageModel<Message> selectByParam(MessageQuery messageQuery) {
		PageHelper.startPage(messageQuery.getPage(), messageQuery.getRows());
		List<Message> list = messageDao.selectByParam(messageQuery);
		PageInfo<Message> pageInfo = new PageInfo<>(list);
		
		PageModel<Message> pm = new PageModel<>(messageQuery.getPage(), pageInfo.getTotal(), pageInfo.getList());
		return pm;
	}
	
	
	/**
	 * 设置账单日的消息
	 */
	public void setBillMessage() {
		Calendar instance = Calendar.getInstance();
		instance.setTime(new Date());
		int currYear = instance.get(Calendar.YEAR);		//当前年
		int currMonth = instance.get(Calendar.MONTH)+1;	//当前月
		
		//账单年月
		String billTime = currYear+"-"+currMonth;
		//结束年月
		String endTime = billTime;
		//上一个年月,开始年月
		String startTime = "";
		if(currMonth == 1) {
			startTime = (currYear-1)+"-12";
		} else {
			startTime = currYear+"-"+(currMonth-1);
		}
		
		
		List<BillDto> list = messageDao.selectBill();
		Message message = new Message();
		for(BillDto temp : list) {
			message.setUserId(temp.getUserId());//设置用户id
			message.setIsValid(1);//设置有效
			message.setIsNew(1);//设置新的
			message.setCreateTime(new Date());//设置创建时间
			
			//尊敬的 userId, 您的账户(accountName)于startTime+billDay至endTime+billDay的账单金额为？,账户余额为
			Double selectSumMoney = messageDao.selectSumMoney(temp.getAccountId(), startTime+"-"+temp.getBillDay(), endTime+"-"+temp.getBillDay());
			double money = 0;
			if(selectSumMoney != null) {
				money = selectSumMoney.doubleValue();
			}
			StringBuffer sb = new StringBuffer();
			sb.append("尊敬的"+temp.getUserId()+"，");
			sb.append("您的账户("+temp.getAccountName()+")于"+startTime+"-"+temp.getBillDay()+"至"+endTime+"-"+temp.getBillDay()+"的账单金额为"+money+temp.getUnitName()+"，");
			sb.append("账户余额为"+temp.getBalance()+temp.getUnitName()+"。");
			double balance = temp.getBalance().doubleValue();
			if(-balance == money) {
				//账户余额 = 欠款
				sb.append("本次欠款为"+money+temp.getUnitName()+"，共欠款"+money+temp.getUnitName()+"。");
			} else if(-balance > money) {
				//账户余额 < 欠款， 账户里欠更多的钱
				sb.append("本次欠款为"+money+temp.getUnitName()+"，历史欠款为"+(-balance-money)+temp.getUnitName()+"，共欠款"+(-balance)+temp.getUnitName()+"。");
			} else if(-balance < money) {
				//账户余额 > 欠款，账户里的已经换了一部分的钱
				sb.append("本次欠款为"+money+temp.getUnitName()+"，已换欠款为"+(money+balance)+temp.getUnitName()+"，共欠款"+(-balance)+temp.getUnitName()+"。");
			}
			sb.append("最后还款日期为"+currYear+"-"+(currMonth+1)+"-"+temp.getRepayDay()+"。此消息发送于"+endTime+"-"+temp.getBillDay()+"。");
			
			message.setContent(sb.toString());
			int result = 0;
			do {
				result = messageDao.insert(message);
			} while(result<0);
		}
	}

	
	/**
	 * 设置还款日消息
	 */
	public void setRepayMessage() {
		List<RepayDto> list = messageDao.selectRepay();
		Message message = new Message();
		
		for(RepayDto temp : list) {
			message.setUserId(temp.getUserId());//设置用户id
			message.setIsValid(1);//设置有效
			message.setIsNew(1);//设置新的
			message.setCreateTime(new Date());//设置创建时间
			
			//尊敬的 userId, 您的账户(accountName)的三天后需还款。此消息发送于
			message.setContent("尊敬的"+temp.getUserId()+"，您的账户("+temp.getAccountName()+")三天后需还款。此消息发送于"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"。");
			
			int result = 0;
			do {
				result = messageDao.insert(message);
			} while(result<0);
		}
	}
}
