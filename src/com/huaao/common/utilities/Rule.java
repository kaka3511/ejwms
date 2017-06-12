package com.huaao.common.utilities;

import com.huaao.common.utilities.Filter.DataOp;

public class Rule{
	private String field;
	private DataOp op;
	private String data;
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public DataOp getOp() {
		return op;
	}
	public void setOp(DataOp op) {
		this.op = op;
	}
}
