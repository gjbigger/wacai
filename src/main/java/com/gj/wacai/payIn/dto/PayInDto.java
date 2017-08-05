package com.gj.wacai.payIn.dto;

import com.gj.wacai.payIn.pojo.PayIn;

public class PayInDto extends PayIn{

	private String typeName;
	private String accountName;
	
	public PayInDto() {
		// TODO Auto-generated constructor stub
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	@Override
	public String toString() {
		return "PayInDto [typeName=" + typeName + ", accountName=" + accountName + "]";
	}
	
	
}
