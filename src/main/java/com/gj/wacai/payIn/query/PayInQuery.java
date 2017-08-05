package com.gj.wacai.payIn.query;

import com.gj.utils.BaseQuery;

public class PayInQuery extends BaseQuery{

	private Integer userId;
	
	private Integer queryPayInAccountId;
	private Integer queryPayInTypeId;
	private String queryPayInTime;
	
	public PayInQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getQueryPayInAccountId() {
		return queryPayInAccountId;
	}

	public void setQueryPayInAccountId(Integer queryPayInAccountId) {
		this.queryPayInAccountId = queryPayInAccountId;
	}

	public Integer getQueryPayInTypeId() {
		return queryPayInTypeId;
	}

	public void setQueryPayInTypeId(Integer queryPayInTypeId) {
		this.queryPayInTypeId = queryPayInTypeId;
	}

	public String getQueryPayInTime() {
		return queryPayInTime;
	}

	public void setQueryPayInTime(String queryPayInTime) {
		this.queryPayInTime = queryPayInTime;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "PayInQuery [userId=" + userId + ", queryPayInAccountId=" + queryPayInAccountId + ", queryPayInTypeId="
				+ queryPayInTypeId + ", queryPayInTime=" + queryPayInTime + "]";
	}

}
