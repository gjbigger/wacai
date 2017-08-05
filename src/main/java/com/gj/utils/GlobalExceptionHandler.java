package com.gj.utils;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(ParamsException.class)
	@ResponseBody
	public MessageModel handleParamsException(ParamsException ex) {
		MessageModel mm = new MessageModel();
		
		mm.setCode(ConstData.FAILED_CODE);
		mm.setMsg(ex.getMsg());
		
		return mm;
	}
	
}
