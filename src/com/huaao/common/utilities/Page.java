package com.huaao.common.utilities;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.jdbc.core.JdbcTemplate;

@SuppressWarnings("unchecked")
public class Page {
	
	
	public enum DataOp{
		eq("="),ne("!="),lt("<"),le("<="),gt(">"),ge(">=");
		private String op;
		DataOp(String op){
			this.op = op;
		}
		public String getOp() {
			return op;
		}
	}

	//记录总数
	private int totalRows;
	//总页数
	private int totalPages;
	
	//起始行数
	private int startIndex;
	//结束行数
	private int lastIndex;
	//结果集存放List
	private List<Map<String, Object>> resultList;
	
	//排序
	private String order;
	
	//排序方式
	private String sort;
	
	private boolean             enablePagination     = false;                         // 分页启用开关
	
	//当前页码页面数
	private int                 currentPage          = 1;                            // 当前页
	
	private int                 pageSize             = 20;   // 每页显示记录数
	
	private String       		pramaStr;    //参数
	
	private String				countSql;    //部分特殊地方，需要用自己的统计语句。
	
	private String				countSqlConditions;
	
	/***
	 * 构造方法,获取参数
	 * @param request
	 */
	public Page(HttpServletRequest request) {
        String sortProperty = null, order = null;
        Set<String> excludesProperties = new HashSet<String>();
        
        for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
            String property = e.nextElement().toString();
            String value = request.getParameter(property);
            if (excludesProperties.contains(property)) {
                continue;
            }
            if (!StringUtils.isEmpty(value)) {
                if ("page".equals(property)) {
                    setCurrentPage(Integer.parseInt(value));
                } else if ("rows".equals(property)) {
                    setPageSize(Integer.parseInt(value));
                } else if ("sort".equals(property) || "sord".equals(property)) {
                    sortProperty = value;
                } else if ("order".equals(property) || "sidx".equals(property)) {
                    order = value;
                } else if ("filters".equals(property)){
                	Filter filter = null;
            		if(StringUtils.isNotBlank(property)){
            			ObjectMapper mapper = new ObjectMapper();
            			try {
            				filter = mapper.readValue(value, Filter.class);
            			} catch (JsonParseException e1) {
            				e1.printStackTrace();
            			} catch (JsonMappingException e1) {
            				e1.printStackTrace();
            			} catch (IOException e1) {
            				e1.printStackTrace();
            			}
            		}
            		StringBuilder filterStr  = new StringBuilder();
            		Filter.buildFilterStr(filter, filterStr);
            		
            		setPramaStr(filterStr.toString());
            		
                }
            }
        }
        
        if (StringUtils.isEmpty(order)) {
        	sortProperty = null;
        }
        
        setOrder(order);
        setSort(sortProperty);
        
    }
	
	
	
	
