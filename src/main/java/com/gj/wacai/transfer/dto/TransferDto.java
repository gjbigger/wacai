package com.gj.wacai.transfer.dto;

import com.gj.wacai.transfer.pojo.Transfer;

public class TransferDto extends Transfer{

	private String srcAccountName;
	private String destAccountName;
	
	public TransferDto() {
		// TODO Auto-generated constructor stub
	}

	public String getSrcAccountName() {
		return srcAccountName;
	}

	public void setSrcAccountName(String srcAccountName) {
		this.srcAccountName = srcAccountName;
	}

	public String getDestAccountName() {
		return destAccountName;
	}

	public void setDestAccountName(String destAccountName) {
		this.destAccountName = destAccountName;
	}

	@Override
	public String toString() {
		return "TransferDto [srcAccountName=" + srcAccountName + ", destAccountName=" + destAccountName + "]";
	}
	
	
}
