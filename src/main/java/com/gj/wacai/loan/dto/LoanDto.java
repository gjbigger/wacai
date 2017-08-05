package com.gj.wacai.loan.dto;

import com.gj.wacai.loan.pojo.Loan;

public class LoanDto extends Loan{

	private String accountName;
	private String typeName;
	private String loanBodyAccountName;
	
	public LoanDto() {
		// TODO Auto-generated constructor stub
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

	public String getLoanBodyAccountName() {
		return loanBodyAccountName;
	}

	public void setLoanBodyAccountName(String loanBodyAccountName) {
		this.loanBodyAccountName = loanBodyAccountName;
	}

	@Override
	public String toString() {
		return "LoanDto [accountName=" + accountName + ", typeName=" + typeName + ", loanBodyAccountName="
				+ loanBodyAccountName + "]";
	}
	
	
}
