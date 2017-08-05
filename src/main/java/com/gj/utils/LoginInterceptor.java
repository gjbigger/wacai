package com.gj.utils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gj.wacai.user.dao.UserDao;
import com.gj.wacai.user.pojo.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Resource
	private UserDao userDao;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		// 验证是否拦截的是方法级别
		if (!(handler instanceof HandlerMethod)) {
			return true;
		}
		// 获取方法前的注解
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		IsLogin isLogin = handlerMethod.getMethodAnnotation(IsLogin.class); // 获取方法前的注解
		if (isLogin == null) { // 此方法不需要登录
			return true;
		}
		//需要登录状态，判断是否是登录状态
		User user = (User) req.getSession().getAttribute("user");
		if(user != null) {
			return true;	//session中有user，已经登录的状态，放行
		}
		//session中没有值，看是否自动登录
		Cookie[] cookies = req.getCookies();
		if(cookies!=null && cookies.length>0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("autoLogin")) {
					//执行自动登录操作并放行
					String value = cookie.getValue();
					String[] split = value.split("--");
					User searchResult = userDao.selectByUserName(split[0]);
					AssertUtil.isTrue(searchResult==null, "用户名不存在");
					AssertUtil.isTrue(!split[1].equals(searchResult.getUserPwd()), "密码不匹配");
					req.getSession().setAttribute("user", searchResult);
					return true;
				}
			}
		}
		
		
		
		String location = req.getContextPath() + "/user/toUserLoginJsp";
		resp.sendRedirect(location);
		return false;
	}

}
