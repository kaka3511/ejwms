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


<script type="text/javascript" src='plugins/jquery.form.js'></script>
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li>发布病例档案</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">发布病例档案</div>
		<div class="panel-body">
			<form class="form-horizontal" action='case/add' id='form_case'>
				<input type="hidden" name="pupilId" value='${pupilId }'>
				<div class='form-group'>
					<label class='col-xs-4'>病例标题：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='title'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-4'>病例描述：</label>
					<div class="col-xs-4">
						<textarea class='form-control' rows='3' name='description' ></textarea>
					
					</div>				
				</div>
				
				
				<div class='form-group'>
					<label class='col-xs-4'>病例图片：</label>
					<div class="col-xs-4" >
							<input type="hidden" name="img_count" id='i_img_count'>
							<div id='ctn_case_img'>
							
							</div>
						<button class='btn btn-primary' id="btn_add_imgs" style='margin-top:20px;'>添加病例图片</button>
					</div>				
				</div>
				
				<div class='form-group'>
					<div class="col-xs-offset-4 col-xs-4">
						<button class='btn btn-primary' id='btn_publish'>发布</button>
						<button class='btn btn-default' onclick="javascript:window.history.back(-1);return false;">返回</button>
					
					</div>				
				</div>
			
			</form>
		</div>
	</div>
	
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加图片及描述</h4>
	      </div>
	      <div class="modal-body">
	      	<form class='form-horizontal' action="">
	      		<div class="form-group">
	      			<label class='col-xs-4'>选择图片：</label>
	      			<div class="col-xs-8">
	      				<input type="hidden"  id='i_choose_img'>
	      				<input type="file"  id='choose_img'>
	      			</div>
	      			
	      		</div>
	      		<div class="form-group">
	      			<label class='col-xs-4'>图片描述：</label>
	      			
	      			<div class="col-xs-8">
	      				<textarea class='form-control' rows="3" id='img_description'></textarea>
	      			</div>
	      			
	      		</div>
	      		
	      		<div class="form-group">
	      			
	      			<div class="col-xs-offset-4 col-xs-8">
	      				<button class='btn btn-primary' id='btn_conform'>确定</button>
	      				<button class='btn btn-primary'  data-dismiss="modal">取消</button>
	      			</div>
	      			
	      		</div>
	      	</form>
	        
	      </div>
	      <!-- <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary">保存</button>
	      </div> -->
	    </div>
	  </div>
	</div>
</body>

<script type="text/javascript">
$(function() {

	function sendFile(file,imgParent){
 		var filename = false;
 		try{
 			filename = file['name'];
 		} catch(e){filename = false;}
 		if(!filename){$(".note-alarm").remove();}
 		var data = new FormData();
 		data.append("file", file);
 		$.ajax({
 		data: data,
 		type: "POST",
 		url: "/ejwms/case/uploadImg",
 		cache: false,
 		contentType: false,
 		processData: false,
 		success: function(data) {
 			//data是返回的hash,key之类的值，key是定义的文件名
 			var result = eval('(' + data + ')'); 
 			alert("上传成功！");
 			imgParent.children('#i_choose_img').val(result.img);
 		},
 		error:function(){
 			alert("上传失败");
 		}
 		});
 	}
 	
	$('#btn_add_imgs').click(function(e){
		e.preventDefault();
		$('#myModal').modal("show");
		
	});
	
	$("#btn_publish").click(function(event){
 		event.preventDefault();
 		var options = {
 				url:'case/add',
 				type:'post',
 				dataType:'json',
		        success: function(responseText, statusText, xhr, $form)  {
			        
			        if(responseText.code==0){
			        	alert("发布成功！");
			        	window.history.back(-1);
			        }else{
			        	alert("发布失败");
			        	
			        }
			    },
		        
		    };
		
		 $('#form_case').ajaxSubmit(options);
		 
		 return false;
 	}); 
	$('#choose_img').change(imgChange);
	function imgChange(){
 		if(this.files.length==1){
 			var file = this.files[0];
 			
 			if(file.size<1024000)
 			sendFile(file,$(this).parent());
 			else alert("图片过大！");
 		}
 		
 	}
	
	var img_count = 0;
	$('#btn_conform').click(function(e){
		e.preventDefault();
		
		var imgSrc = $('#i_choose_img').val();
		var imgDesp = $('#img_description').val();
		
		var img = "<input type='hidden'  name='img_"+img_count+"' value='"+imgSrc+"'><img src='"+imgSrc+"'  class='img img-rounded' style='width:200px;height:100px;margin-right:20px;float:left'><textarea  rows='5' cols='40' name='imgDesp_"+img_count+"'>"+imgDesp+"</textarea>";
		$('#myModal').modal("hide");
		$('#ctn_case_img').prepend(img);
		img_count++;
		$('#i_img_count').val(img_count);
		
	});
 	
});

</script>
</html>