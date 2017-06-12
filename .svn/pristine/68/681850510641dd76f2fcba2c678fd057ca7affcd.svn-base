(function ( $ ) {
	
	
	


    $.fn.imagemgr = function( options ) {
 
        // This is the easiest way to have default options.
        var settings = $.extend({
            // These are the defaults.
        	
            imgs:"",
            imgCount:1,
            autoUpload:true
        }, options );
//        var imgItemTpl = $("<div class='img-item hidden'> <span class='preview'> </span> <div class='information img-rounded '> <span class='glyphicon glyphicon-zoom-in' style='color: white;'></span> </div> <button class='btn btn-danger glyphicon glyphicon-trash del'></button><div id='progress' class='progress' style='margin-bottom: 5px;'> <div class='progress-bar progress-bar-danger'></div> </div> <span class='text-success info' /></div>");
        var imgItemTpl = $("<div class='img-item'> <span class='preview'> </span> <div class='information img-rounded ' > <span class='glyphicon glyphicon-zoom-in' style='color: white;'></span> </div> <button class='btn btn-danger glyphicon glyphicon-trash del'></button><button class='btn btn-success glyphicon glyphicon-edit edit'></button><div id='progress' class='progress' style='margin-bottom: 5px;'> <div class='progress-bar progress-bar-danger'></div> </div> <span class='text-success info' /></div>");
    	var imgUrls = [];
    	var imgCount = settings.imgCount;
    	
    	
    	
    		
    $imgMgrCtn = $("<div class='container-fluid'> </div>")
    .append("<div class='row panel-body files'> <input type='hidden' name='summary_img'> <div class='panel-body add'> </div> </div>")
    .append("<span class='btn btn-primary fileinput-button'>  <i class='glyphicon glyphicon-plus'></i> <span>选择图片</span>  <input  id='fileupload' type='file' name='file[]' multiple></span>");
    this.append($imgMgrCtn);
    var imgArr = settings.imgs?settings.imgs.split(','):[];
	for (var int = 0; int < imgArr.length; int++) {
		if(imgArr[int].trim()){
			
			imgUrls.push(imgArr[int]);
			
			var initItemTpl = $("<div class='panel-body img-init'></div>");;
			initItemTpl.append(imgItemTpl.clone(true));
			initItemTpl.find(".preview").append("<a onclick='return false;' class='img_link' href='"+imgArr[int]+"'><img   src='"+imgArr[int]+"' ></a>");
			initItemTpl.find(".files .del").data("index",int);
			$imgMgrCtn.find(".files .add").append(initItemTpl);
		}
		
		
	}
	if(imgUrls.length>0){
		 if($imgMgrCtn.data("lightGallery")){
	        	$imgMgrCtn.data("lightGallery").destroy("true");
	        }
	        $imgMgrCtn.lightGallery({selector:".img_link"});
	}
	
	 $imgMgrCtn.find(".files input[name='summary_img']").val(imgUrls.join(','));
	

	 $imgMgrCtn.find(".img-init .del").bind("click",function(e){
		 e.preventDefault();
    	imgUrls.splice($(this).data("index"),1);
    	$(this).parent().parent().remove();
    	
    	var urls = "";
    	$.each(imgUrls,function(index,item){
    		if(item.trim()){
    			urls+=item+",";
    		}
    	});
    	 $imgMgrCtn.find(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
    });
    
    $imgMgrCtn.find(".fileinput-button").click(function(){
    		if($imgMgrCtn.find(".files .img-item").size()==imgCount){
    			alert("最多添加"+imgCount+"张图片");
    			return false;
    		}
    		
    		return true;
    	});
    $imgMgrCtn.find('#fileupload').fileupload({
    	        url: "/ejwms/file/uploadImgJson",
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
    	        imageCrop:false,
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
    		        tpl.find(".del").bind("click",function(e){
    		        	e.preventDefault();
    		        	imgUrls.splice($(this).data("index"),1);
    		        	$(this).parent().parent().remove();
    		        	
    		        	var urls = "";
    		        	$.each(imgUrls,function(index,item){
    		        		if(item.trim()){
    		        			urls+=item+",";
    		        		}
    		        	});
    		        	$imgMgrCtn.find(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
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
    	            	data.context.find(".information").data("src",file.url);
    	            	data.context.find(".preview canvas").replaceWith("<a class='img_link' href='"+file.url+"'><img src='"+file.url+"'></a>");
    	            	imgUrls[data.context.find(".del").data('index')] = file.url;
    	            	var urls = "";
    		        	$.each(imgUrls,function(index,item){
    		        		if(item.trim()){
    		        			urls+=item+",";
    		        		}
    		        	});
    		        	$imgMgrCtn.find(".files input[name='summary_img']").val(urls.substring(0,urls.length-1));
    	            } else if (file.error) {
    	                var error = data.context.find(".info").text(file.error);
    	            }
    	        });
    	        if($imgMgrCtn.data("lightGallery")){
    	        	$imgMgrCtn.data("lightGallery").destroy("true");
    	        }
    	        $imgMgrCtn.lightGallery({
    	            selector: '.img_link'
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
        return this
 
    };
 
}( jQuery ));