//	boolean hasProperty(String propName) {
//        return m_metaClass.hasGetter(propName);
//  }
	
	/***
	 * 分页
	 * @param sql
	 * @param jTemplate
	 */
	public void getPageData(String sql, JdbcTemplate jTemplate) {
		if(jTemplate == null){
			throw new IllegalArgumentException("Page.jTemplate is null");
		}else if(sql == null || sql.equals("")){
			throw new IllegalArgumentException("Page.sql is empty");
		}
		
		
		//计算总记录数
		StringBuffer totalSQL = new StringBuffer(" SELECT count(*) FROM ( ");
		
		//如果存在统计语句时，就使用统计语句
		if (StringUtils.isNotBlank(countSql)) {
			totalSQL.append(countSql);
		} else {
			//如果 不存在统计语句，就直接统计查询语句结果
			totalSQL.append(sql);
		}
		
		
		
		StringBuffer paginationSQL = new StringBuffer();
		paginationSQL.append(sql);
		
		if (StringUtils.isNotBlank(pramaStr)) {
			if (pramaStr.trim().indexOf("and") != 0) {
				pramaStr = " and "+ pramaStr;
			}
			totalSQL.append(pramaStr);
			paginationSQL.append(pramaStr);
		}
		
		totalSQL.append(" ) totals ");
		
		//总记录数
		setTotalRows(jTemplate.queryForInt(totalSQL.toString()));
		
		//计算总页数
		setTotalPages();
		//计算起始行数
		setStartIndex();
		//计算结束行数
		setLastIndex();
		
		//使用mysql时直接使用limits
		
		
		if (StringUtils.isNotBlank(order)) {
			paginationSQL.append(" order by " +order);
			if (StringUtils.isNotBlank(sort)) { 
				paginationSQL.append(" " +sort);
			}
			
		}
		
		paginationSQL.append(" limit " + startIndex + "," + pageSize);
		//装入结果集
		setResultList(jTemplate.queryForList(paginationSQL.toString()));
	}
	
	/***
	 * 分页（带查询条件）
	 * @param sql
	 * @param jTemplate
	 */
	public void getPageDataWithConditions(String sql, JdbcTemplate jTemplate, String additions){
		if(jTemplate == null){
			throw new IllegalArgumentException("Page.jTemplate is null");
		}else if(sql == null || sql.equals("")){
			throw new IllegalArgumentException("Page.sql is empty");
		}
		
		
		//计算总记录数
		StringBuffer totalSQL = new StringBuffer(" SELECT count(*) FROM ( ");
		
		//如果存在统计语句时，就使用统计语句
		if (StringUtils.isNotBlank(countSql)) {
			totalSQL.append(countSql);
		} else {
			//如果 不存在统计语句，就直接统计查询语句结果
			totalSQL.append(sql);
		}
		
		
		
		StringBuffer paginationSQL = new StringBuffer();
		paginationSQL.append(sql);
		if (StringUtils.isNotBlank(pramaStr)) {
			if (pramaStr.trim().indexOf("and") != 0) {
				pramaStr = " and "+ pramaStr;
			}
			//如果没有关键字搜索，则直接加入模糊匹配
//			if((pramaStr.trim().charAt(pramaStr.trim().length()-2)=='=')){
//				StringBuffer temp = new StringBuffer(pramaStr);
//				temp.insert((pramaStr.trim().length()), "'%%'");
//				pramaStr = temp.toString();
//			}
			totalSQL.append(pramaStr);
			paginationSQL.append(pramaStr);
		}
		
		totalSQL.append(" "+additions+" ) totals ");
		
		//总记录数
		setTotalRows(jTemplate.queryForInt(totalSQL.toString()));
		//计算总页数
		setTotalPages();
		//计算起始行数
		setStartIndex();
		//计算结束行数
		setLastIndex();
		
		//使用mysql时直接使用limits
		
		
//		if (StringUtils.isNotBlank(order)) {
//			paginationSQL.append(" order by " +order);
//			if (StringUtils.isNotBlank(sort)) { 
//				paginationSQL.append(" " +sort);
//			}
//			
//		}
		
		
		paginationSQL.append(additions);
		paginationSQL.append(" limit " + startIndex + "," + pageSize);
		//装入结果集
		setResultList(jTemplate.queryForList(paginationSQL.toString()));
	}
	
	
	
	public List<Map<String, Object>> getResultList() {
		return resultList;
	}
	
	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}
	
	public int getTotalPages() {
		return totalPages;
	}
	
	//计算总页数
	public void setTotalPages() {
		if(totalRows % pageSize == 0){
			this.totalPages = totalRows / pageSize;
		}else{
			this.totalPages = (totalRows / pageSize) + 1;
		}
	}
	
	public int getTotalRows() {
		return totalRows;
	}
	
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	
	public int getStartIndex() {
		return startIndex;
	}
	
	public void setStartIndex() {
		this.startIndex = (currentPage - 1) * pageSize;
	}
	
	public int getLastIndex() {
		return lastIndex;
	}

	//计算结束时候的索引
	public void setLastIndex() {
//		System.out.println("totalRows="+totalRows);
//		System.out.println("numPerPage="+rows);
		if ( totalRows < pageSize){
			this.lastIndex = totalRows;
		} else if((totalRows % pageSize == 0) || (totalRows % pageSize != 0 && currentPage < totalPages)){
			this.lastIndex = currentPage * pageSize;
		} else if(totalRows % pageSize != 0 && currentPage == totalPages){//最后一页
			this.lastIndex = totalRows ;
		}
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	
	public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
        if (this.currentPage <= 0) this.currentPage = 1;
    }


	public boolean isEnablePagination() {
		return enablePagination;
	}


	public void setEnablePagination(boolean enablePagination) {
		this.enablePagination = enablePagination;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getCurrentPage() {
		return currentPage;
	}


	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}


	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}


	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}




	public String getPramaStr() {
		return pramaStr;
	}




	public void setPramaStr(String pramaStr) {
		this.pramaStr = pramaStr;
	}
	
	/**
	 * 如果是添加判断条件
	 * @param pramaStr
	 */
	public void appendPramaStr(String pramaStr) {
		
		if (StringUtils.isNotBlank(this.pramaStr)) {
			this.pramaStr = this.pramaStr + pramaStr;
		} else {
			this.pramaStr = pramaStr;
		}
		
	}
	


	public String getCountSql() {
		return countSql;
	}




	public void setCountSql(String countSql) {
		this.countSql = countSql;
	}




	public String getCountSqlConditions() {
		return countSqlConditions;
	}




	public void setCountSqlConditions(String countSqlConditions) {
		this.countSqlConditions = countSqlConditions;
	}
	
	
	

	


}
