<%@page import="com.huaao.common.extension.DateTimeUtil"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
		.ui-jqgrid .ui-jqgrid-bdiv{
   			overflow: hidden;
   		}
   		.table tbody tr.active:hover  td, .table tbody tr.active:hover  th{
   			background-color: #dff0d8 !important;
   		}
   		.ui-jqgrid-hbox .ui-jqgrid-labels{
		background-color:rgb(52, 153, 219);
		}
		.ui-jqgrid-hbox .ui-jqgrid-labels   .active{
		background-color:rgb(52, 153, 219);
		} 
.form-horizontal label{
	text-align: right;
}
.modal-dialog{
	z-index: 10050;
}
.note-editor .btn[data-event="codeview"]{
display: none;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<%@ include file="../../base/importJs.jsp"%>
<!-- END PAGE LEVEL SCRIPTS -->

<link rel="stylesheet" href="plugins/bootstrap-datetimepicker/css/datetimepicker.css">
<link rel="stylesheet" href="plugins/summernote-develop/dist/summernote.css">

<script type="text/javascript" src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript" src='plugins/summernote-develop/dist/summernote.js'></script>
<script type="text/javascript" src='plugins/summernote-develop/lang/summernote-zh-CN.js'></script>
<script type="text/javascript" src='plugins/jquery.form.js'></script>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=dc224c3fa3a1878bf789a04f9ffa89f9&plugin=AMap.Geocoder"></script> 

<style type="text/css">
.datetimepicker table td {
  font-family:'Microsoft YaHei'!important;
}

td .day {
  font-family:'Microsoft YaHei'!important;
}
.datepicker table td {
  font-family:'Microsoft YaHei'!important;
}

.datepicker table th {
  font-family:'Microsoft YaHei'!important;
}
.datetimepicker table th {
  font-family:'Microsoft YaHei'!important;
}


.gritter-title {
  font-family:'Microsoft YaHei'!important;
}
  .portlet .calendar .fc-text-arrow {
  font-family:'Microsoft YaHei'!important;
}

</style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>发布信息</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">发布康复活动信息</div>
		<div class="panel-body">
			<%
			String start = DateTimeUtil.getNow();
			String end = DateTimeUtil.getNow();
			%> 

			<input type="file" id = 'choose_img' style="display: none">
			<form class="form-horizontal" id="content_form" action="<%=basePath %>content/publish" method='post'>
			<div class="form-group">
			    <label class="col-xs-2" for="info_type">信息类型</label>
			    <div class="col-xs-2">
				    <select class='form-control' id="info_type" name="type" readonly="readonly">
				    	<option value="2" selected="selected">康复活动</option>
				    </select>
			    </div>
			    
			  </div>
			  <div class="form-group">
			    <label class="col-xs-2"  for="title">标题</label>
			    <div class="col-xs-4">
			    	 <input type="text" class="form-control"  name="title" placeholder="标题字符数不能超过100"  >
			    </div>
			  </div>
				  <div class="form-group ">
					    <label class="col-xs-2"  for="starttime">活动开始时间</label>
					    <div class="col-xs-2 has-feedback">
					    			<input type='text' class="form-control"  name="starttime" id ="starttime" placeholder="开始时间"  ></input>
						    	<span class='glyphicon glyphicon-th form-control-feedback'></span>
						    	
					    </div>
				  </div>
				  <div class="form-group">
					    <label class="col-xs-2"  for="endtime">活动结束时间</label>
					    <div class="col-xs-2 has-feedback">
					    			<input type='text' class="form-control"  name="endtime" id ="endtime" placeholder="结束时间"  ></input>
					    			<span class='glyphicon glyphicon-th form-control-feedback'></span>
						    	
					    </div>
				  </div>
				  
			   		<div class="form-group">
						    <label class="col-xs-2"  for="summary">活动地点</label>
						    <div class="col-xs-2">
						    	<input class="form-control" type="text" id='startaddr' name='startaddr' readonly="readonly" ></input>
						    	<!-- <label id='l_start_addr'>未选择活动地点</label> -->
						    	<input type="hidden" id = 'location' name='location'>
						    </div>
						    <div class="col-xs-2">
						    	<button class="btn btn-primary "  id='btn_location' data-toggle='modal' data-target='#locationModal'>请选择活动地点</button>
						    </div>
					  </div>
			   
			   
			  <div class="form-group">
			    <label class="col-xs-2"  for="summary">摘要</label>
			    <div class="col-xs-4">
			    	<textarea rows='2' class="form-control"  name="summary"  placeholder="摘要字符数不能超过255"  ></textarea>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="col-xs-2"  for="summary">摘要图片</label>
			    <div class="col-xs-10">
			    	<input type="hidden" name='summary_img' id='summary_img'>
			    	<img class='img-rounded'   src="images/idcard_default_290_186.png"  style='width:300px;height:150px;'>
			    	<button class='btn btn-primary' id="btn_add_summary_img" style='margin-top:20px;display: block;'>添加摘要图片</button>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-xs-2"  for="content">内容</label>
			    <div class="col-xs-8">
			    	<textarea  class="form-control"  name="content" id='content'></textarea>
			    </div>
			  </div>
			  <div class="form-group">
				  	<div class="col-xs-offset-2 col-xs-10">
					  	 <button  class="btn btn-primary" id="publish">发布</button>
					  <button  class="btn btn-success" onclick="javascript:window.history.back(-1);return false;">返回</button>
				  	</div>
			  </div>
			 
			</form>
		</div>
		
	
	
	<!-- Modal -->
	<div class="modal fade" id="locationModal" tabindex="-1" role="dialog" >
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="locationModalLabel">请选择活动地点</h4>
	      </div>
	      <div class="modal-body">
	      	<div class='center-block' style='width:800px;height:600px;' id="container">
	      	</div>
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal" id='btn_confirm_location'>确定</button>
	      </div> 
	    </div>
	  </div>
	</div>
</body>
<script type="text/javascript">
	$(function() {

		
		
		$("#starttime").datetimepicker({
			language:'zh-CN',
			format:"yyyy-mm-dd hh:ii:ss"
		}).on('hide', function(ev){
			var end = $('#endtime').val();
		    if (ev.date.valueOf() < new Date(end).valueOf()){
		    }
		});
		$("#endtime").datetimepicker({
			language:'zh-CN',
			format:"yyyy-mm-dd hh:ii:ss"
		}).on('hide', function(ev){
			var start = $('#starttime').val();
		    if (ev.date.valueOf() < new Date(start).valueOf()){
		    }
		});
		$('#content').summernote({
			height:400,
			lang:'zh-CN',
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
		 $.validator.setDefaults({
			 onfocusout:function(element) {
				if (!this.checkable(element)
						&& (element.name in this.submitted || true)&&(element.id!="starttime"&&element.id!="endtime")) {
					this.element(element);
				}
			}, 

			submitHandler:function(form) {
				var starttime=$("#starttime").val();
				var endtime=$("#endtime").val()
                if(starttime>endtime){
                	alert("开始时间大于结束时间！");
                	return false;
                }
				
				var content = $('#content').code().trim();
				if (content && content != "<p><br></p>")
				{var options = {
				        success:       showResponse,  // post-submit callback
				        dataType:  'json'        // 'xml', 'script', or 'json' (expected server response type)
				    };

				    // post-submit callback
				    function showResponse(responseText, statusText, xhr, $form)  {
				        
				        if(responseText.code==0){
				        	alert("添加成功！");
				        	window.history.back(-1);
				        }else{
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
		
		$("#content_form").validate({
			  rules:{
				  title:{
					  required:true,
					  maxlength:100,
				  },
				 /*  starttime:{
					  required:true,
				  },
				  endtime:{
					  required:true,
					  mydate:true,
				  }, */
		  		summary:{
		  			required:true,
		  			maxlength:255,
		  		},
		  		content:{
		  			required:true,
		  		}
		  		,
				  startaddr:{
					  required:true,
				  }
				  
			  },
			  messages:{
				  title:{
					  required:"标题不能为空",
					  maxlength : $.validator .format("标题字符长度不能超过{0}")
				  },
 					/* starttime:{
 						equired:"开始时间不能为空",
 						date:"时间格式错误",
 					},
				  endtime:{
					  equired:"结束时间不能为空",
					  date:"时间格式错误",
				  }, */
				  summary:{
					  required:"概要不能为空",
					  maxlength : $.validator .format("概要字符长度不能超过{0}")
				  },
				  content:{
					  required:"内容不能为空",
					  maxlength : $.validator .format("内容字符长度不能超过{0}")
				  },
				  startaddr:{
					  required:"活动地点不能为空",
				  }
			  },
			  errorElement : "em",
				errorPlacement : function(error,
						element) {
					// Add the `help-block` class to the error element
					error.addClass("help-block");

					// Add `has-feedback` class to the parent div.form-group
					// in order to add icons to inputs
					element.parents(".form-group")
							.addClass(
									"has-feedback");

					if (element.prop("type") === "checkbox") {
						error.insertAfter(element
								.parent("label"));
					} else {
						error.insertAfter(element);
					}

					// Add the span element, if doesn't exists, and apply the icon classes to it.
					if (!element.next("span")[0]) {
						$(
								"<span class='glyphicon glyphicon-remove form-control-feedback'></span>")
								.insertAfter(
										element);
					}
				},
				success : function(label, element) {
					// Add the span element, if doesn't exists, and apply the icon classes to it.
					if (!$(element).next("span")[0]) {
						$(
								"<span class='glyphicon glyphicon-ok form-control-feedback'></span>")
								.insertAfter(
										$(element));
					}
				},
				highlight : function(element,
						errorClass, validClass) {
					$(element).parents(
							".form-group")
							.addClass("has-error")
							.removeClass(
									"has-success");
					$(element)
							.next("span")
							.addClass(
									"glyphicon-remove")
							.removeClass(
									"glyphicon-ok");
				},
				unhighlight : function(element,
						errorClass, validClass) {
					$(element)
							.parents(".form-group")
							.addClass("has-success")
							.removeClass(
									"has-error");
					$(element)
							.next("span")
							.addClass(
									"glyphicon-ok")
							.removeClass(
									"glyphicon-remove");
				}
			});
		jQuery.validator.addMethod("mydate", function(value, element) {   
			console.info(value);
			value +=":00";
			return this.optional( element ) || !/Invalid|NaN/.test( new Date( value ).toString() );
		}, "开头必须为字母、数字或下划线，不能以数字开头");
		
	 	
		$('#btn_add_summary_img').click(function(e){
	 		e.preventDefault();
	 		$("#choose_img").click();
	 		
	 		
	 	});
	 	$("#choose_img").change(function(event){
	 		if(this.files.length==1){
	 			var file = this.files[0];
	 			
	 			if(file.size<1024000){
	 				var imgParent = $('#btn_add_summary_img').parent();
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
				 			alert("上传成功！");
				 			
				 			imgParent.children('input').val(result.img);
				 			imgParent.children('img').attr('src',result.img);
				 		},
				 		error:function(){
				 			alert("上传失败");
				 		}
			 		});
	 				
	 			}else{
	 				alert("图片过大！");
	 			}
	 		}
	 	});
	 	
 	//确定活动地点
 	
 	var map = new AMap.Map('container',{
    zoom: 10,
	    
	});
	map.on('click', function(e) {
       // alert('您在[ '+e.lnglat.getLng()+','+e.lnglat.getLat()+' ]的位置点击了地图！');
        if (marker) {
            marker.setMap(null);
            marker = null;
        }
        addMarker(e.lnglat);
        
    });
	var marker = new AMap.Marker({
	    //position: [116.480983, 39.989628],
	    map:map
	});
	 // 实例化点标记
    function addMarker(lnglat) {
        marker = new AMap.Marker({
            icon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png",
            position: [lnglat.getLng(), lnglat.getLat()]
        });
        marker.setMap(map);
        regeocoder(lnglat);
    }
    var address;
    function regeocoder(lnglatXY) {  //逆地理编码
        var geocoder = new AMap.Geocoder({
            radius: 1000,
            extensions: "all"
        });        
        geocoder.getAddress(lnglatXY, function(status, result) {
            if (status === 'complete' && result.info === 'OK') {
            	address = result.regeocode.formattedAddress;
            }
        });        
    }
	$('#btn_confirm_location').click(function(e){
		e.preventDefault();
		$('#l_start_addr').text(address?address:'湖北省武汉市');
		$('#startaddr').val(address?address:'湖北省武汉市');
		var lnglat = marker.getPosition();
		$('#location').val(lnglat.lng+","+lnglat.lat);
		
	});
	AMap.plugin(['AMap.ToolBar','AMap.Scale'],function(){
	    var toolBar = new AMap.ToolBar();
	    var scale = new AMap.Scale();
	    map.addControl(toolBar);
	    map.addControl(scale);
	});
	 	
});
</script>
<!-- END BODY -->

</html>