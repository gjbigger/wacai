package com.gj.wacai.account.query;

import com.gj.utils.BaseQuery;

public class AccountQuery extends BaseQuery {
	
	private Integer userId;

	private String queryAccountName;
	private Integer queryAccountTypeId;
	private String queryAccountCreateTime;
	
	public AccountQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getQueryAccountName() {
		return queryAccountName;
	}

	public void setQueryAccountName(String queryAccountName) {
		this.queryAccountName = queryAccountName;
	}

	public Integer getQueryAccountTypeId() {
		return queryAccountTypeId;
	}

	public void setQueryAccountTypeId(Integer queryAccountTypeId) {
		this.queryAccountTypeId = queryAccountTypeId;
	}

	public String getQueryAccountCreateTime() {
		return queryAccountCreateTime;
	}

	public void setQueryAccountCreateTime(String queryAccountCreateTime) {
		this.queryAccountCreateTime = queryAccountCreateTime;
	}

	@Override
	public String toString() {
		return "AccountQuery [userId=" + userId + ", queryAccountName=" + queryAccountName + ", queryAccountTypeId="
				+ queryAccountTypeId + ", queryAccountCreateTime=" + queryAccountCreateTime + "]";
	}
	
}
