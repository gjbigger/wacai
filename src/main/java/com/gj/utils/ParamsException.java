package com.gj.utils;

public class ParamsException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private String msg;
	
	public ParamsException() {
		// TODO Auto-generated constructor stub
	}

	public ParamsException(String msg) {
		super(msg);
		this.msg = msg;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
