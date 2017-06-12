<%@ tag language="java" pageEncoding="UTF-8"%>

<%@ attribute name="id" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="initUrl" type="java.lang.String" required="true" description="初始图片url（逗号分隔）"%>
<%@ attribute name="serverUrl" type="java.lang.String" required="true" description="上传服务器url"%>
<%@ attribute name="autoUpload" type="java.lang.Boolean" required="true" description="初始图片url（逗号分隔）"%>
<%@ attribute name="mode" type="java.lang.String" required="true" description="动态添加(added)或者固定修改(fixed)"%>
<%@ attribute name="defaultImg" type="java.lang.String" required="true" description="默认图片(针对固定模式)"%>
<%@ attribute name="fixedCount" type="java.lang.String" required="true" description="初始图片数量（对固定模式有效）"%>
<%@ attribute name="maxCount" type="java.lang.String" required="true" description="最大可添加的图片数量（对动态模式有效）"%>
<%@ attribute name="multiSelect" type="java.lang.Boolean" required="true" description="是否可多选（对动态模式有效）"%>
<%@ attribute name="crop" type="java.lang.Boolean" required="true" description="是否开启裁剪功能（对图片多选无效）"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输出图片url的input元素名称（逗号分隔）"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="输出图片url的input元素名称（逗号分隔）"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="输出图片url的input元素名称（逗号分隔）"%>
<%@ attribute name="maxFileSize" type="java.lang.String" required="true" description="输出图片url的input元素名称（逗号分隔）"%>

<style>
 .bootstrap-dialog .modal-header.bootstrap-dialog-draggable {
                cursor: move;
            }
</style>
<div class="container-fluid" id="${id }">
	<div class="row">
		<input type="hidden" name="${name }">
		<div class="items"></div>
	
	
		<div class="btn_add ${mode=="fixed"?"hidden":"" }"  style="clear: both;">
	
			<span class='btn btn-primary fileinput-button'> 
				<i class='glyphicon glyphicon-plus'></i> 
				<span>添加图片</span> 
				<input class='input_choose ' type='file' name='file[]'>
			</span>
		</div>
	</div>
	

</div>

