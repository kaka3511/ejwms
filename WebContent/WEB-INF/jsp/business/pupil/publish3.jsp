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

<style type="text/css">
.form-group label{
	text-align: right;
}
</style>

<script type="text/javascript" src='plugins/jquery.form.js'></script>

<!-- Generic page styles -->
<link rel="stylesheet" href="css/style.css">
<!-- blueimp Gallery styles -->
<link href="//cdn.bootcss.com/blueimp-gallery/2.21.3/css/blueimp-gallery.min.css" rel="stylesheet">
<!-- CSS to style the file input field as button and adjust the Bootsdivap progress bars -->
<link rel="stylesheet" href="plugins/blueimp/file-upload/css/jquery.fileupload.css">
<link rel="stylesheet" href="plugins/blueimp/file-upload/css/jquery.fileupload-ui.css">


<style type="text/css">
.files img, .files .panel-body button.add {
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
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>添加被监护人</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">添加监护人</div>
		<div class="panel-body">
			<input class=' hidden' type='file' id='f_header_img'>
			<input class=' hidden' type='file' id='f_idcard_img1'>
			<input class=' hidden' type='file' id='f_idcard_img2'>
			<input class=' hidden' type='file' id='f_idcard_img3'>
			<form class="form-horizontal" action='file/uploadImg'  method="POST"  >
			
				<div class='form-group ' >
					<label class="col-sm-4 control-label">头像：</label>
						<div class='col-sm-8' id='img'>
							<input type="hidden" name='head_img' id='i_img' >
							<img class='img-circle'  style="width:80px;height:80px;"'>
							<button class='btn btn-primary btn_choose_img'   id='btn_header_img'>请选择照片</button>
						</div>
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>名称：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='name'>
					
					</div>				
				</div>
				
				
				<div class='form-group'>
					<label class='col-xs-4'>积分：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='score'>
					
					</div>				
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>电话号码：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='cellphone'>
					
					</div>				
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>身份证：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='idcard'>
					
					</div>				
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>疾病类型：</label>
					<div class="col-xs-4">
						<select class='form-control ' name='type'  >
							<option value="0" >精神障碍患者</option>
							    	<option value="1" >残障人士</option>
						</select>
					
					</div>				
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>病史或情况说明：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='illness'>
					
					</div>				
				</div>
				<div class='form-group'>
					<label class='col-xs-4'>性别：</label>
					<div class="col-xs-4">
						<select class='form-control ' name='gender'  >
							<option value="0" >女</option>
							 <option value="1" >男</option>
						</select>
					
					</div>		
					</div>
					
					<div class='form-group'>
					<label class='col-xs-4'>年龄：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='age'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-4'>现住址：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='cuaddr'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-4'>户籍地址：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='addr'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-4'>三证：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='nums'>
					
					</div>				
				</div>
				
				
				<div class='form-group'>
					<label class='col-xs-4'>三证图片：</label>
					<div class="col-xs-4">
						<div class='pull-left' style='margin-right: 40px;'>
						<!-- <h4>医保证</h4> -->
						<input type="hidden" name='idcard_img1' id='i_idcard_img1' >
							<img class='img-rounded'   data-toggle='modal' data-target='#imgModal'  >
						
						<button class='btn btn-primary  btn_choose_img'   id='btn_idcard_img1'>请选择照片</button>
					</div >
					<div class='pull-left' style='margin-right: 40px;'>
						<!-- <h4>低保证</h4> -->
						<input type="hidden" name='idcard_img2' id='i_idcard_img2'  >
							<img class='img-rounded'   data-toggle='modal' data-target='#imgModal' >
						
						<button class='btn btn-primary  btn_choose_img'    id='btn_idcard_img2'>请选择照片</button>
					</div>
					<div class='pull-left' style='margin-right: 40px;'>
						<!-- <h4>低保证</h4> -->
						<input type="hidden" name='idcard_img3' id='i_idcard_img3'  >
							<img class='img-rounded'    data-toggle='modal' data-target='#imgModal' >
						
						<button class='btn btn-primary  btn_choose_img'    id='btn_idcard_img3'>请选择照片</button>
					</div>
					
					</div>				
				</div>
				
					
				<div class='form-group' id="fileupload">
					<label class='col-xs-4'>添加图片：</label>
					<div class="col-xs-4 fileupload-buttonbar" >
						<span class="btn btn-success fileinput-button">
		                    <i class="glyphicon glyphicon-plus"></i>
		                    <span>Add files...</span>
		                    <input type="file" name="file[]" multiple>
		                </span>
					</div>		
					
					<div class="container-fluid">
						<div class="row panel-body files"></div>
					</div>	
				</div>
				
				
				
				<div class='form-group'>
					<div class="col-xs-offset-4 col-xs-4">
						<button class='btn btn-primary' id='btn_publish'>添加</button>
						
						<button class='btn btn-success' onclick="javascript:window.history.back(-1);return false;">返回</button>
					
					</div>				
				</div>
			  
			</form>
		</div>
	</div>
	
	 <div class="modal fade" id="imgModal" tabindex="-1" role="dialog" style='overflow: hidden;'>
		 <div class="modal-dialog modal-lg" >
		 </div>
		
	</div>

</body>

<script type="text/javascript">
	$(function() {
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

						})

		function sendFile(file, imgParent) {
			var filename = false;
			try {
				filename = file['name'];
			} catch (e) {
				filename = false;
			}
			if (!filename) {
				$(".note-alarm").remove();
			}
			var data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/ejwms/authentication/uploadImg",
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
		}
		var curImg;

		/* $(".btn_choose_img").click(function(event){
			event.preventDefault();
			curImg = $(this).siblings('img');
			$('#f_header_img').click();
			
		});  */

		$("#btn_header_img").click(function(event) {
			event.preventDefault();
			curImg = $(this).parent();
			$('#f_header_img').click();

		});
		$("#btn_idcard_img1").click(function(event) {
			event.preventDefault();
			curImg = $(this).parent();
			$('#f_idcard_img1').click();

		});
		$("#btn_idcard_img2").click(function(event) {
			event.preventDefault();
			curImg = $(this).parent();
			$('#f_idcard_img2').click();

		});

		$("#btn_idcard_img3").click(function(event) {
			event.preventDefault();
			curImg = $(this).parent();
			$('#f_idcard_img3').click();

		});
		$('#f_header_img').change(imgChange);
		$('#f_idcard_img1').change(imgChange);
		$('#f_idcard_img2').change(imgChange);
		$('#f_idcard_img3').change(imgChange);

		function imgChange() {
			if (this.files.length == 1) {
				var file = this.files[0];

				if (file.size < 1024000)
					sendFile(file, curImg);
				else
					alert("图片过大！");
			}

		}
		$("#btn_publish").click(function(event) {
			event.preventDefault();

			var options = {
				url : '/ejwms/pupil/add',
				type : 'post',
				dataType : 'json',
				success : function(responseText, statusText, xhr, $form) {

					if (responseText.code == 0) {
						alert("添加成功");
						window.history.back(-1);
					} else {
						alert("添加失败失败");

					}
				},

			};

			$('form').ajaxSubmit(options);
			return false;
		});
		
		$('#fileupload').fileupload({
	        // Uncomment the following to send cross-domain cookies:
	        //xhrFields: {withCredentials: true},
	        url: 'pupil/uploadImgJson',
	        formData:{},
	        autoUpload:false,
	        previewMaxWidth:300,
	        previewMinWidth:300,
	        previewMaxHeight:150,
	        previewMinHeight:150,
	        
	        imageMaxWidth:300,
	        imageMinWidth:300,
	        imageMaxHeight:150,
	        imageMinHeight:150,
	        disableImageResize:false,
	    }).bind('fileuploaddestroy', function (e, data) {
	    		alert(data);
	    });

	});
