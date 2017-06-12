<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>

<%@ include file="../base/taglib.jsp"%>
<%@ include file="../base/importCss.jsp"%>
<%@ include file="../base/importJs.jsp"%>

</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>报警管理</li>
		<li>报警记录</li>
	</ul>
	<div class="panel panel-info col-sm-8">

		<div class="panel-heading">
			<form class='form-inline'  autocomplete="off">
				<div class="form-group">
					<label>报警类型：</label> <select class='form-control' id="query_type">
						<option value="*">全部</option>
						<option value="1">居民报警</option>
						<option value="2">民警举报</option>
						<option value="3">居民举报</option>
					</select>
				</div>
				<div class="form-group">
					<label>处理状态：</label> <select class='form-control'
						id="query_status">
						<option value="*">全部</option>
						<option value="0">未处理</option>
						<option value="1">已处理</option>
					</select>
				</div>
				<!-- <div class="form-group">
								<label>被监护人：</label>
							    <input class='form-control' type="text" id = 'pupil_query'>
							</div> -->
			</form>

		</div>

		<div class="panel-body">
			<table id="jqGrid"></table>
				<div id="jqGridPager"></div>
			
			


		</div>
	</div>
<div class="col-sm-4 right-form">
			
			</div>



</body>

<script type="text/javascript">
	$(function() {
		$(window).resize(function(){
			$("#jqGrid").setGridHeight($(window).height()-$('.panel-body').offset().top-80);
		});
		$("#jqGrid")
				.jqGrid(
						{
							url : "<c:url value='/alert/list'/>",
							// we set the changes to be made at client side using predefined word clientArray
							editurl : 'clientArray',
							datatype : "json",
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
							colModel : [
									{
										label : 'ID',
										name : 'id',
										key : true,
										hidden : true,
									},
									{
										label : '类型',
										name : 'type',
										width:120,
										formatter : 'select',
										editoptions : {
											value : "1:居民报警;2:民警举报;3:居民举报"
										},
									},
									/* {
										label : '报警标题',
										name : 'title',
									}, */
									{
										label : '报警时间',
										name : 'createtime',
										width:180,
										formatter : function(cellvalue,
												options, rowObject) {

											return ToDate("Y-m-d H:i:s",
													cellvalue);
										},
									},
									{
										label : '报警人',
										name : 'apply',
									},
									/* {
										label : '报警记录描述',
										name : 'description',
									},
									{
										label : '地址',
										name : 'address',
									}, */
									{
										label : '状态',
										name : 'status',
										width:100,
										formatter : 'select',
										editoptions : {
											value : "0:未处理;1:已处理"
										},
									},
									{
										label : '处理结果',
										name : 'result',
									},
									{
										label : '处理时间',
										name : 'resulttime',
										formatter : function(cellvalue,
												options, rowObject) {
											if (cellvalue)
												return ToDate("Y-m-d H:i:s",
														cellvalue);
											else
												return "";
										},
									},
									/* {
										label : '委派对象',
										name : 'forward',
									}, */
									{
										label : '操作',
										name : 'operation',
										editable : false,
										width:200,
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											
											/* return "<div><a class='btn btn-primary edit'  href='<c:url value='/alert/view/?oper=show&id='/>"
											+ rowObject.id
											+ "'>查看</a></div>"; */
											
										/* 	if (rowObject.status == 1) {
												return "<div><a class='btn btn-primary edit' href='#' onclick='showAlert("+rowObject.id+");return false;'>查看</a></div>";
											} else {
												return "<div><a class='btn btn-primary edit' href='#' onclick='showAlert("+rowObject.id+");return false;'>查看</a><a class='btn btn-primary edit'  href='#' onclick='handleAlert("+rowObject.id+");return false;'>解除</a><a class='btn btn-primary del' href='#' onclick='delAlert("+rowObject.id+");return false;'>删除</a></div>";
											} 
											 */
											if(rowObject.status!=1){
												return "<div><a class='btn btn-primary edit'  href='#' onclick='handleAlert("+rowObject.id+");return false;'>解除</a><a class='btn btn-primary del' href='#' onclick='delAlert("+rowObject.id+");return false;'>删除</a></div>";
											}else{
												return "<div><a class='btn btn-primary del' href='#' onclick='delAlert("+rowObject.id+");return false;'>删除</a></div>";
											}

										}

									} ],
									 onSelectRow:function(rowid, status, e){
					                	  
					                	  if(rowid != null) {
					                		  $(".right-form").load("<c:url value='/alert/view/?oper=show&id='/>"+rowid);
					  						}	
					                  },
					                  onPaging:function(){
					                  	$(".right-form").html("");
					                  },
							loadonce : false,
							viewrecords : true,
							shrinkToFit : true,
							height:$(window).height()-$('.panel-body').offset().top-80,
							autowidth : true,
							rownumbers : true,
							rownumWidth : 50,
							rowNum : 10,
							pager : "#jqGridPager",

						});
		
		/* window.showAlert=function(id){
			$(".right-form").load("<c:url value='/alert/view/?oper=show&id='/>"+id);
		} */
		
		window.handleAlert=function(id){
			$(".right-form").load("<c:url value='/alert/view/?oper=edit&id='/>"+id);
		}
		
		window.delAlert= function(id){
			if(confirm("确定删除吗？")){
				$.ajax({
					url: "<c:url value='/alert/del/'/>"+id,
					dataType:'json',
					type:'post',
					success:function(data, textStatus, jqXHR){
						alert("删除成功！");
						$("#jqGrid").delRowData(id);
						$(".right-form").html("");
					},
					error:function( jqXHR, textStatus, errorThrown){
						alert("删除失败！");
					}
				});
			}
			
		}

		var f = {
			groupOp : "AND",
			rules : []
		};
		$('#query_status').change(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "status";
				var op = "eq";

				filter(f, grid, field, op, value);

		});

		
		
		$('#query_type').change(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "type";
				var op = "eq";

				filter(f, grid, field, op, value);
				
			
			

		});

		/*  var timer;
		 $('#pupil_query').keyup(function(){
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
		  	var field = "name";
		  	var op = "cn";
		  	
			if(timer) { clearTimeout(timer); }
			timer = setTimeout(function(){
				//timer = null;
				filter(f,grid,field,op,value);
			},0);
		  	
		  });  */

	});
</script>
</html>