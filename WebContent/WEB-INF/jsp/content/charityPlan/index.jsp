<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>自助登记</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<%@ include file="../../base/importJs.jsp"%>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>内容管理</li>
		<li>慈善活动</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">
			<form class='form-inline' action="">
				<div class='form-group'>
					<label>标题：</label> <input class='form-control' type='text'
						id='query_title'>
				</div>

				<div class='form-group  pull-right'>
					<a class='btn btn-primary'
						href="<c:url value='/content/charityPlan/add'/>">发布慈善活动信息</a>
				</div>

			</form>

		</div>
		<div class="panel-body">
			<div>
				<table id="jqGrid"></table>
				<div id="jqGridPager"></div>
			</div>
			<!-- <div id="mysearch"></div>
					<button class='btn btn-primary' id='btn_search'>搜索</button>
					<button class='btn btn-primary' id='trigger'>点击</button>   -->

		</div>

	</div>
</body>
<script type="text/javascript">
	$(function() {
		var currentCharityPlanPage = getOneSessionStorageValue("currentCharityPlanPage");
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid").jqGrid({
			url : "<c:url value='/content/listCharity'/>",
			// we set the changes to be made at client side using predefined word clientArray
			editurl : 'clientArray',
			datatype : "json",
			mtype: 'POST',
			page : currentCharityPlanPage,
			jsonReader : {
				root : 'data.rows',
	            records: 'data.records',
	            total: 'data.pages',
	            repeatitems : false,
				
			},
			cmTemplate : {
				align : 'center',
				sortable : false
			},
			colModel : [ {
				label : 'ID',
				name : 'id',
				key : true,
				hidden : true,
				search : false,
			}, {
				label : '标题',
				name : 'title',
				width : 200,
			}, {
				label : '摘要',
				name : 'summary',
				width : 400,
			}, 

			{
				label : '修改时间',
				name : 'updatetime',
				width : 100,
				search : false,
				formatter : function(cellvalue, options, rowObject) {

					return ToDate("Y-m-d H:i:s", cellvalue);
				}
			},

			{
				label : '操作',
				name : 'operation',
				editable : false,
				search : false,
				formatter : operFormat,
				unformat : operUnFormat,
				width:120,

			} ],
			gridComplete:function(){
	        	$('td .del').off("click",del);
	        	$('td .del').on("click",del);
	        },
			loadonce : false,
			viewrecords : true,
			shrinkToFit : true,
			autowidth : true,
			height:$(window).height()-$('.panel-body').offset().top-80,
			rownumbers : true,
			rownumWidth : 50,
			rowNum : 10,
			pager : "#jqGridPager"
		});
		function del(event){
			event.preventDefault();
			if(confirm("确定删除吗？")){
				var href = $(this).attr('href');
				$.ajax({
					url:href,
					dataType:'json',
					type:'get',
					success:function(data, textStatus, jqXHR){
						alert("删除成功！");
						$("#jqGrid").delRowData(data.data);
					},
					error:function( jqXHR, textStatus, errorThrown){
						alert("删除失败！");
					}
				});
			}
			
		}
		function operFormat(cellvalue, options, rowObject) {
			var currentCharityPlanPage = $(this).jqGrid('getGridParam','page');
			sessionStorage.setItem("currentCharityPlanPage", currentCharityPlanPage); 
			if (rowObject.type == 2) {
				return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/charityPlan/edit/'/>"
						+ rowObject.id
						+ "'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"
						+ rowObject.id
						+ "'>删除</a>&nbsp;&nbsp;<a class='btn btn-primary ' href='<c:url value='/content/downloadQRCode/'/>"
						+ rowObject.id + "'>下载二维码</a></div>";
			} else {
				return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/charityPlan/edit/'/>"
						+ rowObject.id
						+ "'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"
						+ rowObject.id + "'>删除</a></div>";
			}

		}

		function operUnFormat(cellvalue, options, cell) {
			return "";
		}
		var f = {
			groupOp : "AND",
			rules : []
		};
		var timer;
		$('#query_title').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "title";
			var op = "cn";

			if (timer) {
				clearTimeout(timer);
			}
			timer = setTimeout(function() {
				//timer = null;
				filter(f, grid, field, op, value);
			}, 0);
			var query_title = value;
			
			query_title = escape(query_title);
			setCookie("query_title4", query_title, 0.1);

		});

		//再显示查询条件  
		
		{
				var query_title = getCookie('query_title4');

				//cookie中文编码问题 
				query_title = unescape(key_query);
				
				if(query_title != "" || query_title!= null || query_title!= undefined)
					$('#query_type').val(query_title);
			}

	});
</script>
<!-- END BODY -->

</html>