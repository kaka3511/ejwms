<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../base/taglib.jsp"%>
</head>
<body>
	<div class="panel panel-info">

		<div class="panel-heading"><span class="action"></span>轮播图</div>
		<div class="panel-body">
			<form class="form-horizontal form_carousel" >
				<input type="hidden" name="oper" value="${oper }">
				<input type="hidden" name="id" value="${record.id }">
				
				<div class='form-group'>
					<label class='col-sm-2 control-label'>轮播图：</label>
					<div class='col-sm-10'>
						<sys:imageCropper name="dictionary_img" id="dictionary_img" serverUrl="${ctx }/file/uploadImgJson" maxCount="4" 
						initUrl="${record.dictionary_img }" mode="fixed" fixedCount="1" defaultImg="${ctx }/images/card_default_148_96.png" autoUpload="false" maxFileSize="" width="300" 
						height="150" multiSelect='false' crop="true"></sys:imageCropper>
					</div>
				</div>

				<div class='form-group '>
					<label class='col-sm-2 control-label'>排序：</label>
					<div class='col-sm-10'>
						<p class='field_show'>${record.dictionary_order}</p>
						<input type="number" name="dictionary_order" class="form-control  field_edit" placeholder="整数值" value="${record.dictionary_order}">
					</div>
				</div>
				<div class='form-group'>
					<label class='col-sm-2 control-label'>名称：</label>
					<div class='col-sm-10'>
						<p class='field_show'>${record.dictionary_name}</p>
						<input type="text" name="dictionary_name" class="form-control  field_edit " value="${record.dictionary_name}">
					</div>
				</div>

				<div class='form-group'>
					<label class='col-sm-2 control-label'>编码：</label>
					<div class='col-sm-10'>
					<p class='field_show'>${record.dictionary_code}</p>
						<input type="text" name="dictionary_code" class="form-control  field_edit " value="${record.dictionary_code}">
					</div>
				</div>

				<div class='form-group'>
					<label class='col-sm-2 control-label'>值：</label>
					<div class='col-sm-10'>
					<p class='field_show'>${record.dictionary_value}</p>
						<input type="text" name="dictionary_value" class="form-control  field_edit " value="${record.dictionary_value}">
					</div>
				</div>
				
				<div class='form-group form_footer'>
					<div class='col-sm-offset-2 col-sm-10'>
						<c:if test='${oper=="update"||oper=="add" }'>
							<button class="btn btn-primary expand-right btn_save">保存</button>
							<button class="btn btn-success btn_cancel">取消</button>
						</c:if>
						
					</div>
				</div>

			</form>
		</div>
	</div>



</body>

<script type="text/javascript">
$(function() {
	var oper = $("input[name='oper']").val();
	var operName = oper=="show"?"查看":(oper=="add"?"添加":"修改");
	$(".action").text(operName);
	
	
	
	if(oper=="update"||oper=="add"){
		$(".field_show").hide();
		$(".btn_save").click(function(e){
			e.preventDefault();
			if($(".dictionary_img").val()){
				BootstrapDialog.alert("请先上传轮播图");
				return;
			}
			
			$.ajax({
				url:"<c:url value='/carousel/'/>"+oper,
				data:$(".form_carousel").serialize(),
				type:"post",
				success:function(responseText){
					//if(oper=="update")$("form").reset();
				
					if(responseText.code==0){
						BootstrapDialog.alert(operName+"成功！");
						$(".form-horizontal").hide();
						
						if(oper=="update"){
							$("#jqGrid").setRowData(responseText.data.id,{id:responseText.data.id,dictionary_order:responseText.data.dictionary_order,dictionary_img:responseText.data.dictionary_img,dictionary_name:responseText.data.dictionary_name,dictionary_code:responseText.data.dictionary_code,dictionary_value:responseText.data.dictionary_value,updatetime:responseText.data.updatetime,operation:""});
						}
						else if(oper=="add"){
							$("#jqGrid").addRowData(responseText.data.id,{id:responseText.data.id,dictionary_order:responseText.data.dictionary_order,dictionary_img:responseText.data.dictionary_img,dictionary_name:responseText.data.dictionary_name,dictionary_code:responseText.data.dictionary_code,dictionary_value:responseText.data.dictionary_value,updatetime:responseText.data.updatetime},"first");
						}
					}
					
				},
				error:function(){
					BootstrapDialog.alert(operName+"失败！");
				},
			});
		});
	}
	else{
		$(".field_edit").hide();
	}
	
	

});

//@ sourceURL=debug.js
</script>
</html>

