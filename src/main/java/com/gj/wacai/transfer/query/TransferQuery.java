package com.gj.wacai.transfer.query;

import com.gj.utils.BaseQuery;

public class TransferQuery extends BaseQuery{

	private Integer userId;
	private Integer queryTransferSrcAccountId;
	private Integer queryTransferDestAccountId;
	private String queryTransferTime;
	
	public TransferQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getQueryTransferSrcAccountId() {
		return queryTransferSrcAccountId;
	}

	public void setQueryTransferSrcAccountId(Integer queryTransferSrcAccountId) {
		this.queryTransferSrcAccountId = queryTransferSrcAccountId;
	}

	public Integer getQueryTransferDestAccountId() {
		return queryTransferDestAccountId;
	}

	public void setQueryTransferDestAccountId(Integer queryTransferDestAccountId) {
		this.queryTransferDestAccountId = queryTransferDestAccountId;
	}

	public String getQueryTransferTime() {
		return queryTransferTime;
	}

	public void setQueryTransferTime(String queryTransferTime) {
		this.queryTransferTime = queryTransferTime;
	}

	@Override
	public String toString() {
		return "TransferQuery [userId=" + userId + ", queryTransferSrcAccountId=" + queryTransferSrcAccountId
				+ ", queryTransferDestAccountId=" + queryTransferDestAccountId + ", queryTransferTime="
				+ queryTransferTime + "]";
	}
	
	
}
