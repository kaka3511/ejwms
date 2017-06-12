<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<%@ include file="../../base/importJs.jsp"%>

   	<script>
		//$.jgrid.defaults.width = 780;
		$.jgrid.defaults.responsive = true;
		$.jgrid.defaults.styleUI = 'Bootstrap';
	</script>
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>微档案</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
			<div class='row'>
				<div class="col-xs-6">
						<label>被监护人：</label>
						<label>${pupil }</label>
					
					</div>
					<div class="col-xs-6">
						
						
						<button class='btn btn-success pull-right' onclick="javascript:window.history.back(-1);" >返回</button>
					<a class='btn btn-primary pull-right' href="case/view/?oper=add&id=${pupilId}" >发布病例档案</a>
					</div>
			</div>
					
				
		</div>
		<div class="panel-body">
					    <table id="jqGrid"></table>
					    <div id="jqGridPager"></div>
		</div>
	</div>
	
	
	
</body>

<script type="text/javascript">
$(function() {
	
 	
    
});
</script>
</html>