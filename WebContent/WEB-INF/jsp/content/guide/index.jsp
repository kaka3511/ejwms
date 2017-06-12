<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   	<title>办事指南</title>
   	<%@ include file="../../base/taglib.jsp"%>
   	<%@ include file="../../base/importCss.jsp"%>

   <style type="text/css">

   .help-block{
     color:red;
     float: left;
     position: relative;
    }
   .jstree-organize-icon {
    background-image: url(../images/organize.png) !important;
}
#Content-Left{
   width: 350px;
   margin: 5px 5px 5px 20px;/*设置元素跟其他元素的距离为20像素*/
   float:left;/*设置浮动，实现多列效果，div+Css布局中很重要的*/
   
}
#Content-Main{
    width: 890px;
    margin: 0px 5px 5px 5px;/*设置元素跟其他元素的距离为20像素*/
    float:left;/*设置浮动，实现多列效果，div+Css布局中很重要的*/
}
 .display{
   display:block;
 }
   </style>
   	<!-- BEGIN PAGE LEVEL SCRIPTS -->
   	<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
   	<%@ include file="../../base/importJs.jsp"%>
   	<link rel="stylesheet" href="<c:url value='/plugins/font-awesome-master/css/font-awesome.min.css'/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value='/plugins/summernote-develop/dist/summernote.css'/>" type="text/css"/>
   	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.min.css'/>" />
   	<script type="text/javascript" src="<c:url value='/js/jstree.min.js'/>"></script>
   	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/page.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ajaxfileupload.js'/>"></script>
<script type="text/javascript" src="<c:url value='/plugins/kindeditor/kindeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/plugins/kindeditor/lang/zh_CN.js'/>"></script>
   	<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<ul class="page-breadcrumb breadcrumb">
                  <li>
                     <i class="icon-cog"></i>内容管理
                  </li>
                  <li>办事指南</li>
               </ul>
<div class="panel panel-info" style="position: relative;">

   	 	<div class="panel-heading" style='overflow: hidden;height: 50px;'>
							办事指南列表
       <button class="btn btn-primary add addEntityBtn"  style="float:right; right: 30px; top: 12px;">添加</button>
   	</div>
   	<div class="panel-body">
   		<div class="col-md-3" style="overflow: scroll; height: 610px;">
				<div id="tree_part"></div>
   		
   		
   		</div>
	   	<div class="col-md-9">
	   		 <table id="account_table" class="table table-bordered table-striped table-hover">
	            <thead>
	                <tr style="background: #F5F5F5;">
	                  <th class="text-center" style="background: #3499db;color: #ffffff;">序号</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">标题</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;width:20%">摘要</th>
<!-- 	                     <th class="text-center" style="background: #3499db;color: #ffffff;">发布人</th> -->
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">发布时间</th>
	                    <th class="text-center" style="background: #3499db;color: #ffffff;">操作</th>
	                </tr>
	            </thead>
	        </table>
        </div>
   	</div>
</div>

	<!-- 添加 -->
	<input type="file" id='choose_img' style="display: none">
