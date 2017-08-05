package com.gj.utils;

public class MessageModel {

	private Integer code;
	private String msg;
	private Object obj;
	
	public MessageModel() {
		// TODO Auto-generated constructor stub
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	@Override
	public String toString() {
		return "MessageModel [code=" + code + ", msg=" + msg + ", obj=" + obj + "]";
	}
	
	
}
