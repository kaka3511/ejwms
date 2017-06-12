<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<%@ include file="../../base/importJs.jsp"%>

<style type="text/css">

ody.dragging, body.dragging * {
  cursor: move !important;
}

.dragged {
  position: absolute;
  opacity: 0.5;
  z-index: 2000;
}

ol.example li.placeholder {
  position: relative;
  /** More li styles **/
}
ol.example li.placeholder:before {
  position: absolute;
  /** Define arrowhead **/
}
</style>
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>健康测评试题</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">

			<form class="form-inline">
				<div class="form-group">
					<label>题目类型：</label> 
					<select id="query_type" class="form-control">
						<option value="">所有</option>
						<option value="1">精神状态测评</option>
						<option value="2">危险度评测</option>
					</select> 
					
				</div>
<%-- 					<a class='btn btn-primary pull-right' href="<c:url value='/question/view/healthTestPaper?oper=add'/>">添加题目</a> --%>
			</form>
			

		</div>
		<div class="panel-body">
			<div>
				<table id="jqGrid"></table>
				<div id="jqGridPager"></div>
			</div>
		</div>
	</div>
	
</body>

<script type="text/javascript">
	$(function() {
		var currentQuestionHealthTestPage = getOneSessionStorageValue("currentQuestionHealthTestPage");
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid").jqGrid({
			//url : "<c:url value='/question/list?qbType=2'/>",
			url : "<c:url value='/question/list2'/>",
			// we set the changes to be made at client side using predefined word clientArray
			editurl : 'clientArray',
			mtype: 'POST',
	        datatype: "json",
	        page:currentQuestionHealthTestPage,
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
			}, {
				label : '问题标题',
				name : 'question',
			},
			/* {
				label: '题库类型',
			    name: 'questiontype',
			    width:100,
			    formatter:'select', 
			    editoptions:{value:"1:游戏问题;2:健康评测"},
			}, */
			{
				label : '题目类型',
				name : 'type',
				width : 100,
				formatter : 'select',
				editoptions : {
					value : "1:精神状态测评;2:危险度评测"
				},

			}, {
				label : '操作',
				name : 'operation',
				width : 100,
				editable : false,
				search : false,
				formatter : operFormat,
				unformat : operUnFormat

			} ],
			gridComplete : function() {
				$('td .del').off('click',del);
				$('td .del').on('click',del);
			},
			loadonce : false,
			viewrecords : true,
			height:$(window).height()-$('.panel-body').offset().top-80,
			autowidth : true,
			rownumbers : true,
			rownumWidth : 50,
			rowNum : 10,
			pager : "#jqGridPager"
		});
		function del(event) {
			event.preventDefault();
			if(confirm("确认删除该条记录吗？")){
				var href = $(this).attr('href');
				$.ajax({
					url : href,
					dataType : 'json',
					type : 'get',
					success : function(data, textStatus, jqXHR) {
						alert("删除成功！");
						$("#jqGrid").delRowData(data.data);
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("删除失败,请稍后再试！");
					}
				});
			};
			
		}
		function operFormat(cellvalue, options, rowObject) {
			var currentQuestionHealthTestPage = $(this).jqGrid('getGridParam','page');
			sessionStorage.setItem("currentQuestionHealthTestPage", currentQuestionHealthTestPage);
			return "<div><a class='btn btn-primary edit'  href='<c:url value='/question/view/healthTestPaper?oper=edit&id='/>"
					+ rowObject.id
					+ "'>修改</a>&nbsp;&nbsp;<a class='btn btn-primary del' href='<c:url value='/question/mgr/?qbType=2&oper=del&id='/>"
					+ rowObject.id + "'>删除</a></div>";
		}

		function operUnFormat(cellvalue, options, cell) {
			return "";
		}

		 var f = { groupOp: "AND", rules: [] };
	     $('#query_type').change(function(){
	    	var self = this;
	 		var value = self.value;
	     	var grid = $('#jqGrid');
	     	var field = "type";
	     	var op ="cn";

	     	filter(f,grid,field,op,value);
	     	
	     });
	});
</script>
</html>