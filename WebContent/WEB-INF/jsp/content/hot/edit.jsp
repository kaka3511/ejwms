<%@page import="java.util.ArrayList"%>
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
<title>内容管理-社区动态</title>
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
</style>
<!-- CSS to style the file input field as button and adjust the Bootsdivap progress bars -->
<link rel="stylesheet" href="plugins/blueimp/file-upload/css/jquery.fileupload.css">
<link rel="stylesheet" href="plugins/blueimp/file-upload/css/jquery.fileupload-ui.css">


<style type="text/css">
.files img {
	width: 300px;
	height: 150px;
}


.files .panel-body {
	float: left;
	padding: 15px;
}

.files  .panel-body div {
	position: relative;
}

.files .panel-body button.del {
	position: absolute;
	right: 0px;
	top: 0px;
}

.files  .panel-body .information {
	display: inline-block;
	width: 300px;
	height: 150px;
	position: absolute;
	top: 0px;
	visibility: hidden;
}

.files  .ctn-img:hover .information {
	visibility: visible;
	cursor: pointer;
	background-color: rgba(0, 0, 0, 0.6);
}
</style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>内容管理</li>
		<li>修改社区动态</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">修改社区动态</div>
		<div class="panel-body">
			<%
				SqlRowSet content = (SqlRowSet) request.getAttribute("content");
				content.next();

				int type = content.getInt("type");
// 				 Integer subtype = content.getInt("subtype"); 
				String typeStr = "";
			/* 	switch (type) {
					case 1 :
						typeStr = "办事指南";
						break;
					case 2 :
						typeStr = "康复活动";
						break;
					case 3 :
						typeStr = "慈善活动";
						break;
					case 4 :
						typeStr = "健康计划";
						break;
					case 5 :
						typeStr = "健康生活";
						break;
					case 6 :
						typeStr = "健康贴士";
						break;

				} */

				String subtypeStr = "";
// 				if(type==1)subtypeStr = subtype==1?"社区民政业务":"户籍业务"; 

				
				Long starttime = content.getLong("starttime");
				Long endtime = content.getLong("endtime");
				String start = starttime == null || starttime == 0
						? DateTimeUtil.getNow()
						: DateTimeUtil.getDateFromObject(starttime);
				String end = endtime == null || endtime == 0
						? DateTimeUtil.getNow()
						: DateTimeUtil.getDateFromObject(endtime);
						
						String summary_img = StringUtils.isEmpty(content.getString("summary_img"))?"":content.getString("summary_img");
						String[] imgs = summary_img.split(",");
						 ArrayList<String> imgList = new ArrayList<String>();
						for(int i = 0;i<imgs.length;i++){
							if(!StringUtils.isEmpty(imgs[i])){
								imgList.add(imgs[i]);
							}
						}
		
			%>
			<input type="file" id='choose_img' style="display: none">
			<form class="form-horizontal" id="content_form"
				action="<%=basePath%>content/update" method="post">
				<input type="hidden" value="${id }" name="id">
				<%-- <div class="form-group">
					<label class="col-xs-2 control-label" for="info_type">信息类型</label>
					<div class="col-xs-2">
						<p class="form-control-static"><%=typeStr%></p>
					</div>

				</div>
				<c:if test='<%=type==1 %>'>
					<div class="form-group show" id='ctn_sub_type'>
						    <label class="col-xs-2 control-label" >办事子类型</label>
						    <div class="col-xs-2">
							   <p class="form-control-static"><%=subtypeStr%></p>
						    </div>
						    </div>
				</c:if>
				 --%>
			    
			  
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

			
				
				<div class='form-group' >
					<label class='col-xs-2'>摘要图片：</label>
					<div class="col-xs-10 fileupload-buttonbar" >
					
						<div class="container-fluid">
							<div class="row panel-body files">
								<input type="hidden" name="summary_img">
								<c:forEach items="<%=imgs %>" var="item"  varStatus="status">
									<div class='panel-body img-init'>
									
										<div class="img-item ">
											<span class="preview" style="width: 300px;height:150px;"> 
												<img alt="" src="${item }" >
											</span>
								
											<div class="information img-rounded ">
												<span class='glyphicon glyphicon-zoom-in' style="color: white;"></span>
											</div>
											<button class="btn btn-danger glyphicon glyphicon-trash del" data-index="${status.index }"></button>
											<div id="progress" class="progress" style="margin-bottom: 5px;">
												<div class="progress-bar progress-bar-danger"></div>
											</div>
											<span class="text-success info" />
										</div>
									</div>
								</c:forEach>
								
								
								<div class="panel-body add">
									<!-- <span class="btn btn-primary fileinput-button">
					                    <i class="glyphicon glyphicon-plus"></i>
					                    <span>选择摘要图片</span>
					                    <input  id="fileupload" type="file" name="file[]" multiple>
					                </span> -->
								</div>
								
							</div>
							<span class="btn btn-primary fileinput-button">
					                    <i class="glyphicon glyphicon-plus"></i>
					                    <span>选择摘要图片</span>
					                    <input  id="fileupload" type="file" name="file[]" multiple>
					       </span>
						</div>	
						
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
		
		<div class="img-item-tpl hidden">
			<span class="preview"> </span>

			<div class="information img-rounded ">
				<span class='glyphicon glyphicon-zoom-in' style="color: white;"></span>
			</div>
			<button class="btn btn-danger glyphicon glyphicon-trash del"></button>
			<div id="progress" class="progress" style="margin-bottom: 5px;">
				<div class="progress-bar progress-bar-danger"></div>
			</div>
			<span class="text-success info" />
		</div>
