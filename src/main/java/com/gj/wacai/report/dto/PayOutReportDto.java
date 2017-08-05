package com.gj.wacai.report.dto;

public class PayOutReportDto {

	private Integer month;
	private Double money;
	private String accountName;
	private String typeName;
	
	public PayOutReportDto() {
		// TODO Auto-generated constructor stub
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Override
	public String toString() {
		return "PayInReportDto [month=" + month + ", money=" + money + ", accountName=" + accountName + ", typeName="
				+ typeName + "]";
	}
	
	
}
