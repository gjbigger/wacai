package com.gj.wacai.loanType.pojo;

public class LoanType {
	
	private Integer id;
	private String name;
	
	public LoanType() {
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

	@Override
	public String toString() {
		return "LoanType [id=" + id + ", name=" + name + "]";
	}
	
	

}
