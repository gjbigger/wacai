package com.gj.utils;

import java.util.List;

public class PageModel<T> {

	private Integer currPage;		//当前页
	private Long recordsCount;		//总记录数
	private List<T> records;		//具体的记录
	private Integer pages;			//总页数
	private Boolean hasPrePage;		//是否有上一页
	private Boolean hasNextPage;	//是否有下一页
	private Integer startPage;		//开始页
	private Integer endPage;		//结束页
	
	public PageModel() {
		// TODO Auto-generated constructor stub
	}
	
	public PageModel(Integer currPage, Long recordsCount, List<T> records) {
		this.currPage = currPage;
		this.recordsCount = recordsCount;
		this.records = records;
		
		//总记录+页面显示数量-1，除以页面显示数量，得到总页数
		pages =  (int) ((this.recordsCount+ConstData.PAGE_SIZE-1) / ConstData.PAGE_SIZE);
		//如果当前页不是第一页，就有上一页
		if(this.currPage.equals(1)) {
			hasPrePage = false;
		} else {
			hasPrePage = true;
		}
		//如果当前页不是最后一页，就有下一页
		if(this.currPage.equals(pages)) {
			hasNextPage = false;
		} else {
			hasNextPage = true;
		}
		//如果当前页-2得到数小于1，起始页为1，再判断总页数，如果总页数大于5，结束页就是5,否则就是pages
		if(this.currPage-2 < 1) {
			startPage = 1;
			if(pages > 5) {
				endPage = 5;
			} else {
				endPage = pages;
			}
		} else {
			startPage = this.currPage-2;
			if(this.currPage+2 > pages) {
				endPage = pages;
			} else {
				endPage = this.currPage+2;
			}
		}
	}

	public Integer getCurrPage() {
		return currPage;
	}
	public void setCurrPage(Integer currPage) {
		this.currPage = currPage;
	}
	public Long getRecordsCount() {
		return recordsCount;
	}
	public void setRecordsCount(Long recordsCount) {
		this.recordsCount = recordsCount;
	}
	public List<T> getRecords() {
		return records;
	}
	public void setRecords(List<T> records) {
		this.records = records;
	}
	public Integer getPages() {
		return pages;
	}
	public void setPages(Integer pages) {
		this.pages = pages;
	}
	public Boolean getHasPrePage() {
		return hasPrePage;
	}
	public void setHasPrePage(Boolean hasPrePage) {
		this.hasPrePage = hasPrePage;
	}
	public Boolean getHasNextPage() {
		return hasNextPage;
	}
	public void setHasNextPage(Boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}
	public Integer getStartPage() {
		return startPage;
	}
	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}

	@Override
	public String toString() {
		return "PageModel [currPage=" + currPage + ", recordsCount=" + recordsCount + ", records=" + records
				+ ", pages=" + pages + ", hasPrePage=" + hasPrePage + ", hasNextPage=" + hasNextPage + ", startPage="
				+ startPage + ", endPage=" + endPage + "]";
	}
	
	
}
