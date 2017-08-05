package com.gj.wacai.message.dto;

public class BillDto {

	private Integer userId;
	private Integer accountId;
	private Double balance;
	private Integer unitId;
	private Integer billDay;
	private Integer repayDay;
	
	private String accountName;
	private String unitName;
	
	public BillDto() {
		// TODO Auto-generated constructor stub
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Integer getUnitId() {
		return unitId;
	}

	public void setUnitId(Integer unitId) {
		this.unitId = unitId;
	}

	public Integer getBillDay() {
		return billDay;
	}

	public void setBillDay(Integer billDay) {
		this.billDay = billDay;
	}

	public Integer getRepayDay() {
		return repayDay;
	}

	public void setRepayDay(Integer repayDay) {
		this.repayDay = repayDay;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	@Override
	public String toString() {
		return "BillDto [userId=" + userId + ", accountId=" + accountId + ", balance=" + balance + ", unitId=" + unitId
				+ ", billDay=" + billDay + ", repayDay=" + repayDay + ", accountName=" + accountName + ", unitName="
				+ unitName + "]";
	}

	
	
}
