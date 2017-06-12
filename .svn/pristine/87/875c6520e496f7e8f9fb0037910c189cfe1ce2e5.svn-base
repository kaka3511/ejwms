<%@page import="com.huaao.common.extension.DateTimeUtil"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>警情信息-警情信息</title>
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>

<style type="text/css">
.ui-jqgrid .ui-jqgrid-bdiv {
	overflow: hidden;
}

.table tbody tr.active:hover  td, .table tbody tr.active:hover  th {
	background-color: #dff0d8 !important;
}

.ui-jqgrid-hbox .ui-jqgrid-labels {
	background-color: rgb(52, 153, 219);
}

.ui-jqgrid-hbox .ui-jqgrid-labels   .active {
	background-color: rgb(52, 153, 219);
}

.form-horizontal label {
	text-align: right;
}

.modal-dialog {
	z-index: 10050;
}
.note-editor .btn[data-event="codeview"]{
display: none;
}

#gview_jqGrid .ui-jqgrid-bdiv {
	height: 550px !important;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<%@ include file="../../base/importJs.jsp"%>
<!-- END PAGE LEVEL SCRIPTS -->

<link rel="stylesheet"
	href="plugins/bootstrap-datetimepicker/css/datetimepicker.css">
<link rel="stylesheet"
	href="plugins/summernote-develop/dist/summernote.css">

<script type="text/javascript"
	src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript"
	src="plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript"
	src='plugins/summernote-develop/dist/summernote.js'></script>
<script type="text/javascript"
	src='plugins/summernote-develop/lang/summernote-zh-CN.js'></script>
<script type="text/javascript" src='plugins/jquery.form.js'></script>

<script type="text/javascript"
	src="http://webapi.amap.com/maps?v=1.3&key=9b5fc4b54aada032211000047d875f65&plugin=AMap.Geocoder"></script>

<style type="text/css">
.datetimepicker table td {
	font-family: 'Microsoft YaHei' !important;
}

td .day {
	font-family: 'Microsoft YaHei' !important;
}

.datepicker table td {
	font-family: 'Microsoft YaHei' !important;
}

.datepicker table th {
	font-family: 'Microsoft YaHei' !important;
}

.datetimepicker table th {
	font-family: 'Microsoft YaHei' !important;
}

.gritter-title {
	font-family: 'Microsoft YaHei' !important;
}