<script type="text/javascript">
$(function(){
	
//@ sourceURL=imageManage.tag.js

	var itemTpl = $(".template .item_template").clone(true).removeClass("hidden");
	var dialogTpl = $(".template .dialog_body_template").clone(true).removeClass("hidden");
	
	var initUrl = "${initUrl}";
	var urlArr = initUrl?initUrl.split(','):[];
	if(urlArr.length==0){
		var item = itemTpl.clone(true);
		$("#${id} .items").append(item);
   	 
   		 item.find(".preview").html($('<img src="${defaultImg}" style="height:${height}px;width:${width}px;">'));
    	
    	
        var btnDel =  item.find(".btn_delete");
        if(${mode=="fixed"}){
        	btnDel.parent().removeClass("btn-group");
        }else{
        	btnDel.prop("disabled",true);
        	btnDel.click(function(e){
	        	e.preventDefault();
	        });
        }
        
        
		
		//绑定选择事件
		var btnChoose =  item.find(".btn_choose");
		btnChoose.click(function(e){
        	e.preventDefault();
        	$('#${id } .input_choose').data("itemIndex",$("#${id} .items .item").index(item)+"");
        	$('#${id } .input_choose').click();
        });
	}else{
		for (var int = 0; int < urlArr.length; int++) {
			if(urlArr[int].trim()){
				
				
				var item = itemTpl.clone(true);
				$("#${id} .items").append(item);
				item.data("src",urlArr[int]);
	       	 
	       		 item.find(".preview").html($('<img src="' + urlArr[int] + '">'));
	        	
	        	
		        var btnDel =  item.find(".btn_delete");
		        if(${mode=="fixed"}){
		        	btnDel.parent().removeClass("btn-group");
		        }else{
		        	btnDel.click(function(e){
			        	e.preventDefault();
			        	$(this).parents(".item").remove();
			        	
			        	
			        	var urls = "";
			        	
			        	var items = $("#${id} .items .item");
		           		items.each(function(index,item){
			        		var src = $(item).data("src");
			        		if(src.trim()){
			        			urls+=src+",";
			        		}
			        	})
			        	$("#${id} input[name='${name }']").val(urls.substring(0,urls.length-1));
			        });
		        }
		        
		        
				
				//绑定选择事件
				var btnChoose =  item.find(".btn_choose");
				btnChoose.click(function(e){
		        	e.preventDefault();
		        	$('#${id } .input_choose').data("itemIndex",$("#${id} .items .item").index(item)+"");
		        	$('#${id } .input_choose').click();
		        });
			}
		}
		
		var urls = "";
		var items = $("#${id} .items .item");
		items.each(function(index,item){
			var src = $(item).data("src");
			if(src.trim()){
				urls+=src+",";
			}
		});
		$("#${id} input[name='${name }']").val(urls.substring(0,urls.length-1));
	}
	
	
	
	$('#${id } .input_choose').fileupload({
        url: "${serverUrl}",
        dataType: 'json',
        autoUpload: ${autoUpload},
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 4096000,
        // Enable image resizing, except for Android and Opera,
        // which actually support image resizing, but fail to
        // send Blob objects via XHR requests:
        disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
        previewMaxWidth: ${width},
        previewMaxHeight: ${height},
        previewCrop:false,
		previewCanvas:false,
        formData:{},
        paramName:"file[]",
        messages:{
        	maxFileSize:"文件太大"
        }
        
    }).on('fileuploadadd', function (e, data) { 
    }).on('fileuploadprocessalways', function (e, data) {
        var index = data.index,
            file = data.files[index];
        
        if (file.preview) {
        	 var item = itemTpl.clone(true);
        	 item.data("src","");
        	 
        	 item.find(".preview").append($(file.preview));
	        var btnDel =  item.find(".btn_delete");
	        
	        btnDel.bind("click",function(e){
	        	e.preventDefault();
	        	$(this).parents(".item").remove();
	        	
	        	
	        	var urls = "";
	        	
	        	var items = $("#${id} .items .item");
            	items.each(function(index,item){
	        		var src = $(item).data("src");
	        		if(src.trim()){
	        			urls+=src+",";
	        		}
	        	})
	        	$("#${id} input[name='${name }']").val(urls.substring(0,urls.length-1));
	        });
	        
	        
			
			//绑定选择事件
			var btnChoose =  item.find(".btn_choose");
			btnChoose.bind("click",function(e){
	        	e.preventDefault();
	        	$('#${id } .input_choose').data("itemIndex",$("#${id} .items .item").index(item)+"");
	        	$('#${id } .input_choose').click();
	        });
			
			
			if(${crop}&&(('${mode}'=='added'&&!${multiSelect})||'${mode}'=='fixed')){
				var dilog = BootstrapDialog.show({
	        		size:BootstrapDialog.SIZE_WIDE ,
	        		title:"剪切轮播图",
	        		draggable: true,
	        		closable:false,
	        		message:function(dialog){
	        			return dialogTpl;
	        		},
	        		onshown:function(dialog){
	        			var modalBody = dialog.getModalBody();
	        			var  url = URL.createObjectURL(data.files[0]);
	        			var img = $('<img src="' + url + '">');
	        			modalBody.find(".avatar-preview").html(img.clone(true)); 
	        			
	        			var cropImg = img.clone(true);
	        			modalBody.find('.avatar-wrapper').html(cropImg);
	        			
	        			$(".btn-group button").on('click', $.proxy( function(e) {
	        			    var data=$(e.currentTarget).data();
        			        if (data.method) {
        			        	cropImg.cropper(data.method, data.option);
        			        }
	        			}, this));
	        			cropImg.cropper({
	        	          aspectRatio: 1126/540,
	        	          viewMode:0,
	        	          zoomable:false,
	        	          movable:false,
	        	          toggleDragModeOnDblclick:false,
	        	          minCropBoxWidth:100,
	        	          preview: '.avatar-preview',
	        	          
	        	          crop: function (e) {
	        	            var json = [
	        	                  '{"x":' + e.x,
	        	                  '"y":' + e.y,
	        	                  '"height":' + e.height,
	        	                  '"width":' + e.width,
	        	                  '"rotate":' + e.rotate + '}'
	        	                ].join();

	        	            console.info(json);
	        	            data.formData = JSON.parse(json);
	        	          }
	        	        });
	        		},
	        		buttons: [{
		                id: 'btn_upload',
		                label: '上传',
		                cssClass:'btn-primary',
		                action: function(dialog) {
		                		dialog.close();
							    data.submit();           	
		                }
		            },{
		            	label: '取消',
		                action: function(dialog) {
		                    dialog.close();
		                   
		                    if($('#${id } .input_choose').data("itemIndex")){
		                    	var item = data.context;
		                    	var oldItem = item.oldItem;
		                    	var btnChoose =  oldItem.find(".btn_choose");
		        				
		                    	item.replaceWith(oldItem);
		                    	btnChoose.click(function(e){
		        		        	e.preventDefault();
		        		        	$('#${id } .input_choose').data("itemIndex",$("#${id} .items .item").index(oldItem)+"");
		        		        	$('#${id } .input_choose').click();
		        		        });
		    		        }else{
		    		        	 data.context.remove();
		    		        }
		                }
		            }]
	        	});
				
				
				
			}
	        
			var itemIndex = $('#${id } .input_choose').data("itemIndex");
	        if(itemIndex>=0){
	        	item.oldItem=$("#${id} .items .item:eq("+itemIndex+")");
	        	$("#${id} .items .item:eq("+itemIndex+")").replaceWith(item);
	        	/* $("#${id} .items .item:eq("+itemIndex+")").remove();
	        	if(itemIndex==0){
	        		item.appendTo("#${id} .items");
	        	}else{
	        		item.insertAfter("#${id} .items .item:eq("+(itemIndex-1)+")");
	        	} */
	        	
	        	
	        }else{
	        	$("#${id} .items").append(item);
	        }
	        
	        
	        data.context = item;
        }
        if (file.error) {
        	BootstrapDialog.alert(file.error);
        }
    }).on('fileuploadprogress', function (e, data) {
    	var progress = Math.floor(data.loaded / data.total * 100);
        if (data.context) {
        	data.context.find('.progress')
                    .children().first().css(
                        'width',
                        progress + '%'
                    );
        }
    }).on('fileuploadprogressall', function (e, data) {
    }).on('fileuploaddone', function (e, data) {
    	
    	data.context.find('.progress-bar').removeClass("progress-bar-danger").addClass("progress-bar-success");
    	 data.context.find(".progress-bar").text("上传成功");
    	
        $.each(data.result.files, function (index, file) {
            if (file.url) {
            	data.context.data("src",file.url);
            	//data.context.find(".information").data("src",file.url);
            	//data.context.find(".preview img").replaceWith("<img src='"+file.url+"' style='max-height:${height}px; max-width:${width}px;'>");
            	var urls = "";
            	var items = $("#${id} .items .item");
            	items.each(function(index,item){
	        		var src = $(item).data("src");
	        		if(src.trim()){
	        			urls+=src+",";
	        		}
	        	})
	        	$("#${id} input[name='${name }']").val(urls.substring(0,urls.length-1));
            	$('#${id } .input_choose').removeData("itemIndex");
            } else if (file.error) {
                var error = data.context.find(".progress-bar").text(file.error);
            }
        });
        
    }).on('fileuploadfail', function (e, data) {
        $.each(data.files, function (index,file) {
        	data.context.find(".progress-bar").text(file.error);
        });
        if($('#${id } .input_choose').data("itemIndex")){
        	var item = data.context;
        	var oldItem = item.data("oldItem");
        	item.replaceWith("oldItem");
        }else{
        	 data.context.remove();
        }
    }).prop('disabled', !$.support.fileInput)
     .parent().addClass($.support.fileInput ? undefined : 'disabled');
	
	
	 



});
</script>
<div class="hidden template">
	<div class="item item_template pull-left">
		<div class="preview avatar-preview alert alert-success" style="text-align: center;margin-bottom: 0px;height: ${height}px;width:${width }px;max-width:${width }px;padding:0px;"></div>
		<div class="progress" style="margin-bottom: 0px;">
			 <div class='progress-bar progress-bar-success progress-bar-striped'></div>
		</div>
		<div class="toolbar" style="text-align: center;">
			<div class="btn-group">
			  <button type="button" class="btn btn-primary btn_choose">选择</button>
			  <!-- <button type="button" class="btn btn-success btn_crop">裁剪</button> -->
			  <button type="button" class="btn btn-danger btn_delete ${mode=="fixed"?"hidden":"" }">删除</button>
			  <!-- <button type="button" class="btn btn-success btn_upload">上传</button> -->
			</div>
		</div>
	</div>

	<div class="container-fluid dialog_body_template" id="crop-avatar">

		<div class="avatar-body">
			<!-- Upload image and data -->
			<!-- <div class="avatar-upload">
				<input type="hidden" class="avatar-src" name="avatar_src"> <input type="hidden" class="avatar-data" name="avatar_data">
			</div> -->

			<!-- Crop and preview -->
			<div class="row">
				<div class="col-md-9">
					<div class="avatar-wrapper"></div>
				</div>
				<div class="col-md-3">
					<div class="row">
						<div class="avatar-preview preview-lg" style="width: 100%"></div>
						<!-- <div class="avatar-preview preview-md"></div>
						<div class="avatar-preview preview-sm"></div> -->
					</div>
					<div class="row">
							<div class="btn-group avatar-btns">
								<!-- <button type="button" class="btn btn-success" data-method="rotate" data-option="-45">
						            <span class="docs-tooltip" data-toggle="tooltip" title="旋转-45度">
						              <span class="fa fa-rotate-left"></span>
						            </span>
						          </button> -->
						          
						          <button type="button" class="btn btn-success" data-method="rotate" data-option="90">
						            <span class="docs-tooltip" data-toggle="tooltip" title="旋转90度">
						              <span class="fa fa-rotate-right"></span>
						            </span>
						          </button>
						          
						          <button type="button" class="btn btn-success" data-method="reset" >
						            <span class="docs-tooltip" data-toggle="tooltip" title="重置">
						              <span class="fa fa-refresh"></span>
						            </span>
						          </button>
						          
						          
								
							</div>
							
					</div>
					
				</div>
			</div>

		</div>

	</div>
</div>


