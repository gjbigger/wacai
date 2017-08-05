package com.gj.utils;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 用于标记方法是否需要用户已登录状态
 * @author GJ
 *
 */
@Target(value=ElementType.METHOD)
@Retention(value = RetentionPolicy.RUNTIME)
@Documented
public @interface IsLogin {

}
