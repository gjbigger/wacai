package com.gj.wacai.loan.query;

import com.gj.utils.BaseQuery;

public class LoanQuery extends BaseQuery {

	private Integer userId;//其实可以写进BaseQuery里头
	
	private Integer queryLoanTypeId;
	private Integer queryLoanBodyAccountId;
	private String queryLoanTime;
	
	public LoanQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getQueryLoanTypeId() {
		return queryLoanTypeId;
	}

	public void setQueryLoanTypeId(Integer queryLoanTypeId) {
		this.queryLoanTypeId = queryLoanTypeId;
	}

	public Integer getQueryLoanBodyAccountId() {
		return queryLoanBodyAccountId;
	}

	public void setQueryLoanBodyAccountId(Integer queryLoanBodyAccountId) {
		this.queryLoanBodyAccountId = queryLoanBodyAccountId;
	}

	public String getQueryLoanTime() {
		return queryLoanTime;
	}

	public void setQueryLoanTime(String queryLoanTime) {
		this.queryLoanTime = queryLoanTime;
	}

	@Override
	public String toString() {
		return "LoanQuery [userId=" + userId + ", queryLoanTypeId=" + queryLoanTypeId + ", queryLoanBodyAccountId="
				+ queryLoanBodyAccountId + ", queryLoanTime=" + queryLoanTime + "]";
	}
	
	
}
