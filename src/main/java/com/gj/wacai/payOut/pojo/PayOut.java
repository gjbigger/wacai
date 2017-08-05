package com.gj.wacai.payOut.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class PayOut {
	
	private Integer id;
	private Double money;
	private Integer bigTypeId;
	private Integer smallTypeId;
	private Integer accountId;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date time;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTime;
	private String remark;
	private Integer userId;
	private Integer isValid;
	
	public PayOut() {
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

	public Integer getBigTypeId() {
		return bigTypeId;
	}

	public void setBigTypeId(Integer bigTypeId) {
		this.bigTypeId = bigTypeId;
	}

	public Integer getSmallTypeId() {
		return smallTypeId;
	}

	public void setSmallTypeId(Integer smallTypeId) {
		this.smallTypeId = smallTypeId;
	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
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

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	@Override
	public String toString() {
		return "PayOut [id=" + id + ", money=" + money + ", bigTypeId=" + bigTypeId + ", smallTypeId=" + smallTypeId
				+ ", accountId=" + accountId + ", time=" + time + ", createTime=" + createTime + ", updateTime="
				+ updateTime + ", remark=" + remark + ", userId=" + userId + ", isValid=" + isValid + "]";
	}
	
	


}