.portlet .calendar .fc-text-arrow {
	font-family: 'Microsoft YaHei' !important;
}
</style>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>发布慈善活动信息</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">发布慈善活动信息</div>
		<div class="panel-body">
			<%
				String start = DateTimeUtil.getNow();
				String end = DateTimeUtil.getNow();
			%>
			<input type="file" id='choose_img' style="display: none">
			<form class="form-horizontal" id="content_form"
				action="<%=basePath%>content/publish" method='post'>
				<div class="form-group">
					<label class="col-xs-2 control-label" for="info_type">信息类型</label>
					<div class="col-xs-2">
						<select class='form-control' id="info_type" name="type"
							readonly="readonly">
							<option value="3" selected="selected">慈善活动</option>
						</select>
					</div>

				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label" for="title">标题</label>
					<div class="col-xs-4">
						<input type="text" class="form-control" name="title"
							placeholder="标题字符数不能超过100">
					</div>
				</div>
				<div class="form-group ">
					<label class="col-xs-2 control-label" for="starttime">活动开始时间</label>
					<div class="col-xs-2 has-feedback">
						<input type='text' class="form-control" name="starttime"
							id="starttime" placeholder="开始时间"></input> <span
							class='glyphicon glyphicon-th form-control-feedback'></span>

					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label" for="endtime">活动结束时间</label>
					<div class="col-xs-2 has-feedback">
						<input type='text' class="form-control" name="endtime"
							id="endtime" placeholder="结束时间"></input> <span
							class='glyphicon glyphicon-th form-control-feedback'></span>

					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">被捐赠人</label>
					<div class="col-xs-2">
						<label class='form-control' id='l_pupil'>未选择被捐赠人</label> <input type="hidden"
							id='pupil' name='pupil'></input> <input type="hidden"
							id='pupilId' name='pupilId'>


					</div>

					<div class='col-xs-2'>
						<button class="btn btn-primary" id="btn_pupil">请选择被捐赠人</button>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">代收人</label>
					<div class="col-xs-2">
						<label class='form-control' id='l_keeper'>未选择代收人</label> <input type="hidden"
							id='keeper' name='keeper'></input> <input type="hidden"
							id='keeperId' name='keeperId'>

					</div>

					<div class='col-xs-2'>
						<button class="btn btn-primary" id="btn_keeper">请选择代收人</button>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">摘要</label>
					<div class="col-xs-4">
						<textarea rows='2' class="form-control" name="summary"
							placeholder="摘要字符数不能超过255"></textarea>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">摘要图片</label>
					<div class="col-xs-10">
						<input type="hidden" name='summary_img' id='summary_img'>
						<img class='img-rounded' src="images/idcard_default_290_186.png"
							style='width: 300px; height: 150px;' />
						<button class='btn btn-primary' id="btn_add_summary_img"
							style='margin-top: 20px; display: block;'>添加摘要图片</button>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-2 control-label" for="content">内容</label>
					<div class="col-xs-8">
						<textarea class="form-control" name="content" id='content'></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-offset-2 col-xs-10">
						<button class="btn btn-primary" id="publish">发布</button>
						<button class="btn btn-success"
							onclick="javascript:window.history.back(-1);return false;">返回</button>
					</div>
				</div>

			</form>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="pupilModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="pupilModalLabel">请选择被监护人</h4>
					</div>
					<div class="modal-body">
						<div class='center-block' style='width: 800px;'>
							<form class='form-inline' style='padding-bottom: 10px;'>
								<div class="form-group">
									<label>类型：</label> <select class='form-control'
										id="type_query">
										<option value="">所有</option>
										<option value="0">精神障碍患者</option>
										<option value="1">残障人士</option>
									</select>
								</div>

								<div class="form-group">
									<label>被监护人：</label> <input class='form-control' type="text"
										id='pupil_query'>
								</div>
							</form>
							<table id="jqGrid"></table>
							<div id="jqGridPager"></div>
						</div>

					</div>
					<!-- <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary">保存</button>
	      </div> -->
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="keeperModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="keeperModalLabel">请选择代收人</h4>
					</div>
					<div class="modal-body">
						<div class='center-block' style='width: 800px;'>
							<form class='form-inline' style='padding-bottom: 10px;'>
								<div class="form-group">
									<label>姓名：</label> <input class='form-control' type='text'
										id="name_query"></input>
								</div>

								<div class="form-group">
									<label>手机号：</label> <input class='form-control' type="text"
										id='cellphone_query'>
								</div>
							</form>
							<table id="jqGridDetails"></table>
							<div id="jqGridPagerDetails"></div>
						</div>

					</div>
					<!--  <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary">保存</button>
	      </div>  -->
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">
	$(function() {

		$("#starttime").datetimepicker({
			language : 'zh-CN',
			format : "yyyy-mm-dd hh:ii:ss"
		}).on('hide', function(ev) {
			var end = $('#endtime').val();
			if (ev.date.valueOf() < new Date(end).valueOf()) {
			}
		});
		$("#endtime").datetimepicker({
			language : 'zh-CN',
			format : "yyyy-mm-dd hh:ii:ss"
		}).on('hide', function(ev) {
			var start = $('#starttime').val();
			if (ev.date.valueOf() < new Date(start).valueOf()) {
			}
		});
		$('#content').summernote({
			height : 400,
			lang : 'zh-CN',
			onImageUpload : function(files, editor, $editable) {
				sendFile(files[0], editor, $editable);
			}
		});
		
		$('#content').code($('#content_ctn').html());
		function sendFile(file, editor, $editable) {
			var filename = false;
			try {
				filename = file['name'];
			} catch (e) {
				filename = false;
			}
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/ejwms/content/uploadImg",
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					//data是返回的hash,key之类的值，key是定义的文件名
					var result = eval('(' + data + ')');
					$('#content').summernote('editor.insertImage', result.img);
				},
			});
		}
		$.validator
				.setDefaults({

					submitHandler : function(form) {
						var content = $('#content').code().trim();
						
						var pupilId = $("#pupilId").val();
						if (!pupilId) {
							alert("请选择被捐赠人!");
							return;
						} 
						
						if (content && content != "<p><br></p>")
						{var options = {
								success : showResponse, // post-submit callback
								dataType : 'json' // 'xml', 'script', or 'json' (expected server response type)
							};

							// post-submit callback
							function showResponse(responseText, statusText, xhr,
									$form) {

								if (responseText.code == 0) {
									alert("添加成功！");
									window.history.back(-1);
								} else {
									alert("添加失败");

								}
							}

							$('#content_form').ajaxSubmit(options);}
						else {
							alert("发布内容不能为空！");
							return false;
						}
						
					},
				});

		$("#content_form")
				.validate(
						{
							onsubmit :true,
							rules : {
								title : {
									required : true,
									maxlength : 100,
								},
								starttime:{
								  required:true,
								  mydate:true,
								 },
								 endtime:{
								  required:true,
								  mydate:true,
								  dateGreat:"#starttime",
								 }, 
								 pupil:{
									required:true 
								 },
								 keeperId:{
										required:true 
								},
								summary : {
									required : true,
									maxlength : 255,
								},
								content : {
									required : true,
								}

							},
							messages : {
								title : {
									required : "标题不能为空",
									maxlength : $.validator
											.format("标题字符长度不能超过{0}")
								},
								 starttime:{
									required:"开始时间不能为空",
									mydate:"时间格式错误",
								},
								endtime:{
								 required:"结束时间不能为空",
								 mydate:"时间格式错误",
								 dateGreat:"结束时间要大于起始时间!"
								}, 
								pupil:{
									required:"被捐赠人不能为空",
								 },
								 keeperId:{
										required:"代收人不能为空",
								},
								summary : {
									required : "概要不能为空",
									maxlength : $.validator
											.format("概要字符长度不能超过{0}")
								},
								content : {
									required : "内容不能为空",
									maxlength : $.validator
											.format("内容字符长度不能超过{0}")
								}
							},
							errorElement : "em",
							errorPlacement : function(error, element) {
								// Add the `help-block` class to the error element
								error.addClass("help-block");

								// Add `has-feedback` class to the parent div.form-group
								// in order to add icons to inputs
								element.parents(".form-group").addClass(
										"has-feedback");

								if (element.prop("type") === "checkbox") {
									error.insertAfter(element.parent("label"));
								} else {
									error.insertAfter(element);
								}

								// Add the span element, if doesn't exists, and apply the icon classes to it.
								if (!element.next("span")[0]) {
									$(
											"<span class='glyphicon glyphicon-remove form-control-feedback'></span>")
											.insertAfter(element);
								}
							},
							success : function(label, element) {
								// Add the span element, if doesn't exists, and apply the icon classes to it.
								if (!$(element).next("span")[0]) {
									$(
											"<span class='glyphicon glyphicon-ok form-control-feedback'></span>")
											.insertAfter($(element));
								}
							},
							highlight : function(element, errorClass,
									validClass) {
								$(element).parents(".form-group").addClass(
										"has-error").removeClass("has-success");
								$(element).next("span").addClass(
										"glyphicon-remove").removeClass(
										"glyphicon-ok");
							},
							unhighlight : function(element, errorClass,
									validClass) {
								$(element).parents(".form-group").addClass(
										"has-success").removeClass("has-error");
								$(element).next("span")
										.addClass("glyphicon-ok").removeClass(
												"glyphicon-remove");
							}
						});
		jQuery.validator.addMethod("mydate", function(value, element) {
			return this.optional(element)
					|| !/Invalid|NaN/.test(new Date(value).toString());
		}, "日期格式不正确");

		jQuery.validator.addMethod("dateGreat", function(value, element,targetEle) {
			console.info(value);
			var time1 = new Date(value).getTime();
			var timeVal = $(targetEle).val();
			var time2 = new Date(timeVal).getTime();
			return this.optional(element)
					|| time1>time2;
		}, "日期格式不正确");
		
		$("#jqGrid")
				.jqGrid(
						{
							url : "<c:url value='/associateMgr/listPupil'/>",
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
							colModel : [
									{
										label : 'ID',
										name : 'id',
										key : true,
										hidden : true,
									},
									{
										label : '被监护人',
										name : 'name',
										width : 200,
									},
									{
										label : '类型',
										name : 'type',
										width : 100,
										formatter : 'select',
										editoptions : {
											value : "0:精神障碍患者;1:残障人士"
										},
									},
									{
										label : '头像',
										name : 'head_img',
										formatter : function(cellvalue,
												options, rowObject) {
											var img = "<img style='width:34px;height:34px;' src='"
													+ (rowObject.head_img ? rowObject.head_img
															: '../images/header_default_96_96.png')
													+ "'/>";
											return img;
											//return "<img src='images/header_img_default.jpg'/>";
										}

									},
									{
										label : '身份证号',
										name : 'idcard',
										width : 100,

									},
									{
										label : '社区',
										name : 'communityid',
										width : 100,
										editable : false,

									},
									{
										label : '操作',
										name : 'operation',
										width : 100,
										editable : false,
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											return "<div><button class='btn btn-primary addPupil' data-rowid='"+rowObject.id+"'>添加</button></div>";
										}

									} ],
							gridComplete : function() {
								$('td .addPupil').off('click', addPupil);
								$('td .addPupil').on('click', addPupil);
							},
							
							loadonce : true,
							viewrecords : true,
							shrinkToFit : true,
							autowidth : true,
							rownumbers : true,
							rownumWidth : 50,
							rowNum : 10,
							pager : "#jqGridPager",
						});
		function addPupil(event) {
			event.preventDefault();
			var grid = $("#jqGrid");
			var pupilId = $(this).data('rowid');
			var row = grid.getRowData(pupilId);

			$('#l_pupil').text(row.name);
			$('#pupil').val(row.name);
			$('#pupilId').val(pupilId);

			jQuery("#jqGridDetails")
					.jqGrid(
							'setGridParam',
							{
								url : "<c:url value='/associateMgr/listAssociatedKeeper/'/>"
										+ pupilId,
								datatype : 'json'
							}); // the last setting is for demo only
			//jQuery("#jqGridDetails").jqGrid('setCaption', '关联的监护人');
			jQuery("#jqGridDetails").trigger("reloadGrid");
			
			
			return false;
		}

		var f = {
			groupOp : "AND",
			rules : []
		};
		$('#type_query').change(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "type";
			var op = "cn";

			filter(f, grid, field, op, value);

		});

		var timer;
		$('#pupil_query').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGrid');
			var field = "name";
			var op = "cn";

			if (timer) {
				clearTimeout(timer);
			}
			timer = setTimeout(function() {
				//timer = null;
				filter(f, grid, field, op, value);
			}, 0);

		});

		var f1 = {
			groupOp : "AND",
			rules : []
		};

		var timer1;
		$('#name_query').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGridDetails');
			var field = "name";
			var op = "cn";

			if (timer1) {
				clearTimeout(timer1);
			}
			timer1 = setTimeout(function() {
				//timer = null;
				filter(f1, grid, field, op, value);
			}, 0);

		});

		var timer2;
		$('#cellphone_query').keyup(function() {
			var self = this;
			var value = self.value;
			var grid = $('#jqGridDetails');
			var field = "cellphone";
			var op = "cn";

			if (timer2) {
				clearTimeout(timer2);
			}
			timer2 = setTimeout(function() {
				//timer = null;
				filter(f1, grid, field, op, value);
			}, 0);

		});

		$("#jqGridDetails")
				.jqGrid(
						{
							url : "clientArray",
							// we set the changes to be made at client side using predefined word clientArray
							/* editurl: 'clientArray', */
							datatype : "local",
							jsonReader : {
								root : 'data',
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
										label : '监护人姓名',
										name : 'name',
										width : 200,
									},
									{
										label : '电话',
										name : 'cellphone',
										width : 100,
									},
									{
										label : '社区',
										name : 'community',
										width : 100,
										editable : false,

									},

									{
										label : '住址',
										name : 'address',
										width : 100,
										editable : false,

									},
									{
										label : '操作',
										name : 'operation',
										width : 100,
										editable : false,
										search : false,
										formatter : function(cellvalue,
												options, rowObject) {
											return "<div><button class='btn btn-primary addKeeper' data-rowid='"+rowObject.id+"'>添加</button></div>";
										}

									} ],

							gridComplete : function() {
								$('td .addKeeper').off('click', addKeeper);
								$('td .addKeeper').on('click', addKeeper);
								
								
							},
							loadComplete:function(data){
								if(data.data){
									var len = data.data.length;
									if(len>0){
										alert("添加被监护人成功！");
										$('#pupilModal').modal('hide');
									}else{
										alert("该被监护人没有绑定监护人，请先绑定监护人！！");
									}
								}
								
							},
							loadonce : true,
							viewrecords : true,

							width : 800,
							shrinkToFit : true,
							autowidth : true,
							rownumbers : true,
							rownumWidth : 50,
							rowNum : 10,
							pager : "#jqGridPagerDetails",
							onSelectRow : function(rowid, status, e) {

							}
						});
		function addKeeper(event) {
			event.preventDefault();

			var grid = $("#jqGridDetails");
			var keeperId = $(this).data('rowid');
			var row = grid.getRowData(keeperId);

			$('#l_keeper').text(row.name);
			$('#keeper').val(row.name);
			$('#keeperId').val(keeperId);
			alert("添加代收人成功！");
			$('#keeperModal').modal('hide');
			return false;
		}

		$("#btn_pupil").click(function(e) {
			e.preventDefault();
			$('#pupilModal').modal('show');
		});
		$("#btn_keeper").click(function(e) {
			e.preventDefault();
			var pupilId = $("#pupilId").val();
			if (!pupilId) {
				alert("请先选中被捐赠人!");
			} else {

				$('#keeperModal').modal('show');
			}
		});

		$('#btn_add_summary_img').click(function(e) {
			e.preventDefault();
			$("#choose_img").click();

		});
		$("#choose_img").change(function(event) {
			if (this.files.length == 1) {
				var file = this.files[0];

				if (file.size < 1024000) {
					var imgParent = $('#btn_add_summary_img').parent();
					var filename = false;
					try {
						filename = file['name'];
					} catch (e) {
						filename = false;
					}
					data = new FormData();
					data.append("file", file);
					$.ajax({
						data : data,
						type : "POST",
						url : "/ejwms/content/uploadImg",
						cache : false,
						contentType : false,
						processData : false,
						success : function(data) {
							//data是返回的hash,key之类的值，key是定义的文件名
							var result = eval('(' + data + ')');
							alert("上传成功！");

							imgParent.children('input').val(result.img);
							imgParent.children('img').attr('src', result.img);
						},
						error : function() {
							alert("上传失败");
						}
					});

				} else {
					alert("图片过大！");
				}
			}
		});

	});
</script>
<!-- END BODY -->

</html>