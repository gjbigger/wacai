package com.gj.wacai.payOut.dto;

import com.gj.wacai.payOut.pojo.PayOut;

public class PayOutDto extends PayOut{

	private String bigTypeName;
	private String smallTypeName;
	private String accountName;
	
	public PayOutDto() {
		// TODO Auto-generated constructor stub
	}

	public String getBigTypeName() {
		return bigTypeName;
	}

	public void setBigTypeName(String bigTypeName) {
		this.bigTypeName = bigTypeName;
	}

	public String getSmallTypeName() {
		return smallTypeName;
	}

	public void setSmallTypeName(String smallTypeName) {
		this.smallTypeName = smallTypeName;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	@Override
	public String toString() {
		return "PayOutDto [bigTypeName=" + bigTypeName + ", smallTypeName=" + smallTypeName + ", accountName="
				+ accountName + "]";
	}
	
	
	
}
