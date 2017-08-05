package com.gj.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

public class Md5Util {

	public static String encoding(String str) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("md5");
			return Base64.encodeBase64String(messageDigest.digest(str.getBytes()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void main(String[] args) {
		String a = encoding("abc");
		String b = encoding("aBc");
		System.out.println(a + "--" + b);//大小写不同加密结果也不同
	}
}