</script>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>




<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
   <div class="panel-body template-upload fade">
	<div class="ctn-img">
		<span class="preview"></span>
		<div class="information img-rounded ">
			<span class='glyphicon glyphicon-zoom-in' style="color: white;"></span>
		</div>
		<button class="btn btn-danger glyphicon glyphicon-trash del"></button>
		

	</div>
<div>
			<div class="progress progress-striped active" role="progressbar"
				aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
				<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
			</div>
			<p class="size">Processing...</p>
			
		</div>
<div>
			<strong class="error text-danger"></strong>
		</div>
</div>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <div class="panel-body template-upload fade">
	<div class="ctn-img">
		<span class="preview"> {% if (file.thumbnailUrl) { %} <a
		href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}"
		data-gallery><img src="{%=file.thumbnailUrl%}" class="img-rounded"></a> {% } %}

	</span>


		<div>
			<p class="size">Processing...</p>
			<div class="progress progress-sdiviped active" role="progressbar"
				aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
				<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
			</div>
		</div>
		<div class="information img-rounded ">
			<span class='glyphicon glyphicon-zoom-in' style="color: white;"></span>
		</div>
		<button class="btn btn-danger glyphicon glyphicon-trash del"></button>
		<div>
		<p class="name">
			{% if (file.url) { %} <a href="{%=file.url%}" title="{%=file.name%}"
				download="{%=file.name%}"{%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
			{% } else { %} <span>{%=file.name%}</span> {% } %}
		</p>
		{% if (file.error) { %}
		<div>
			<span class="label label-danger">Error</span> {%=file.error%}
		</div>
		{% } %}
	</div>
	<div>
		<span class="size">{%=o.formatFileSize(file.size)%}</span>
	</div>
	</div>
</div>




{% } %}
</script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="plugins/blueimp/file-upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="//cdn.bootcss.com/blueimp-JavaScript-Templates/3.5.0/js/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="plugins/blueimp/canvas-to-blob.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="plugins/blueimp/load-img/js/load-image.all.min.js"></script>
<!-- Bootsdivap JS is not required, but included for the responsive demo navigation -->
<!-- blueimp Gallery script -->
<script src="//cdn.bootcss.com/blueimp-gallery/2.21.3/js/blueimp-gallery.min.js"></script>
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
<script src="plugins/blueimp/file-upload/js/jquery.fileupload-ui.js"></script>
<!-- The main application script -->
<script src="plugins/blueimp/file-upload/js/main.js"></script>
<!-- The XDomainRequest divansport is included for cross-domain file deletion for IE 8 and IE 9 -->
<!--[if (gte IE 8)&(lt IE 10)]>
<script src="plugins/blueimp/file-upload/js/cors/jquery.xdr-transport.js"></script>
<![endif]-->
</html>