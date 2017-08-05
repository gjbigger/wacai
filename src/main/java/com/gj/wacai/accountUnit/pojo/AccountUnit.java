package com.gj.wacai.accountUnit.pojo;

public class AccountUnit {

	private Integer id;
	private String name;
	private String abbreviation;
	
	public AccountUnit() {
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

	public String getAbbreviation() {
		return abbreviation;
	}

	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}

	@Override
	public String toString() {
		return "AccountUnit [id=" + id + ", name=" + name + ", abbreviation=" + abbreviation + "]";
	}

}
