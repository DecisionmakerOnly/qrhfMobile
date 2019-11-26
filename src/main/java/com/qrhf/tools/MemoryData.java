package com.qrhf.tools;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

public class MemoryData  {
	private static Map<String, HttpSession> sessionIDMap = new HashMap<String,HttpSession>();
	public static  Map<String, HttpSession> sessionIDMap2 = new HashMap<String, HttpSession>();
	public static Map<String, HttpSession> getSessionIDMap() {
		return sessionIDMap;
	}
	public static void setSessionIDMap(Map<String, HttpSession> sessionIDMap) {
		MemoryData.sessionIDMap = sessionIDMap;
	}
	public static Map<String, HttpSession> getSessionIDMap2() {
		return sessionIDMap2;
	}
	public static void setSessionIDMap2(Map<String, HttpSession> sessionIDMap2) {
		MemoryData.sessionIDMap2 = sessionIDMap2;
	}
	
}