<div class="modal fade" id="entityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="width: 900px;">
      <div class="modal-content">
		<form class="addtable addform" action="" method="post">
         <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="entityLabel"></h4>
		 </div>
         <div class="modal-body">
				<input  type="hidden" name="id" id="id" />
				<input  type="hidden" name="subject_id" id="subject_id" />
				<div class="form-group">
					<div class="input-group" style="width: 95%;">
						<label class="input-group-addon" style="width: 100px;">标题：</label>
						<input class="_account form-control" name="title" id="title"
							style="width: 100%;" />
					</div>
				</div>
				
				<div class="form-group">
					<div class="input-group" style="width: 95%;">
						<label class="input-group-addon" style="width: 100px;">摘要：</label>
						<textarea rows='2' class="form-control"  name="summary" id="summary" ></textarea>
						
					</div>
				</div>
                <div class="form-group">
				  <div class="input-group" style="width: 100%;">
					<label class="input-group-addon" style="width: 100px;">摘要图标</label>
					    <input type="hidden" name='summary_img' id='summary_img'>
					    <img class='img-rounded' src="./images/idcard_default_290_186.png" style='width: 300px; height: 150px;' />
						<button class='btn btn-primary' id="btn_add_summary_img" style='margin-top: 20px; display: block;'>选取图片</button>
					</div>
				</div>
				
				<div class="form-group">
					<div class="input-group" style="width: 95%;">
						<label class="input-group-addon" style="width: 100px;">内容：</label>
						<textarea id="content" name="content" style="width:100%;height:350px;" class="textArea"></textarea>
					</div>
				</div>
		</div>
        
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal" onclick="javascript:$('.addform').validate().resetForm();$('.addform')[0].reset();">关闭
            </button>
            <input class="btn btn-primary addchild" id="param_summit"name="submit" type="submit" value="保存" />
         </div>
         </form>
          </div>
      </div>
      </div>
