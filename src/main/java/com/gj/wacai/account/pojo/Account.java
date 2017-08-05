package com.gj.wacai.account.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Account {

	private Integer id;
	private Integer typeId;
	private String name;
	private Double balance;
	private Integer unitId;
	private String remark;
	private Integer userId;
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTime;
	
	private Double limits;
	private Integer billDay;
	private Integer repayDay;
	private Integer isValid;

	public Account() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Double getLimits() {
		return limits;
	}

	public void setLimits(Double limits) {
		this.limits = limits;
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

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	@Override
	public String toString() {
		return "Account [id=" + id + ", typeId=" + typeId + ", name=" + name + ", balance=" + balance + ", unitId="
				+ unitId + ", remark=" + remark + ", userId=" + userId + ", createTime=" + createTime + ", updateTime="
				+ updateTime + ", limits=" + limits + ", billDay=" + billDay + ", repayDay=" + repayDay + ", isValid="
				+ isValid + "]";
	}

}
