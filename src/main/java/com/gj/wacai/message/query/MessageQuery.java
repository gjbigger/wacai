package com.gj.wacai.message.query;

import com.gj.utils.BaseQuery;

public class MessageQuery extends BaseQuery{

	private Integer queryUserId;
	private Integer queryIsNew;
	private String queryCreateTime;
	
	public MessageQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getQueryUserId() {
		return queryUserId;
	}

	public void setQueryUserId(Integer queryUserId) {
		this.queryUserId = queryUserId;
	}

	public Integer getQueryIsNew() {
		return queryIsNew;
	}

	public void setQueryIsNew(Integer queryIsNew) {
		this.queryIsNew = queryIsNew;
	}

	public String getQueryCreateTime() {
		return queryCreateTime;
	}

	public void setQueryCreateTime(String queryCreateTime) {
		this.queryCreateTime = queryCreateTime;
	}

	@Override
	public String toString() {
		return "MessageQuery [queryUserId=" + queryUserId + ", queryIsNew=" + queryIsNew + ", queryCreateTime="
				+ queryCreateTime + "]";
	}
	
	
}
