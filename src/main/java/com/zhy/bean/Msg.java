package com.zhy.bean;

import java.util.HashMap;

public class Msg {

	// 状态码 100表示成功 200表示失败
	private int code;
	private String msg;
	private HashMap<String, Object> extend = new HashMap<String, Object>();

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public HashMap<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(HashMap<String, Object> extend) {
		this.extend = extend;
	}

	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功！");
		return result;
	}

	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("处理失败！");
		return result;
	}

	public Msg add(String key, Object value) {

		this.getExtend().put(key, value);
		return this;
	}
}