</body>
<script type="text/javascript">
var bData,json;
$(function() {
	/* $('.modal').attr("data-backdrop","false");
 	$('#tree_part').jstree({
		'core' : {
			"themes" : { "stripes" : true },
			'data' : {
				"url" : "/ejwms/Subject/subjectTree.do",
				"dataType" : "json",
				"async": true, 
				"data":function(node){
					 return {"id" : 0};
		        }
			},
			"plugins" : [ "contextmenu" ]
		}
	}).on("select_node.jstree", function(e, data){
		var code=data.node.original.code;
		var deptTypeNo='';
		if(code=='10'){
			type='1';
			deptTypeNo=data.node.original.role;
			$(".addEntityBtn").hide();
		}else{
			if(code=='20'){
				type='2';
				deptTypeNo=data.node.id;
			}else{
				type='3';
				deptTypeNo=0;

			}
			$(".addEntityBtn").show();
		}
		query(deptTypeNo,type);
	}).on("open_node.jstree", function(e, data) {
			
		}).on("loaded.jstree", function() {
			$('#tree_part').jstree("open_all");
		}); */

     
		//我的门店table列表
		$("#account_table")
				.dataTable(
						{
							serverSide : false, //分页，取数据等等的都放到服务端去
							processing : true, //载入数据的时候是否显示“载入中”
							pageLength : 10, //首次加载的数据条数
							ordering : false, //排序操作
							stateSave : true,
							"bLengthChange" : false,
							"bPaginate" : true, //翻页功能
							"bFilter" : true,
							"bDeferRender" : true,
							ajax : {//类似jquery的ajax参数，基本都可以用。
								type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
								url : "/ejwms/Subject/getSubjectContentList.do",
								dataType : "json",
								dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
								data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
									var p = {};
									p.deptTypeNo = 0;
									p.type=0;
									return p;
								},
							},
							"aoColumnDefs" : [ {
								sDefaultContent : '',
								aTargets : [ '_all' ]
							} ],
							columns : [//对应上面thead里面的序列
									{
										data : "xh",
										"sClass" : "text-center"
									},
									{
										data : "title",
										"sClass" : "text-center"
									},
									{
										data : "summary",
										"sClass" : "text-center"
									},
									/* {
										data : "cuser",
										"sClass" : "text-center"
									}, */
									{
										data : "updatetime",
										"sClass" : "text-center"
									},
									{
										data : function(e) {//这里给最后一列返回一个操作列表
											//e是得到的json数组中的一个item ，可以用于控制标签的属性。
											 var sContent = '<button class="btn-primary modify">修改</button>&nbsp;&nbsp;&nbsp;<button class="btn-primary delete" >删除</button>';
											
											return sContent; 
										},
										"sClass" : "text-center"
									} ],
							initComplete : function(setting, data) {
								/* if(data.total!=null){
									PageSpace.initPages(document.getElementById("page"), data.total, 10, pageEvent);
								} */
								$('.modal').attr("data-backdrop","false");
							 	$('#tree_part').jstree({
									'core' : {
										"themes" : { "stripes" : true },
										'data' : {
											"url" : "/ejwms/Subject/subjectTree.do",
											"dataType" : "json",
											"async": true, 
											"data":function(node){
												 return {"id" : 0};
									        }
										},
										"plugins" : [ "contextmenu" ]
									}
								}).on("select_node.jstree", function(e, data){
									var code=data.node.original.code;
									var deptTypeNo='';
									if(code=='10'){
										type='1';
										deptTypeNo=data.node.original.role;
										$(".addEntityBtn").hide();
									}else{
										if(code=='20'){
											type='2';
											deptTypeNo=data.node.id;
										}else{
											type='3';
											deptTypeNo=0;

										}
										$(".addEntityBtn").show();
									}
									query(deptTypeNo,type);
									/* $(".form-control").val(""); */
									
								}).on("open_node.jstree", function(e, data) {
										
									}).on("loaded.jstree", function() {
										$('#tree_part').jstree("open_all");
									});
							},
							"fnDrawCallback": function(){
						            var oTable = $("#account_table").dataTable();
						            $("#redirect").keyup(function(e){
						                if($(this).val() && $(this).val()>0){
						                    var redirectpage = $(this).val()-1;
						                }else{
						                    var redirectpage = 0;
						                }
						                oTable.fnPageChange( redirectpage );
						            });
						        },
							language : {
								lengthMenu : '<select class="form-control input-xsmall">'
										+ '<option value="5">5</option>'
										+ '<option value="10">10</option>'
										+ '<option value="20">20</option>'
										+ '<option value="30">30</option>'
										+ '<option value="40">40</option>'
										+ '<option value="50">50</option>'
										+ '</select>条记录',//左上角的分页大小显示。
								processing : "载入中",//处理页面数据的时候的显示
								paginate : {//分页的样式文本内容。
									previous : "上一页",
									next : "下一页",
									first : "第一页",
									last : "最后一页"
								},
								search : "关键字查询      ",
								zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
								//下面三者构成了总体的左下角的内容。
								info : "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
								infoEmpty : "0条记录",//筛选为空时左下角的显示。
								infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
							}
						});
	});

	var currentDeptTypeNo=0,currentType=0;

	//查询
	function query(deptTypeNo,type) {
		currentDeptTypeNo = deptTypeNo;
		currentType = type;
		$("#account_table").dataTable().fnClearTable();
		$.ajax({
			type : "post",//不写此参数默认为get方式提交
			async : false, //设置为同步
			url : "/ejwms/Subject/getSubjectContentList.do",//请求的uri
			data : {deptTypeNo:deptTypeNo,type:type},//传递到后台的参数				
			cache : false,
			dataType : 'json',//后台返回前台的数据格式为json
			success : function(data) {
				if(data.data.length){
					$("#account_table").dataTable().fnAddData(data.data, true);	
				}
			}
		});

	};

	//新增
	var editor;
	
	$(document).on('click','.addEntityBtn',function(){
		var node = $('#tree_part').jstree().get_selected(true)[0];
		if(node){
			$('#entityLabel').html("办事指南添加");
			$('#entityModal').modal('show');
			$('.addform')[0].reset();
			editor.html("");
			$('#id').val(0);
			var code=node.original.code;
			$('.img-rounded').hide();
			if(code=='10'){
				$('#subject_id').val(node.original.role);
			}else{
				if(code=='20'){
					$('#subject_id').val(node.id);
				}
			}
		}else{
			BootstrapDialog.alert("请先选择左边科目节点，不能选单位");
		}
		
	});

	//新增设备提交
	

	KindEditor.ready(function(K) {
		editor = K.create('#content');//editor.html();
		$('.addform').submit(function () {$('#content').val(editor.html());
		if($(".addform").valid()){
				$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/Subject/saveSubjectContent.do",//请求的uri
				data : $('.addform').serialize(),//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data){
				
				/* url : "/ejwms/Subject/saveSubjectContent.do",//请求的uri 
				type:"POST",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				secureuri : false,//安全协议  
				dataType : 'html',
				fileElementId:'uploadImg',
	      		data : $('.addform').serialize(),//传递到后台的参数				
	      		success : function(data) { */
	      			if(data){
		      			$('.addform')[0].reset();
						$('#entityModal').modal('hide');
						BootstrapDialog.alert("操作成功!");	
						query(currentDeptTypeNo, currentType); 
						/* $("#account_table").dataTable().page($("#account_table").dataTable().page()).draw(false); */
					/* 	$("#account_table").dataTable().fnReloadAjax();
						$('#tree_part').jstree().refresh();  */
	      			}
		      	},error: function () {
		      		BootstrapDialog.alert('系统出现异常，请稍后再试!');
		        }}); 
		  	}
			return false;
		});
	});
	//修改设备
	$(document).on('click','.modify',function(){//修改方案	
		$('#entityLabel').html("办事指南修改");
		$('.addform')[0].reset();
		$('.addform').validate().resetForm();
		aData = $("#account_table").DataTable().row($(this).parents("tr")).data();
		$('#id').val(aData.id);
		$('#title').val(aData.title);
		$('#summary').val(aData.summary);
		var img=aData.summary_img;
		$('#summary_img').val(img);
		$('.img-rounded').attr('src', img);
		if(img!=null&&img.length>0){
			$('.img-rounded').show();
		}else{
			$('.img-rounded').hide();
		}
		editor.html(aData.content)
		$('#subject_id').val(aData.subject_id);
		$('#entityModal').modal('show');
	});


	//删除设备
	$(document).on('click','.delete',function(){
		if (confirm("你确定要删除吗?"))  {  
			aData = $("#account_table").DataTable().row($(this).parents("tr")).data();
			$.ajax( {
					type:"post",//不写此参数默认为get方式提交
					async:false,   //设置为同步
					url : "/ejwms/Subject/deleteSubjectContent.do",//请求的uri
					data : {id:aData.id},//传递到后台的参数				
					cache : false,
					dataType : 'json',//后台返回前台的数据格式为json
					success : function(data) {
						BootstrapDialog.alert("删除成功!");
						$('.addform')[0].reset();
						$('#entityModal').modal('hide');
						$("#account_table").dataTable().fnReloadAjax();
						$('#tree_part').jstree().refresh();
			},error: function () {
				BootstrapDialog.alert('系统出现异常，请稍后再试!');
	        }}); 
		}
	});


	//添加验证
	$(function(){
	  $(".addform").validate({  
		  errorElement: 'em', 
			  errorClass: 'help-block',
			  focusInvalid: false,   
			  rules:{
		        	title:{
		                required:true,
		                byteRangeLength:[0,100]
		            },
		            summary:{
		            	byteRangeLength:[0,500]
		            }
		        },
		        messages:{
		        	title:{
		                required:"必填",
		                byteRangeLength:"名称不超过100位(汉字占2位)"
		            },
		            summary:{
		            	byteRangeLength:"描述不超过500位(汉字占2位)"
		            }           
		        }
	  });
	});
	
	jQuery.validator.addMethod("byteRangeLength", function(value, element,
			param) {
		var length = value.length;
		for (var i = 0; i < value.length; i++) {
			if (value.charCodeAt(i) > 127) {
				length++;
			}
		}
		return this.optional(element)
				|| (length >= param[0] && length <= param[1]);
	}, "不得多余16字");

	
	
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
						$('.img-rounded').show();
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
	
</script>
<!-- END BODY -->

</html>