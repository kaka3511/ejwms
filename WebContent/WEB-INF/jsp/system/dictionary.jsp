<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统管理-数据字典管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.1,user-scalable=no">
<%@ include file="../base/taglib.jsp"%>
<%@ include file="../base/importCss.jsp"%>
<!-- END PAGE LEVEL STYLES -->
<style type="text/css">
.help-block {
	color: red;
	float: left;
	position: relative;
}
</style>
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css" />
<%@ include file="../base/importJs.jsp"%>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<!-- END PAGE LEVEL SCRIPTS -->
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<ul class="page-breadcrumb breadcrumb">
		<li><i class="icon-cog"></i>系统管理</li>
		<li>数据字典</li>
	</ul>
	<div class="panel panel-info" style="position: relative;">
		<div class="panel-heading">
							<br/>
							数据字典列表
							<br/>
        <button class="btn btn-primary add addEntityBtn"  style="position:absolute; right: 15px; top: 12px;">添加</button>
     	</div>

		<div class="panel-body">
			<table class="table table-bordered table-striped table-hover entity_table">
				<thead>
				 <tr style="background: #F5F5F5;">
                    <th class="text-center" style="background: #3499db; color: #ffffff; width: 5%;">序号</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 20%;">名称</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">编码</th>
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">创建时间</th>
<!-- 					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">更新时间</th> -->
<!-- 					<th class="text-center" style="background: #3499db; color: #ffffff; width: 10%;">操作人</th> -->
					<th class="text-center" style="background: #3499db; color: #ffffff; width: 15%;">操作</th>
                </tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 设备对话框 -->
	<div class="modal fade modalArea" id="entityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="entityLabel"></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal entityform" role="form">
						<div class="form-group">
						    <input type="hidden"  id="id" name="id">
						    <input type="hidden"  id="type" name="type">
						    <input type="file" id="uploadImg" name="uploadImg" style="display:none;">
							<label class="col-sm-2 control-label">名称</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="name" name="name"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">编码</label>
							<div class="col-sm-6"><input type="text" class="form-control col-sm-6" id="code" name="code"></div>
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="entity_summit">提交</button>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- END BODY -->
<script type="text/javascript">
var aData= null;
$(function() {
	$(".entity_table").dataTable({
		serverSide: false,	//分页，取数据等等的都放到服务端去
		processing: true,	//载入数据的时候是否显示“载入中”
		pageLength: 10,		//首次加载的数据条数
		ordering: false,		//排序操作
		"bLengthChange": false,
		"bPaginate": true, //翻页功能
		"bFilter": true,
		"bDeferRender": true,
		ajax:  {//类似jquery的ajax参数，基本都可以用。
			type: "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
			url: "/ejwms/dictionaryManage/dictionaryQuery.do",
			dataType: "json",
			dataSrc: "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
			data:function(d){
				var p={};
				p.js= $("#js").val();
				p.parentId = 0;
				return p;
			}
	    } ,
	    "columnDefs": [ {
            "searchable": false,
            "orderable": false,
            "targets": 0
        } ],
	    columns: [//对应上面thead里面的序列
	              {  data: "xh", "sClass" : "text-center" },
	              { data: "name", "sClass" : "text-center" },
	              { data: "code", "sClass" : "text-center" },
	              { data: "createtime", "sClass" : "text-center" },
// 	              { data: "updatetime", "sClass" : "text-center" },
// 	              { data: "username", "sClass" : "text-center" },
	              { data: function (e) {//这里给最后一列返回一个操作列表
	                    //e是得到的json数组中的一个item ，可以用于控制标签的属性。
	                  var  sContent = '<button class="btn btn-primary addChildBtn">子类管理</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-primary modify">修改</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-primary delete">删除</button>';
	                  return sContent;
	                }, "sClass" : "text-center"
	              }
	    ] ,
	    initComplete: function (setting, json) {
	        //初始化完成之后替换原先的搜索框。
	        //本来想把form标签放到hidden_filter 里面，因为事件绑定的缘故，还是拿出来。
	       // $(tablePrefix+"_filter").html("<form id='filter_form'>" + $("#hidden_filter").html() + "</form>");
	    },
	    language: {
	        lengthMenu: '<select class="form-control input-xsmall">' + '<option value="5">5</option>' + '<option value="10">10</option>' + '<option value="20">20</option>' + '<option value="30">30</option>' + '<option value="40">40</option>' + '<option value="50">50</option>' + '</select>条记录',//左上角的分页大小显示。
	        processing: "载入中",//处理页面数据的时候的显示
	        paginate: {//分页的样式文本内容。
	            previous: "上一页",
	            next: "下一页",
	            first: "第一页",
	            last: "最后一页"
	         },
	         search: "关键字查询      ",
	         zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
	         //下面三者构成了总体的左下角的内容。
	         info: "共_PAGES_页     显示_START_ -  _END_条",//左下角的信息显示，大写的词为关键字。
	         infoEmpty: "0条记录",//筛选为空时左下角的显示。
	         infoFiltered: ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
	    } 
	});   
});

