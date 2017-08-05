package com.gj.wacai.index.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;

@Controller
@RequestMapping("index")
public class IndexController {
	
	@Resource
	private IndexService indexService;
	@RequestMapping("test")
	@ResponseBody
	public MessageModel test() {
		indexService.test();
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("没有抛异常");
		return mm;
	}
	
	

	/**
	 * 跳转到主页面
	 */
	@IsLogin
	@RequestMapping("toIndexJsp")
	public ModelAndView toIndexJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "overview.jsp");
		mv.addObject("currentMenu", "overview");
		mv.setViewName("index/index");
		return mv;
	}
	
	/**
	 * 跳转到主页面，切换到财务概括栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toOverviewJsp")
	public ModelAndView toOverviewJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "overview.jsp");
		mv.addObject("currentMenu", "overview");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	/**
	 * 跳转到主页面，切换到记账栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toRecordJsp")
	public ModelAndView toRecordJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "record.jsp");
		mv.addObject("currentMenu", "record");
		mv.setViewName("index/index");
		return mv;
	}
	
	/**
	 * 跳转到主页面，切换到明细栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toDetailJsp")
	public ModelAndView toDetailJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "detail.jsp");
		mv.addObject("currentMenu", "detail");
		mv.setViewName("index/index");
		return mv;
	}
	
	/**
	 * 跳转到主页面，切换到报表栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toReportJsp")
	public ModelAndView toReportJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "report.jsp");
		mv.addObject("currentMenu", "report");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	/**
	 * 跳转到主页面，切换到账户栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toAccountListJsp")
	public ModelAndView toAccountListJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../account/account_list.jsp");
		mv.addObject("currentMenu", "account");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	/**
	 * 跳转到主页面，切换到预算
	 * @return
	 */
	/*@IsLogin
	@RequestMapping("toBudgetListJsp")
	public ModelAndView toBudgetListJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../budget/budget_list.jsp");
		mv.addObject("currentMenu", "budget");
		mv.setViewName("index/index");
		return mv;
	}*/
	
	
	/**
	 * 跳转到主页面，切换到设置下的个人中心栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toSetPersonCenterJsp")
	public ModelAndView toSetPersonCenterJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../set/set_personCenter.jsp");
		mv.addObject("set_detail_show", "on");
		mv.addObject("currentMenu", "personCenter");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	
	
	/**
	 * 跳转到主页面，切换到设置下的消息中心栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toSetNotificationJsp")
	public ModelAndView toSetNotificationJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../set/set_notification.jsp");
		mv.addObject("set_detail_show", "on");
		mv.addObject("currentMenu", "notification");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	/**
	 * 跳转到主页面，切换到设置下的导入导出栏
	 */
	@IsLogin
	@RequestMapping("toSetImportExportJsp")
	public ModelAndView toSetImportExportJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../set/set_importExport.jsp");
		mv.addObject("set_detail_show", "on");
		mv.addObject("currentMenu", "importExport");
		mv.setViewName("index/index");
		return mv;
	}
	
	
	/**
	 * 跳转到主页面，切换到设置下的基础数据设置栏
	 */
	@IsLogin
	@RequestMapping("toSetBaseDataSettingJsp")
	public ModelAndView toSetBaseDataSettingJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../set/set_baseDataSetting.jsp");
		mv.addObject("set_detail_show", "on");
		mv.addObject("currentMenu", "baseDataSetting");
		mv.setViewName("index/index");
		return mv;
	}
	
	/**
	 * 跳转到主页面，切换到设置下的个性化设置栏
	 * @return
	 */
	@IsLogin
	@RequestMapping("toSetPersonSettingJsp")
	public ModelAndView toSetPersonSettingJsp() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("mainShow", "../set/set_personSetting.jsp");
		mv.addObject("set_detail_show", "on");
		mv.addObject("currentMenu", "personSetting");
		mv.setViewName("index/index");
		return mv;
	}
}
