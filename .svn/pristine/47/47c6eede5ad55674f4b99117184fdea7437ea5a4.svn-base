package com.huaao.common.utilities;

import java.util.ArrayList;
import java.util.List;

public class Filter {

	private GroupOp groupOp;
	private List<Rule> rules = new ArrayList<Rule>();
	private List<Filter> groups = new ArrayList<Filter>();
	public enum DataOp{
		eq("="),ne("!="),lt("<"),le("<="),gt(">"),ge(">="),bw("like '?%'"),bn("not like '?%'"),in("="),ni("!="),ew("like '%?'"),en("not like '%?'"),cn("like '%?%'"),nc("not like '%?%'");
		private String op;
		DataOp(String op){
			this.op = op;
		}
		public String getOp() {
			return op;
		}
	}
	//odata: [{ oper:'eq', text:'等于\u3000\u3000'},{ oper:'ne', text:'不等\u3000\u3000'},{ oper:'lt', text:'小于\u3000\u3000'},{ oper:'le', text:'小于等于'},{ oper:'gt', text:'大于\u3000\u3000'},
	//{ oper:'ge', text:'大于等于'},{ oper:'bw', text:'开始于'},{ oper:'bn', text:'不开始于'},{ oper:'in', text:'属于\u3000\u3000'},{ oper:'ni', text:'不属于'},{ oper:'ew', text:'结束于'},
	//{ oper:'en', text:'不结束于'},{ oper:'cn', text:'包含\u3000\u3000'},{ oper:'nc', text:'不包含'},{ oper:'nu', text:'不存在'},{ oper:'nn', text:'存在'}, {oper:'bt', text:'between'}],
	public enum GroupOp{
		AND,OR;
	}
	
	public GroupOp getGroupOp() {
		return groupOp;
	}
	public void setGroupOp(GroupOp groupOp) {
		this.groupOp = groupOp;
	}
	public List<Rule> getRules() {
		return rules;
	}
	public void setRules(List<Rule> rules) {
		this.rules = rules;
	}
	public List<Filter> getGroups() {
		return groups;
	}
	public void setGroups(List<Filter> groups) {
		this.groups = groups;
	}
	
	public static void buildFilterStr(Filter filter, StringBuilder filterStr) {
		if(filter!=null){
			String groupOp = filter.getGroupOp().name().toLowerCase();
			List<Rule> rules = filter.getRules();
			for (Rule rule : rules) {
				filterStr.append(rule.getField());
				filterStr.append(" ");
				
				DataOp op = rule.getOp();
				String opStr = op.getOp();
				if(op==DataOp.bw||op==DataOp.bn||op==DataOp.ew||op==DataOp.en||op==DataOp.cn||op==DataOp.nc){
					opStr = opStr.replace("?", rule.getData());
					filterStr.append(opStr);
				}else{
					filterStr.append(opStr);
					filterStr.append(rule.getData());
				}
				
				filterStr.append(" ");
				filterStr.append(groupOp);
				filterStr.append(" ");
			}
			List<Filter> groups = filter.getGroups();
			if(rules.size()>0&&groups.size()==0)filterStr.delete(filterStr.length()-4, filterStr.length());
			for (Filter groupFilter : groups) {
				filterStr.append("(");
				buildFilterStr(groupFilter, filterStr);
				filterStr.append(")");
				
			}
		}
	}
}
