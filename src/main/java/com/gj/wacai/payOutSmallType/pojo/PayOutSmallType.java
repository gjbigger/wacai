package com.gj.wacai.payOutSmallType.pojo;

public class PayOutSmallType {

	private Integer id;
	private String name;
	private Integer pid;
	private Integer userId;
	private Integer isValid;
	
	public PayOutSmallType() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
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
		return "PayOutSmallType [id=" + id + ", name=" + name + ", pid=" + pid + ", userId=" + userId + ", isValid="
				+ isValid + "]";
	}
	
	
}
