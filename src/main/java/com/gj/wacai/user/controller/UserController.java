package com.gj.wacai.user.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gj.utils.AssertUtil;
import com.gj.utils.ConstData;
import com.gj.utils.IsLogin;
import com.gj.utils.MessageModel;
import com.gj.wacai.user.dao.UserDao;
import com.gj.wacai.user.pojo.User;
import com.gj.wacai.user.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Resource
	private UserService userService;
	@Resource
	private UserDao userDao;
	
	/**
	 * 跳转到用户登录页面
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("toUserLoginJsp")
	public ModelAndView toUserLoginJsp(String userName, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		User user = (User) req.getSession().getAttribute("user");
		if(user != null) {
			resp.sendRedirect(req.getContextPath()+"/index/toIndexJsp");
			return null;
		}
		//session中没有值，看是否自动登录
		Cookie[] cookies = req.getCookies();
		if(cookies!=null && cookies.length>0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("autoLogin")) {
					String value = cookie.getValue();
					String[] split = value.split("--");
					User searchResult = userDao.selectByUserName(split[0]);
					if(searchResult!=null && searchResult.getUserPwd().equals(split[1])) {
						req.getSession().setAttribute("user", searchResult);
						resp.sendRedirect(req.getContextPath()+"/index/toIndexJsp");
						return null;
					}
				}
			}
		}
		
		
		ModelAndView mv = new ModelAndView();
		if(!StringUtils.isBlank(userName)) {
			mv.addObject("loginUserName", userName.trim());
		}
		mv.setViewName("user/user_login");
		return mv;
	}

	/**
	 * 跳转到用户注册页面
	 * @return
	 */
	@RequestMapping("toUserRegisterJsp")
	public ModelAndView toUserRegisterJsp() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/user_register");
		return mv;
	}

	
	/**
	 * 用户登录
	 * @param resp
	 * @param req
	 * @param userName
	 * @param userPwd
	 * @param autoLogin
	 * @return
	 */
	@RequestMapping("userLogin")
	@ResponseBody
	public MessageModel userLogin(HttpServletResponse resp, HttpServletRequest req, String userName, String userPwd, String autoLogin) {
		MessageModel mm = new MessageModel();
		
		//执行登录
		User user = userService.userLogin(userName, userPwd);
		req.getSession().setAttribute("user", user);
		
		//判断是否7天免登录
		if("1".equals(autoLogin)) {
			Cookie cookie = new Cookie("autoLogin", userName+"--"+user.getUserPwd());
			cookie.setMaxAge(3600*24*7);
			cookie.setPath(req.getContextPath());
			resp.addCookie(cookie);
		}
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("登录成功");
		return mm;
	}
	
	
	/**
	 * 用户注册
	 * @param req
	 * @param userName
	 * @param userPwd
	 * @param confirmPwd
	 * @param kaptcha
	 * @return
	 */
	@RequestMapping("userRegister")
	@ResponseBody
	public MessageModel userRegister(HttpServletRequest req, String userName, String userPwd, String confirmPwd,
			String kaptcha) {
		MessageModel mm = new MessageModel();

		//去除验证码前后空格
		kaptcha = kaptcha.trim();
		// 判断验证码是否为空
		AssertUtil.isTrue(StringUtils.isBlank(kaptcha), "验证码不能为空");
		// 判断验证码是否正确
		String kaptchaExpected = (String) req.getSession()
				.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		AssertUtil.isTrue(!kaptcha.equalsIgnoreCase(kaptchaExpected), "验证码错误");
		//执行注册
		userService.userRegister(userName, userPwd, confirmPwd);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("注册成功");
		mm.setObj(userName.trim());
		return mm;
	}
	
	
	/**
	 * 用户登出
	 * @param req
	 * @return
	 */
	@IsLogin
	@RequestMapping("userLogout")
	public ModelAndView userLogout(HttpServletRequest req, HttpServletResponse resp) {
		req.getSession().setAttribute("user", null);
		
		Cookie cookie=new Cookie("autoLogin", null);
		cookie.setMaxAge(0);
		cookie.setPath(req.getContextPath());
		resp.addCookie(cookie);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/user_login");
		return mv;
	}
	
	
	/**
	 * 用户修改密码
	 * @return
	 */
	@IsLogin
	@RequestMapping("userChangePwd")
	@ResponseBody
	public MessageModel userChangePwd(HttpServletRequest req, String oldPwd, String newPwd, String newPwdConfirm) {
		Integer id = ((User) req.getSession().getAttribute("user")).getId()	;
		userService.userChangePwd(id, oldPwd, newPwd, newPwdConfirm);
		
		MessageModel mm = new MessageModel();
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("修改密码成功");
		
		return mm;
	}
	
	
	/**
	 * 修改默认币种
	 * @return
	 */
	@IsLogin
	@RequestMapping("userChangeDefaultAccountUnit")
	@ResponseBody
	public MessageModel userChangeDefaultAccountUnit(HttpServletRequest req, Integer defaultAccountUnitId) {
		MessageModel mm = new MessageModel();
		
		User oldUser = (User) req.getSession().getAttribute("user");
		
		if(defaultAccountUnitId.equals(oldUser.getDefaultAccountUnitId())) {
			mm.setCode(0);
			mm.setMsg("新旧默认币种相同，不更新");
			return mm;
		}
		
		userService.userChangeDefaultAccountUnit(oldUser.getId(), defaultAccountUnitId);
		User newUser = oldUser;
		newUser.setDefaultAccountUnitId(defaultAccountUnitId);
		req.getSession().setAttribute("user", newUser);
		
		mm.setCode(ConstData.SUCCESS_CODE);
		mm.setMsg("修改默认币种成功");
		return mm;
	}
}
