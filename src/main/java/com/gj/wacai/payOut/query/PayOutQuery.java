package com.gj.wacai.payOut.query;

import com.gj.utils.BaseQuery;

public class PayOutQuery extends BaseQuery{

	private Integer userId;
	
	private Integer queryPayOutAccountId;
	private Integer queryPayOutBigTypeId;
	private String queryPayOutTime;
	
	public PayOutQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getQueryPayOutAccountId() {
		return queryPayOutAccountId;
	}

	public void setQueryPayOutAccountId(Integer queryPayOutAccountId) {
		this.queryPayOutAccountId = queryPayOutAccountId;
	}

	public Integer getQueryPayOutBigTypeId() {
		return queryPayOutBigTypeId;
	}

	public void setQueryPayOutBigTypeId(Integer queryPayOutBigTypeId) {
		this.queryPayOutBigTypeId = queryPayOutBigTypeId;
	}

	public String getQueryPayOutTime() {
		return queryPayOutTime;
	}

	public void setQueryPayOutTime(String queryPayOutTime) {
		this.queryPayOutTime = queryPayOutTime;
	}

	@Override
	public String toString() {
		return "PayOutQuery [userId=" + userId + ", queryPayOutAccountId=" + queryPayOutAccountId
				+ ", queryPayOutBigTypeId=" + queryPayOutBigTypeId + ", queryPayOutTime=" + queryPayOutTime + "]";
	}

	
}