</body>
<script type="text/javascript">
	$(function() {
		var imgUrls = [];
		var imgCount = <%=type==6?9:1%>;
		var imgItemTpl = $(".img-item-tpl");
		var summary_img = "<%=summary_img%>";
		var imgArr = summary_img.split(',');
		for (var int = 0; int < imgArr.length; int++) {
			if(imgArr[int].trim())imgUrls.push(imgArr[int]);
		}
		$(".files input[name='summary_img']").val(imgUrls.join(','));
		

		$(".img-init .del").bind("click",function(){
        	imgUrls.splice($(this).data("index"),1);
        	$(this).parent().parent().remove();
        	
        	var urls = "";
        	$.each(imgUrls,function(index,item){
        		if(item.trim()){
        			urls+=item+",";
        		}
        	});
        	$(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
        });
		
		$("#info_type").change(function(){
			if($(this).val()==6){
				imgCount = 9;
			}else{
				imgCount = 1;
			}
			$(".files .ctn-img").remove();
		});
		$(".fileinput-button").click(function(){
			if($(".files .img-item").size()==imgCount){
				alert("最多添加<%=type==6?9:1%>张图片");
				return false;
			}
			
			return true;
		});
		 $('#fileupload').fileupload({
		        url: "pupil/uploadImgJson",
		        dataType: 'json',
		        autoUpload: true,
		        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
		        maxFileSize: 4096000,
		        // Enable image resizing, except for Android and Opera,
		        // which actually support image resizing, but fail to
		        // send Blob objects via XHR requests:
		        disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
		        previewMaxWidth: 300,
		        previewMaxHeight: 150,
		        previewCrop: true,
		        formData:{},
		        paramName:"file[]",
		        messages:{
		        	maxFileSize:"文件太大"
		        }
		        
		    }).on('fileuploadadd', function (e, data) { 
			    data.context = $("<div class='panel-body ctn-img'></div>").insertBefore($('.files .add'));
		    }).on('fileuploadprocessalways', function (e, data) {
		        var index = data.index,
		            file = data.files[index];
		        node = data.context;
		        if (file.preview) {
			        var tpl = imgItemTpl.clone(true).removeClass('hidden');
			        tpl.find(".preview").append(file.preview);
			        
			        imgUrls.push("");
			        tpl.find(".del").data("index",imgUrls.length-1);
			        tpl.find(".del").bind("click",function(){
			        	imgUrls.splice($(this).data("index"),1);
			        	$(this).parent().parent().remove();
			        	
			        	var urls = "";
			        	$.each(imgUrls,function(index,item){
			        		if(item.trim()){
			        			urls+=item+",";
			        		}
			        	});
			        	$(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
			        });
			        node.prepend(tpl);
		        }
		        if (file.error) {
		        	node.find('.progress-bar').css(
		                    'width',
		                    100 + '%'
		                );
		            node.append($('<span class="text-danger"/>').text(file.error));
		        }
		    }).on('fileuploadprogress', function (e, data) {
		    	var progress = Math.floor(data.loaded / data.total * 100);
		        if (data.context) {
		            data.context.each(function () {
		                $(this).find('.progress')
		                    .attr('aria-valuenow', progress)
		                    .children().first().css(
		                        'width',
		                        progress + '%'
		                    );
		            });
		        }
		    }).on('fileuploadprogressall', function (e, data) {
		    }).on('fileuploaddone', function (e, data) {
		    	
		    	data.context.find('.progress-bar').removeClass("progress-bar-danger").addClass("progress-bar-success");
		    	data.context.find(".info").text("上传成功");
		    	
		        $.each(data.result.files, function (index, file) {
		            if (file.url) {
		            	imgUrls[data.context.find(".del").data('index')] = file.url;
		            	var urls = "";
			        	$.each(imgUrls,function(index,item){
			        		if(item.trim()){
			        			urls+=item+",";
			        		}
			        	});
			        	$(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
		            } else if (file.error) {
		                var error = data.context.find(".info").text(file.error);
		            }
		        });
		    }).on('fileuploadfail', function (e, data) {
		        $.each(data.files, function (index) {
		            var error = $('<span class="text-danger"/>').text('File upload failed.');
		            $(data.context.children()[index])
		                .append('<br>')
		                .append(error);
		        });
		    }).prop('disabled', !$.support.fileInput)
		     .parent().addClass($.support.fileInput ? undefined : 'disabled');


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
								/* starttime:{
									equired:"开始时间不能为空",
									date:"时间格式错误",
								},
								endtime:{
								 equired:"结束时间不能为空",
								 date:"时间格式错误",
								}, */
								summary : {
									required : "概要不能为空",
									maxlength : $.validator
											.format("概要字符长度不能超过{0}")
								},
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
						url : "/ejwms/file/uploadImg",
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
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="plugins/blueimp/file-upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<!-- <script src="//cdn.bootcss.com/blueimp-JavaScript-Templates/3.5.0/js/tmpl.min.js"></script> -->
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<!-- <script src="plugins/blueimp/canvas-to-blob.min.js"></script> -->
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="plugins/blueimp/load-img/js/load-image.all.min.js"></script>
<!-- Bootsdivap JS is not required, but included for the responsive demo navigation -->
<!-- blueimp Gallery script -->
<!-- <script src="//cdn.bootcss.com/blueimp-gallery/2.21.3/js/blueimp-gallery.min.js"></script> -->
<!-- The Iframe divansport is required for browsers without support for XHR file uploads -->
<script src="plugins/blueimp/file-upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-video.js"></script>
<!-- The File Upload validation plugin -->
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-validate.js"></script>
<!-- The File Upload user interface plugin -->
<!-- <script src="plugins/blueimp/file-upload/js/jquery.fileupload-ui.js"></script> -->
<!-- The main application script -->
<script src="plugins/blueimp/file-upload/js/main.js"></script>
<!-- The XDomainRequest divansport is included for cross-domain file deletion for IE 8 and IE 9 -->
<!--[if (gte IE 8)&(lt IE 10)]>
<script src="plugins/blueimp/file-upload/js/cors/jquery.xdr-transport.js"></script>
<![endif]-->
</html>