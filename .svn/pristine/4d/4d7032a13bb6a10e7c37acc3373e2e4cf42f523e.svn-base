<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<%@ include file="../../base/importImgJs.jsp"%>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>系统设置</li>
		<li>轮播图管理</li>
	</ul>
	<div class="row">
		<div class="col-sm-6">
			<div class="panel panel-info">
				<div class="panel-heading clearfix">
					<a class='pull-right ' href="" id="btn_upload" onclick='$(".content_right").load("${ctx}/carousel/form/add");return false;'>添加轮播图</a>

				</div>
				<div class="panel-body">
					<table id="jqGrid"></table>
					<div id="jqGridPager"></div>
				</div>
			</div>
		</div>
		<div class="col-sm-6 content_right">
		</div>
	</div>
<div class="modal fade" id="imgModal" tabindex="-1" role="dialog" style='overflow: hidden;'>
		 <div class="modal-dialog modal-lg" >
		 </div>
		
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var currentcarouselIndexPage = getOneSessionStorageValue("currentcarouselIndexPage");
		$(window).resize(function() {
			var h = $(window).height() - $('.panel-body').offset().top;
			$("#jqGrid").setGridHeight(h - 80);
		});
		
		$('.modal').on('mousewheel', function(e) {
			var minHeight = 150; // min height
			var tempStep = 10; // evey step for scroll down or up
			zoom(e, $('.modal img'), minHeight, tempStep);
		});
		$('#imgModal .modal-dialog').click(function() {
			$('#imgModal ').modal('hide');
		});
		$('#imgModal')
				.on(
						'show.bs.modal',
						function(e) {
							var img = $("<img class='center-block' style='position:relative'/>");
							var src = $(e.relatedTarget).data('src');
							img.attr('src', src);
							img.draggable({
								cursor : 'move',
								scroll : false,
							});

							$('#imgModal .modal-dialog img').remove();
							$('#imgModal .modal-dialog').append(img);

						});
		$("#jqGrid")
				.jqGrid(
						{
							url : "<c:url value='/carousel/list'/>",
							// we set the changes to be made at client side using predefined word clientArray
							editurl : 'clientArray',
							datatype : "json",
							mtype: 'POST',
							page :currentcarouselIndexPage,
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
										search : false,
									},
									{
										label : '轮播图',
										name : 'dictionary_img',
										formatter : function(cellvalue,
												options, rowObject) {
											var img = "<ul class='dowebok'><li><img class='img-rounded' style='width:34px;height:34px;cursor:pointer;' src='"
													+ (rowObject.dictionary_img ? rowObject.dictionary_img
															: '../images/idcard_default_290_186.png')  
													+ "'/></li></ul>";
											return img;
										}
									},
									{
										label : '排序',
										name : 'dictionary_order',
										width:50
									},
									{
										label : '名称',
										name : 'dictionary_name',
									},
									/* {
										label : '编码',
										name : 'dictionary_code',
									},
									{
										label : '值',
										name : 'dictionary_value',
									}, */
									{
										label : '更新时间',
										name : 'updatetime',
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											var cell = 0;
											if ((cellvalue + "").length > 10) {
												cell = cellvalue / 1000;
											} else {
												cell = cellvalue;
											}
											return ToDate("Y/m/d", cell);
										}
									},

									{
										label : '操作',
										name : 'operation',
										editable : false,
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											var currentcarouselIndexPage = $(this).jqGrid('getGridParam','page');
											sessionStorage.setItem("currentcarouselIndexPage", currentcarouselIndexPage); 
											/* var tpl = $("<div><a class='btn btn-primary edit'  href='<c:url value='/carousel/form/update?id='/>"+rowObject.id+"'>修改</a><a class='btn btn-primary del' data-id='"+rowObject.id+"' onclick='del(this);'>删除</a></div>"); */
											var tpl = $("<div><a class='btn btn-primary edit' data-id='"
													+ rowObject.id
													+ "' onclick='update(this)'>修改</a><a class='btn btn-primary del' data-id='"
													+ rowObject.id
													+ "' onclick='del(this);'>删除</a></div>");
											return tpl[0].outerHTML;

										},
										width : 120,

									} ],
							loadonce : false,
							viewrecords : true,
							height : $(window).height()- $('.panel-body').offset().top - 80,
							autowidth : true,
							rownumbers : true,
							rownumWidth : 50,
							rowNum : 10,
							pager : "#jqGridPager",
					        gridComplete: function(){
					        	$('.dowebok').viewer();
					        }
						});
		var h = $(window).height() - $('.panel-body').offset().top;
		$("#jqGrid").setGridHeight(h - 80);
		update = function(me) {
			var id = $(me).data("id");
			$(".content_right").load(
					"${ctx}/carousel/form/update?id=" + id );
		}
		del = function(me) {
			var id = $(me).data("id");
			BootstrapDialog.confirm({
				title : '警告',
				message : '确认删除吗?',
				type : BootstrapDialog.TYPE_WARNING, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
				closable : true, // <-- Default value is false
				draggable : true, // <-- Default value is false
				btnCancelLabel : '取消', // <-- Default value is 'Cancel',
				btnOKLabel : '确定', // <-- Default value is 'OK',
				btnOKClass : 'btn-warning', // <-- If you didn't specify it, dialog type will be used,
				callback : function(result) {
					// result will be true if button was click, while it will be false if users close the dialog directly.
					if (result) {
						$.ajax({
							url : "<c:url value='/carousel/del/'/>" + id,
							dataType : 'json',
							type : 'get',
							success : function(data, textStatus, jqXHR) {
								BootstrapDialog.alert("删除成功！");

								$("#jqGrid").delRowData(id);
							},
							error : function(jqXHR, textStatus, errorThrown) {
								BootstrapDialog.alert("删除失败,请稍后再试！");
							}
						});
					}
				}
			});
		}

	});
</script>
<!-- END BODY -->

</html>
