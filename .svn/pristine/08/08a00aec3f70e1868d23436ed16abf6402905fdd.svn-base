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

</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>通知发布</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">

			<form class="form-inline">
				<div class="form-group">
					<label>通知内容：</label> 
					<input class="form-control" id='query_content'>
					
				</div>
					<a class='btn btn-primary pull-right' href="<c:url value='/notify/view?oper=add'/>">发布通知</a>
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
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid").jqGrid({
			url : "<c:url value='/notify/list'/>",
			// we set the changes to be made at client side using predefined word clientArray
			editurl : 'clientArray',
			datatype : "json",
			jsonReader : {
				root : 'data',
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
				label : '通知内容',
				name : 'content',
			},
			 {
				label : '发送时间',
				name : 'createtime',
				formatter : function(cellvalue, options, rowObject) {

					return ToDate("Y-m-d H:i:s", cellvalue);
				}
			},
			 {
				label : '操作',
				name : 'operation',
				width : 100,
				editable : false,
				search : false,
				formatter : function operFormat(cellvalue, options, rowObject) {
					return "<div><a class='btn btn-primary del' href='<c:url value='/notify/mgr/?oper=del&id='/>"+ rowObject.id + "'>删除</a></div>";
				}

			} ],
			gridComplete : function() {
				$('td .del').off('click',del);
				$('td .del').on('click',del);
			},
			loadonce : true,
			viewrecords : true,
			height:$(window).height()-$('.panel-body').offset().top-80,
			shrinkToFit : true,
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

		 var f = { groupOp: "AND", rules: [] };
	     $('#query_content').keyup(function(){
	    	var self = this;
	 		var value = self.value;
	     	var grid = $('#jqGrid');
	     	var field = "content";
	     	var op ="cn";

	     	filter(f,grid,field,op,value);
	     	
	     });
	});
</script>
</html>