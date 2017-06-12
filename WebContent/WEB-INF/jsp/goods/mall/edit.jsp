<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>商品管理</li>
		<li>修改商品</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading">修改商品</div>
		<div class="panel-body">
			
			<%
			SqlRowSet goods = (SqlRowSet)request.getAttribute("goods");
			goods.next();
			
			%>
		<input  type="file" name='image' id='f_choose_img' style='display: none;'>
				<form class="form-horizontal" action='mall/update' method='post'>
				
				<input type="hidden" name='id' value='<%=goods.getString("id") %>'>
				<div class='form-group'>
					<label class='col-xs-5'>商品名称：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='name' value='<%=goods.getString("name")%>'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>商品图片：</label>
					<div class="col-xs-4">
						
					
					
					<%
					   String name=StringUtils.isEmpty(goods.getString("image"))? "images/idcard_default_290_186.png":goods.getString("image");
					%>
					<input  type="hidden" name='image' value='<%=name %>'>
						<img src="<%=name %>"  class='img img-rounded' style='width:200px;height:100px;'>
						
						<button class='pull-right btn btn-primary ' id='btn_choose_img'>请选择商品图片</button>
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>库存数量：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='stocks' value='<%=goods.getString("stocks") %>'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>商品积分：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='points' value='<%=goods.getString("points") %>'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>排序值：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='sortby' value='<%=goods.getString("sortby") %>'>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>商品描述：</label>
					<div class="col-xs-4">
						<textarea class='form-control' rows="4" name='description'><%=goods.getString("description") %></textarea>
					
					</div>				
				</div>
				
				<div class='form-group'>
					<label class='col-xs-5'>领取说明：</label>
					<div class="col-xs-4">
						<textarea class='form-control' rows="4" name='inform'><%=goods.getString("inform") %></textarea>
					
					</div>				
				</div>
				<!-- <div class='form-group'>
					<label class='col-xs-5'>商品状态：</label>
					<div class="col-xs-4">
						<label class="radio-inline">
						  <input type="radio" name="status" value="0" id='radio_up'>已上架</input>
						</label>
						<label class="radio-inline">
						  <input type="radio" name="status"  value="1" id='radio_down'>已下架</input>
						</label>
					
					</div>				
				</div> -->
				<div class='form-group'>
					<div class="col-xs-offset-5 col-xs-4">
						<button class='btn btn-primary' id='btn_confirm'>修改商品</button>
					
					
					<button class='btn btn-default' onclick="javascript:window.history.back(-1);return false;">取消</button>
					</div>				
				</div>
			
			</form>
		</div>
	</div>
</body>

<script type="text/javascript">
$(function(){
	
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
 		url: "/ejwms/mall/uploadImg",
 		cache: false,
 		contentType: false,
 		processData: false,
 		success: function(data) {
 			//data是返回的hash,key之类的值，key是定义的文件名
 			var result = eval('(' + data + ')'); 
 			alert("上传成功！");
 			imgParent.children("img").attr('src',result.img);
 			imgParent.children("input").val(result.img);
 		},
 		error:function(){
 			alert("上传失败");
 		}
 		});
 	}
	
	function imgChange(){
 		if(this.files.length==1){
 			var file = this.files[0];
 			
 			if(file.size<1024000)
 			sendFile(file,$('#btn_choose_img').parent());
 			else alert("图片过大！");
 		}
 		
 	}
	
	$("#btn_choose_img").click(function(e){
		e.preventDefault();
		
		$("#f_choose_img").click();
		
	});
	$("#f_choose_img").change(imgChange);
	$.validator.setDefaults({
		 onfocusout:function(element) {
			if (!this.checkable(element)
					&& (element.name in this.submitted || true)&&(element.id!="starttime"&&element.id!="endtime")) {
				this.element(element);
			}
		}, 

		submitHandler:function(form) {
				var options = {
						url:'mall/update',
			        success:       showResponse,  // post-submit callback
			        dataType:  'json'        // 'xml', 'script', or 'json' (expected server response type)
			    };

			    // post-submit callback
			    function showResponse(responseText, statusText, xhr, $form)  {
			        
			        if(responseText.code==0){
			        	alert("修改成功！");
			        	window.history.back(-1);
			        }else{
			        	alert("修改失败");
			        	
			        }
			    }
			
			 $('form').ajaxSubmit(options);
		},
	}); 
	
	$("form").validate({
		  rules:{
			  name:{
				  required:true,
				  maxlength:128,
			  },
			stocks:{
		  			required:true,
		  			digits: true
		  		},
	  		sortby:{
		  			required:true,
		  			digits: true
	  		},
	  		points:{
	  			required:true,
	  			digits: true
	  		},
	  		description:{
	  			required:true,
	  			maxlength:255,
	  		},
	  		inform:{
	  			required:true,
	  			maxlength:255,
	  		},
			  
		  },
		  messages:{
			  name:{
				  required:"商品名称不能为空",
				  maxlength : $.validator .format("标题字符长度不能超过{0}")
			  },
			  stocks:{
				  required:"商品库存不能为空",
				  digits:"库存数量必须大于等于0！",
			  },
			  sortby:{
				  required:"排序字段不能为空",
				  digits:"排序值必须大于等于0！",
			  },
			  points:{
				  required:"积分不能为空",
				  digits:"商品积分必须大于等于0！",
			  },
			  description:{
				  required:"描述不能为空",
				  maxlength : $.validator .format("内容字符长度不能超过{0}")
			  },
			  inform:{
				  required:"说明不能为空",
				  maxlength : $.validator .format("说明字符长度不能超过{0}")
		  		},
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
	
});
</script>
</html>