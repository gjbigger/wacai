package com.gj.wacai.loan.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Loan {

	private Integer id;
	private Double money;
	private Integer typeId;
	private Integer accountId;
	private Integer loanBodyAccountId;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date time;
	private String remark;
	private Integer userId;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTime;
	private Integer isValid;
	
	public Loan() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public Integer getLoanBodyAccountId() {
		return loanBodyAccountId;
	}

	public void setLoanBodyAccountId(Integer loanBodyAccountId) {
		this.loanBodyAccountId = loanBodyAccountId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	@Override
	public String toString() {
		return "Loan [id=" + id + ", money=" + money + ", typeId=" + typeId + ", accountId=" + accountId
				+ ", loanBodyAccountId=" + loanBodyAccountId + ", time=" + time + ", remark=" + remark + ", userId="
				+ userId + ", createTime=" + createTime + ", updateTime=" + updateTime + ", isValid=" + isValid + "]";
	}

	

}
