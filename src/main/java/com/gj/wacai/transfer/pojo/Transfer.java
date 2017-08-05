package com.gj.wacai.transfer.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Transfer {

	private Integer id;
	private Integer srcAccountId;
	private Integer destAccountId;
	private Double srcMoney;
	private Double destMoney;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date time;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private String remark;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTime;
	private Integer userId;
	private Integer isValid;
	
	public Transfer() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSrcAccountId() {
		return srcAccountId;
	}

	public void setSrcAccountId(Integer srcAccountId) {
		this.srcAccountId = srcAccountId;
	}

	public Integer getDestAccountId() {
		return destAccountId;
	}

	public void setDestAccountId(Integer destAccountId) {
		this.destAccountId = destAccountId;
	}

	public Double getSrcMoney() {
		return srcMoney;
	}

	public void setSrcMoney(Double srcMoney) {
		this.srcMoney = srcMoney;
	}

	public Double getDestMoney() {
		return destMoney;
	}

	public void setDestMoney(Double destMoney) {
		this.destMoney = destMoney;
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
		return "Transfer [id=" + id + ", srcAccountId=" + srcAccountId + ", destAccountId=" + destAccountId
				+ ", srcMoney=" + srcMoney + ", destMoney=" + destMoney + ", time=" + time + ", remark=" + remark
				+ ", createTime=" + createTime + ", updateTime=" + updateTime + ", userId=" + userId + ", isValid="
				+ isValid + "]";
	}
	
	

}
