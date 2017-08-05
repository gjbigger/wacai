package com.gj.wacai.account.dto;

import com.gj.wacai.account.pojo.Account;

public class AccountDto extends Account {

	private String typeName;
	private String unitName;
	private String unitAbbreviation;
	
	public AccountDto() {
		// TODO Auto-generated constructor stub
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getUnitAbbreviation() {
		return unitAbbreviation;
	}

	public void setUnitAbbreviation(String unitAbbreviation) {
		this.unitAbbreviation = unitAbbreviation;
	}

	@Override
	public String toString() {
		return "AccountDto [typeName=" + typeName + ", unitName=" + unitName + ", unitAbbreviation=" + unitAbbreviation
				+ "]";
	}
	
	
	
}
