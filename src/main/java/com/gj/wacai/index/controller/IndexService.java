package com.gj.wacai.index.controller;

import org.springframework.stereotype.Service;

import com.gj.utils.AssertUtil;

@Service
public class IndexService {

	
	public void test() {
		AssertUtil.isTrue(true, "抛个异常看看");
	}
}