//查询
$(document).on('click','.query',function(){
	$(".entity_table").dataTable().fnReloadAjax();  //刷新datatables
});

//添加子类
$(document).on('click','.addChildBtn',function(){
	var data = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	window.location.href="/ejwms/dictionaryManage/dictionaryChild/"+data.id+"?name="+encodeURI(data.name);
});

//添加设备对话框
$(document).on('click','.addEntityBtn',function(){
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	$('#id').val("");
	$('#type').val("0");
	$('#entityLabel').html("添加");
	$('#entityModal').modal('show');
});

//新增设备提交
$("#entity_summit").click(function () {
	if($(".entityform").valid()){
		$.ajaxFileUpload( {
			url : "/ejwms/dictionaryManage/saveDictionary.do",//请求的uri
			type:"POST",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				secureuri : false,//安全协议  
				dataType : 'text',
		 	    fileElementId:'uploadImg',
	      		data : {
	      			name:$('#name').val(),
	      			code:$("#code").val(),
	      			id:$("#id").val()
	      			},//传递到后台的参数				
	      		success : function(data) {
	      			console.log(data);
	      			if(data=='true'){
		      			$('.entityform')[0].reset();
		      			/* $(".entity_table").dataTable().fnReloadAjax(); */
		      			$(".entity_table").DataTable().ajax.reload(null,false);
						$('#entityModal').modal('hide');
						alert("操作成功!");
		      			}else{
		      				alert("编码已存在！");
		      			}
	      			
	      	},error: function () {
				alert('系统出现异常，请稍后再试!');
	        }}); 
	  	}
});

//修改设备
$(document).on('click','.modify',function(){//修改方案	
	$('.entityform')[0].reset();
	$('.entityform').validate().resetForm();
	aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
	$('#name').val(aData.name);
	$('#code').val(aData.code);
	$('#id').val(aData.id);
	$('#type').val("1");
	$('#entityModal').modal('show');
});


//删除设备
$(document).on('click','.delete',function(){
	if (confirm("你确定要删除吗?"))  {  
		aData = $(".entity_table").DataTable().row($(this).parents("tr")).data();
		$.ajax( {
				type:"post",//不写此参数默认为get方式提交
				async:false,   //设置为同步
				url : "/ejwms/dictionaryManage/deleteDictionary.do",//请求的uri
				data : {id:aData.id},//传递到后台的参数				
				cache : false,
				dataType : 'json',//后台返回前台的数据格式为json
				success : function(data) {
					$(".entity_table").dataTable().fnReloadAjax();
					alert("删除成功");
		},error: function () {
			alert('系统出现异常，请稍后再试!');
        }}); 
	}
});

//添加验证
$(function(){
  $(".entityform").validate({  
	  errorElement: 'em', 
		  errorClass: 'help-block',
		  focusInvalid: false,   
		  rules:{
	            "name":{
	                required:true,
	                maxlength:100
	            },"code":{
	                required:true,
	                maxlength:30
	            }
	        },
	        messages:{
	        	"name":{
	                required:"必填",
	                maxlength:"不超过100位"
	            },"code":{
	                required:"必填",
	                maxlength:"不超过30位"
	            }
	        }       
  });
 
});
</script>
</html>