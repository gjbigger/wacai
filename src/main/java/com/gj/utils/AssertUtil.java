package com.gj.utils;

public class AssertUtil {

	public static void isTrue(boolean b, String msg) {
		if(b) { 
			throw new ParamsException(msg);
		}
	}
	
	
}
