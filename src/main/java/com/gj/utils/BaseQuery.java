package com.gj.utils;

public class BaseQuery {
	
	private Integer page = 1;
	private Integer rows = ConstData.PAGE_SIZE;
	
	public BaseQuery() {
		// TODO Auto-generated constructor stub
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	@Override
	public String toString() {
		return "BaseQuery [page=" + page + ", rows=" + rows + "]";
	}
	
}
