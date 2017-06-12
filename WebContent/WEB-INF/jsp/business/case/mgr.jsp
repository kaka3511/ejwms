<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.jdbc.support.rowset.SqlRowSet"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.util.StringUtils"%>
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

<%@ include file="../../base/taglib.jsp"%>
<%@ include file="../../base/importCss.jsp"%>
<%@ include file="../../base/importJs.jsp"%>

</head>
<body>
	<%
		String oper = (String)request.getAttribute("oper");
		String caseId = "";
		String title = "";
		String description = "";
		
		List<Map<String, Object>> imgs = new ArrayList<Map<String, Object>>();
		int imgIndex = 0;
		int imgCount = 0;
		
		String pupilId = "";
		
		String operName = "";
		if(oper.equals("edit")||oper.equals("show")){
			if(oper.equals("edit"))operName = "修改";
			else operName="查看";
			SqlRowSet rowSet = (SqlRowSet) request.getAttribute("rowSet");
			boolean more = rowSet.next();
			
			if(more){
				caseId = rowSet.getString("id");
				title = StringUtils.isEmpty(rowSet.getString("title"))?"":rowSet.getString("title");
				description = StringUtils.isEmpty(rowSet.getString("description"))?"":rowSet.getString("description");
				
				imgs = (List<Map<String, Object>>)request.getAttribute("imgs");
				imgCount = imgs.size();
			}
			
		}else{
			pupilId = request.getAttribute("pupilId").toString();
			operName = "发布";
		}
		
		
	%>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>业务管理</li>
		<li><%=operName %>病例档案</li>
	</ul>
	<div class="panel panel-info">

		<div class="panel-heading"><%=operName %>病例档案</div>
		<div class="panel-body">


			<form class="form-horizontal" action='case/update'>
				<c:if test='<%=oper.equals("edit") %>'>
						<input type="hidden" name='caseId' value='<%=caseId%>' id='case_id'>
				</c:if>
				<c:if test='<%=oper.equals("add") %>'>
						<input type="hidden" name='pupilId' value='<%=pupilId%>' id='pupil_id'>
				</c:if>
				
				<div class='form-group'>
					<label class='col-xs-4 star'>病例标题：</label>
					<div class="col-xs-4">
						<input class='form-control' type="text" name='title' id='title'
							value='<%=title%>'>

					</div>
				</div>

				<div class='form-group'>
					<label class='col-xs-4 star'>病例描述：</label>
					<div class="col-xs-4">
						<textarea class='form-control' rows='3' name='description' id = 'description'><%=description%></textarea>

					</div>
				</div>


				 <div class='form-group'>
					<label class='col-xs-4'>病例图片：</label>
					<div class="col-xs-4" >
							
							<div id='ctn_case_img'>
								<c:if test='<%=oper.equals("edit")||oper.equals("show") %>'>
									<%-- <input type="hidden" name="img_count" id='i_img_count' value='<%=imgCount%>'> --%>
									<c:forEach items="<%=imgs %>" var="item"  >
										<div >
											<%-- <input type='hidden'  name='img_<%=imgIndex %>' value='${item.img }'> --%>
											<img src='${item.img }'  class='img img-rounded' style='width:200px;height:100px;'>
											<textarea  rows='5' cols='40' readonly="readonly" style='vertical-align: middle;'>${item.brief }</textarea>
											<c:if test='<%=!oper.equals("show")%>'>
												<button class='btn btn-danger  btn_del_img' data-imgid='${item.id}' >删除</button>
											</c:if>
											
										</div>
										
										<%imgIndex++; %>
									</c:forEach>
									
								</c:if>
							
							</div>
							<c:if test='<%=!oper.equals("show")%>'>
								<button class='btn btn-primary' id="btn_add_imgs" style='margin-top:20px;'>添加病例图片及描述</button>
							</c:if>
						
					</div>				
				</div>

				<div class='form-group'>
					<div class="col-xs-offset-4 col-xs-4">
						<c:if test='<%=!oper.equals("show")%>'>
							<button class='btn btn-primary' id='btn_form_confirm'><%=oper.equals("edit")?"保存":"发布" %></button>
						</c:if>
						
						<button class='btn btn-success'
							onclick="javascript:window.history.back(-1);return false;">返回</button>
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
	      				<button class='btn btn-primary' id='btn_dialog_conform'>确定</button>
	      				<button class='btn btn-success'   data-dismiss="modal">取消</button>
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

	var oper = '<%=oper%>';
	var imgIdsRemoved =[];
	if(oper=='show'){
		$('.form-group input').attr('readonly',true);
		$('.form-group textarea').attr('readonly',true);
		return ;
	}
	$.validator.setDefaults({
		
		submitHandler:function(form){
			var postData ={
					oper:oper,
					title:$('#title').val(),
					description:$('#description').val(),
					imgs:[]
				} ;
			if(oper=='add'){
				postData.pupilId = $("#pupil_id").val();
			}else if(oper=='edit'){
				postData.caseId = $("#case_id").val();
				postData.imgIdsRemoved = imgIdsRemoved;
			} 
			
			
			$("#ctn_case_img .ctn_img_added").each(function(i,v){
				var img = $(v).children('input').val();
				var description = $(v).children('textarea').val();
				postData.imgs.push({
					img:img,
					description:description
				});
				
			})
			var options = {
				url : 'case/mgr',
				type : 'post',
				contentType :"application/json",
				dataType : 'json',
				data:JSON.stringify(postData),
				success : function(responseText, statusText, xhr, $form) {

					if (responseText.code == 0) {
						alert("操作成功！");
						window.history.back(-1);
					} else {
						alert("操作失败");

					}
				},

			};

			$.ajax(options);
			return false;
		}
	})
	$("form").validate({
		rules:{
			title:{
				required:true,
				maxlength:255,
			},
			description:{
				required:true,
				maxlength:255,
			},
		},
		messages:{
			title:{
				required:"标题不能为空",
				maxlength:$.validator.format("标题字符长度不能超过{0}"),
			},
			description:{
				required:"描述不能为空",
				maxlength:$.validator.format("描述字符长度不能超过{0}"),
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
	
	/* $('#btn_form_confirm').click(function(event) {
		event.preventDefault();
		

	}); */
	
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
	
	$('#choose_img').change(imgChange);
	function imgChange(){
 		if(this.files.length==1){
 			var file = this.files[0];
 			
 			if(file.size<1024000)
 			sendFile(file,$(this).parent());
 			else alert("图片过大！");
 		}
 		
 	}
	
	var img_count = <%=imgCount%>;
	$('#btn_dialog_conform').click(function(e){
		e.preventDefault();
		
		var imgSrc = $('#i_choose_img').val();
		if(!imgSrc)return;
		var imgDesp = $('#img_description').val();
		
		var img = $("<div class='ctn_img_added'><input type='hidden'  name='img_"+img_count+"' value='"+imgSrc+"'><img src='"+imgSrc+"'  class='img img-rounded' style='width:200px;height:100px;'><textarea  rows='5' cols='40' name='imgDesp_"+img_count+"' style='vertical-align: middle;'>"+imgDesp+"</textarea><button class='btn btn-danger btn_del_img' >删除</button>");
		$('#myModal').modal("hide");
		$('#ctn_case_img').append(img);
		img.children(".btn_del_img").click(function(e){
			e.preventDefault();
			$(this).parent().remove();
			
		});
	});
	
	$("#ctn_case_img .btn_del_img").click(function(e){
		e.preventDefault();
		$(this).parent().remove();
		imgIdsRemoved.push($(this).data('imgid'));
		
	});
});
</script>
</html>