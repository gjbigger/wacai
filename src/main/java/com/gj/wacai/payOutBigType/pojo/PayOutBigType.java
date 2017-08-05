package com.gj.wacai.payOutBigType.pojo;

public class PayOutBigType {

	private Integer id;
	private String name;
	private Integer userId;
	private Integer isValid;
	
	public PayOutBigType() {
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
		return "PayOutBigType [id=" + id + ", name=" + name + ", userId=" + userId + ", isValid=" + isValid + "]";
	}
	
	

}
