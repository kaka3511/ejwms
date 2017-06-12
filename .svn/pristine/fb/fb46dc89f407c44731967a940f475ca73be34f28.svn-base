<%@page import="org.springframework.util.StringUtils"%>
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
<title>办事指南-修改</title>
<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>

<style type="text/css">
.form-horizontal label {
	text-align: right;
}

.modal-dialog {
	z-index: 10050;
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
.note-editor .btn[data-event="codeview"]{
display: none;
}
</style>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>修改办事指南</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">修改办事指南</div>
		<div class="panel-body">
			<%
				SqlRowSet content = (SqlRowSet) request.getAttribute("content");
				content.next();

				int type = content.getInt("type");
				Integer subtype = content.getInt("subtype"); 
				
				String typeStr = "办事指南";


				/* String subtypeStr = "";
				if(subtype==1){
					subtypeStr="社区民政业务";
				}else{
					subtypeStr="户籍业务";
				} */
				
				
				Long starttime = content.getLong("starttime");
				Long endtime = content.getLong("endtime");
				String start = starttime == null || starttime == 0
						? DateTimeUtil.getNow()
						: DateTimeUtil.getDateFromObject(starttime);
				String end = endtime == null || endtime == 0
						? DateTimeUtil.getNow()
						: DateTimeUtil.getDateFromObject(endtime);
			%>
			<input type="file" id='choose_img' style="display: none">
			<form class="form-horizontal" id="content_form"
				action="<%=basePath%>content/update" method="post">
				<input type="hidden" value="${id }" name="id">
				
<!-- 				<div class="form-group"> -->
<!-- 					<label class="col-xs-2 control-label" for="info_type">信息类型</label> -->
<!-- 					<div class="col-xs-2"> -->
<%-- 						<p class="form-control-static"><%=typeStr%></p> --%>
<!-- 					</div> -->

<!-- 				</div> -->
				<div class="form-group show" id='ctn_sub_type'>
						    <label class="col-xs-2 control-label" >办事子类型</label>
						    <div class="col-xs-2">
						        <select class="form-control-static" name="subtype" id="subtype"
									style="width: 100%;">
								</select>
						    </div>
						    </div>
				
			    
			  
				<div class="form-group">
					<label class="col-xs-2 control-label" for="title">标题</label>
					<div class="col-xs-4">
						<input type="text" class="form-control" name="title"
							placeholder="标题字符数不能超过100"
							value="<%=content.getString("title")%>">
					</div>
				</div>


				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">摘要</label>
					<div class="col-xs-4">
						<textarea rows='2' class="form-control" name="summary"
							placeholder="摘要字符数不能超过255"><%=content.getString("summary")%></textarea>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-2 control-label" for="summary">摘要图片</label>
					<div class="col-xs-10">
						<input type="hidden" name='summary_img' id='summary_img'
							value='<%=content.getString("summary_img")%>'> <img
							class='img-rounded'
							src='<%=StringUtils.isEmpty(content.getString("summary_img"))
					? "images/idcard_default_290_186.png"
					: content.getString("summary_img")%>'
							style='width: 300px; height: 150px;'>
						<button class='btn btn-primary' id="btn_add_summary_img"
							style='margin-top: 20px; display: block;'>选择摘要图片</button>
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
						<button class="btn btn-primary" id="update">保存</button>
						<button class="btn btn-success"
							onclick="javascript:window.history.back(-1);return false;">返回</button>
					</div>
				</div>

			</form>
		</div>
</div>
		<div id='content_ctn' style='display: none'>
			<%=content.getString("content")%>
		</div>
</body>
<script type="text/javascript">
	$(function() {
		
		var json;
		$.ajax({
			type : "post",//不写此参数默认为get方式提交
			async : false, //设置为同步
			url : "/ejwms/content/getGuideSubtypeByDictionary.do",
			data : '',//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				json=data.data;
			}
		});
		
		var $select = $('#subtype');
		$select.empty();
		$select.append('<option value="">--请选择--</option>');
		for (var i = 0, len = json.length; i < len; i++) {
			$select.append('<option value="'+json[i].value+'">'
					+ json[i].name + '</option>');
		}
		
		$('#subtype').val("<%=subtype%>");
		

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
			height : 300,
			lang : 'zh-CN',
			codeview:false,
			onImageUpload: function(files, editor, $editable) {
				  sendFile(files[0],editor,$editable);
			  }
		});
		$('#content').code($('#content_ctn').html());
		function sendFile(file, editor, $editable){
			var filename = false;
			try{
				filename = file['name'];
			} catch(e){filename = false;}
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data: data,
				type: "POST",
				url: "/ejwms/content/uploadImg",
				cache: false,
				contentType: false,
				processData: false,
				success: function(data) {
					//data是返回的hash,key之类的值，key是定义的文件名
					var result = eval('(' + data + ')'); 
			    	$('#content').summernote('editor.insertImage', result.img);
				},
			});
		}
		/* $('#content').code($("#content_ctn").html());  */

		$.validator
				.setDefaults({
					onfocusout : function(element) {
						if (!this.checkable(element)
								&& (element.name in this.submitted || true)
								&& (element.id != "starttime" && element.id != "endtime")) {
							this.element(element);
						}
					},

					submitHandler : function(form) {
						var content = $('#content').code().trim();
						if (content && content != "<p><br></p>"){
							var options = {
									success : showResponse, // post-submit callback
									dataType : 'json' // 'xml', 'script', or 'json' (expected server response type)
								};

								function showResponse(responseText, statusText, xhr,
										$form) {

									if (responseText.code == 0) {
										alert("修改成功！");
										window.history.back(-1);
									} else {
										alert("修改失败！");

									}
								}
                                 
								$('#content_form').ajaxSubmit(options);
						}else {
							alert("发布内容不能为空！");
							return false;
						}
						
					},
				});

		$("#content_form")
				.validate(
						{
							rules : {
								title : {
									required : true,
									maxlength : 100,
								},
								/*  starttime:{
								  required:true,
								 },
								 endtime:{
								  required:true,
								  mydate:true,
								 }, */
								summary : {
									required : true,
									maxlength : 255,
								},
								subtype : {
									required : true
								},
								content : {
									required : true
								}

							},
							messages : {
								title : {
									required : "标题不能为空",
									maxlength : $.validator
											.format("标题字符长度不能超过{0}")
								},
								/* starttime:{
									equired:"开始时间不能为空",
									date:"时间格式错误",
								},
								endtime:{
								 equired:"结束时间不能为空",
								 date:"时间格式错误",
								}, */
								subtype : {
									required : "子类不能为空"
								},
								summary : {
									required : "概要不能为空",
									maxlength : $.validator
											.format("概要字符长度不能超过{0}")
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
			console.info(value);
			value += ":00";
			return this.optional(element)
					|| !/Invalid|NaN/.test(new Date(value).toString());
		}, "开头必须为字母、数字或下划线，不能以数字开头");

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