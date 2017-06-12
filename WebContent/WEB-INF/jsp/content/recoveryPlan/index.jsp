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
</script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>内容管理</li>
		<li>康复活动</li>
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
						href="<c:url value='/content/recoveryPlan/add'/>">发布康复活动信息</a>
				</div>

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
		var currentRecoveryPlanPage = getOneSessionStorageValue("currentRecoveryPlanPage");
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid").jqGrid({
			url : "<c:url value='/content/listRecovery'/>",
			// we set the changes to be made at client side using predefined word clientArray
			editurl : 'clientArray',
			datatype : "json",
			mtype: 'POST',
			page : currentRecoveryPlanPage,
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
			},
			/* {
				label: '类型',
			    name: 'type',
			    width:100,
			    formatter:'select', 
			    editoptions:{value:"1:办事指南;2:康复活动;3:慈善活动;4:健康计划;5:健康生活;6:健康贴士"},
			    stype:'text', 
			    searchoptions:{
			    	//value:"1:办事指南;2:康复活动;3:慈善活动;4:健康计划;5:健康生活;6:健康贴士"
			    },
			
			}, */
			{
				label : '标题',
				name : 'title',
				width : 200,
			}, {
				label : '摘要',
				name : 'summary',
				width : 400,
			}, {
				label : '预约人数',
				name : 'personnum',
				search : false,
			}, {
				label : '开始时间',
				name : 'starttime',
				search : false,
				formatter : function(cellvalue, options, rowObject) {

					return ToDate("Y-m-d H:i:s", cellvalue);
				},

			},

			{
				label : '结束时间',
				name : 'endtime',
				search : false,
				formatter : function(cellvalue, options, rowObject) {

					return ToDate("Y-m-d H:i:s", cellvalue);
				}
			}
			,

			{
				label : '修改时间',
				name : 'updatetime',
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
				width:280,
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
		function operFormat(cellvalue, options, rowObject) {
			var currentRecoveryPlanPage = $(this).jqGrid('getGridParam','page');
			sessionStorage.setItem("currentRecoveryPlanPage", currentRecoveryPlanPage); 
			if (rowObject.type == 2) {
				return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/recoveryPlan/edit/'/>"
						+ rowObject.id
						+ "'>修改</a>"+(rowObject.personnum>0?"":"<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"
						+ rowObject.id
						+ "'>删除</a>")+"<a class='btn btn-primary ' href='<c:url value='/content/downloadQRCode/'/>"
						+ rowObject.id +"/"+rowObject.title+"-"+new Date().getTime()+ ".png'>下载二维码</a></div>";
			} else {
				return "<div><a class='btn btn-primary edit'  href='<c:url value='/content/recoveryPlan/edit/'/>"
						+ rowObject.id
						+ "'>修改</a>"+(rowObject.personnum>0?"":"<a class='btn btn-primary del' href='<c:url value='/content/del/'/>"
						+ rowObject.id + "'>删除</a>")+"</div>";
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
			setCookie("query_title3", query_title, 0.1);

		});

		//再显示查询条件  
		
		{
				var query_title = getCookie('query_title3');

				//cookie中文编码问题 
				query_title = unescape(key_query);
				
				if(query_title != "" || query_title!= null || query_title!= undefined)
					$('#query_title').val(query_title);
			}
	});
</script>
<!-- END BODY -->

</html>